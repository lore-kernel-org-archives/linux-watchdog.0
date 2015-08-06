Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38130 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156AbbHFQhO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Aug 2015 12:37:14 -0400
From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, support.opensource@diasemi.com,
	kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 1/2] watchdog: da9063: Ping watchdog only during allowed time window
Date: Thu,  6 Aug 2015 18:36:58 +0200
Message-Id: <1438879019-12978-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

There is a cooldown period after watchdog timer setup, and also after each
watchdog ping. If a ping is issued too early, the watchdog triggers the
watchdog error condition and causes a system reset.

The 256 ms period length is a best guess based on the same value being used
for the DA9053 predecessor PMIC and experiments that have shown 200 ms are
not enough to avoid the error.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 88 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index e2fe2eb..b2e9201 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -35,11 +35,15 @@ static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
 #define DA9063_WDT_MIN_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MIN]
 #define DA9063_WDT_MAX_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MAX]
 #define DA9063_WDG_TIMEOUT		wdt_timeout[3]
+#define DA9063_TWDMIN			256
 
 struct da9063_watchdog {
 	struct da9063 *da9063;
 	struct watchdog_device wdtdev;
 	struct notifier_block restart_handler;
+	struct delayed_work ping_work;
+	struct mutex mutex;
+	bool defer_ping;
 };
 
 static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
@@ -54,10 +58,23 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
 	return DA9063_TWDSCALE_MAX;
 }
 
-static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
+static int _da9063_wdt_set_timeout(struct da9063_watchdog *wdt,
+				   unsigned int regval)
 {
-	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
-				  DA9063_TWDSCALE_MASK, regval);
+	struct da9063 *da9063 = wdt->da9063;
+	int ret;
+
+	mutex_lock(&wdt->mutex);
+
+	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
+				 DA9063_TWDSCALE_MASK, regval);
+
+	wdt->defer_ping = false;
+	schedule_delayed_work(&wdt->ping_work, msecs_to_jiffies(DA9063_TWDMIN));
+
+	mutex_unlock(&wdt->mutex);
+
+	return ret;
 }
 
 static int da9063_wdt_start(struct watchdog_device *wdd)
@@ -67,12 +84,16 @@ static int da9063_wdt_start(struct watchdog_device *wdd)
 	int ret;
 
 	selector = da9063_wdt_timeout_to_sel(wdt->wdtdev.timeout);
-	ret = _da9063_wdt_set_timeout(wdt->da9063, selector);
-	if (ret)
+	ret = _da9063_wdt_set_timeout(wdt, selector);
+	if (ret) {
 		dev_err(wdt->da9063->dev, "Watchdog failed to start (err = %d)\n",
 			ret);
+		return ret;
+	}
 
-	return ret;
+	wdd->timeout = wdt_timeout[selector];
+
+	return 0;
 }
 
 static int da9063_wdt_stop(struct watchdog_device *wdd)
@@ -80,6 +101,8 @@ static int da9063_wdt_stop(struct watchdog_device *wdd)
 	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
 	int ret;
 
+	cancel_delayed_work_sync(&wdt->ping_work);
+
 	ret = regmap_update_bits(wdt->da9063->regmap, DA9063_REG_CONTROL_D,
 				 DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
 	if (ret)
@@ -89,9 +112,8 @@ static int da9063_wdt_stop(struct watchdog_device *wdd)
 	return ret;
 }
 
-static int da9063_wdt_ping(struct watchdog_device *wdd)
+static int da9063_wdt_issue_ping(struct da9063_watchdog *wdt)
 {
-	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
 	int ret;
 
 	ret = regmap_write(wdt->da9063->regmap, DA9063_REG_CONTROL_F,
@@ -100,9 +122,45 @@ static int da9063_wdt_ping(struct watchdog_device *wdd)
 		dev_alert(wdt->da9063->dev, "Failed to ping the watchdog (err = %d)\n",
 			  ret);
 
+	wdt->defer_ping = false;
+	schedule_delayed_work(&wdt->ping_work, msecs_to_jiffies(DA9063_TWDMIN));
+
 	return ret;
 }
 
+static int da9063_wdt_ping(struct watchdog_device *wdd)
+{
+	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
+	int ret = 0;
+
+	mutex_lock(&wdt->mutex);
+
+	if (delayed_work_pending(&wdt->ping_work)) {
+		wdt->defer_ping = true;
+
+		goto out;
+	}
+
+	da9063_wdt_issue_ping(wdt);
+out:
+	mutex_unlock(&wdt->mutex);
+
+	return ret;
+}
+
+static void da9063_wdt_ping_work(struct work_struct *work)
+{
+	struct da9063_watchdog *wdt = container_of(to_delayed_work(work),
+					struct da9063_watchdog, ping_work);
+
+	mutex_lock(&wdt->mutex);
+
+	if (wdt->defer_ping)
+		da9063_wdt_issue_ping(wdt);
+
+	mutex_unlock(&wdt->mutex);
+}
+
 static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 				  unsigned int timeout)
 {
@@ -111,7 +169,7 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 	int ret;
 
 	selector = da9063_wdt_timeout_to_sel(timeout);
-	ret = _da9063_wdt_set_timeout(wdt->da9063, selector);
+	ret = _da9063_wdt_set_timeout(wdt, selector);
 	if (ret)
 		dev_err(wdt->da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
 			ret);
@@ -178,6 +236,9 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 
 	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
 
+	INIT_DELAYED_WORK(&wdt->ping_work, da9063_wdt_ping_work);
+	mutex_init(&wdt->mutex);
+
 	watchdog_set_drvdata(&wdt->wdtdev, wdt);
 	dev_set_drvdata(&pdev->dev, wdt);
 
@@ -202,13 +263,22 @@ static int da9063_wdt_remove(struct platform_device *pdev)
 	unregister_restart_handler(&wdt->restart_handler);
 
 	watchdog_unregister_device(&wdt->wdtdev);
+	cancel_delayed_work_sync(&wdt->ping_work);
 
 	return 0;
 }
 
+static void da9063_wdt_shutdown(struct platform_device *pdev)
+{
+	struct da9063_watchdog *wdt = dev_get_drvdata(&pdev->dev);
+
+	cancel_delayed_work_sync(&wdt->ping_work);
+}
+
 static struct platform_driver da9063_wdt_driver = {
 	.probe = da9063_wdt_probe,
 	.remove = da9063_wdt_remove,
+	.shutdown = da9063_wdt_shutdown,
 	.driver = {
 		.name = DA9063_DRVNAME_WATCHDOG,
 	},
-- 
2.4.6

