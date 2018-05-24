Return-Path: <mfe@pengutronix.de>
Return-path: <mfe@pengutronix.de>
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v7 2/5] watchdog: da9063: Fix setting HW_RUNNING indication during wdt_start
Date: Thu, 24 May 2018 09:56:06 +0200
Message-Id: <20180524075609.19951-3-m.felsch@pengutronix.de>
In-Reply-To: <20180524075609.19951-1-m.felsch@pengutronix.de>
References: <20180524075609.19951-1-m.felsch@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

Inform the watchdog framework that the watchog is running. Each driver
have to set this bit because the watchdog core framework only clears
this bit.

Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index c1216e61e64e..1b0ccadbc248 100644
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
