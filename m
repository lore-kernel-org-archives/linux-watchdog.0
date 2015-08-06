Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35605 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176AbbHFIZj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Aug 2015 04:25:39 -0400
Received: by pabxd6 with SMTP id xd6so39532910pab.2
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2015 01:25:38 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: wim@iguana.be, linux-watchdog@vger.kernel.org
Cc: workgroup.linux@csr.com, William Wang <William.Wang@csr.com>,
	Guo Zeng <guo.zeng@csr.com>, Barry Song <Baohua.Song@csr.com>
Subject: [PATCH] watchdog : sirf: add support for CSR atlas7 SoC
Date: Thu,  6 Aug 2015 08:31:59 +0000
Message-Id: <1438849919-27724-1-git-send-email-21cnbao@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: William Wang <William.Wang@csr.com>

This patch adds support for the new CSR atlas7 chips. prima2 and atlas7
are similar in chip design, but the register layout and flows have some
differences.

This patch puts the differences including register layout and operations
in dt private data, so that one driver can be compatible for two chips.

Signed-off-by: William Wang <William.Wang@csr.com>
Signed-off-by: Guo Zeng <guo.zeng@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/watchdog/sirfsoc_wdt.c | 323 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 272 insertions(+), 51 deletions(-)

diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index 42fa5c0c5..7b6f7ee1 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -13,19 +13,43 @@
 #include <linux/of.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/clk.h>
+
+struct sirfsoc_timer_hw {
+	/* hardware timer specific*/
+	u32 match;
+	u32 irq_status;
+	u32 watchdog_en;
+	u32 cnt64_lo;
+	u32 cnt64_hi;
+	u32 cnt64_latch_lo;
+	u32 cnt64_latch_hi;
+
+	/* only atlas7 has*/
+	u32 match_num;
+	u32 cnt_ctrl;
+	u32 cnt;
+	u32 cnt64_load_lo;
+	u32 cnt64_load_hi;
+	u32 cnt64_ctrl;
+
+	/* only prima2 has*/
+	u32 irq_enable;
+	u32 div;
+	u32 latch_eable;
+
+	int (*wdt_enable)(struct watchdog_device *);
+	int (*wdt_disable)(struct watchdog_device *);
+	void (*wdt_latch)(struct watchdog_device *);
+	unsigned int (*wdt_updatetimeout)(struct watchdog_device *);
+	unsigned int (*wdt_gettimeleft)(struct watchdog_device *);
+};
 
-#define CLOCK_FREQ	1000000
-
-#define SIRFSOC_TIMER_COUNTER_LO	0x0000
-#define SIRFSOC_TIMER_MATCH_0		0x0008
-#define SIRFSOC_TIMER_INT_EN		0x0024
-#define SIRFSOC_TIMER_WATCHDOG_EN	0x0028
-#define SIRFSOC_TIMER_LATCH		0x0030
-#define SIRFSOC_TIMER_LATCHED_LO	0x0034
+#define SIRFSOC_CNT64_CTRL_LOAD_BIT		BIT(1)
+#define SIRFSOC_CNT64_CTRL_LATCH_BIT		BIT(0)
 
 #define SIRFSOC_TIMER_WDT_INDEX		5
-
-#define SIRFSOC_WDT_MIN_TIMEOUT		30		/* 30 secs */
+#define SIRFSOC_WDT_MIN_TIMEOUT		1		/* 1 sec */
 #define SIRFSOC_WDT_MAX_TIMEOUT		(10 * 60)	/* 10 mins */
 #define SIRFSOC_WDT_DEFAULT_TIMEOUT	30		/* 30 secs */
 
@@ -39,69 +63,200 @@ MODULE_PARM_DESC(timeout, "Default watchdog timeout (in seconds)");
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+struct sirfsoc_wdog {
+	struct device *dev;
+	struct sirfsoc_timer_hw *hw;
+	void __iomem *base;
+	unsigned long tick_rate;
+};
+
 static unsigned int sirfsoc_wdt_gettimeleft(struct watchdog_device *wdd)
 {
+	struct sirfsoc_wdog *wdt = watchdog_get_drvdata(wdd);
+	struct sirfsoc_timer_hw *hw = wdt->hw;
+
+	unsigned int time_left = hw->wdt_gettimeleft(wdd);
+
+	return  time_left;
+}
+
+static unsigned int prima2_wdt_gettimeleft(struct watchdog_device *wdd)
+{
+	struct sirfsoc_wdog *wdt = watchdog_get_drvdata(wdd);
+	struct sirfsoc_timer_hw *hw = wdt->hw;
 	u32 counter, match;
-	void __iomem *wdt_base;
-	int time_left;
+	unsigned int time_left;
 
-	wdt_base = watchdog_get_drvdata(wdd);
-	counter = readl(wdt_base + SIRFSOC_TIMER_COUNTER_LO);
-	match = readl(wdt_base +
-		SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
+	counter = readl(wdt->base + hw->cnt64_lo);
+	match = readl(wdt->base + hw->match +
+			4 * SIRFSOC_TIMER_WDT_INDEX);
 
 	time_left = match - counter;
 
-	return time_left / CLOCK_FREQ;
+	return  time_left / wdt->tick_rate;
 }
 
-static int sirfsoc_wdt_updatetimeout(struct watchdog_device *wdd)
+static unsigned int atlas7_wdt_gettimeleft(struct watchdog_device *wdd)
 {
-	u32 counter, timeout_ticks;
-	void __iomem *wdt_base;
+	struct sirfsoc_wdog *wdt = watchdog_get_drvdata(wdd);
+	struct sirfsoc_timer_hw *hw = wdt->hw;
+	u32 counter, match;
+	unsigned int time_left;
+
+	counter = readl(wdt->base + hw->cnt + 4 * SIRFSOC_TIMER_WDT_INDEX);
+	match = readl(wdt->base + hw->match +
+			4 * SIRFSOC_TIMER_WDT_INDEX);
+
+	time_left = match - counter;
 
-	timeout_ticks = wdd->timeout * CLOCK_FREQ;
-	wdt_base = watchdog_get_drvdata(wdd);
+	return  time_left / wdt->tick_rate;
+}
+
+static void prima2_wdt_latch(struct watchdog_device *wdd)
+{
+	struct sirfsoc_wdog *wdt = watchdog_get_drvdata(wdd);
+	struct sirfsoc_timer_hw *hw = wdt->hw;
 
 	/* Enable the latch before reading the LATCH_LO register */
-	writel(1, wdt_base + SIRFSOC_TIMER_LATCH);
+	writel(SIRFSOC_CNT64_CTRL_LATCH_BIT,
+		wdt->base + hw->latch_eable);
+}
+
+static int prima2_wdt_enable(struct watchdog_device *wdd)
+{
+	struct sirfsoc_wdog *wdt = watchdog_get_drvdata(wdd);
+	struct sirfsoc_timer_hw *hw = wdt->hw;
+	/*
+	 * NOTE: If interrupt is not enabled
+	 * then WD-Reset doesn't get generated at all.
+	 */
+	writel(readl(wdt->base + hw->irq_enable) |
+				(1 << SIRFSOC_TIMER_WDT_INDEX),
+			wdt->base + hw->irq_enable);
 
-	/* Set the TO value */
-	counter = readl(wdt_base + SIRFSOC_TIMER_LATCHED_LO);
+	writel(1, wdt->base + hw->watchdog_en);
+	return 0;
+}
+
+static int prima2_wdt_disable(struct watchdog_device *wdd)
+{
+	struct sirfsoc_wdog *wdt = watchdog_get_drvdata(wdd);
+	struct sirfsoc_timer_hw *hw = wdt->hw;
 
-	counter += timeout_ticks;
+	writel(0, wdt->base + hw->watchdog_en);
 
-	writel(counter, wdt_base +
-		SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
+	writel(readl(wdt->base + hw->irq_enable) &
+		~(1 << SIRFSOC_TIMER_WDT_INDEX),
+	wdt->base + hw->irq_enable);
 
 	return 0;
 }
 
-static int sirfsoc_wdt_enable(struct watchdog_device *wdd)
+static unsigned int prima2_wdt_updatetimeout(struct watchdog_device *wdd)
 {
-	void __iomem *wdt_base = watchdog_get_drvdata(wdd);
-	sirfsoc_wdt_updatetimeout(wdd);
+	struct sirfsoc_wdog *wdt = watchdog_get_drvdata(wdd);
+	struct sirfsoc_timer_hw *hw = wdt->hw;
+	u32 timeout_ticks;
+
+	timeout_ticks = wdd->timeout * wdt->tick_rate;
+
+	/* Enable the latch before reading the LATCH_LO register */
+	hw->wdt_latch(wdd);
+
+	writel(readl(wdt->base + hw->cnt64_latch_lo) +
+		timeout_ticks,
+	wdt->base + hw->match +
+		4 * SIRFSOC_TIMER_WDT_INDEX);
+
+	return 0;
+}
+
+static int atlas7_wdt_enable(struct watchdog_device *wdd)
+{
+	struct sirfsoc_wdog *wdt = watchdog_get_drvdata(wdd);
+	struct sirfsoc_timer_hw *hw = wdt->hw;
 
 	/*
 	 * NOTE: If interrupt is not enabled
 	 * then WD-Reset doesn't get generated at all.
 	 */
-	writel(readl(wdt_base + SIRFSOC_TIMER_INT_EN)
-		| (1 << SIRFSOC_TIMER_WDT_INDEX),
-		wdt_base + SIRFSOC_TIMER_INT_EN);
-	writel(1, wdt_base + SIRFSOC_TIMER_WATCHDOG_EN);
+	writel(1, wdt->base + hw->watchdog_en);
+	writel(readl(wdt->base + hw->cnt_ctrl +
+			4 * SIRFSOC_TIMER_WDT_INDEX) | 0x3,
+		wdt->base + hw->cnt_ctrl +
+			4 * SIRFSOC_TIMER_WDT_INDEX);
+
+	return 0;
+}
+
+static int atlas7_wdt_disable(struct watchdog_device *wdd)
+{
+	struct sirfsoc_wdog *wdt = watchdog_get_drvdata(wdd);
+	struct sirfsoc_timer_hw *hw = wdt->hw;
+
+	writel(0, wdt->base + hw->watchdog_en);
+
+	writel(readl(wdt->base +
+			hw->cnt_ctrl +
+			4 * SIRFSOC_TIMER_WDT_INDEX) & ~0x3,
+		wdt->base + hw->cnt_ctrl +
+			4 * SIRFSOC_TIMER_WDT_INDEX);
+
+	return 0;
+}
+
+static unsigned int atlas7_wdt_updatetimeout(struct watchdog_device *wdd)
+{
+	struct sirfsoc_wdog *wdt = watchdog_get_drvdata(wdd);
+	struct sirfsoc_timer_hw *hw = wdt->hw;
+
+	u32 timeout_ticks;
+
+	timeout_ticks = wdd->timeout * wdt->tick_rate;
+
+	/* disable counter count */
+	writel(readl(wdt->base + hw->cnt_ctrl +
+			4 * SIRFSOC_TIMER_WDT_INDEX) & 0xfffffffe,
+		wdt->base + hw->cnt_ctrl + 4 * SIRFSOC_TIMER_WDT_INDEX);
+
+	writel(timeout_ticks,
+			wdt->base + hw->match +	4 * SIRFSOC_TIMER_WDT_INDEX);
+
+	/* enable counter count */
+	writel(readl(wdt->base + hw->cnt_ctrl +
+			4 * SIRFSOC_TIMER_WDT_INDEX) | 0x1,
+		wdt->base + hw->cnt_ctrl + 4 * SIRFSOC_TIMER_WDT_INDEX);
+
+	return 0;
+}
+
+static int sirfsoc_wdt_updatetimeout(struct watchdog_device *wdd)
+{
+	struct sirfsoc_wdog *wdt = watchdog_get_drvdata(wdd);
+	struct sirfsoc_timer_hw *hw = wdt->hw;
+
+	hw->wdt_updatetimeout(wdd);
+
+	return 0;
+}
+
+static int sirfsoc_wdt_enable(struct watchdog_device *wdd)
+{
+	struct sirfsoc_wdog *wdt = watchdog_get_drvdata(wdd);
+	struct sirfsoc_timer_hw *hw = wdt->hw;
+
+	sirfsoc_wdt_updatetimeout(wdd);
+	hw->wdt_enable(wdd);
 
 	return 0;
 }
 
 static int sirfsoc_wdt_disable(struct watchdog_device *wdd)
 {
-	void __iomem *wdt_base = watchdog_get_drvdata(wdd);
+	struct sirfsoc_wdog *wdt = watchdog_get_drvdata(wdd);
+	struct sirfsoc_timer_hw *hw = wdt->hw;
 
-	writel(0, wdt_base + SIRFSOC_TIMER_WATCHDOG_EN);
-	writel(readl(wdt_base + SIRFSOC_TIMER_INT_EN)
-		& (~(1 << SIRFSOC_TIMER_WDT_INDEX)),
-		wdt_base + SIRFSOC_TIMER_INT_EN);
+	hw->wdt_disable(wdd);
 
 	return 0;
 }
@@ -139,29 +294,99 @@ static struct watchdog_device sirfsoc_wdd = {
 	.max_timeout = SIRFSOC_WDT_MAX_TIMEOUT,
 };
 
+struct sirfsoc_timer_hw sirfsoc_timer_atlas7 = {
+	.cnt_ctrl = 0x0,
+	.match = 0x18,
+	.cnt = 0x48,
+	.irq_status = 0x60,
+	.watchdog_en = 0x64,
+	.cnt64_ctrl = 0x68,
+	.cnt64_lo = 0x6c,
+	.cnt64_hi = 0x70,
+	.cnt64_load_lo = 0x74,
+	.cnt64_load_hi = 0x78,
+	.cnt64_latch_lo = 0x7c,
+	.cnt64_latch_hi = 0x80,
+	.wdt_enable = atlas7_wdt_enable,
+	.wdt_disable = atlas7_wdt_disable,
+	.wdt_updatetimeout = atlas7_wdt_updatetimeout,
+	.wdt_gettimeleft = atlas7_wdt_gettimeleft,
+};
+
+struct sirfsoc_timer_hw sirfsoc_timer_prima2 = {
+	.match = 0x8,
+	.irq_status = 0x20,
+	.watchdog_en = 0x28,
+	.cnt64_lo = 0x0,
+	.cnt64_hi = 0x4,
+	.cnt64_latch_lo = 0x34,
+	.cnt64_latch_hi = 0x38,
+	.irq_enable = 0x24,
+	.div = 0x2c,
+	.latch_eable = 0x30,
+	.wdt_enable = prima2_wdt_enable,
+	.wdt_disable = prima2_wdt_disable,
+	.wdt_latch = prima2_wdt_latch,
+	.wdt_updatetimeout = prima2_wdt_updatetimeout,
+	.wdt_gettimeleft = prima2_wdt_gettimeleft,
+};
+
+static const struct of_device_id sirfsoc_wdt_of_match[] = {
+	{ .compatible = "sirf,atlas7-tick", .data = &sirfsoc_timer_atlas7},
+	{ .compatible = "sirf,prima2-tick", .data = &sirfsoc_timer_prima2},
+	{}
+};
+
 static int sirfsoc_wdt_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
+	struct sirfsoc_wdog *wdt;
+	const struct of_device_id *match;
 	struct resource *res;
+	struct clk *clk;
 	int ret;
-	void __iomem *base;
 
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	watchdog_set_drvdata(&sirfsoc_wdd, base);
+	wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
+
+	match = of_match_node(sirfsoc_wdt_of_match, np);
+	if (!match)
+		return -ENODEV;
+	wdt->hw = (struct sirfsoc_timer_hw *)match->data;
+
+	/*assign clks div and callbacks*/
+	if (of_device_is_compatible(np, "sirf,atlas7-tick")) {
+		clk = of_clk_get(np, 0);
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			goto err;
+		}
+
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			goto err;
+		wdt->tick_rate = clk_get_rate(clk);
+	} else if (of_device_is_compatible(np, "sirf,prima2-tick"))
+		wdt->tick_rate = 1000000;
 
 	watchdog_init_timeout(&sirfsoc_wdd, timeout, &pdev->dev);
 	watchdog_set_nowayout(&sirfsoc_wdd, nowayout);
 
 	ret = watchdog_register_device(&sirfsoc_wdd);
 	if (ret)
-		return ret;
+		goto err;
 
+	watchdog_set_drvdata(&sirfsoc_wdd, wdt);
 	platform_set_drvdata(pdev, &sirfsoc_wdd);
 
 	return 0;
+err:
+	return ret;
 }
 
 static void sirfsoc_wdt_shutdown(struct platform_device *pdev)
@@ -201,10 +426,6 @@ static int sirfsoc_wdt_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(sirfsoc_wdt_pm_ops,
 		sirfsoc_wdt_suspend, sirfsoc_wdt_resume);
 
-static const struct of_device_id sirfsoc_wdt_of_match[] = {
-	{ .compatible = "sirf,prima2-tick"},
-	{},
-};
 MODULE_DEVICE_TABLE(of, sirfsoc_wdt_of_match);
 
 static struct platform_driver sirfsoc_wdt_driver = {
-- 
2.3.5

