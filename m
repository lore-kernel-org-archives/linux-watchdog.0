Return-Path: <mfe@pengutronix.de>
Return-path: <mfe@pengutronix.de>
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 5/5] watchdog: da9063: Fix timeout handling during probe
Date: Wed, 23 May 2018 10:27:55 +0200
Message-Id: <20180523082755.8205-6-m.felsch@pengutronix.de>
In-Reply-To: <20180523082755.8205-1-m.felsch@pengutronix.de>
References: <20180523082755.8205-1-m.felsch@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

The watchdog can be enabled in previous step (e.g. the bootloader). Check
if the watchdog is already running, retrieve the set timeout value and
set it again to set the new timeout reference mark.

Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index e4aed95616f2..a2c7c8d276cc 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -45,6 +45,19 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
 	return DA9063_TWDSCALE_MAX;
 }
 
+/*
+ * Return 0 if watchdog is disabled, else non zero.
+ */
+static int da9063_wdt_is_running(struct da9063 *da9063)
+{
+	unsigned int val;
+
+	regmap_read(da9063->regmap, DA9063_REG_CONTROL_D, &val);
+	val &= DA9063_TWDSCALE_MASK;
+
+	return wdt_timeout[val];
+}
+
 static int da9063_wdt_disable_timer(struct da9063 *da9063)
 {
 	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
@@ -182,6 +195,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 {
 	struct da9063 *da9063;
 	struct watchdog_device *wdd;
+	unsigned int cur_timeout;
 
 	if (!pdev->dev.parent)
 		return -EINVAL;
@@ -208,6 +222,12 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(wdd, da9063);
 
+	cur_timeout = da9063_wdt_is_running(da9063);
+	if (cur_timeout) {
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+		da9063_wdt_set_timeout(wdd, cur_timeout);
+	}
+
 	return devm_watchdog_register_device(&pdev->dev, wdd);
 }
 
-- 
2.17.0
