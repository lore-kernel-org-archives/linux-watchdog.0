Return-Path: <mgr@pengutronix.de>
Return-path: <mgr@pengutronix.de>
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: lee.jones@linaro.org,
	support.opensource@diasemi.com,
	wim@iguana.be,
	linux@roeck-us.net,
	kernel@pengutronix.de,
	Stefan Christ <s.christ@phytec.de>
Subject: [PATCH 3/6] watchdog: da9062: reset board on watchdog timeout
Date: Tue, 17 Oct 2017 17:30:24 +0200
Message-Id: <20171017153027.24665-4-m.grzeschik@pengutronix.de>
In-Reply-To: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
References: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

From: Stefan Christ <s.christ@phytec.de>

In the default fuse configuration the watchdog poweroffs the system
instead of resetting it on a watchdog timeout. This patch changes the
behavior. Now the board is reseted and reboots.

Note: This patch requires that the config register CONFIG_I is
configured as writable in the da9062 multi function device.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
Signed-off-by: Christian Hemp <c.hemp@phytec.de>
---
 drivers/watchdog/da9062_wdt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index 4349a02215489..b95719b349e5c 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -112,6 +112,20 @@ static int da9062_wdt_start(struct watchdog_device *wdd)
 	unsigned int selector;
 	int ret;
 
+	/*
+	 * Use da9062's SHUTDOWN mode instead of POWERDOWN for watchdog reset.
+	 * On timeout the PMIC should reset the system, not powering it
+	 * off.
+	 */
+	ret = regmap_update_bits(wdt->hw->regmap,
+				 DA9062AA_CONFIG_I,
+				 DA9062AA_WATCHDOG_SD_MASK,
+				 DA9062AA_WATCHDOG_SD_MASK);
+	if (ret)
+		dev_err(wdt->hw->dev,
+			"failed to set wdt reset mode. Expect poweroff on watchdog reset: %d\n",
+			ret);
+
 	selector = da9062_wdt_timeout_to_sel(wdt->wdtdev.timeout);
 	ret = da9062_wdt_update_timeout_register(wdt, selector);
 	if (ret)
-- 
2.11.0
