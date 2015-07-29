Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47826 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbbG2Qpm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 12:45:42 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: booke_wdt: Use infrastructure to check timeout limits
Date: Wed, 29 Jul 2015 09:45:36 -0700
Message-Id: <1438188336-29548-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog infrastructure checks the maximum timeout for us.
Use it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/booke_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index e96b09b135c8..04da4b66c75e 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -186,8 +186,6 @@ static int booke_wdt_stop(struct watchdog_device *wdog)
 static int booke_wdt_set_timeout(struct watchdog_device *wdt_dev,
 				 unsigned int timeout)
 {
-	if (timeout > MAX_WDT_TIMEOUT)
-		return -EINVAL;
 	wdt_dev->timeout = timeout;
 	booke_wdt_set(wdt_dev);
 
@@ -211,7 +209,6 @@ static struct watchdog_device booke_wdt_dev = {
 	.info = &booke_wdt_info,
 	.ops = &booke_wdt_ops,
 	.min_timeout = 1,
-	.max_timeout = 0xFFFF
 };
 
 static void __exit booke_wdt_exit(void)
@@ -229,6 +226,7 @@ static int __init booke_wdt_init(void)
 	booke_wdt_set_timeout(&booke_wdt_dev,
 			      period_to_sec(booke_wdt_period));
 	watchdog_set_nowayout(&booke_wdt_dev, nowayout);
+	booke_wdt_dev.max_timeout = MAX_WDT_TIMEOUT;
 	if (booke_wdt_enabled)
 		booke_wdt_start(&booke_wdt_dev);
 
-- 
2.1.4

