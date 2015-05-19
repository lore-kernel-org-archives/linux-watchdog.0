Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:51218 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754304AbbESI0o (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 May 2015 04:26:44 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv8 01/10] watchdog: Rename watchdog_active to watchdog_hw_active
Date: Tue, 19 May 2015 11:26:00 +0300
Message-Id: <1432023969-20736-2-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Before extending the watchdog core midlayer, it is useful to rename
the watchdog_active function so that it states explicitly what it
really does. That is, "active" watchdog means really that the watchdog
hardware is running and needs pinging to prevent a watchdog reset
taking place in near future.

This is different to "watchdog open" state, which simply states that
kernel is expecting the user space to keep the watchdog alive. These
states might become different mainly because some hardware have
limitations that prevent them from being stopped at will.

The actual change to the code was made with the following script:

find -name *.c | xargs sed -i -e s.watchdog_active.watchdog_hw_active.g

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 drivers/watchdog/at91sam9_wdt.c     | 2 +-
 drivers/watchdog/iTCO_wdt.c         | 2 +-
 drivers/watchdog/imx2_wdt.c         | 6 +++---
 drivers/watchdog/sp805_wdt.c        | 4 ++--
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 4 ++--
 drivers/watchdog/tegra_wdt.c        | 6 +++---
 drivers/watchdog/twl4030_wdt.c      | 4 ++--
 drivers/watchdog/ux500_wdt.c        | 4 ++--
 drivers/watchdog/via_wdt.c          | 2 +-
 drivers/watchdog/watchdog_dev.c     | 6 +++---
 include/linux/watchdog.h            | 4 ++--
 11 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 1443b3c..411b7a6 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -122,7 +122,7 @@ static void at91_ping(unsigned long data)
 {
 	struct at91wdt *wdt = (struct at91wdt *)data;
 	if (time_before(jiffies, wdt->next_heartbeat) ||
-	    !watchdog_active(&wdt->wdd)) {
+	    !watchdog_hw_active(&wdt->wdd)) {
 		at91_wdt_reset(wdt);
 		mod_timer(&wdt->timer, jiffies + wdt->heartbeat);
 	} else {
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 3c3fd41..75d7534 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -595,7 +595,7 @@ static int iTCO_wdt_suspend_noirq(struct device *dev)
 	int ret = 0;
 
 	iTCO_wdt_private.suspended = false;
-	if (watchdog_active(&iTCO_wdt_watchdog_dev) && need_suspend()) {
+	if (watchdog_hw_active(&iTCO_wdt_watchdog_dev) && need_suspend()) {
 		ret = iTCO_wdt_stop(&iTCO_wdt_watchdog_dev);
 		if (!ret)
 			iTCO_wdt_private.suspended = true;
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 5e6d808..48fcce8 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -348,7 +348,7 @@ static int imx2_wdt_suspend(struct device *dev)
 		imx2_wdt_ping(wdog);
 
 		/* The watchdog is not active */
-		if (!watchdog_active(wdog))
+		if (!watchdog_hw_active(wdog))
 			del_timer_sync(&wdev->timer);
 	}
 
@@ -365,7 +365,7 @@ static int imx2_wdt_resume(struct device *dev)
 
 	clk_prepare_enable(wdev->clk);
 
-	if (watchdog_active(wdog) && !imx2_wdt_is_running(wdev)) {
+	if (watchdog_hw_active(wdog) && !imx2_wdt_is_running(wdev)) {
 		/*
 		 * If the watchdog is still active and resumes
 		 * from deep sleep state, need to restart the
@@ -382,7 +382,7 @@ static int imx2_wdt_resume(struct device *dev)
 		 * But the watchdog is not active, then start
 		 * the timer again.
 		 */
-		if (!watchdog_active(wdog))
+		if (!watchdog_hw_active(wdog))
 			mod_timer(&wdev->timer,
 				  jiffies + wdog->timeout * HZ / 2);
 	}
diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index c1b03f4..0b0f1c406 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -262,7 +262,7 @@ static int __maybe_unused sp805_wdt_suspend(struct device *dev)
 {
 	struct sp805_wdt *wdt = dev_get_drvdata(dev);
 
-	if (watchdog_active(&wdt->wdd))
+	if (watchdog_hw_active(&wdt->wdd))
 		return wdt_disable(&wdt->wdd);
 
 	return 0;
@@ -272,7 +272,7 @@ static int __maybe_unused sp805_wdt_resume(struct device *dev)
 {
 	struct sp805_wdt *wdt = dev_get_drvdata(dev);
 
-	if (watchdog_active(&wdt->wdd))
+	if (watchdog_hw_active(&wdt->wdd))
 		return wdt_enable(&wdt->wdd);
 
 	return 0;
diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index e7f0d5b..1137262 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -98,7 +98,7 @@ static int __maybe_unused stmp3xxx_wdt_suspend(struct device *dev)
 {
 	struct watchdog_device *wdd = &stmp3xxx_wdd;
 
-	if (watchdog_active(wdd))
+	if (watchdog_hw_active(wdd))
 		return wdt_stop(wdd);
 
 	return 0;
@@ -108,7 +108,7 @@ static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
 {
 	struct watchdog_device *wdd = &stmp3xxx_wdd;
 
-	if (watchdog_active(wdd))
+	if (watchdog_hw_active(wdd))
 		return wdt_start(wdd);
 
 	return 0;
diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index 30451ea..40d4691 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -140,7 +140,7 @@ static int tegra_wdt_set_timeout(struct watchdog_device *wdd,
 {
 	wdd->timeout = timeout;
 
-	if (watchdog_active(wdd))
+	if (watchdog_hw_active(wdd))
 		return tegra_wdt_start(wdd);
 
 	return 0;
@@ -257,7 +257,7 @@ static int tegra_wdt_runtime_suspend(struct device *dev)
 {
 	struct tegra_wdt *wdt = dev_get_drvdata(dev);
 
-	if (watchdog_active(&wdt->wdd))
+	if (watchdog_hw_active(&wdt->wdd))
 		tegra_wdt_stop(&wdt->wdd);
 
 	return 0;
@@ -267,7 +267,7 @@ static int tegra_wdt_runtime_resume(struct device *dev)
 {
 	struct tegra_wdt *wdt = dev_get_drvdata(dev);
 
-	if (watchdog_active(&wdt->wdd))
+	if (watchdog_hw_active(&wdt->wdd))
 		tegra_wdt_start(&wdt->wdd);
 
 	return 0;
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 2c1db6f..118b361 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -109,7 +109,7 @@ static int twl4030_wdt_remove(struct platform_device *pdev)
 static int twl4030_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct watchdog_device *wdt = platform_get_drvdata(pdev);
-	if (watchdog_active(wdt))
+	if (watchdog_hw_active(wdt))
 		return twl4030_wdt_stop(wdt);
 
 	return 0;
@@ -118,7 +118,7 @@ static int twl4030_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 static int twl4030_wdt_resume(struct platform_device *pdev)
 {
 	struct watchdog_device *wdt = platform_get_drvdata(pdev);
-	if (watchdog_active(wdt))
+	if (watchdog_hw_active(wdt))
 		return twl4030_wdt_start(wdt);
 
 	return 0;
diff --git a/drivers/watchdog/ux500_wdt.c b/drivers/watchdog/ux500_wdt.c
index 9de09ab..6349bfa 100644
--- a/drivers/watchdog/ux500_wdt.c
+++ b/drivers/watchdog/ux500_wdt.c
@@ -124,7 +124,7 @@ static int ux500_wdt_remove(struct platform_device *dev)
 static int ux500_wdt_suspend(struct platform_device *pdev,
 			     pm_message_t state)
 {
-	if (watchdog_active(&ux500_wdt)) {
+	if (watchdog_hw_active(&ux500_wdt)) {
 		ux500_wdt_stop(&ux500_wdt);
 		prcmu_config_a9wdog(PRCMU_WDOG_CPU1, true);
 
@@ -136,7 +136,7 @@ static int ux500_wdt_suspend(struct platform_device *pdev,
 
 static int ux500_wdt_resume(struct platform_device *pdev)
 {
-	if (watchdog_active(&ux500_wdt)) {
+	if (watchdog_hw_active(&ux500_wdt)) {
 		ux500_wdt_stop(&ux500_wdt);
 		prcmu_config_a9wdog(PRCMU_WDOG_CPU1, false);
 
diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index 56369c4..b1c095c 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -91,7 +91,7 @@ static inline void wdt_reset(void)
 static void wdt_timer_tick(unsigned long data)
 {
 	if (time_before(jiffies, next_heartbeat) ||
-	   (!watchdog_active(&wdt_dev))) {
+	   (!watchdog_hw_active(&wdt_dev))) {
 		wdt_reset();
 		mod_timer(&timer, jiffies + WDT_HEARTBEAT);
 	} else
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 6aaefba..2c4d3f1 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -70,7 +70,7 @@ static int watchdog_ping(struct watchdog_device *wddev)
 		goto out_ping;
 	}
 
-	if (!watchdog_active(wddev))
+	if (!watchdog_hw_active(wddev))
 		goto out_ping;
 
 	if (wddev->ops->ping)
@@ -103,7 +103,7 @@ static int watchdog_start(struct watchdog_device *wddev)
 		goto out_start;
 	}
 
-	if (watchdog_active(wddev))
+	if (watchdog_hw_active(wddev))
 		goto out_start;
 
 	err = wddev->ops->start(wddev);
@@ -136,7 +136,7 @@ static int watchdog_stop(struct watchdog_device *wddev)
 		goto out_stop;
 	}
 
-	if (!watchdog_active(wddev))
+	if (!watchdog_hw_active(wddev))
 		goto out_stop;
 
 	if (test_bit(WDOG_NO_WAY_OUT, &wddev->status)) {
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index a746bf5..5b84578 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -90,7 +90,7 @@ struct watchdog_device {
 	struct mutex lock;
 	unsigned long status;
 /* Bit numbers for status flags */
-#define WDOG_ACTIVE		0	/* Is the watchdog running/active */
+#define WDOG_ACTIVE		0	/* Is the watchdog hw running/active */
 #define WDOG_DEV_OPEN		1	/* Opened via /dev/watchdog ? */
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
@@ -101,7 +101,7 @@ struct watchdog_device {
 #define WATCHDOG_NOWAYOUT_INIT_STATUS	(WATCHDOG_NOWAYOUT << WDOG_NO_WAY_OUT)
 
 /* Use the following function to check whether or not the watchdog is active */
-static inline bool watchdog_active(struct watchdog_device *wdd)
+static inline bool watchdog_hw_active(struct watchdog_device *wdd)
 {
 	return test_bit(WDOG_ACTIVE, &wdd->status);
 }
-- 
2.1.0

