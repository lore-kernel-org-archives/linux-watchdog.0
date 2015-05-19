Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:51244 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754048AbbESI0t (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 May 2015 04:26:49 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv8 08/10] watchdog: at91sam9_wdt: Convert to use new watchdog core extensions
Date: Tue, 19 May 2015 11:26:07 +0300
Message-Id: <1432023969-20736-9-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
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
 drivers/watchdog/at91sam9_wdt.c | 73 +++++++++--------------------------------
 drivers/watchdog/watchdog_dev.c |  3 +-
 2 files changed, 18 insertions(+), 58 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 411b7a6..ef1e8d0a 100644
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
@@ -115,39 +111,17 @@ static inline void at91_wdt_reset(struct at91wdt *wdt)
 	wdt_write(wdt, AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
 }
 
-/*
- * Timer tick
- */
-static void at91_ping(unsigned long data)
-{
-	struct at91wdt *wdt = (struct at91wdt *)data;
-	if (time_before(jiffies, wdt->next_heartbeat) ||
-	    !watchdog_hw_active(&wdt->wdd)) {
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
+	at91_wdt_reset(wdt);
 	return 0;
 }
 
-static int at91_wdt_set_timeout(struct watchdog_device *wdd, unsigned int new_timeout)
+static int at91_wdt_stop(struct watchdog_device *wdd)
 {
-	wdd->timeout = new_timeout;
-	return at91_wdt_start(wdd);
+	return -ENOTSUPP;
 }
 
 static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
@@ -196,11 +170,11 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 	 * it at the min_heartbeat period.
 	 */
 	if ((max_heartbeat / 4) >= min_heartbeat)
-		wdt->heartbeat = max_heartbeat / 4;
+		wdt->wdd.hw_heartbeat = jiffies_to_msecs(max_heartbeat / 4);
 	else if ((max_heartbeat / 2) >= min_heartbeat)
-		wdt->heartbeat = max_heartbeat / 2;
+		wdt->wdd.hw_heartbeat = jiffies_to_msecs(max_heartbeat / 2);
 	else
-		wdt->heartbeat = min_heartbeat;
+		wdt->wdd.hw_heartbeat = jiffies_to_msecs(min_heartbeat);
 
 	if (max_heartbeat < min_heartbeat + 4)
 		dev_warn(dev,
@@ -220,47 +194,28 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
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
+	watchdog_set_hw_active(&wdt->wdd, 1);
+	watchdog_init_params(&wdt->wdd, dev);
 
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
 
 static const struct watchdog_info at91_wdt_info = {
 	.identity	= DRV_NAME,
-	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
-						WDIOF_MAGICCLOSE,
+	.options	= WDIOF_KEEPALIVEPING |	WDIOF_MAGICCLOSE,
 };
 
 static const struct watchdog_ops at91_wdt_ops = {
 	.owner =	THIS_MODULE,
 	.start =	at91_wdt_start,
 	.stop =		at91_wdt_stop,
-	.set_timeout =	at91_wdt_set_timeout,
 };
 
 #if defined(CONFIG_OF)
@@ -287,6 +242,8 @@ static int of_at91wdt_init(struct device_node *np, struct at91wdt *wdt)
 		}
 	}
 
+	wdt->wdd.hw_max_timeout = max * 1000;
+
 	min = secs_to_ticks(min);
 	max = secs_to_ticks(max);
 
@@ -345,7 +302,7 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 	wdt->wdd.ops = &at91_wdt_ops;
 	wdt->wdd.timeout = WDT_HEARTBEAT;
 	wdt->wdd.min_timeout = 1;
-	wdt->wdd.max_timeout = 0xFFFF;
+	wdt->wdd.hw_max_timeout = WDT_COUNTER_MAX_SECS * 1000;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdt->base = devm_ioremap_resource(&pdev->dev, r);
@@ -358,6 +315,9 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 			return err;
 	}
 
+	if (heartbeat > 0)
+		wdt->wdd.timeout = heartbeat;
+
 	err = at91_wdt_init(pdev, wdt);
 	if (err)
 		return err;
@@ -376,7 +336,6 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
 	watchdog_unregister_device(&wdt->wdd);
 
 	pr_warn("I quit now, hardware will probably reboot!\n");
-	del_timer(&wdt->timer);
 
 	return 0;
 }
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 0310eda..8f99020 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -78,7 +78,8 @@ static int watchdog_ping(struct watchdog_device *wddev)
 	if (wddev->hw_max_timeout &&
 		wddev->timeout * 1000 > wddev->hw_max_timeout) {
 		wddev->expires = jiffies + wddev->timeout * HZ;
-		schedule_delayed_work(&wddev->work, wddev->hw_heartbeat);
+		schedule_delayed_work(&wddev->work,
+				      msecs_to_jiffies(wddev->hw_heartbeat));
 	}
 
 out_ping:
-- 
2.1.0

