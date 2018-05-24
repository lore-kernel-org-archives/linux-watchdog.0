Return-Path: <mfe@pengutronix.de>
Return-path: <mfe@pengutronix.de>
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v7 5/5] watchdog: da9063: rename helper function to avoid misunderstandings
Date: Thu, 24 May 2018 09:56:09 +0200
Message-Id: <20180524075609.19951-6-m.felsch@pengutronix.de>
In-Reply-To: <20180524075609.19951-1-m.felsch@pengutronix.de>
References: <20180524075609.19951-1-m.felsch@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

_da9063_wdt_set_timeout() is called from da9063_wdg_set_timeout() and
from da9063_wdg_start() but the name expect to be called only from
da9063_wdg_set_timeout(). Rename the function to avoid
misunderstandings.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 9056fa945c01..5a2a8ef39491 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -65,7 +65,7 @@ static int da9063_wdt_disable_timer(struct da9063 *da9063)
 				  DA9063_TWDSCALE_DISABLE);
 }
 
-static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
+static int da9063_wdt_update_timeout(struct da9063 *da9063, unsigned int regval)
 {
 	int ret;
 
@@ -94,7 +94,7 @@ static int da9063_wdt_start(struct watchdog_device *wdd)
 	int ret;
 
 	selector = da9063_wdt_timeout_to_sel(wdd->timeout);
-	ret = _da9063_wdt_set_timeout(da9063, selector);
+	ret = da9063_wdt_update_timeout(da9063, selector);
 	if (ret)
 		dev_err(da9063->dev, "Watchdog failed to start (err = %d)\n",
 			ret);
@@ -151,7 +151,7 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 	 * enabling the watchdog, so the timeout must be buffered by the driver.
 	 */
 	if (watchdog_hw_running(wdd))
-		ret = _da9063_wdt_set_timeout(da9063, selector);
+		ret = da9063_wdt_update_timeout(da9063, selector);
 
 	if (ret)
 		dev_err(da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
-- 
2.17.0
