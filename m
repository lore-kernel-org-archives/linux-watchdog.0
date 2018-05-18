Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54855 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeERQix (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 May 2018 12:38:53 -0400
From: Marco Felsch <m.felsch@pengutronix.de>
To: support.opensource@diasemi.com, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v5] watchdog: da9063: Fix setting/changing timeout
Date: Fri, 18 May 2018 18:38:50 +0200
Message-Id: <20180518163850.5237-1-m.felsch@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If the timeout value is set more than once the DA9063 watchdog triggers
a reset signal which reset the system.

The DA9063 watchdog timeout register field TWDSCALE combines two functions:
setting the timeout value scale and enabling the watchdog. If the
watchdog is enabled we have to disable the watchdog, wait some time due
to a HW issue and set the new timeout value. Setting the new timeout
value reenables the watchdog. 

We have to buffer the timeout value because the DA9063 can't set a
timeout without enabling the watchdog (as described above). The buffered
value will then set by the next wdt_start() call.

The patch is based on Philipp Zabel's previous patch.

Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 54 ++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index b17ac1bb1f28..1e2ecb76dcb1 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -45,10 +45,51 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
 	return DA9063_TWDSCALE_MAX;
 }
 
-static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
+/*
+ * Writing a '1' to the self-clearing WATCHDOG bit resets the watchdog counter
+ * value.
+ */
+static int _da9063_wdt_reset_timer(struct da9063 *da9063)
+{
+	return regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
+			    DA9063_WATCHDOG);
+}
+
+static int da9063_wdt_stop(struct watchdog_device *wdd);
+static int
+_da9063_wdt_set_timeout(struct watchdog_device *wdd, unsigned int regval)
 {
-	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
-				  DA9063_TWDSCALE_MASK, regval);
+	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
+	int ret = 0;
+
+	/*
+	 * The watchdog triggers a reboot if a timeout value is already
+	 * programmed because the timeout value combines two functions
+	 * in one: indicating the counter limit and starting the watchdog.
+	 * The watchdog must be disabled to be able to change the timeout
+	 * value if the watchdog is already running. Then we can set the
+	 * new timeout value which enables the watchdog again.
+	 *
+	 * We have to cache the timeout value since we can't update the value
+	 * without enabling the watchdog. This case may happen if the watchdog
+	 * is disabled and we only want to update the timeout value.
+	 */
+
+	if (watchdog_hw_running(wdd)) {
+		/* Don't try to update the value if disabling fails */
+		ret = da9063_wdt_stop(wdd);
+		if (ret)
+			goto out;
+
+		usleep_range(150, 300);
+
+		ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
+					 DA9063_TWDSCALE_MASK, regval);
+	}
+
+	wdd->timeout = regval;
+out:
+	return ret;
 }
 
 static int da9063_wdt_start(struct watchdog_device *wdd)
@@ -58,7 +99,7 @@ static int da9063_wdt_start(struct watchdog_device *wdd)
 	int ret;
 
 	selector = da9063_wdt_timeout_to_sel(wdd->timeout);
-	ret = _da9063_wdt_set_timeout(da9063, selector);
+	ret = _da9063_wdt_set_timeout(wdd, selector);
 	if (ret)
 		dev_err(da9063->dev, "Watchdog failed to start (err = %d)\n",
 			ret);
@@ -85,8 +126,7 @@ static int da9063_wdt_ping(struct watchdog_device *wdd)
 	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
 	int ret;
 
-	ret = regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
-			   DA9063_WATCHDOG);
+	ret = _da9063_wdt_reset_timer(da9063);
 	if (ret)
 		dev_alert(da9063->dev, "Failed to ping the watchdog (err = %d)\n",
 			  ret);
@@ -102,7 +142,7 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 	int ret;
 
 	selector = da9063_wdt_timeout_to_sel(timeout);
-	ret = _da9063_wdt_set_timeout(da9063, selector);
+	ret = _da9063_wdt_set_timeout(wdd, selector);
 	if (ret)
 		dev_err(da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
 			ret);
-- 
2.17.0

