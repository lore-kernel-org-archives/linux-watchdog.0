Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from dukecmwbtp06.coxmail.com ([68.99.120.54]:57875 "EHLO
        dukecmwbtp06.coxmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753902AbdA3STH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 30 Jan 2017 13:19:07 -0500
From: H Hartley Sweeten <hsweeten@visionengravers.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/2] watchdog: ep93xx_wdt: cleanup and let the core handle the heartbeat
Date: Mon, 30 Jan 2017 09:55:47 -0700
Message-Id: <20170130165548.40965-2-hsweeten@visionengravers.com>
In-Reply-To: <20170130165548.40965-1-hsweeten@visionengravers.com>
References: <20170130165548.40965-1-hsweeten@visionengravers.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Cleanup this driver and remove the 200ms heartbeat timer. The core now
has the ability to handle the heartbeat.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/ep93xx_wdt.c | 115 +++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 69 deletions(-)

diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 0a4d7cc..756ca47 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -19,81 +19,55 @@
  * for us to rely on the user space daemon alone. So we ping the
  * wdt each ~200msec and eventually stop doing it if the user space
  * daemon dies.
- *
- * TODO:
- *
- *	- Test last reset from watchdog status
- *	- Add a few missing ioctls
  */
 
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/watchdog.h>
-#include <linux/timer.h>
 #include <linux/io.h>
 
-#define WDT_VERSION	"0.4"
-
-/* default timeout (secs) */
-#define WDT_TIMEOUT 30
-
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
 
-static unsigned int timeout = WDT_TIMEOUT;
-module_param(timeout, uint, 0);
-MODULE_PARM_DESC(timeout,
-	"Watchdog timeout in seconds. (1<=timeout<=3600, default="
-				__MODULE_STRING(WDT_TIMEOUT) ")");
-
-static void __iomem *mmio_base;
-static struct timer_list timer;
-static unsigned long next_heartbeat;
-
 #define EP93XX_WATCHDOG		0x00
 #define EP93XX_WDSTATUS		0x04
 
-/* reset the wdt every ~200ms - the heartbeat of the device is 0.250 seconds*/
-#define WDT_INTERVAL (HZ/5)
-
-static void ep93xx_wdt_timer_ping(unsigned long data)
-{
-	if (time_before(jiffies, next_heartbeat))
-		writel(0x5555, mmio_base + EP93XX_WATCHDOG);
-
-	/* Re-set the timer interval */
-	mod_timer(&timer, jiffies + WDT_INTERVAL);
-}
+struct ep93xx_wdt_priv {
+	void __iomem *mmio;
+	struct watchdog_device wdd;
+};
 
 static int ep93xx_wdt_start(struct watchdog_device *wdd)
 {
-	next_heartbeat = jiffies + (timeout * HZ);
+	struct ep93xx_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
-	writel(0xaaaa, mmio_base + EP93XX_WATCHDOG);
-	mod_timer(&timer, jiffies + WDT_INTERVAL);
+	writel(0xaaaa, priv->mmio + EP93XX_WATCHDOG);
 
 	return 0;
 }
 
 static int ep93xx_wdt_stop(struct watchdog_device *wdd)
 {
-	del_timer_sync(&timer);
-	writel(0xaa55, mmio_base + EP93XX_WATCHDOG);
+	struct ep93xx_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	writel(0xaa55, priv->mmio + EP93XX_WATCHDOG);
 
 	return 0;
 }
 
-static int ep93xx_wdt_keepalive(struct watchdog_device *wdd)
+static int ep93xx_wdt_ping(struct watchdog_device *wdd)
 {
-	/* user land ping */
-	next_heartbeat = jiffies + (timeout * HZ);
+	struct ep93xx_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	writel(0x5555, priv->mmio + EP93XX_WATCHDOG);
 
 	return 0;
 }
 
 static const struct watchdog_info ep93xx_wdt_ident = {
 	.options	= WDIOF_CARDRESET |
+			  WDIOF_SETTIMEOUT |
 			  WDIOF_MAGICCLOSE |
 			  WDIOF_KEEPALIVEPING,
 	.identity	= "EP93xx Watchdog",
@@ -103,47 +77,48 @@ static struct watchdog_ops ep93xx_wdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= ep93xx_wdt_start,
 	.stop		= ep93xx_wdt_stop,
-	.ping		= ep93xx_wdt_keepalive,
-};
-
-static struct watchdog_device ep93xx_wdt_wdd = {
-	.info		= &ep93xx_wdt_ident,
-	.ops		= &ep93xx_wdt_ops,
+	.ping		= ep93xx_wdt_ping,
 };
 
 static int ep93xx_wdt_probe(struct platform_device *pdev)
 {
+	struct ep93xx_wdt_priv *priv;
+	struct watchdog_device *wdd;
 	struct resource *res;
 	unsigned long val;
-	int err;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mmio_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mmio_base))
-		return PTR_ERR(mmio_base);
+	priv->mmio = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->mmio))
+		return PTR_ERR(priv->mmio);
+
+	val = readl(priv->mmio + EP93XX_WATCHDOG);
 
-	if (timeout < 1 || timeout > 3600) {
-		timeout = WDT_TIMEOUT;
-		dev_warn(&pdev->dev,
-			"timeout value must be 1<=x<=3600, using %d\n",
-			timeout);
-	}
+	wdd = &priv->wdd;
+	wdd->bootstatus = (val & 0x01) ? WDIOF_CARDRESET : 0;
+	wdd->info = &ep93xx_wdt_ident;
+	wdd->ops = &ep93xx_wdt_ops;
+	wdd->timeout = 30;
+	wdd->min_timeout = 1;
+	wdd->max_hw_heartbeat_ms = 200;
+	wdd->parent = &pdev->dev;
 
-	val = readl(mmio_base + EP93XX_WATCHDOG);
-	ep93xx_wdt_wdd.bootstatus = (val & 0x01) ? WDIOF_CARDRESET : 0;
-	ep93xx_wdt_wdd.timeout = timeout;
-	ep93xx_wdt_wdd.parent = &pdev->dev;
+	watchdog_set_nowayout(wdd, nowayout);
 
-	watchdog_set_nowayout(&ep93xx_wdt_wdd, nowayout);
+	watchdog_set_drvdata(wdd, priv);
 
-	setup_timer(&timer, ep93xx_wdt_timer_ping, 1);
+	ret = watchdog_register_device(wdd);
+	if (ret)
+		return ret;
 
-	err = watchdog_register_device(&ep93xx_wdt_wdd);
-	if (err)
-		return err;
+	platform_set_drvdata(pdev, priv);
 
-	dev_info(&pdev->dev,
-		"EP93XX watchdog, driver version " WDT_VERSION "%s\n",
+	dev_info(&pdev->dev, "EP93XX watchdog driver %s\n",
 		(val & 0x08) ? " (nCS1 disable detected)" : "");
 
 	return 0;
@@ -151,7 +126,10 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 
 static int ep93xx_wdt_remove(struct platform_device *pdev)
 {
-	watchdog_unregister_device(&ep93xx_wdt_wdd);
+	struct ep93xx_wdt_priv *priv = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(&priv->wdd);
+
 	return 0;
 }
 
@@ -170,4 +148,3 @@ MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
 MODULE_AUTHOR("H Hartley Sweeten <hsweeten@visionengravers.com>");
 MODULE_DESCRIPTION("EP93xx Watchdog");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(WDT_VERSION);
-- 
2.10.0

