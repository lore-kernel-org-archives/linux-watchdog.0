Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41641 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754558AbaAUN0j (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 08:26:39 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 07/15] watchdog: orion: Introduce an orion_watchdog device structure
Date: Tue, 21 Jan 2014 10:26:06 -0300
Message-Id: <1390310774-20781-8-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In order to prepare to support multiple compatible-strings, this
commit adds a device structure to hold the driver's state.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 97 +++++++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 37 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 7889309..9a904be 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -40,45 +40,56 @@
 
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
 
 static unsigned int orion_wdt_get_timeleft(struct watchdog_device *wdt_dev)
 {
-	return readl(wdt_reg + WDT_VAL) / wdt_tclk;
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+	return readl(dev->reg + WDT_VAL) / dev->clk_rate;
 }
 
 static int orion_wdt_set_timeout(struct watchdog_device *wdt_dev,
@@ -102,12 +113,6 @@ static const struct watchdog_ops orion_wdt_ops = {
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
@@ -116,29 +121,41 @@ static irqreturn_t orion_wdt_irq(int irq, void *devid)
 
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
 		return -ENODEV;
 	}
-	clk_prepare_enable(clk);
-	wdt_tclk = clk_get_rate(clk);
+	clk_prepare_enable(dev->clk);
+	dev->clk_rate = clk_get_rate(dev->clk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
-	wdt_reg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!wdt_reg)
+	dev->reg = devm_ioremap(&pdev->dev, res->start,
+			       resource_size(res));
+	if (!dev->reg)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!res)
 		return -ENODEV;
-	wdt_rstout = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!wdt_rstout)
+	dev->rstout = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!dev->rstout)
 		return -ENOMEM;
 
 	irq = platform_get_irq(pdev, 0);
@@ -154,34 +171,40 @@ static int orion_wdt_probe(struct platform_device *pdev)
 		}
 	}
 
-	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
+	wdt_max_duration = WDT_MAX_CYCLE_COUNT / dev->clk_rate;
 
-	orion_wdt.timeout = wdt_max_duration;
-	orion_wdt.max_timeout = wdt_max_duration;
-	watchdog_init_timeout(&orion_wdt, heartbeat, &pdev->dev);
+	dev->wdt.timeout = wdt_max_duration;
+	dev->wdt.max_timeout = wdt_max_duration;
+	watchdog_init_timeout(&dev->wdt, heartbeat, &pdev->dev);
 
-	watchdog_set_nowayout(&orion_wdt, nowayout);
-	ret = watchdog_register_device(&orion_wdt);
+	platform_set_drvdata(pdev, &dev->wdt);
+	watchdog_set_drvdata(&dev->wdt, dev);
+	watchdog_set_nowayout(&dev->wdt, nowayout);
+	ret = watchdog_register_device(&dev->wdt);
 	if (ret) {
-		clk_disable_unprepare(clk);
+		clk_disable_unprepare(dev->clk);
 		return ret;
 	}
 
 	pr_info("Initial timeout %d sec%s\n",
-		orion_wdt.timeout, nowayout ? ", nowayout" : "");
+		dev->wdt.timeout, nowayout ? ", nowayout" : "");
 	return 0;
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

