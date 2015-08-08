Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46060 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbbHHFDM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 8 Aug 2015 01:03:12 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 8/8] watchdog: at91sam9: Convert to use infrastructure triggered keepalives
Date: Fri,  7 Aug 2015 22:02:47 -0700
Message-Id: <1439010167-13818-9-git-send-email-linux@roeck-us.net>
In-Reply-To: <1439010167-13818-1-git-send-email-linux@roeck-us.net>
References: <1439010167-13818-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog infrastructure now supports handling watchdog keepalive
if the watchdog is running while the watchdog device is closed.
The infrastructure now also supports generating additional heartbeats
if the maximum hardware timeout is smaller than or close to the
configured timeout. Convert the driver to use this
infrastructure.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No changes
---
 drivers/watchdog/at91sam9_wdt.c | 102 +++++-----------------------------------
 1 file changed, 11 insertions(+), 91 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index e4698f7c5f93..0de39b52962c 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -29,7 +29,6 @@
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/jiffies.h>
-#include <linux/timer.h>
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
 #include <linux/of.h>
@@ -48,8 +47,8 @@
  * use this to convert a watchdog
  * value from/to milliseconds.
  */
-#define ticks_to_hz_rounddown(t)	((((t) + 1) * HZ) >> 8)
-#define ticks_to_hz_roundup(t)		(((((t) + 1) * HZ) + 255) >> 8)
+#define ticks_to_ms_rounddown(t)	((((t) + 1) * 1000) >> 8)
+#define ticks_to_ms_roundup(t)		(((((t) + 1) * 1000) + 255) >> 8)
 #define ticks_to_secs(t)		(((t) + 1) >> 8)
 #define secs_to_ticks(s)		((s) ? (((s) << 8) - 1) : 0)
 
@@ -64,9 +63,6 @@
 /* Hardware timeout in seconds */
 #define WDT_HW_TIMEOUT 2
 
-/* Timer heartbeat (500ms) */
-#define WDT_TIMEOUT	(HZ/2)
-
 /* User land timeout */
 #define WDT_HEARTBEAT 15
 static int heartbeat;
@@ -83,11 +79,8 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 struct at91wdt {
 	struct watchdog_device wdd;
 	void __iomem *base;
-	unsigned long next_heartbeat;	/* the next_heartbeat for the timer */
-	struct timer_list timer;	/* The timer that pings the watchdog */
 	u32 mr;
 	u32 mr_mask;
-	unsigned long heartbeat;	/* WDT heartbeat in jiffies */
 	bool nowayout;
 	unsigned int irq;
 };
@@ -107,47 +100,13 @@ static irqreturn_t wdt_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/*
- * Reload the watchdog timer.  (ie, pat the watchdog)
- */
-static inline void at91_wdt_reset(struct at91wdt *wdt)
-{
-	wdt_write(wdt, AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
-}
-
-/*
- * Timer tick
- */
-static void at91_ping(unsigned long data)
-{
-	struct at91wdt *wdt = (struct at91wdt *)data;
-	if (time_before(jiffies, wdt->next_heartbeat) ||
-	    !watchdog_active(&wdt->wdd)) {
-		at91_wdt_reset(wdt);
-		mod_timer(&wdt->timer, jiffies + wdt->heartbeat);
-	} else {
-		pr_crit("I will reset your machine !\n");
-	}
-}
-
 static int at91_wdt_start(struct watchdog_device *wdd)
 {
 	struct at91wdt *wdt = to_wdt(wdd);
-	/* calculate when the next userspace timeout will be */
-	wdt->next_heartbeat = jiffies + wdd->timeout * HZ;
-	return 0;
-}
 
-static int at91_wdt_stop(struct watchdog_device *wdd)
-{
-	/* The watchdog timer hardware can not be stopped... */
-	return 0;
-}
+	wdt_write(wdt, AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
 
-static int at91_wdt_set_timeout(struct watchdog_device *wdd, unsigned int new_timeout)
-{
-	wdd->timeout = new_timeout;
-	return at91_wdt_start(wdd);
+	return 0;
 }
 
 static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
@@ -157,8 +116,8 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 	u32 value;
 	int err;
 	u32 mask = wdt->mr_mask;
-	unsigned long min_heartbeat = 1;
-	unsigned long max_heartbeat;
+	unsigned int min_timeout = jiffies_to_msecs(1);
+	unsigned int hw_timeout;
 	struct device *dev = &pdev->dev;
 
 	tmp = wdt_read(wdt, AT91_WDT_MR);
@@ -180,31 +139,15 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 	delta = (tmp & AT91_WDT_WDD) >> 16;
 
 	if (delta < value)
-		min_heartbeat = ticks_to_hz_roundup(value - delta);
+		min_timeout = ticks_to_ms_roundup(value - delta);
 
-	max_heartbeat = ticks_to_hz_rounddown(value);
-	if (!max_heartbeat) {
+	hw_timeout = ticks_to_ms_rounddown(value);
+	if (hw_timeout < min_timeout * 2) {
 		dev_err(dev,
 			"heartbeat is too small for the system to handle it correctly\n");
 		return -EINVAL;
 	}
-
-	/*
-	 * Try to reset the watchdog counter 4 or 2 times more often than
-	 * actually requested, to avoid spurious watchdog reset.
-	 * If this is not possible because of the min_heartbeat value, reset
-	 * it at the min_heartbeat period.
-	 */
-	if ((max_heartbeat / 4) >= min_heartbeat)
-		wdt->heartbeat = max_heartbeat / 4;
-	else if ((max_heartbeat / 2) >= min_heartbeat)
-		wdt->heartbeat = max_heartbeat / 2;
-	else
-		wdt->heartbeat = min_heartbeat;
-
-	if (max_heartbeat < min_heartbeat + 4)
-		dev_warn(dev,
-			 "min heartbeat and max heartbeat might be too close for the system to handle it correctly\n");
+	wdt->wdd.max_hw_timeout_ms = hw_timeout;
 
 	if ((tmp & AT91_WDT_WDFIEN) && wdt->irq) {
 		err = request_irq(wdt->irq, wdt_interrupt,
@@ -220,32 +163,12 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 			 "watchdog already configured differently (mr = %x expecting %x)\n",
 			 tmp & wdt->mr_mask, wdt->mr & wdt->mr_mask);
 
-	setup_timer(&wdt->timer, at91_ping, (unsigned long)wdt);
-
-	/*
-	 * Use min_heartbeat the first time to avoid spurious watchdog reset:
-	 * we don't know for how long the watchdog counter is running, and
-	 *  - resetting it right now might trigger a watchdog fault reset
-	 *  - waiting for heartbeat time might lead to a watchdog timeout
-	 *    reset
-	 */
-	mod_timer(&wdt->timer, jiffies + min_heartbeat);
-
 	/* Try to set timeout from device tree first */
 	if (watchdog_init_timeout(&wdt->wdd, 0, dev))
 		watchdog_init_timeout(&wdt->wdd, heartbeat, dev);
 	watchdog_set_nowayout(&wdt->wdd, wdt->nowayout);
-	err = watchdog_register_device(&wdt->wdd);
-	if (err)
-		goto out_stop_timer;
-
-	wdt->next_heartbeat = jiffies + wdt->wdd.timeout * HZ;
-
-	return 0;
 
-out_stop_timer:
-	del_timer(&wdt->timer);
-	return err;
+	return watchdog_register_device(&wdt->wdd);
 }
 
 /* ......................................................................... */
@@ -259,8 +182,6 @@ static const struct watchdog_info at91_wdt_info = {
 static const struct watchdog_ops at91_wdt_ops = {
 	.owner =	THIS_MODULE,
 	.start =	at91_wdt_start,
-	.stop =		at91_wdt_stop,
-	.set_timeout =	at91_wdt_set_timeout,
 };
 
 #if defined(CONFIG_OF)
@@ -376,7 +297,6 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
 	watchdog_unregister_device(&wdt->wdd);
 
 	pr_warn("I quit now, hardware will probably reboot!\n");
-	del_timer(&wdt->timer);
 
 	return 0;
 }
-- 
2.1.4

