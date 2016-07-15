Return-path: <prvs=997fd3939=Rasmus.Villemoes@prevas.dk>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric
 Anholt <eric@anholt.net>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	<linux-watchdog@vger.kernel.org>, <linux-rpi-kernel@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] watchdog: bcm2835_wdt: set WDOG_HW_RUNNING bit when appropriate
Date: Fri, 15 Jul 2016 10:15:23 +0200
Message-ID: <1468570524-18222-3-git-send-email-rasmus.villemoes@prevas.dk>
In-Reply-To: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1468570524-18222-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

A bootloader may start the watchdog device before handing control to
the kernel - in that case, we should tell the kernel about it so the
watchdog framework can keep it alive until userspace opens
/dev/watchdog0.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/bcm2835_wdt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 4dddd82..9a08334 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -55,6 +55,15 @@ struct bcm2835_wdt {
 static unsigned int heartbeat;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
+static bool bcm2835_wdt_is_running(struct bcm2835_wdt *wdt)
+{
+	uint32_t cur;
+
+	cur = readl(wdt->base + PM_RSTC);
+
+	return !!(cur & PM_RSTC_WRCFG_FULL_RESET);
+}
+
 static int bcm2835_wdt_start(struct watchdog_device *wdog)
 {
 	struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
@@ -70,6 +79,7 @@ static int bcm2835_wdt_start(struct watchdog_device *wdog)
 		  PM_RSTC_WRCFG_FULL_RESET, wdt->base + PM_RSTC);
 
 	spin_unlock_irqrestore(&wdt->lock, flags);
+	set_bit(WDOG_HW_RUNNING, &wdog->status);
 
 	return 0;
 }
@@ -79,6 +89,7 @@ static int bcm2835_wdt_stop(struct watchdog_device *wdog)
 	struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
 
 	writel_relaxed(PM_PASSWORD | PM_RSTC_RESET, wdt->base + PM_RSTC);
+	clear_bit(WDOG_HW_RUNNING, &wdog->status);
 	return 0;
 }
 
@@ -181,6 +192,17 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 	watchdog_init_timeout(&bcm2835_wdt_wdd, heartbeat, dev);
 	watchdog_set_nowayout(&bcm2835_wdt_wdd, nowayout);
 	bcm2835_wdt_wdd.parent = &pdev->dev;
+	if (bcm2835_wdt_is_running(wdt)) {
+		/*
+		 * The currently active timeout value (set by the
+		 * bootloader) may be different from the module
+		 * heartbeat parameter or the value in device
+		 * tree. But we just need to set WDOG_HW_RUNNING,
+		 * because then the framework will "immediately" ping
+		 * the device, updating the timeout.
+		 */
+		set_bit(WDOG_HW_RUNNING, &bcm2835_wdt_wdd.status);
+	}
 	err = watchdog_register_device(&bcm2835_wdt_wdd);
 	if (err) {
 		dev_err(dev, "Failed to register watchdog device");
-- 
2.5.0
