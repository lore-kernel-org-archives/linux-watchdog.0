Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35151 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753387AbeE1Gqq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 28 May 2018 02:46:46 -0400
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org, linux@roeck-us.net,
        support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v9 2/3] watchdog: da9063: Fix updating timeout value
Date: Mon, 28 May 2018 08:45:45 +0200
Message-Id: <20180528064546.11244-3-m.felsch@pengutronix.de>
In-Reply-To: <20180528064546.11244-1-m.felsch@pengutronix.de>
References: <20180528064546.11244-1-m.felsch@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The DA9063 watchdog has only one register field to store the timeout value
and to enable the watchdog. The watchdog gets enabled if the value is
not zero. There is no issue if the watchdog is already running but it
leads into problems if the watchdog is disabled.

If the watchdog is disabled and only the timeout value should be prepared
the watchdog gets enabled too. Add a check to get the current watchdog
state and update the watchdog timeout value on hw-side only if the
watchdog is already active.

Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index c1216e61e64e..6b0092b7d5a6 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -121,10 +121,23 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 {
 	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
 	unsigned int selector;
-	int ret;
+	int ret = 0;
 
 	selector = da9063_wdt_timeout_to_sel(timeout);
-	ret = _da9063_wdt_set_timeout(da9063, selector);
+
+	/*
+	 * There are two cases when a set_timeout() will be called:
+	 * 1. The watchdog is off and someone wants to set the timeout for the
+	 *    further use.
+	 * 2. The watchdog is already running and a new timeout value should be
+	 *    set.
+	 *
+	 * The watchdog can't store a timeout value not equal zero without
+	 * enabling the watchdog, so the timeout must be buffered by the driver.
+	 */
+	if (watchdog_active(wdd))
+		ret = _da9063_wdt_set_timeout(da9063, selector);
+
 	if (ret)
 		dev_err(da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
 			ret);
-- 
2.17.0

