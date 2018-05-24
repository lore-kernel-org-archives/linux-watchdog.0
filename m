Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53585 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965090AbeEXH4b (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 24 May 2018 03:56:31 -0400
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org, linux@roeck-us.net,
        support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v7 3/5] watchdog: da9063: Fix updating timeout value
Date: Thu, 24 May 2018 09:56:07 +0200
Message-Id: <20180524075609.19951-4-m.felsch@pengutronix.de>
In-Reply-To: <20180524075609.19951-1-m.felsch@pengutronix.de>
References: <20180524075609.19951-1-m.felsch@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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
index 1b0ccadbc248..54c526436304 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -123,10 +123,23 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
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
+	if (watchdog_hw_running(wdd))
+		ret = _da9063_wdt_set_timeout(da9063, selector);
+
 	if (ret)
 		dev_err(da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
 			ret);
-- 
2.17.0

