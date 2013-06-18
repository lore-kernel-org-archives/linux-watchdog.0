Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38296 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab3FRPWU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 11:22:20 -0400
Received: by mail-pa0-f45.google.com with SMTP id bi5so4113476pad.18
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 08:22:20 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wim@iguana.be
Cc: marc.zyngier@arm.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 12/14] watchdog/mpcore_wdt: use correct clk_rate to program timeout
Date: Tue, 18 Jun 2013 20:50:36 +0530
Message-Id: <c2b519e853ec25b09da3202eef11bb43dbc55399.1371535243.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Currently, mpcore wdt driver doesn't use exact clk_rate to program timeout in
hardware. This patch provides two ways of doing so:
	- either use clk_get_rate() if clk_get passes
	- use clk_rate passed via module param

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/include/asm/smp_twd.h | 10 +++++
 drivers/watchdog/mpcore_wdt.c  | 99 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 90 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index a62bcfa..a9791c5 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -13,11 +13,21 @@
 #define TWD_WDOG_RESETSTAT		0x30
 #define TWD_WDOG_DISABLE		0x34
 
+#define TWD_WDOG_LOAD_MIN		0x00000000
+#define TWD_WDOG_LOAD_MAX		0xFFFFFFFF
+
 #define TWD_TIMER_CONTROL_ENABLE	(1 << 0)
 #define TWD_TIMER_CONTROL_ONESHOT	(0 << 1)
 #define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
+#define TWD_WDOG_CONTROL_ENABLE		(1 << 0)
+#define TWD_WDOG_CONTROL_IRQ_ENABLE	(1 << 2)
+#define TWD_WDOG_CONTROL_WDT_MODE	(1 << 3)
+#define TWD_WDOG_CONTROL_WDT_PRESCALE(x)	((x) << 8)
+#define TWD_WDOG_CONTROL_PRESCALE_MIN	0x00
+#define TWD_WDOG_CONTROL_PRESCALE_MAX	0xFF
+
 #define TWD_WDOG_RESETSTAT_MASK		0x1
 
 #include <linux/ioport.h>
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 1a1a1fd..64878a7 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -42,7 +42,10 @@ struct mpcore_wdt {
 	void __iomem	*base;
 	spinlock_t	lock;
 	struct clk	*clk;
+	unsigned long	clk_rate;	/* In Hz */
 	int		irq;
+	unsigned int	prescale;
+	unsigned int	load_val;
 	unsigned int	perturb;
 };
 
@@ -61,6 +64,11 @@ MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+static int clk_rate;
+module_param(clk_rate, int, 0);
+MODULE_PARM_DESC(clk_rate,
+	"Watchdog clock rate in Hz, required if clk_get() fails");
+
 #define ONLY_TESTING	0
 static int mpcore_noboot = ONLY_TESTING;
 module_param(mpcore_noboot, int, 0);
@@ -96,17 +104,10 @@ static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
 static int mpcore_wdt_ping(struct watchdog_device *wdd)
 {
 	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
-	unsigned long count;
 
 	spin_lock(&wdt->lock);
-	/* Assume prescale is set to 256 */
-	count = readl_relaxed(wdt->base + TWD_WDOG_COUNTER);
-	count = (0xFFFFFFFFU - count) * (HZ / 5);
-	count = (count / 256) * mpcore_margin;
-
-	/* Reload the counter */
-	writel_relaxed(count + wdt->perturb, wdt->base + TWD_WDOG_LOAD);
-	wdt->perturb = wdt->perturb ? 0 : 1;
+	writel_relaxed(wdt->load_val + wdt->perturb, wdt->base + TWD_WDOG_LOAD);
+	wdt->perturb = !wdt->perturb;
 	spin_unlock(&wdt->lock);
 
 	return 0;
@@ -136,6 +137,7 @@ static int mpcore_wdt_stop(struct watchdog_device *wdd)
 static int mpcore_wdt_start(struct watchdog_device *wdd)
 {
 	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 val, mode;
 	int ret;
 
 	dev_info(wdt->dev, "enabling watchdog\n");
@@ -151,20 +153,70 @@ static int mpcore_wdt_start(struct watchdog_device *wdd)
 	/* This loads the count register but does NOT start the count yet */
 	mpcore_wdt_ping(wdd);
 
-	if (mpcore_noboot) {
-		/* Enable watchdog - prescale=256, watchdog mode=0, enable=1 */
-		writel_relaxed(0x0000FF01, wdt->base + TWD_WDOG_CONTROL);
-	} else {
-		/* Enable watchdog - prescale=256, watchdog mode=1, enable=1 */
-		writel_relaxed(0x0000FF09, wdt->base + TWD_WDOG_CONTROL);
-	}
+	if (mpcore_noboot)
+		mode = 0;
+	else
+		mode = TWD_WDOG_CONTROL_WDT_MODE;
+
+	spin_lock(&wdt->lock);
+
+	val = TWD_WDOG_CONTROL_WDT_PRESCALE(wdt->prescale) |
+		TWD_WDOG_CONTROL_ENABLE | mode;
+	writel_relaxed(val, wdt->base + TWD_WDOG_CONTROL);
+
+	spin_unlock(&wdt->lock);
 
 	return 0;
 }
 
-static int mpcore_wdt_set_heartbeat(struct watchdog_device *wdd, unsigned int t)
+/* binary search */
+static inline void bsearch(u32 *var, u32 var_start, u32 var_end,
+		const u64 param, const u32 timeout, u32 rate)
 {
-	mpcore_margin = t;
+	u64 tmp = 0;
+
+	/* get the lowest var value that can satisfy our requirement */
+	while (var_start < var_end) {
+		tmp = var_start;
+		tmp += var_end;
+		tmp = div_u64(tmp, 2);
+		if (timeout > div_u64((param + 1) * (tmp + 1), rate)) {
+			if (var_start == tmp)
+				break;
+			else
+				var_start = tmp;
+		} else {
+			if (var_end == tmp)
+				break;
+			else
+				var_end = tmp;
+		}
+	}
+	*var = tmp;
+}
+
+static int
+mpcore_wdt_set_heartbeat(struct watchdog_device *wdd, unsigned int timeout)
+{
+	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned int psc, rate = wdt->clk_rate;
+	u64 load = 0;
+
+	/* get appropriate value of psc and load */
+	bsearch(&psc, TWD_WDOG_CONTROL_PRESCALE_MIN,
+			TWD_WDOG_CONTROL_PRESCALE_MAX, TWD_WDOG_LOAD_MAX,
+			timeout, rate);
+	bsearch((u32 *)&load, TWD_WDOG_LOAD_MIN, TWD_WDOG_LOAD_MAX, psc,
+			timeout, rate);
+
+	spin_lock(&wdt->lock);
+	wdt->prescale = psc;
+	wdt->load_val = load;
+
+	/* roundup timeout to closest positive integer value */
+	mpcore_margin = div_u64((psc + 1) * (load + 1) + (rate / 2), rate);
+	spin_unlock(&wdt->lock);
+
 	return 0;
 }
 
@@ -240,7 +292,10 @@ static int mpcore_wdt_probe(struct platform_device *pdev)
 	wdt->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(wdt->clk)) {
 		dev_warn(&pdev->dev, "Clock not found\n");
+		wdt->clk_rate = clk_rate;
 	} else {
+		wdt->clk_rate = clk_get_rate(wdt->clk);
+
 		ret = clk_prepare_enable(wdt->clk);
 		if (ret) {
 			dev_err(wdt->dev, "clock prepare-enable failed");
@@ -253,6 +308,12 @@ static int mpcore_wdt_probe(struct platform_device *pdev)
 
 	mpcore_wdt_stop(&wdt->wdd);
 
+	if (!wdt->clk_rate) {
+		dev_err(&pdev->dev, "Clock rate can't be zero\n");
+		ret = -EINVAL;
+		goto err_put_clk;
+	}
+
 	ret = watchdog_register_device(&wdt->wdd);
 	if (ret) {
 		dev_err(wdt->dev, "watchdog_register_device() failed: %d\n",
@@ -270,7 +331,7 @@ static int mpcore_wdt_probe(struct platform_device *pdev)
 			TIMER_MARGIN);
 	}
 
-	mpcore_wdt_set_heartbeat(NULL, mpcore_margin);
+	mpcore_wdt_set_heartbeat(&wdt->wdd, mpcore_margin);
 	dev_info(wdt->dev, "MPcore Watchdog Timer: 0.1. mpcore_noboot=%d "
 			"mpcore_margin=%d sec (nowayout= %d)\n", mpcore_noboot,
 			mpcore_margin, nowayout);
-- 
1.7.12.rc2.18.g61b472e

