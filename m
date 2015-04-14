Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:51573 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752464AbbDNH1e (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 14 Apr 2015 03:27:34 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv6 4/4] watchdog: at91sam9_wdt: Convert to use new watchdog core extensions
Date: Tue, 14 Apr 2015 10:26:52 +0300
Message-Id: <1428996412-30448-5-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1428996412-30448-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1428996412-30448-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fill in the new watchdog core parameters and call
watchdog_init_params() to let core know we are ready to support the
new core API extensions. This allows the ad hoc timer code to be
removed from the driver as the watchdog core takes care of petting the
driver as needed.

Tested-by: Wenyou Yang <wenyou.yang@atmel.com>
Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 drivers/watchdog/at91sam9_wdt.c | 58 +++++++++--------------------------------
 1 file changed, 12 insertions(+), 46 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 1443b3c..a30dadb 100644
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
@@ -83,11 +82,8 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
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
@@ -115,26 +111,11 @@ static inline void at91_wdt_reset(struct at91wdt *wdt)
 	wdt_write(wdt, AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
 }
 
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
+
+	at91_wdt_reset(wdt);
 	return 0;
 }
 
@@ -146,7 +127,7 @@ static int at91_wdt_stop(struct watchdog_device *wdd)
 
 static int at91_wdt_set_timeout(struct watchdog_device *wdd, unsigned int new_timeout)
 {
-	wdd->timeout = new_timeout;
+	/* The watchdog hardware can't be reconfigured */
 	return at91_wdt_start(wdd);
 }
 
@@ -196,11 +177,11 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 	 * it at the min_heartbeat period.
 	 */
 	if ((max_heartbeat / 4) >= min_heartbeat)
-		wdt->heartbeat = max_heartbeat / 4;
+		wdt->wdd.hw_heartbeat = max_heartbeat / 4;
 	else if ((max_heartbeat / 2) >= min_heartbeat)
-		wdt->heartbeat = max_heartbeat / 2;
+		wdt->wdd.hw_heartbeat = max_heartbeat / 2;
 	else
-		wdt->heartbeat = min_heartbeat;
+		wdt->wdd.hw_heartbeat = min_heartbeat;
 
 	if (max_heartbeat < min_heartbeat + 4)
 		dev_warn(dev,
@@ -220,32 +201,15 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 			 "watchdog already configured differently (mr = %x expecting %x)\n",
 			 tmp & wdt->mr_mask, wdt->mr & wdt->mr_mask);
 
-	setup_timer(&wdt->timer, at91_ping, (unsigned long)wdt);
+	wdt->wdd.hw_features = WDOG_HW_RUNNING_AT_BOOT;
+	watchdog_init_params(&wdt->wdd, dev);
 
-	/*
-	 * Use min_heartbeat the first time to avoid spurious watchdog reset:
-	 * we don't know for how long the watchdog counter is running, and
-	 *  - resetting it right now might trigger a watchdog fault reset
-	 *  - waiting for heartbeat time might lead to a watchdog timeout
-	 *    reset
-	 */
-	mod_timer(&wdt->timer, jiffies + min_heartbeat);
-
-	/* Try to set timeout from device tree first */
-	if (watchdog_init_timeout(&wdt->wdd, 0, dev))
-		watchdog_init_timeout(&wdt->wdd, heartbeat, dev);
 	watchdog_set_nowayout(&wdt->wdd, wdt->nowayout);
 	err = watchdog_register_device(&wdt->wdd);
 	if (err)
-		goto out_stop_timer;
-
-	wdt->next_heartbeat = jiffies + wdt->wdd.timeout * HZ;
+		return err;
 
 	return 0;
-
-out_stop_timer:
-	del_timer(&wdt->timer);
-	return err;
 }
 
 /* ......................................................................... */
@@ -287,6 +251,8 @@ static int of_at91wdt_init(struct device_node *np, struct at91wdt *wdt)
 		}
 	}
 
+	wdt->wdd.hw_max_timeout = max * HZ;
+
 	min = secs_to_ticks(min);
 	max = secs_to_ticks(max);
 
@@ -346,6 +312,7 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 	wdt->wdd.timeout = WDT_HEARTBEAT;
 	wdt->wdd.min_timeout = 1;
 	wdt->wdd.max_timeout = 0xFFFF;
+	wdt->wdd.hw_max_timeout = 15 * HZ;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdt->base = devm_ioremap_resource(&pdev->dev, r);
@@ -376,7 +343,6 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
 	watchdog_unregister_device(&wdt->wdd);
 
 	pr_warn("I quit now, hardware will probably reboot!\n");
-	del_timer(&wdt->timer);
 
 	return 0;
 }
-- 
2.1.0

