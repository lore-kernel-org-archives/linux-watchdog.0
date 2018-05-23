Return-Path: <mfe@pengutronix.de>
Return-path: <mfe@pengutronix.de>
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 3/5] watchdog: da9063: set HW_RUNNING indication during wdt_start
Date: Wed, 23 May 2018 10:27:53 +0200
Message-Id: <20180523082755.8205-4-m.felsch@pengutronix.de>
In-Reply-To: <20180523082755.8205-1-m.felsch@pengutronix.de>
References: <20180523082755.8205-1-m.felsch@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

Inform the watchdog framework that the watchog is running. Each driver
have to set this bit because the watchdog core framework clears this bit
only.

Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 0669e5cfa835..6840e505bf0a 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -86,6 +86,8 @@ static int da9063_wdt_start(struct watchdog_device *wdd)
 		dev_err(da9063->dev, "Watchdog failed to start (err = %d)\n",
 			ret);
 
+	set_bit(WDOG_HW_RUNNING, &wdd->status);
+
 	return ret;
 }
 
-- 
2.17.0
