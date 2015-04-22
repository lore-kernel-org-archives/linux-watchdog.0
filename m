Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:58628 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756897AbbDVLMD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Apr 2015 07:12:03 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv7 6/8] watchdog: imx2_wdt: Convert to use new core extensions
Date: Wed, 22 Apr 2015 14:11:40 +0300
Message-Id: <1429701102-22320-7-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fill in the HW capabilities in watchdog_device structure and call
watchdgog_init_params() to let watchdog core to init itself
properly. The watchdog core can then ping stopped watchdog and the
timer code in the driver can be removed.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 drivers/watchdog/imx2_wdt.c | 43 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 5e6d808..8be8006 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -62,7 +62,6 @@
 struct imx2_wdt_device {
 	struct clk *clk;
 	struct regmap *regmap;
-	struct timer_list timer;	/* Pings the watchdog when closed */
 	struct watchdog_device wdog;
 	struct notifier_block restart_handler;
 };
@@ -151,21 +150,13 @@ static int imx2_wdt_ping(struct watchdog_device *wdog)
 	return 0;
 }
 
-static void imx2_wdt_timer_ping(unsigned long arg)
-{
-	struct watchdog_device *wdog = (struct watchdog_device *)arg;
-	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
-
-	/* ping it every wdog->timeout / 2 seconds to prevent reboot */
-	imx2_wdt_ping(wdog);
-	mod_timer(&wdev->timer, jiffies + wdog->timeout * HZ / 2);
-}
-
 static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
 				unsigned int new_timeout)
 {
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 
+	wdog->hw_heartbeat = new_timeout * HZ / 2;
+	wdog->timeout = new_timeout;
 	regmap_update_bits(wdev->regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
 			   WDOG_SEC_TO_COUNT(new_timeout));
 	return 0;
@@ -176,8 +167,6 @@ static int imx2_wdt_start(struct watchdog_device *wdog)
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 
 	if (imx2_wdt_is_running(wdev)) {
-		/* delete the timer that pings the watchdog after close */
-		del_timer_sync(&wdev->timer);
 		imx2_wdt_set_timeout(wdog, wdog->timeout);
 	} else
 		imx2_wdt_setup(wdog);
@@ -191,7 +180,7 @@ static int imx2_wdt_stop(struct watchdog_device *wdog)
 	 * We don't need a clk_disable, it cannot be disabled once started.
 	 * We use a timer to ping the watchdog while /dev/watchdog is closed
 	 */
-	imx2_wdt_timer_ping((unsigned long)wdog);
+	imx2_wdt_ping(wdog);
 	return 0;
 }
 
@@ -201,7 +190,7 @@ static inline void imx2_wdt_ping_if_active(struct watchdog_device *wdog)
 
 	if (imx2_wdt_is_running(wdev)) {
 		imx2_wdt_set_timeout(wdog, wdog->timeout);
-		imx2_wdt_timer_ping((unsigned long)wdog);
+		imx2_wdt_ping(wdog);
 	}
 }
 
@@ -256,6 +245,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	wdog->ops		= &imx2_wdt_ops;
 	wdog->min_timeout	= 1;
 	wdog->max_timeout	= IMX2_WDT_MAX_TIME;
+	wdog->hw_max_timeout	= wdog->max_timeout * HZ;
 
 	clk_prepare_enable(wdev->clk);
 
@@ -267,12 +257,12 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "Initial timeout out of range! Clamped from %u to %u\n",
 			 timeout, wdog->timeout);
 
+	wdog->timeout = timeout;
+	wdog->hw_heartbeat = timeout * HZ / 2;
 	platform_set_drvdata(pdev, wdog);
 	watchdog_set_drvdata(wdog, wdev);
 	watchdog_set_nowayout(wdog, nowayout);
-	watchdog_init_timeout(wdog, timeout, &pdev->dev);
-
-	setup_timer(&wdev->timer, imx2_wdt_timer_ping, (unsigned long)wdog);
+	watchdog_init_params(wdog, &pdev->dev);
 
 	imx2_wdt_ping_if_active(wdog);
 
@@ -311,7 +301,6 @@ static int __exit imx2_wdt_remove(struct platform_device *pdev)
 	watchdog_unregister_device(wdog);
 
 	if (imx2_wdt_is_running(wdev)) {
-		del_timer_sync(&wdev->timer);
 		imx2_wdt_ping(wdog);
 		dev_crit(&pdev->dev, "Device removed: Expect reboot!\n");
 	}
@@ -325,10 +314,9 @@ static void imx2_wdt_shutdown(struct platform_device *pdev)
 
 	if (imx2_wdt_is_running(wdev)) {
 		/*
-		 * We are running, we need to delete the timer but will
-		 * give max timeout before reboot will take place
+		 * We are running, give max timeout before reboot will
+		 * take place
 		 */
-		del_timer_sync(&wdev->timer);
 		imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
 		imx2_wdt_ping(wdog);
 		dev_crit(&pdev->dev, "Device shutdown: Expect reboot!\n");
@@ -346,10 +334,6 @@ static int imx2_wdt_suspend(struct device *dev)
 	if (imx2_wdt_is_running(wdev)) {
 		imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
 		imx2_wdt_ping(wdog);
-
-		/* The watchdog is not active */
-		if (!watchdog_active(wdog))
-			del_timer_sync(&wdev->timer);
 	}
 
 	clk_disable_unprepare(wdev->clk);
@@ -378,13 +362,6 @@ static int imx2_wdt_resume(struct device *dev)
 		/* Resuming from non-deep sleep state. */
 		imx2_wdt_set_timeout(wdog, wdog->timeout);
 		imx2_wdt_ping(wdog);
-		/*
-		 * But the watchdog is not active, then start
-		 * the timer again.
-		 */
-		if (!watchdog_active(wdog))
-			mod_timer(&wdev->timer,
-				  jiffies + wdog->timeout * HZ / 2);
 	}
 
 	return 0;
-- 
2.1.0

