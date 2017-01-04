Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] watchdog: asm9260_wdt: Use watchdog core to install restart handler
Date: Wed,  4 Jan 2017 13:28:35 -0800
Message-Id: <1483565318-25578-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use the infrastructure provided by the watchdog core to install
the restart handler.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/asm9260_wdt.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
index d0b59ba0f661..05a2b922304b 100644
--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/reset.h>
 #include <linux/watchdog.h>
 
@@ -59,7 +58,6 @@ struct asm9260_wdt_priv {
 	struct clk		*clk;
 	struct clk		*clk_ahb;
 	struct reset_control	*rst;
-	struct notifier_block	restart_handler;
 
 	void __iomem		*iobase;
 	int			irq;
@@ -172,15 +170,14 @@ static irqreturn_t asm9260_wdt_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-static int asm9260_restart_handler(struct notifier_block *this,
-				   unsigned long mode, void *cmd)
+static int asm9260_restart(struct watchdog_device *wdd, unsigned long action,
+			   void *data)
 {
-	struct asm9260_wdt_priv *priv =
-		container_of(this, struct asm9260_wdt_priv, restart_handler);
+	struct asm9260_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
 	asm9260_wdt_sys_reset(priv);
 
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static const struct watchdog_info asm9260_wdt_ident = {
@@ -196,6 +193,7 @@ static struct watchdog_ops asm9260_wdt_ops = {
 	.get_timeleft	= asm9260_wdt_gettimeleft,
 	.ping		= asm9260_wdt_feed,
 	.set_timeout	= asm9260_wdt_settimeout,
+	.restart	= asm9260_restart,
 };
 
 static int asm9260_wdt_get_dt_clks(struct asm9260_wdt_priv *priv)
@@ -341,12 +339,6 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	priv->restart_handler.notifier_call = asm9260_restart_handler;
-	priv->restart_handler.priority = 128;
-	ret = register_restart_handler(&priv->restart_handler);
-	if (ret)
-		dev_warn(&pdev->dev, "cannot register restart handler\n");
-
 	dev_info(&pdev->dev, "Watchdog enabled (timeout: %d sec, mode: %s)\n",
 		 wdd->timeout, mode_name[priv->mode]);
 	return 0;
@@ -370,8 +362,6 @@ static int asm9260_wdt_remove(struct platform_device *pdev)
 
 	asm9260_wdt_disable(&priv->wdd);
 
-	unregister_restart_handler(&priv->restart_handler);
-
 	watchdog_unregister_device(&priv->wdd);
 
 	clk_disable_unprepare(priv->clk);
-- 
2.7.4
