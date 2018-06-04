Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59301 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeFDJm5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 4 Jun 2018 05:42:57 -0400
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org, linux@roeck-us.net,
        support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] watchdog: da9063: rename helper function to avoid misunderstandings
Date: Mon,  4 Jun 2018 11:42:40 +0200
Message-Id: <20180604094241.30937-2-m.felsch@pengutronix.de>
In-Reply-To: <20180604094241.30937-1-m.felsch@pengutronix.de>
References: <20180604094241.30937-1-m.felsch@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

_da9063_wdt_set_timeout() is called by da9063_wdt_set_timeout(),
da9063_wdt_start() and da9063_wdt_probe() but the name expect only to be
called by da9063_wdg_set_timeout(). Rename the function to avoid
misunderstandings.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index a4380a887e85..760aa9bca81b 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -64,7 +64,7 @@ static int da9063_wdt_disable_timer(struct da9063 *da9063)
 				  DA9063_TWDSCALE_DISABLE);
 }
 
-static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
+static int da9063_wdt_update_timeout(struct da9063 *da9063, unsigned int regval)
 {
 	int ret;
 
@@ -93,7 +93,7 @@ static int da9063_wdt_start(struct watchdog_device *wdd)
 	int ret;
 
 	selector = da9063_wdt_timeout_to_sel(wdd->timeout);
-	ret = _da9063_wdt_set_timeout(da9063, selector);
+	ret = da9063_wdt_update_timeout(da9063, selector);
 	if (ret)
 		dev_err(da9063->dev, "Watchdog failed to start (err = %d)\n",
 			ret);
@@ -148,7 +148,7 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 	 * enabling the watchdog, so the timeout must be buffered by the driver.
 	 */
 	if (watchdog_active(wdd))
-		ret = _da9063_wdt_set_timeout(da9063, selector);
+		ret = da9063_wdt_update_timeout(da9063, selector);
 
 	if (ret)
 		dev_err(da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
@@ -223,7 +223,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 		unsigned int timeout;
 
 		timeout = da9063_wdt_timeout_to_sel(DA9063_WDG_TIMEOUT);
-		_da9063_wdt_set_timeout(da9063, timeout);
+		da9063_wdt_update_timeout(da9063, timeout);
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
 	}
 
-- 
2.17.1

