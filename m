Return-Path: <mfe@pengutronix.de>
Return-path: <mfe@pengutronix.de>
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v9 3/3] watchdog: da9063: Fix timeout handling during probe
Date: Mon, 28 May 2018 08:45:46 +0200
Message-Id: <20180528064546.11244-4-m.felsch@pengutronix.de>
In-Reply-To: <20180528064546.11244-1-m.felsch@pengutronix.de>
References: <20180528064546.11244-1-m.felsch@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

The watchdog can be enabled in previous steps (e.g. the bootloader). Set
the driver default timeout value (8s) if the watchdog is already running
and the HW_RUNNING flag. So the watchdog core framework will ping the
watchdog till the user space activates the watchdog explicit with the
desired timeout value.

Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 6b0092b7d5a6..a4380a887e85 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -45,6 +45,18 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
 	return DA9063_TWDSCALE_MAX;
 }
 
+/*
+ * Return 0 if watchdog is disabled, else non zero.
+ */
+static unsigned int da9063_wdt_is_running(struct da9063 *da9063)
+{
+	unsigned int val;
+
+	regmap_read(da9063->regmap, DA9063_REG_CONTROL_D, &val);
+
+	return val & DA9063_TWDSCALE_MASK;
+}
+
 static int da9063_wdt_disable_timer(struct da9063 *da9063)
 {
 	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
@@ -206,6 +218,15 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(wdd, da9063);
 
+	/* Change the timeout to the default value if the watchdog is running */
+	if (da9063_wdt_is_running(da9063)) {
+		unsigned int timeout;
+
+		timeout = da9063_wdt_timeout_to_sel(DA9063_WDG_TIMEOUT);
+		_da9063_wdt_set_timeout(da9063, timeout);
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+	}
+
 	return devm_watchdog_register_device(&pdev->dev, wdd);
 }
 
-- 
2.17.0
