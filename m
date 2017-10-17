Return-Path: <mgr@pengutronix.de>
Return-path: <mgr@pengutronix.de>
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: lee.jones@linaro.org,
	support.opensource@diasemi.com,
	wim@iguana.be,
	linux@roeck-us.net,
	kernel@pengutronix.de
Subject: [PATCH 5/6] watchdog: da9062: use protection delay mechanism from core
Date: Tue, 17 Oct 2017 17:30:26 +0200
Message-Id: <20171017153027.24665-6-m.grzeschik@pengutronix.de>
In-Reply-To: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
References: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

This patch removes the windows protection routine that got
now covered by the wdt core.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/watchdog/da9062_wdt.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index d43e0c46e23fb..8297bcf0b9f75 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -46,22 +46,6 @@ static void da9062_set_window_start(struct da9062_watchdog *wdt)
 	wdt->j_time_stamp = jiffies;
 }
 
-static void da9062_apply_window_protection(struct da9062_watchdog *wdt)
-{
-	unsigned long delay = msecs_to_jiffies(DA9062_RESET_PROTECTION_MS);
-	unsigned long timeout = wdt->j_time_stamp + delay;
-	unsigned long now = jiffies;
-	unsigned int diff_ms;
-
-	/* if time-limit has not elapsed then wait for remainder */
-	if (time_before(now, timeout)) {
-		diff_ms = jiffies_to_msecs(timeout-now);
-		dev_dbg(wdt->hw->dev,
-			"Kicked too quickly. Delaying %u msecs\n", diff_ms);
-		msleep(diff_ms);
-	}
-}
-
 static unsigned int da9062_wdt_timeout_to_sel(unsigned int secs)
 {
 	unsigned int i;
@@ -78,8 +62,6 @@ static int da9062_reset_watchdog_timer(struct da9062_watchdog *wdt)
 {
 	int ret;
 
-	da9062_apply_window_protection(wdt);
-
 	ret = regmap_update_bits(wdt->hw->regmap,
 			   DA9062AA_CONTROL_F,
 			   DA9062AA_WATCHDOG_MASK,
@@ -256,6 +238,7 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 	wdt->wdtdev.ops = &da9062_watchdog_ops;
 	wdt->wdtdev.min_timeout = DA9062_WDT_MIN_TIMEOUT;
 	wdt->wdtdev.max_timeout = DA9062_WDT_MAX_TIMEOUT;
+	wdt->wdtdev.min_hw_heartbeat_ms = DA9062_RESET_PROTECTION_MS;
 	wdt->wdtdev.timeout = DA9062_WDG_DEFAULT_TIMEOUT;
 	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
 	wdt->wdtdev.parent = &pdev->dev;
-- 
2.11.0
