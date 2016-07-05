Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.phycard.de ([217.6.246.34]:55937 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640AbcGENYr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 Jul 2016 09:24:47 -0400
From: Stefan Christ <s.christ@phytec.de>
To: linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [RFC 1/6] watchdog: da9063_wdt: don't trigger watchdog too fast
Date: Tue, 5 Jul 2016 15:22:18 +0200
Message-Id: <1467724943-13416-2-git-send-email-s.christ@phytec.de>
In-Reply-To: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Triggering the watchdog faster than T_WDMIN=256ms leads to resets of the
da9063 chip. The datasheet says that the watchdog must only be triggered
in the timeframe T_WDMIN to T_WDMAX. The T_WDMAX is configured in the
driver.

This problem was already mentioned in the patch:

    http://comments.gmane.org/gmane.linux.watchdog/1708

You also could say that this behavior is a feature. When the userspace
goes wild, triggering the watchdog to fast, the system is reseted. But
there is currently no information in the watchdog ABI to report a
minimum wait time between two watchdog heartbeats.

The code is taken from the watchdog driver da9062_wdt.c.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
 drivers/watchdog/da9063_wdt.c | 45 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index e2fe2eb..f7bdfb1 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -35,13 +35,36 @@ static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
 #define DA9063_WDT_MIN_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MIN]
 #define DA9063_WDT_MAX_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MAX]
 #define DA9063_WDG_TIMEOUT		wdt_timeout[3]
+#define DA9063_RESET_PROTECTION_MS	256
 
 struct da9063_watchdog {
 	struct da9063 *da9063;
 	struct watchdog_device wdtdev;
 	struct notifier_block restart_handler;
+	unsigned long j_time_stamp;
 };
 
+static void da9063_set_window_start(struct da9063_watchdog *wdt)
+{
+	wdt->j_time_stamp = jiffies;
+}
+
+static void da9063_apply_window_protection(struct da9063_watchdog *wdt)
+{
+	unsigned long delay = msecs_to_jiffies(DA9063_RESET_PROTECTION_MS);
+	unsigned long timeout = wdt->j_time_stamp + delay;
+	unsigned long now = jiffies;
+	unsigned int diff_ms;
+
+	/* if time-limit has not elapsed then wait for remainder */
+	if (time_before(now, timeout)) {
+		diff_ms = jiffies_to_msecs(timeout-now);
+		dev_dbg(wdt->da9063->dev,
+			"Kicked too quickly. Delaying %u msecs\n", diff_ms);
+		msleep(diff_ms);
+	}
+}
+
 static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
 {
 	unsigned int i;
@@ -54,10 +77,18 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
 	return DA9063_TWDSCALE_MAX;
 }
 
-static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
+static int _da9063_wdt_set_timeout(struct da9063_watchdog *wdt, unsigned int regval)
 {
-	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
+	int ret;
+
+	da9063_apply_window_protection(wdt);
+
+	ret = regmap_update_bits(wdt->da9063->regmap, DA9063_REG_CONTROL_D,
 				  DA9063_TWDSCALE_MASK, regval);
+
+	da9063_set_window_start(wdt);
+
+	return ret;
 }
 
 static int da9063_wdt_start(struct watchdog_device *wdd)
@@ -67,7 +98,7 @@ static int da9063_wdt_start(struct watchdog_device *wdd)
 	int ret;
 
 	selector = da9063_wdt_timeout_to_sel(wdt->wdtdev.timeout);
-	ret = _da9063_wdt_set_timeout(wdt->da9063, selector);
+	ret = _da9063_wdt_set_timeout(wdt, selector);
 	if (ret)
 		dev_err(wdt->da9063->dev, "Watchdog failed to start (err = %d)\n",
 			ret);
@@ -94,12 +125,16 @@ static int da9063_wdt_ping(struct watchdog_device *wdd)
 	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
 	int ret;
 
+	da9063_apply_window_protection(wdt);
+
 	ret = regmap_write(wdt->da9063->regmap, DA9063_REG_CONTROL_F,
 			   DA9063_WATCHDOG);
 	if (ret)
 		dev_alert(wdt->da9063->dev, "Failed to ping the watchdog (err = %d)\n",
 			  ret);
 
+	da9063_set_window_start(wdt);
+
 	return ret;
 }
 
@@ -111,7 +146,7 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 	int ret;
 
 	selector = da9063_wdt_timeout_to_sel(timeout);
-	ret = _da9063_wdt_set_timeout(wdt->da9063, selector);
+	ret = _da9063_wdt_set_timeout(wdt, selector);
 	if (ret)
 		dev_err(wdt->da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
 			ret);
@@ -192,6 +227,8 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 		dev_err(wdt->da9063->dev,
 			"Failed to register restart handler (err = %d)\n", ret);
 
+	da9063_set_window_start(wdt);
+
 	return 0;
 }
 
-- 
1.9.1

