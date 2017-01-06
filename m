Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>,
	Eric Anholt <eric@anholt.net>,
	linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] watchdog: bcm2835_wdt: Use watchdog core to install restart handler
Date: Thu,  5 Jan 2017 19:51:58 -0800
Message-Id: <1483674720-4870-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1483674720-4870-1-git-send-email-linux@roeck-us.net>
References: <1483674720-4870-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use the infrastructure provided by the watchdog core to install
the restart handler.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Need to call watchdog_set_restart_priority()

 drivers/watchdog/bcm2835_wdt.c | 57 ++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index c32c45bd8b09..4e0adb6c88f0 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -14,7 +14,6 @@
  */
 
 #include <linux/delay.h>
-#include <linux/reboot.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/io.h>
@@ -49,7 +48,6 @@
 struct bcm2835_wdt {
 	void __iomem		*base;
 	spinlock_t		lock;
-	struct notifier_block	restart_handler;
 };
 
 static unsigned int heartbeat;
@@ -99,11 +97,37 @@ static unsigned int bcm2835_wdt_get_timeleft(struct watchdog_device *wdog)
 	return WDOG_TICKS_TO_SECS(ret & PM_WDOG_TIME_SET);
 }
 
+static void __bcm2835_restart(struct bcm2835_wdt *wdt)
+{
+	u32 val;
+
+	/* use a timeout of 10 ticks (~150us) */
+	writel_relaxed(10 | PM_PASSWORD, wdt->base + PM_WDOG);
+	val = readl_relaxed(wdt->base + PM_RSTC);
+	val &= PM_RSTC_WRCFG_CLR;
+	val |= PM_PASSWORD | PM_RSTC_WRCFG_FULL_RESET;
+	writel_relaxed(val, wdt->base + PM_RSTC);
+
+	/* No sleeping, possibly atomic. */
+	mdelay(1);
+}
+
+static int bcm2835_restart(struct watchdog_device *wdog,
+			   unsigned long action, void *data)
+{
+	struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
+
+	__bcm2835_restart(wdt);
+
+	return 0;
+}
+
 static const struct watchdog_ops bcm2835_wdt_ops = {
 	.owner =	THIS_MODULE,
 	.start =	bcm2835_wdt_start,
 	.stop =		bcm2835_wdt_stop,
 	.get_timeleft =	bcm2835_wdt_get_timeleft,
+	.restart =	bcm2835_restart,
 };
 
 static const struct watchdog_info bcm2835_wdt_info = {
@@ -120,26 +144,6 @@ static struct watchdog_device bcm2835_wdt_wdd = {
 	.timeout =	WDOG_TICKS_TO_SECS(PM_WDOG_TIME_SET),
 };
 
-static int
-bcm2835_restart(struct notifier_block *this, unsigned long mode, void *cmd)
-{
-	struct bcm2835_wdt *wdt = container_of(this, struct bcm2835_wdt,
-					       restart_handler);
-	u32 val;
-
-	/* use a timeout of 10 ticks (~150us) */
-	writel_relaxed(10 | PM_PASSWORD, wdt->base + PM_WDOG);
-	val = readl_relaxed(wdt->base + PM_RSTC);
-	val &= PM_RSTC_WRCFG_CLR;
-	val |= PM_PASSWORD | PM_RSTC_WRCFG_FULL_RESET;
-	writel_relaxed(val, wdt->base + PM_RSTC);
-
-	/* No sleeping, possibly atomic. */
-	mdelay(1);
-
-	return 0;
-}
-
 /*
  * We can't really power off, but if we do the normal reset scheme, and
  * indicate to bootcode.bin not to reboot, then most of the chip will be
@@ -163,7 +167,7 @@ static void bcm2835_power_off(void)
 	writel_relaxed(val, wdt->base + PM_RSTS);
 
 	/* Continue with normal reset mechanism */
-	bcm2835_restart(&wdt->restart_handler, REBOOT_HARD, NULL);
+	__bcm2835_restart(wdt);
 }
 
 static int bcm2835_wdt_probe(struct platform_device *pdev)
@@ -201,6 +205,9 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 		 */
 		set_bit(WDOG_HW_RUNNING, &bcm2835_wdt_wdd.status);
 	}
+
+	watchdog_set_restart_priority(&bcm2835_wdt_wdd, 128);
+
 	err = watchdog_register_device(&bcm2835_wdt_wdd);
 	if (err) {
 		dev_err(dev, "Failed to register watchdog device");
@@ -208,9 +215,6 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	wdt->restart_handler.notifier_call = bcm2835_restart;
-	wdt->restart_handler.priority = 128;
-	register_restart_handler(&wdt->restart_handler);
 	if (pm_power_off == NULL)
 		pm_power_off = bcm2835_power_off;
 
@@ -222,7 +226,6 @@ static int bcm2835_wdt_remove(struct platform_device *pdev)
 {
 	struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&wdt->restart_handler);
 	if (pm_power_off == bcm2835_power_off)
 		pm_power_off = NULL;
 	watchdog_unregister_device(&bcm2835_wdt_wdd);
-- 
2.7.4
