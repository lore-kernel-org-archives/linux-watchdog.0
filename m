Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:20597 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755116AbdC2KXx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Mar 2017 06:23:53 -0400
From: Tomas Melin <tomas.melin@vaisala.com>
To: wim@iguana.be
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [RESEND PATCH] watchdog: cadence_wdt: fix timeout setting
Date: Wed, 29 Mar 2017 13:23:31 +0300
Message-Id: <1490783011-57993-1-git-send-email-tomas.melin@vaisala.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

wdt_timeout must not be initialized to CDNS_WDT_DEFAULT_TIMEOUT in
order to allow the value to be overriddden by a device tree setting.

This way, the default timeout value will be used only in case module_param
has not been set, or device tree timeout-sec has not been defined.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/cadence_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index f0d199a..85960c0 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -50,7 +50,7 @@
 /* Counter maximum value */
 #define CDNS_WDT_COUNTER_MAX 0xFFF
 
-static int wdt_timeout = CDNS_WDT_DEFAULT_TIMEOUT;
+static int wdt_timeout;
 static int nowayout = WATCHDOG_NOWAYOUT;
 
 module_param(wdt_timeout, int, 0);
-- 
2.1.4
