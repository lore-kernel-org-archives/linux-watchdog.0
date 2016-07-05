Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.phytec.co.uk ([217.6.246.34]:55939 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbcGENYr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 Jul 2016 09:24:47 -0400
From: Stefan Christ <s.christ@phytec.de>
To: linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [RFC 2/6] watchdog: da9063_wdt: use delayed work to trigger
Date: Tue, 5 Jul 2016 15:22:19 +0200
Message-Id: <1467724943-13416-3-git-send-email-s.christ@phytec.de>
In-Reply-To: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use a delayed worker to trigger the watchdog asynchronously. This avoids
blocking the caller, when the watchdog is triggered faster than 256ms.
For example the systemd init daemon triggers it at each iteration of its
mainloop.

Using schedule_delayed_work() also consolidates multiple watchdog
trigger requests in a 256ms timeframe into a single watchdog trigger
event.

TODO There is a race condition between call schedule_delayed_work() and
resetting the window start time with da9063_set_window_start().  This
leads to warnings like:

    da9063 0-0058: Kicked too quickly. Delaying 260 msecs

These are harmless, but can be fixed with correct locking.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
 drivers/watchdog/da9063_wdt.c | 54 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index f7bdfb1..a32f2cd 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -41,6 +41,7 @@ struct da9063_watchdog {
 	struct da9063 *da9063;
 	struct watchdog_device wdtdev;
 	struct notifier_block restart_handler;
+	struct delayed_work ping_work;
 	unsigned long j_time_stamp;
 };
 
@@ -49,18 +50,28 @@ static void da9063_set_window_start(struct da9063_watchdog *wdt)
 	wdt->j_time_stamp = jiffies;
 }
 
-static void da9063_apply_window_protection(struct da9063_watchdog *wdt)
+static unsigned int da9063_get_wait_time(struct da9063_watchdog *wdt)
 {
 	unsigned long delay = msecs_to_jiffies(DA9063_RESET_PROTECTION_MS);
 	unsigned long timeout = wdt->j_time_stamp + delay;
 	unsigned long now = jiffies;
-	unsigned int diff_ms;
 
 	/* if time-limit has not elapsed then wait for remainder */
 	if (time_before(now, timeout)) {
-		diff_ms = jiffies_to_msecs(timeout-now);
-		dev_dbg(wdt->da9063->dev,
-			"Kicked too quickly. Delaying %u msecs\n", diff_ms);
+		return timeout - now;
+	}
+
+	return 0; /* Watchdog can be pinged at once */
+}
+
+static void da9063_apply_window_protection(struct da9063_watchdog *wdt)
+{
+	unsigned int diff_ms = jiffies_to_msecs(da9063_get_wait_time(wdt));
+
+	/* if time-limit has not elapsed then wait for remainder */
+	if (diff_ms) {
+		dev_warn(wdt->da9063->dev,
+			 "Kicked too quickly. Delaying %u msecs\n", diff_ms);
 		msleep(diff_ms);
 	}
 }
@@ -103,6 +114,8 @@ static int da9063_wdt_start(struct watchdog_device *wdd)
 		dev_err(wdt->da9063->dev, "Watchdog failed to start (err = %d)\n",
 			ret);
 
+	da9063_set_window_start(wdt);
+
 	return ret;
 }
 
@@ -111,6 +124,12 @@ static int da9063_wdt_stop(struct watchdog_device *wdd)
 	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
 	int ret;
 
+	/*
+	 * Cancel current ping request and wait for it to finished if it's
+	 * currently running.
+	 */
+	cancel_delayed_work_sync(&wdt->ping_work);
+
 	ret = regmap_update_bits(wdt->da9063->regmap, DA9063_REG_CONTROL_D,
 				 DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
 	if (ret)
@@ -120,9 +139,14 @@ static int da9063_wdt_stop(struct watchdog_device *wdd)
 	return ret;
 }
 
-static int da9063_wdt_ping(struct watchdog_device *wdd)
+static void da9063_wdt_ping_work_now(struct work_struct *work)
 {
-	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
+	struct delayed_work *workd = container_of(work,
+						struct delayed_work,
+						work);
+	struct da9063_watchdog *wdt = container_of(workd,
+						struct da9063_watchdog,
+						ping_work);
 	int ret;
 
 	da9063_apply_window_protection(wdt);
@@ -134,8 +158,16 @@ static int da9063_wdt_ping(struct watchdog_device *wdd)
 			  ret);
 
 	da9063_set_window_start(wdt);
+}
 
-	return ret;
+static int da9063_wdt_ping(struct watchdog_device *wdd)
+{
+	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
+	unsigned int delay = da9063_get_wait_time(wdt); /* in jiffies */
+
+	schedule_delayed_work(&wdt->ping_work, delay);
+
+	return 0;
 }
 
 static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
@@ -204,6 +236,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	wdt->da9063 = da9063;
+	da9063_set_window_start(wdt);
 
 	wdt->wdtdev.info = &da9063_watchdog_info;
 	wdt->wdtdev.ops = &da9063_watchdog_ops;
@@ -227,7 +260,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 		dev_err(wdt->da9063->dev,
 			"Failed to register restart handler (err = %d)\n", ret);
 
-	da9063_set_window_start(wdt);
+	INIT_DELAYED_WORK(&(wdt->ping_work), da9063_wdt_ping_work_now);
 
 	return 0;
 }
@@ -236,6 +269,9 @@ static int da9063_wdt_remove(struct platform_device *pdev)
 {
 	struct da9063_watchdog *wdt = dev_get_drvdata(&pdev->dev);
 
+	/* Wait for delayed worker to finish. */
+	cancel_delayed_work_sync(&wdt->ping_work);
+
 	unregister_restart_handler(&wdt->restart_handler);
 
 	watchdog_unregister_device(&wdt->wdtdev);
-- 
1.9.1

