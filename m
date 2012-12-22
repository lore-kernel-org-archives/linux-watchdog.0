Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:62386 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab2LVDHO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 21 Dec 2012 22:07:14 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so3193294pac.1
        for <linux-watchdog@vger.kernel.org>; Fri, 21 Dec 2012 19:07:14 -0800 (PST)
Message-ID: <1356145621.11884.1.camel@phoenix>
Subject: [PATCH] watchdog: da9055: Don't update wdt_dev->timeout in
 da9055_wdt_set_timeout error path
From: Axel Lin <axel.lin@ingics.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: David Dajun Chen <dchen@diasemi.com>,
	Ashish Jangam <ashish.jangam@kpitcummins.com>,
	linux-watchdog@vger.kernel.org
Date: Sat, 22 Dec 2012 11:07:01 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Otherwise, WDIOC_GETTIMEOUT returns wrong value if set_timeout fails.
This patch also removes unnecessary ret variable in da9055_wdt_ping function.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/watchdog/da9055_wdt.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
index 31d5379..f5ad105 100644
--- a/drivers/watchdog/da9055_wdt.c
+++ b/drivers/watchdog/da9055_wdt.c
@@ -72,20 +72,21 @@ static int da9055_wdt_set_timeout(struct watchdog_device *wdt_dev,
 					DA9055_TWDSCALE_MASK,
 					da9055_wdt_maps[i].reg_val <<
 					DA9055_TWDSCALE_SHIFT);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(da9055->dev,
 			"Failed to update timescale bit, %d\n", ret);
+		return ret;
+	}
 
 	wdt_dev->timeout = timeout;
 
-	return ret;
+	return 0;
 }
 
 static int da9055_wdt_ping(struct watchdog_device *wdt_dev)
 {
 	struct da9055_wdt_data *driver_data = watchdog_get_drvdata(wdt_dev);
 	struct da9055 *da9055 = driver_data->da9055;
-	int ret;
 
 	/*
 	 * We have a minimum time for watchdog window called TWDMIN. A write
@@ -94,10 +95,8 @@ static int da9055_wdt_ping(struct watchdog_device *wdt_dev)
 	mdelay(DA9055_TWDMIN);
 
 	/* Reset the watchdog timer */
-	ret = da9055_reg_update(da9055, DA9055_REG_CONTROL_E,
-				DA9055_WATCHDOG_MASK, 1);
-
-	return ret;
+	return da9055_reg_update(da9055, DA9055_REG_CONTROL_E,
+				 DA9055_WATCHDOG_MASK, 1);
 }
 
 static void da9055_wdt_release_resources(struct kref *r)
-- 
1.7.9.5



