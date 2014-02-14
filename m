Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59303 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752947AbaBNWZB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Feb 2014 17:25:01 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RESEND/PATCH v7 08/18] watchdog: orion: Introduce an orion_watchdog device structure
Date: Fri, 14 Feb 2014 19:24:08 -0300
Message-Id: <1392416658-2780-9-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In order to prepare to support multiple compatible-strings, this
commit adds a device structure to hold the driver's state.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 114 ++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 45 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 65aa655..9d3a5b9 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -44,55 +44,66 @@
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
-static unsigned int wdt_max_duration;	/* (seconds) */
-static struct clk *clk;
-static unsigned int wdt_tclk;
-static void __iomem *wdt_reg;
-static void __iomem *wdt_rstout;
+
+struct orion_watchdog {
+	struct watchdog_device wdt;
+	void __iomem *reg;
+	void __iomem *rstout;
+	unsigned long clk_rate;
+	struct clk *clk;
+};
 
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 {
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
 	/* Reload watchdog duration */
-	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
+	writel(dev->clk_rate * wdt_dev->timeout, dev->reg + WDT_VAL);
 	return 0;
 }
 
 static int orion_wdt_start(struct watchdog_device *wdt_dev)
 {
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+
 	/* Set watchdog duration */
-	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
+	writel(dev->clk_rate * wdt_dev->timeout, dev->reg + WDT_VAL);
 
 	/* Enable watchdog timer */
-	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, WDT_EN);
+	atomic_io_modify(dev->reg + TIMER_CTRL, WDT_EN, WDT_EN);
 
 	/* Enable reset on watchdog */
-	atomic_io_modify(wdt_rstout, WDT_RESET_OUT_EN, WDT_RESET_OUT_EN);
+	atomic_io_modify(dev->rstout, WDT_RESET_OUT_EN, WDT_RESET_OUT_EN);
+
 	return 0;
 }
 
 static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 {
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+
 	/* Disable reset on watchdog */
-	atomic_io_modify(wdt_rstout, WDT_RESET_OUT_EN, 0);
+	atomic_io_modify(dev->rstout, WDT_RESET_OUT_EN, 0);
 
 	/* Disable watchdog timer */
-	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, 0);
+	atomic_io_modify(dev->reg + TIMER_CTRL, WDT_EN, 0);
+
 	return 0;
 }
 
-static int orion_wdt_enabled(void)
+static int orion_wdt_enabled(struct orion_watchdog *dev)
 {
 	bool enabled, running;
 
-	enabled = readl(wdt_rstout) & WDT_RESET_OUT_EN;
-	running = readl(wdt_reg + TIMER_CTRL) & WDT_EN;
+	enabled = readl(dev->rstout) & WDT_RESET_OUT_EN;
+	running = readl(dev->reg + TIMER_CTRL) & WDT_EN;
 
 	return enabled && running;
 }
 
 static unsigned int orion_wdt_get_timeleft(struct watchdog_device *wdt_dev)
 {
-	return readl(wdt_reg + WDT_VAL) / wdt_tclk;
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+	return readl(dev->reg + WDT_VAL) / dev->clk_rate;
 }
 
 static int orion_wdt_set_timeout(struct watchdog_device *wdt_dev,
@@ -116,12 +127,6 @@ static const struct watchdog_ops orion_wdt_ops = {
 	.get_timeleft = orion_wdt_get_timeleft,
 };
 
-static struct watchdog_device orion_wdt = {
-	.info = &orion_wdt_info,
-	.ops = &orion_wdt_ops,
-	.min_timeout = 1,
-};
-
 static irqreturn_t orion_wdt_irq(int irq, void *devid)
 {
 	panic("Watchdog Timeout");
@@ -157,18 +162,29 @@ static void __iomem *orion_wdt_ioremap_rstout(struct platform_device *pdev,
 
 static int orion_wdt_probe(struct platform_device *pdev)
 {
+	struct orion_watchdog *dev;
+	unsigned int wdt_max_duration;	/* (seconds) */
 	struct resource *res;
 	int ret, irq;
 
-	clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk)) {
+	dev = devm_kzalloc(&pdev->dev, sizeof(struct orion_watchdog),
+			   GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->wdt.info = &orion_wdt_info;
+	dev->wdt.ops = &orion_wdt_ops;
+	dev->wdt.min_timeout = 1;
+
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dev->clk)) {
 		dev_err(&pdev->dev, "Orion Watchdog missing clock\n");
-		return PTR_ERR(clk);
+		return PTR_ERR(dev->clk);
 	}
-	ret = clk_prepare_enable(clk);
+	ret = clk_prepare_enable(dev->clk);
 	if (ret)
 		return ret;
-	wdt_tclk = clk_get_rate(clk);
+	dev->clk_rate = clk_get_rate(dev->clk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -176,24 +192,28 @@ static int orion_wdt_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	wdt_reg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!wdt_reg) {
+	dev->reg = devm_ioremap(&pdev->dev, res->start,
+			       resource_size(res));
+	if (!dev->reg) {
 		ret = -ENOMEM;
 		goto disable_clk;
 	}
 
-	wdt_rstout = orion_wdt_ioremap_rstout(pdev, res->start &
-						    INTERNAL_REGS_MASK);
-	if (!wdt_rstout) {
+	dev->rstout = orion_wdt_ioremap_rstout(pdev, res->start &
+						     INTERNAL_REGS_MASK);
+	if (!dev->rstout) {
 		ret = -ENODEV;
 		goto disable_clk;
 	}
 
-	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
+	wdt_max_duration = WDT_MAX_CYCLE_COUNT / dev->clk_rate;
+
+	dev->wdt.timeout = wdt_max_duration;
+	dev->wdt.max_timeout = wdt_max_duration;
+	watchdog_init_timeout(&dev->wdt, heartbeat, &pdev->dev);
 
-	orion_wdt.timeout = wdt_max_duration;
-	orion_wdt.max_timeout = wdt_max_duration;
-	watchdog_init_timeout(&orion_wdt, heartbeat, &pdev->dev);
+	platform_set_drvdata(pdev, &dev->wdt);
+	watchdog_set_drvdata(&dev->wdt, dev);
 
 	/*
 	 * Let's make sure the watchdog is fully stopped, unless it's
@@ -201,8 +221,8 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	 * removed and re-insterted, or if the bootloader explicitly
 	 * set a running watchdog before booting the kernel.
 	 */
-	if (!orion_wdt_enabled())
-		orion_wdt_stop(&orion_wdt);
+	if (!orion_wdt_enabled(dev))
+		orion_wdt_stop(&dev->wdt);
 
 	/* Request the IRQ only after the watchdog is disabled */
 	irq = platform_get_irq(pdev, 0);
@@ -212,37 +232,41 @@ static int orion_wdt_probe(struct platform_device *pdev)
 		 * watchdog, so let's make it optional.
 		 */
 		ret = devm_request_irq(&pdev->dev, irq, orion_wdt_irq, 0,
-				       pdev->name, &orion_wdt);
+				       pdev->name, dev);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "failed to request IRQ\n");
 			goto disable_clk;
 		}
 	}
 
-	watchdog_set_nowayout(&orion_wdt, nowayout);
-	ret = watchdog_register_device(&orion_wdt);
+	watchdog_set_nowayout(&dev->wdt, nowayout);
+	ret = watchdog_register_device(&dev->wdt);
 	if (ret)
 		goto disable_clk;
 
 	pr_info("Initial timeout %d sec%s\n",
-		orion_wdt.timeout, nowayout ? ", nowayout" : "");
+		dev->wdt.timeout, nowayout ? ", nowayout" : "");
 	return 0;
 
 disable_clk:
-	clk_disable_unprepare(clk);
+	clk_disable_unprepare(dev->clk);
 	return ret;
 }
 
 static int orion_wdt_remove(struct platform_device *pdev)
 {
-	watchdog_unregister_device(&orion_wdt);
-	clk_disable_unprepare(clk);
+	struct watchdog_device *wdt_dev = platform_get_drvdata(pdev);
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+
+	watchdog_unregister_device(wdt_dev);
+	clk_disable_unprepare(dev->clk);
 	return 0;
 }
 
 static void orion_wdt_shutdown(struct platform_device *pdev)
 {
-	orion_wdt_stop(&orion_wdt);
+	struct watchdog_device *wdt_dev = platform_get_drvdata(pdev);
+	orion_wdt_stop(wdt_dev);
 }
 
 static const struct of_device_id orion_wdt_of_match_table[] = {
-- 
1.8.1.5

