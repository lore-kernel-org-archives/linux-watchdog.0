Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34578 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756359AbdDPQdm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 16 Apr 2017 12:33:42 -0400
From: Karim Eshapa <karim.eshapa@gmail.com>
To: joel@jms.id.au
Cc: wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] drivers:watchdog:aspeed_wdt: using msleep instead of mdelay
Date: Sun, 16 Apr 2017 18:33:08 +0200
Message-Id: <1492360388-20697-1-git-send-email-karim.eshapa@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

that's useful for the scheduler, power management unless
the driver needs to delay in atomic context
look at documentation/timers/timers-howto

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/watchdog/aspeed_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 1c65258..17f06d1 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -115,7 +115,7 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
 
 	aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
 
-	mdelay(1000);
+	msleep(1000);
 
 	return 0;
 }
-- 
2.7.4

