Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42829 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753997AbeEHDSe (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 7 May 2018 23:18:34 -0400
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: morbidrsa@gmail.com, wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] watchdog: mena21_wdt: Fix a possible data race in a21_wdt_set_timeout
Date: Tue,  8 May 2018 11:18:25 +0800
Message-Id: <20180508031825.12525-1-baijiaju1990@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The write operation to "wdt->timeout" is protected by
the lock on line 118, but the read operation to
this data on line 105 is not protected by the lock.
Thus, there may exist a data race for "wdt->timeout".

To fix this data race, the read operation to "wdt->timeout" 
should be also protected by the lock.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/watchdog/mena21_wdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index 25d5d2b8cfbe..05ca69042829 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -102,14 +102,15 @@ static int a21_wdt_set_timeout(struct watchdog_device *wdt,
 		return -EINVAL;
 	}
 
+	mutex_lock(&drv->lock);
+
 	if (timeout == 30 && wdt->timeout == 1) {
+		mutex_unlock(&drv->lock);
 		dev_err(wdt->parent,
 			"Transition from fast to slow mode not allowed\n");
 		return -EINVAL;
 	}
 
-	mutex_lock(&drv->lock);
-
 	if (timeout == 1)
 		gpio_set_value(drv->gpios[GPIO_WD_FAST], 1);
 	else
-- 
2.17.0

