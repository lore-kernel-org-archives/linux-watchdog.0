Return-Path: <mgr@pengutronix.de>
Return-path: <mgr@pengutronix.de>
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: lee.jones@linaro.org,
	support.opensource@diasemi.com,
	wim@iguana.be,
	linux@roeck-us.net,
	kernel@pengutronix.de
Subject: [PATCH 6/6] watchdog: da9062: add protective delay before stop
Date: Tue, 17 Oct 2017 17:30:27 +0200
Message-Id: <20171017153027.24665-7-m.grzeschik@pengutronix.de>
In-Reply-To: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
References: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

In case some application was writing to the watchdog before closing we
have to ensure that we add enough delay before writing again to the
DA9062AA_CONTROL_F register. The delay otherwise can only be ensured by
min_hw_heartbeat_ms for pings.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/watchdog/da9062_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index 8297bcf0b9f75..1fe88826c6981 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -129,6 +129,8 @@ static int da9062_wdt_stop(struct watchdog_device *wdd)
 	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
 	int ret;
 
+	mdelay(DA9062_RESET_PROTECTION_MS);
+
 	ret = da9062_reset_watchdog_timer(wdt);
 	if (ret) {
 		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err = %d)\n",
-- 
2.11.0
