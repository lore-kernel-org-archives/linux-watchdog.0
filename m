Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45263 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754643AbeEWI17 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 23 May 2018 04:27:59 -0400
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org, linux@roeck-us.net,
        support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v6 1/5] watchdog: da9063: rename helper function to avoid misunderstandings
Date: Wed, 23 May 2018 10:27:51 +0200
Message-Id: <20180523082755.8205-2-m.felsch@pengutronix.de>
In-Reply-To: <20180523082755.8205-1-m.felsch@pengutronix.de>
References: <20180523082755.8205-1-m.felsch@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

_da9063_wdt_set_timeout() is called from da9063_wdg_set_timeout() and
from da9063_wdg_start() but the name expect to be called only from
da9063_wdg_set_timeout(). Rename the function to avoid
misunderstandings.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index b17ac1bb1f28..10bf325598d7 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -45,7 +45,7 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
 	return DA9063_TWDSCALE_MAX;
 }
 
-static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
+static int da9063_wdt_update_timeout(struct da9063 *da9063, unsigned int regval)
 {
 	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
 				  DA9063_TWDSCALE_MASK, regval);
@@ -58,7 +58,7 @@ static int da9063_wdt_start(struct watchdog_device *wdd)
 	int ret;
 
 	selector = da9063_wdt_timeout_to_sel(wdd->timeout);
-	ret = _da9063_wdt_set_timeout(da9063, selector);
+	ret = da9063_wdt_update_timeout(da9063, selector);
 	if (ret)
 		dev_err(da9063->dev, "Watchdog failed to start (err = %d)\n",
 			ret);
@@ -102,7 +102,7 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 	int ret;
 
 	selector = da9063_wdt_timeout_to_sel(timeout);
-	ret = _da9063_wdt_set_timeout(da9063, selector);
+	ret = da9063_wdt_update_timeout(da9063, selector);
 	if (ret)
 		dev_err(da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
 			ret);
-- 
2.17.0

