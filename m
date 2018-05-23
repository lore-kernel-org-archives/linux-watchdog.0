Return-Path: <mfe@pengutronix.de>
Return-path: <mfe@pengutronix.de>
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 4/5] watchdog: da9063: Fix updating timeout value
Date: Wed, 23 May 2018 10:27:54 +0200
Message-Id: <20180523082755.8205-5-m.felsch@pengutronix.de>
In-Reply-To: <20180523082755.8205-1-m.felsch@pengutronix.de>
References: <20180523082755.8205-1-m.felsch@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

The DA9063 watchdog has only one register field to store the timeout value
and to enable the watchdog. The watchdog gets enabled if the value is
not zero. There is no issue if the watchdog is already running but it
leads into problems if the watchdog is disabled.

If the watchdog is diabled and only the timeout value should be prepared
the watchdog gets enabled too. Add a check to get the current watchdog
state and update the watchdog timeout value on hw-side only if the
watchdog is already running.

Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 6840e505bf0a..e4aed95616f2 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -123,10 +123,23 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 {
 	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
 	unsigned int selector;
-	int ret;
+	int ret = 0;
 
 	selector = da9063_wdt_timeout_to_sel(timeout);
-	ret = da9063_wdt_update_timeout(da9063, selector);
+
+	/*
+	 * There are two cases when a set_timeout() will be called:
+	 * 1. The watchdog is off and someone wants to set the timeout for the
+	 *    further use.
+	 * 2. The watchdog is already running and a new timeout value should be
+	 *    set.
+	 *
+	 * We have to cache the timeout value since the watchdog can't store the
+	 * value without enable the watchdog.
+	 */
+	if (watchdog_hw_running(wdd))
+		ret = da9063_wdt_update_timeout(da9063, selector);
+
 	if (ret)
 		dev_err(da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
 			ret);
-- 
2.17.0
