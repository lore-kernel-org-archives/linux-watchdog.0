Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:43305 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751536Ab2CGK3n (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 05:29:43 -0500
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 15/15] watchdog/mpcore_wdt: use correct clk_rate to program timeout
Date: Wed, 7 Mar 2012 15:57:56 +0530
Message-ID: <df077de1c4561a5d3c42260d57cfc7732d292e22.1331115752.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
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
 drivers/watchdog/mpcore_wdt.c  |  104 +++++++++++++++++++++++++++++++--------
 2 files changed, 92 insertions(+), 22 deletions(-)

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
index 9747193..fc14709 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -41,7 +41,10 @@ struct mpcore_wdt {
 	struct device	*dev;
 	void __iomem	*base;
 	struct clk	*clk;
+	unsigned long	clk_rate;	/* In Hz */
 	int		irq;
+	unsigned int	prescale;
+	unsigned int	load_val;
 	unsigned int	perturb;
 	char		expect_close;
 };
@@ -62,6 +65,11 @@ MODULE_PARM_DESC(nowayout,
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
@@ -97,17 +105,9 @@ static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
  */
 static void mpcore_wdt_keepalive(struct mpcore_wdt *wdt)
 {
-	unsigned long count;
-
 	spin_lock(&wdt_lock);
-	/* Assume prescale is set to 256 */
-	count =  __raw_readl(wdt->base + TWD_WDOG_COUNTER);
-	count = (0xFFFFFFFFU - count) * (HZ / 5);
-	count = (count / 256) * mpcore_margin;
-
-	/* Reload the counter */
-	writel(count + wdt->perturb, wdt->base + TWD_WDOG_LOAD);
-	wdt->perturb = wdt->perturb ? 0 : 1;
+	writel(wdt->load_val + wdt->perturb, wdt->base + TWD_WDOG_LOAD);
+	wdt->perturb = !wdt->perturb;
 	spin_unlock(&wdt_lock);
 }
 
@@ -122,26 +122,76 @@ static void mpcore_wdt_stop(struct mpcore_wdt *wdt)
 
 static void mpcore_wdt_start(struct mpcore_wdt *wdt)
 {
+	u32 val, mode;
+
 	dev_printk(KERN_INFO, wdt->dev, "enabling watchdog.\n");
 
 	/* This loads the count register but does NOT start the count yet */
 	mpcore_wdt_keepalive(wdt);
 
-	if (mpcore_noboot) {
-		/* Enable watchdog - prescale=256, watchdog mode=0, enable=1 */
-		writel(0x0000FF01, wdt->base + TWD_WDOG_CONTROL);
-	} else {
-		/* Enable watchdog - prescale=256, watchdog mode=1, enable=1 */
-		writel(0x0000FF09, wdt->base + TWD_WDOG_CONTROL);
+	if (mpcore_noboot)
+		mode = 0;
+	else
+		mode = TWD_WDOG_CONTROL_WDT_MODE;
+
+	spin_lock(&wdt_lock);
+
+	val = TWD_WDOG_CONTROL_WDT_PRESCALE(wdt->prescale) |
+		TWD_WDOG_CONTROL_ENABLE | mode;
+	writel(val, wdt->base + TWD_WDOG_CONTROL);
+
+	spin_unlock(&wdt_lock);
+}
+
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
 	}
+	*var = tmp;
 }
 
-static int mpcore_wdt_set_heartbeat(int t)
+static int mpcore_wdt_set_heartbeat(struct mpcore_wdt *wdt, int timeout)
 {
-	if (t < 0x0001 || t > 0xFFFF)
+	unsigned int psc, rate = wdt->clk_rate;
+	u64 load = 0;
+
+	if (timeout < 0x0001 || timeout > 0xFFFF)
 		return -EINVAL;
 
-	mpcore_margin = t;
+	/* get appropriate value of psc and load */
+	bsearch(&psc, TWD_WDOG_CONTROL_PRESCALE_MIN,
+			TWD_WDOG_CONTROL_PRESCALE_MAX, TWD_WDOG_LOAD_MAX,
+			timeout, rate);
+	bsearch((u32 *)&load, TWD_WDOG_LOAD_MIN, TWD_WDOG_LOAD_MAX, psc,
+			timeout, rate);
+
+	spin_lock(&wdt_lock);
+	wdt->prescale = psc;
+	wdt->load_val = load;
+
+	/* roundup timeout to closest positive integer value */
+	mpcore_margin = div_u64((psc + 1) * (load + 1) + (rate / 2), rate);
+	spin_unlock(&wdt_lock);
+
 	return 0;
 }
 
@@ -280,7 +330,7 @@ static long mpcore_wdt_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case WDIOC_SETTIMEOUT:
-		ret = mpcore_wdt_set_heartbeat(uarg.i);
+		ret = mpcore_wdt_set_heartbeat(wdt, uarg.i);
 		if (ret)
 			break;
 
@@ -372,6 +422,16 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt->clk)) {
 		dev_warn(&pdev->dev, "Clock not found\n");
 		wdt->clk = NULL;
+
+		wdt->clk_rate = clk_rate;
+	} else {
+		wdt->clk_rate = clk_get_rate(wdt->clk);
+	}
+
+	if (!wdt->clk_rate) {
+		dev_err(&pdev->dev, "Clock rate can't be zero\n");
+		ret = -EINVAL;
+		goto err_put_clk;
 	}
 
 	if (wdt->clk) {
@@ -394,8 +454,8 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 	 * Check that the margin value is within it's range;
 	 * if not reset to the default
 	 */
-	if (mpcore_wdt_set_heartbeat(mpcore_margin)) {
-		mpcore_wdt_set_heartbeat(TIMER_MARGIN);
+	if (mpcore_wdt_set_heartbeat(wdt, mpcore_margin)) {
+		mpcore_wdt_set_heartbeat(wdt, TIMER_MARGIN);
 		printk(KERN_INFO "mpcore_margin value must be 0 < mpcore_margin < 65536, using %d\n",
 			TIMER_MARGIN);
 	}
-- 
1.7.8.110.g4cb5d

