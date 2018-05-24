Return-Path: <mfe@pengutronix.de>
Return-path: <mfe@pengutronix.de>
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v8 4/4] watchdog: da9063: rename helper function to avoid misunderstandings
Date: Thu, 24 May 2018 13:51:01 +0200
Message-Id: <20180524115101.17097-5-m.felsch@pengutronix.de>
In-Reply-To: <20180524115101.17097-1-m.felsch@pengutronix.de>
References: <20180524115101.17097-1-m.felsch@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

_da9063_wdt_set_timeout() is called from da9063_wdg_set_timeout() and
from da9063_wdg_start() but the name expect to be called only from
da9063_wdg_set_timeout(). Rename the function to avoid
misunderstandings.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index c5bd5ffe8ded..d6e30a1e6535 100644
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
@@ -222,7 +222,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	cur_timeout = da9063_wdt_is_running(da9063);
 	if (cur_timeout) {
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
-		_da9063_wdt_set_timeout(da9063, cur_timeout);
+		da9063_wdt_update_timeout(da9063, cur_timeout);
 	}
 
 	return devm_watchdog_register_device(&pdev->dev, wdd);
-- 
2.17.0
