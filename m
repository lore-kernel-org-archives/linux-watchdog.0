Return-path: <ben.dooks@codethink.co.uk>
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Barry Song <baohua@kernel.org>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] watchdog: sirf: fix __iomem * warnings
Date: Tue,  7 Jun 2016 12:53:07 +0100
Message-Id: <1465300387-20629-1-git-send-email-ben.dooks@codethink.co.uk>
List-ID: <linux-watchdog@vger.kernel.org>

Fix the following warnings from sparse due to casting to/from an __iomem
annotated variable:

drivers/watchdog/sirfsoc_wdt.c:48:18: warning: incorrect type in assignment (different address spaces)
drivers/watchdog/sirfsoc_wdt.c:48:18:    expected void [noderef] <asn:2>*wdt_base
drivers/watchdog/sirfsoc_wdt.c:48:18:    got void *
drivers/watchdog/sirfsoc_wdt.c:64:18: warning: incorrect type in assignment (different address spaces)
drivers/watchdog/sirfsoc_wdt.c:64:18:    expected void [noderef] <asn:2>*wdt_base
drivers/watchdog/sirfsoc_wdt.c:64:18:    got void *
drivers/watchdog/sirfsoc_wdt.c:82:54: warning: incorrect type in initializer (different address spaces)
drivers/watchdog/sirfsoc_wdt.c:82:54:    expected void [noderef] <asn:2>*wdt_base
drivers/watchdog/sirfsoc_wdt.c:82:54:    got void *
drivers/watchdog/sirfsoc_wdt.c:99:54: warning: incorrect type in initializer (different address spaces)
drivers/watchdog/sirfsoc_wdt.c:99:54:    expected void [noderef] <asn:2>*wdt_base
drivers/watchdog/sirfsoc_wdt.c:99:54:    got void *
drivers/watchdog/sirfsoc_wdt.c:153:44: warning: incorrect type in argument 2 (different address spaces)
drivers/watchdog/sirfsoc_wdt.c:153:44:    expected void *data
drivers/watchdog/sirfsoc_wdt.c:153:44:    got void [noderef] <asn:2>*[assigned] base

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Barry Song <baohua@kernel.org>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/watchdog/sirfsoc_wdt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index d0578ab..3050a00 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -39,13 +39,18 @@ MODULE_PARM_DESC(timeout, "Default watchdog timeout (in seconds)");
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+static void __iomem *sirfsoc_wdt_base(struct watchdog_device *wdd)
+{
+	return (void __iomem __force *)watchdog_get_drvdata(wdd);
+}
+
 static unsigned int sirfsoc_wdt_gettimeleft(struct watchdog_device *wdd)
 {
 	u32 counter, match;
 	void __iomem *wdt_base;
 	int time_left;
 
-	wdt_base = watchdog_get_drvdata(wdd);
+	wdt_base = sirfsoc_wdt_base(wdd);
 	counter = readl(wdt_base + SIRFSOC_TIMER_COUNTER_LO);
 	match = readl(wdt_base +
 		SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
@@ -61,7 +66,7 @@ static int sirfsoc_wdt_updatetimeout(struct watchdog_device *wdd)
 	void __iomem *wdt_base;
 
 	timeout_ticks = wdd->timeout * CLOCK_FREQ;
-	wdt_base = watchdog_get_drvdata(wdd);
+	wdt_base = sirfsoc_wdt_base(wdd);
 
 	/* Enable the latch before reading the LATCH_LO register */
 	writel(1, wdt_base + SIRFSOC_TIMER_LATCH);
@@ -79,7 +84,7 @@ static int sirfsoc_wdt_updatetimeout(struct watchdog_device *wdd)
 
 static int sirfsoc_wdt_enable(struct watchdog_device *wdd)
 {
-	void __iomem *wdt_base = watchdog_get_drvdata(wdd);
+	void __iomem *wdt_base = sirfsoc_wdt_base(wdd);
 	sirfsoc_wdt_updatetimeout(wdd);
 
 	/*
@@ -96,7 +101,7 @@ static int sirfsoc_wdt_enable(struct watchdog_device *wdd)
 
 static int sirfsoc_wdt_disable(struct watchdog_device *wdd)
 {
-	void __iomem *wdt_base = watchdog_get_drvdata(wdd);
+	void __iomem *wdt_base = sirfsoc_wdt_base(wdd);
 
 	writel(0, wdt_base + SIRFSOC_TIMER_WATCHDOG_EN);
 	writel(readl(wdt_base + SIRFSOC_TIMER_INT_EN)
@@ -150,7 +155,7 @@ static int sirfsoc_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	watchdog_set_drvdata(&sirfsoc_wdd, base);
+	watchdog_set_drvdata(&sirfsoc_wdd, (__force void *)base);
 
 	watchdog_init_timeout(&sirfsoc_wdd, timeout, &pdev->dev);
 	watchdog_set_nowayout(&sirfsoc_wdd, nowayout);
-- 
2.8.1
