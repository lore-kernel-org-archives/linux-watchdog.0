Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52543 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeERPBg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 May 2018 11:01:36 -0400
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: support.opensource@diasemi.com, linux@roeck-us.net,
        kernel@pengutronix.de
Subject: [PATCH] watchdog: da9062: remove unused code
Date: Fri, 18 May 2018 17:01:30 +0200
Message-Id: <20180518150130.14193-1-m.grzeschik@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The patch "watchdog: da9062: use protection delay mechanism from core"
(fb484262) removed the only user of j_time_stamp. This turned into some
leftover functions that are removed with this patch.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/watchdog/da9062_wdt.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index a001782bbfdb1..fe169d8e1fb2f 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -30,14 +30,8 @@ static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
 struct da9062_watchdog {
 	struct da9062 *hw;
 	struct watchdog_device wdtdev;
-	unsigned long j_time_stamp;
 };
 
-static void da9062_set_window_start(struct da9062_watchdog *wdt)
-{
-	wdt->j_time_stamp = jiffies;
-}
-
 static unsigned int da9062_wdt_timeout_to_sel(unsigned int secs)
 {
 	unsigned int i;
@@ -59,8 +53,6 @@ static int da9062_reset_watchdog_timer(struct da9062_watchdog *wdt)
 			   DA9062AA_WATCHDOG_MASK,
 			   DA9062AA_WATCHDOG_MASK);
 
-	da9062_set_window_start(wdt);
-
 	return ret;
 }
 
@@ -232,8 +224,6 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	da9062_set_window_start(wdt);
-
 	return da9062_wdt_ping(&wdt->wdtdev);
 }
 
-- 
2.17.0

