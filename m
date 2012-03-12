Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:56370 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751955Ab2CLEYK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:24:10 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 17/22] watchdog/mpcore_wdt: use correct clk_rate to program timeout
Date: Mon, 12 Mar 2012 09:52:12 +0530
Message-ID: <4d69b903be5a62ee88aa1017d5dcbf94bbe0dc8e.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Currently, mpcore wdt driver doesn't use exact clk_rate to program timeout in
hardware. This patch provides two ways of doing so:
	- either use clk_get_rate() if clk_get passes
	- use clk_rate passed via module param

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/include/asm/smp_twd.h |   10 ++++
 drivers/watchdog/mpcore_wdt.c  |   97 ++++++++++++++++++++++++++++++++-------
 2 files changed, 89 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index a13b536..389ca02 100644
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
 
 struct clock_event_device;
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 23c324c..de46b5d 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -39,7 +39,10 @@ struct mpcore_wdt {
 	void __iomem	*base;
 	spinlock_t	lock;
 	struct clk	*clk;
+	unsigned long	clk_rate;	/* In Hz */
 	int		irq;
+	unsigned int	prescale;
+	unsigned int	load_val;
 	unsigned int	perturb;
 };
 
@@ -58,6 +61,11 @@ MODULE_PARM_DESC(nowayout,
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
@@ -93,17 +101,10 @@ static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
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
@@ -135,6 +136,7 @@ static int mpcore_wdt_stop(struct watchdog_device *wdd)
 static int mpcore_wdt_start(struct watchdog_device *wdd)
 {
 	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 val, mode;
 	int ret;
 
 	dev_info(wdt->dev, "enabling watchdog.\n");
@@ -157,20 +159,70 @@ static int mpcore_wdt_start(struct watchdog_device *wdd)
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
+{
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
 {
-	mpcore_margin = t;
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
 
@@ -246,7 +298,10 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 	wdt->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(wdt->clk)) {
 		dev_warn(&pdev->dev, "Clock not found\n");
+		wdt->clk_rate = clk_rate;
 	} else {
+		wdt->clk_rate = clk_get_rate(wdt->clk);
+
 		ret = clk_prepare(wdt->clk);
 		if (ret) {
 			dev_err(wdt->dev, "clock prepare fail");
@@ -266,6 +321,12 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 
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
-- 
1.7.8.110.g4cb5d

