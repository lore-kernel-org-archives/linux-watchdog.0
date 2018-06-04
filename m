Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49971 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeFDJm6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 4 Jun 2018 05:42:58 -0400
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org, linux@roeck-us.net,
        support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] watchdog: da9063: remove duplicated timeout_to_sel calls
Date: Mon,  4 Jun 2018 11:42:41 +0200
Message-Id: <20180604094241.30937-3-m.felsch@pengutronix.de>
In-Reply-To: <20180604094241.30937-1-m.felsch@pengutronix.de>
References: <20180604094241.30937-1-m.felsch@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Every time da9063_wdt_update_timeout() gets called a timeout_to_sel() is
made because the timeout argument of update_timeout() is the raw
register value. Moving the second<->raw-value translation into
da9063_wdt_update_timeout() removes duplicated code.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 760aa9bca81b..8007839fb3c0 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -64,8 +64,9 @@ static int da9063_wdt_disable_timer(struct da9063 *da9063)
 				  DA9063_TWDSCALE_DISABLE);
 }
 
-static int da9063_wdt_update_timeout(struct da9063 *da9063, unsigned int regval)
+static int da9063_wdt_update_timeout(struct da9063 *da9063, unsigned int timeout)
 {
+	unsigned int regval;
 	int ret;
 
 	/*
@@ -81,6 +82,7 @@ static int da9063_wdt_update_timeout(struct da9063 *da9063, unsigned int regval)
 		return ret;
 
 	usleep_range(150, 300);
+	regavl = da9063_wdt_timeout_to_sel(timeout);
 
 	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
 				  DA9063_TWDSCALE_MASK, regval);
@@ -89,11 +91,9 @@ static int da9063_wdt_update_timeout(struct da9063 *da9063, unsigned int regval)
 static int da9063_wdt_start(struct watchdog_device *wdd)
 {
 	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
-	unsigned int selector;
 	int ret;
 
-	selector = da9063_wdt_timeout_to_sel(wdd->timeout);
-	ret = da9063_wdt_update_timeout(da9063, selector);
+	ret = da9063_wdt_update_timeout(da9063, wdd->timeout);
 	if (ret)
 		dev_err(da9063->dev, "Watchdog failed to start (err = %d)\n",
 			ret);
@@ -132,11 +132,8 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 				  unsigned int timeout)
 {
 	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
-	unsigned int selector;
 	int ret = 0;
 
-	selector = da9063_wdt_timeout_to_sel(timeout);
-
 	/*
 	 * There are two cases when a set_timeout() will be called:
 	 * 1. The watchdog is off and someone wants to set the timeout for the
@@ -148,13 +145,13 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 	 * enabling the watchdog, so the timeout must be buffered by the driver.
 	 */
 	if (watchdog_active(wdd))
-		ret = da9063_wdt_update_timeout(da9063, selector);
+		ret = da9063_wdt_update_timeout(da9063, timeout);
 
 	if (ret)
 		dev_err(da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
 			ret);
 	else
-		wdd->timeout = wdt_timeout[selector];
+		wdd->timeout = wdt_timeout[da9063_wdt_timeout_to_sel(timeout)];
 
 	return ret;
 }
@@ -220,10 +217,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 
 	/* Change the timeout to the default value if the watchdog is running */
 	if (da9063_wdt_is_running(da9063)) {
-		unsigned int timeout;
-
-		timeout = da9063_wdt_timeout_to_sel(DA9063_WDG_TIMEOUT);
-		da9063_wdt_update_timeout(da9063, timeout);
+		da9063_wdt_update_timeout(da9063, DA9063_WDG_TIMEOUT);
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
 	}
 
-- 
2.17.1

