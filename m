Return-Path: <mgr@pengutronix.de>
Return-path: <mgr@pengutronix.de>
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: lee.jones@linaro.org,
	support.opensource@diasemi.com,
	wim@iguana.be,
	linux@roeck-us.net,
	kernel@pengutronix.de
Subject: [PATCH 4/6] watchdog: da9062: Disable and wait before changing timeout
Date: Tue, 17 Oct 2017 17:30:25 +0200
Message-Id: <20171017153027.24665-5-m.grzeschik@pengutronix.de>
In-Reply-To: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
References: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

The DA9062 watchdog occasionally enters error condition and resets the
system if the timeout is changed quickly after the timer was enabled.

The method of disabling and waiting for > 150 µs before setting the
new timeout is taken from the DA9052 driver.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/watchdog/da9062_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index b95719b349e5c..d43e0c46e23fb 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -100,6 +100,13 @@ static int da9062_wdt_update_timeout_register(struct da9062_watchdog *wdt,
 	if (ret)
 		return ret;
 
+	regmap_update_bits(chip->regmap,
+				  DA9062AA_CONTROL_D,
+				  DA9062AA_TWDSCALE_MASK,
+				  DA9062_TWDSCALE_DISABLE);
+
+	usleep_range(150, 300);
+
 	return regmap_update_bits(chip->regmap,
 				  DA9062AA_CONTROL_D,
 				  DA9062AA_TWDSCALE_MASK,
-- 
2.11.0
