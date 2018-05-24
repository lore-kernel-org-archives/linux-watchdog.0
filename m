Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35563 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967086AbeEXLvP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 24 May 2018 07:51:15 -0400
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org, linux@roeck-us.net,
        support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v8 3/4] watchdog: da9063: Fix timeout handling during probe
Date: Thu, 24 May 2018 13:51:00 +0200
Message-Id: <20180524115101.17097-4-m.felsch@pengutronix.de>
In-Reply-To: <20180524115101.17097-1-m.felsch@pengutronix.de>
References: <20180524115101.17097-1-m.felsch@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog can be enabled in previous steps (e.g. the bootloader). Check
if the watchdog is already running, retrieve the set timeout value and
set it again to set the new timeout reference mark.

Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 6b0092b7d5a6..c5bd5ffe8ded 100644
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
@@ -180,6 +192,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 {
 	struct da9063 *da9063;
 	struct watchdog_device *wdd;
+	unsigned int cur_timeout;
 
 	if (!pdev->dev.parent)
 		return -EINVAL;
@@ -206,6 +219,12 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(wdd, da9063);
 
+	cur_timeout = da9063_wdt_is_running(da9063);
+	if (cur_timeout) {
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+		_da9063_wdt_set_timeout(da9063, cur_timeout);
+	}
+
 	return devm_watchdog_register_device(&pdev->dev, wdd);
 }
 
-- 
2.17.0

