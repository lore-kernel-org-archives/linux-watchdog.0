Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/4] watchdog: coh901327_wdt: Keep clock enabled after loading driver
Date: Tue,  3 Jan 2017 19:25:41 -0800
Message-Id: <1483500343-27113-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
References: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Enabling the clock before accessing chip registers and disabling it
afterwards does not really make sense and only adds complexity to
the driver. In addition to that, a comment int the driver suggests
that it does not serve a useful purpose either.

"The watchdog block is of course always clocked, the
 clk_enable()/clk_disable() calls are mainly for performing reference
 counting higher up in the clock hierarchy."

Just keep the clock enabled instead.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/coh901327_wdt.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index dc97b2fd6c49..1385a920df4f 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -74,11 +74,6 @@ static int irq;
 static void __iomem *virtbase;
 static struct device *parent;
 
-/*
- * The watchdog block is of course always clocked, the
- * clk_enable()/clk_disable() calls are mainly for performing reference
- * counting higher up in the clock hierarchy.
- */
 static struct clk *clk;
 
 /*
@@ -90,7 +85,6 @@ static void coh901327_enable(u16 timeout)
 	unsigned long freq;
 	unsigned long delay_ns;
 
-	clk_enable(clk);
 	/* Restart timer if it is disabled */
 	val = readw(virtbase + U300_WDOG_D2R);
 	if (val == U300_WDOG_D2R_DISABLE_STATUS_DISABLED)
@@ -118,7 +112,6 @@ static void coh901327_enable(u16 timeout)
 	 */
 	(void) readw(virtbase + U300_WDOG_CR);
 	val = readw(virtbase + U300_WDOG_D2R);
-	clk_disable(clk);
 	if (val != U300_WDOG_D2R_DISABLE_STATUS_ENABLED)
 		dev_err(parent,
 			"%s(): watchdog not enabled! D2R value %04x\n",
@@ -129,7 +122,6 @@ static void coh901327_disable(void)
 {
 	u16 val;
 
-	clk_enable(clk);
 	/* Disable the watchdog interrupt if it is active */
 	writew(0x0000U, virtbase + U300_WDOG_IMR);
 	/* If the watchdog is currently enabled, attempt to disable it */
@@ -144,7 +136,6 @@ static void coh901327_disable(void)
 		       virtbase + U300_WDOG_D2R);
 	}
 	val = readw(virtbase + U300_WDOG_D2R);
-	clk_disable(clk);
 	if (val != U300_WDOG_D2R_DISABLE_STATUS_DISABLED)
 		dev_err(parent,
 			"%s(): watchdog not disabled! D2R value %04x\n",
@@ -165,11 +156,9 @@ static int coh901327_stop(struct watchdog_device *wdt_dev)
 
 static int coh901327_ping(struct watchdog_device *wdd)
 {
-	clk_enable(clk);
 	/* Feed the watchdog */
 	writew(U300_WDOG_FR_FEED_RESTART_TIMER,
 	       virtbase + U300_WDOG_FR);
-	clk_disable(clk);
 	return 0;
 }
 
@@ -177,13 +166,11 @@ static int coh901327_settimeout(struct watchdog_device *wdt_dev,
 				unsigned int time)
 {
 	wdt_dev->timeout = time;
-	clk_enable(clk);
 	/* Set new timeout value */
 	writew(time * 100, virtbase + U300_WDOG_TR);
 	/* Feed the dog */
 	writew(U300_WDOG_FR_FEED_RESTART_TIMER,
 	       virtbase + U300_WDOG_FR);
-	clk_disable(clk);
 	return 0;
 }
 
@@ -191,13 +178,11 @@ static unsigned int coh901327_gettimeleft(struct watchdog_device *wdt_dev)
 {
 	u16 val;
 
-	clk_enable(clk);
 	/* Read repeatedly until the value is stable! */
 	val = readw(virtbase + U300_WDOG_CR);
 	while (val & U300_WDOG_CR_VALID_IND)
 		val = readw(virtbase + U300_WDOG_CR);
 	val &= U300_WDOG_CR_COUNT_VALUE_MASK;
-	clk_disable(clk);
 	if (val != 0)
 		val /= 100;
 
@@ -221,13 +206,11 @@ static irqreturn_t coh901327_interrupt(int irq, void *data)
 	 * to prevent a watchdog reset by feeding the watchdog at this
 	 * point.
 	 */
-	clk_enable(clk);
 	val = readw(virtbase + U300_WDOG_IER);
 	if (val == U300_WDOG_IER_WILL_BARK_IRQ_EVENT_IND)
 		writew(U300_WDOG_IER_WILL_BARK_IRQ_ACK_ENABLE,
 		       virtbase + U300_WDOG_IER);
 	writew(0x0000U, virtbase + U300_WDOG_IMR);
-	clk_disable(clk);
 	dev_crit(parent, "watchdog is barking!\n");
 	return IRQ_HANDLED;
 }
@@ -263,7 +246,7 @@ static int __exit coh901327_remove(struct platform_device *pdev)
 	watchdog_unregister_device(&coh901327_wdt);
 	coh901327_disable();
 	free_irq(irq, pdev);
-	clk_unprepare(clk);
+	clk_disable_unprepare(clk);
 	clk_put(clk);
 	iounmap(virtbase);
 	release_mem_region(phybase, physize);
@@ -352,8 +335,6 @@ static int __init coh901327_probe(struct platform_device *pdev)
 		goto out_no_irq;
 	}
 
-	clk_disable(clk);
-
 	ret = watchdog_init_timeout(&coh901327_wdt, margin, &pdev->dev);
 	if (ret < 0)
 		coh901327_wdt.timeout = 60;
-- 
2.7.4
