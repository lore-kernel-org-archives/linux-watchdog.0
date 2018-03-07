Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43320 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbeCGHr2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 7 Mar 2018 02:47:28 -0500
Received: by mail-pl0-f68.google.com with SMTP id f23-v6so869812plr.10
        for <linux-watchdog@vger.kernel.org>; Tue, 06 Mar 2018 23:47:28 -0800 (PST)
From: Igor Pylypiv <igor.pylypiv@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, igor.pylypiv@gmail.com
Subject: [PATCH] watchdog: f71808e_wdt: Fix WD_EN register read
Date: Tue,  6 Mar 2018 23:47:25 -0800
Message-Id: <1520408845-16987-1-git-send-email-igor.pylypiv@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

F71808FG_FLAG_WD_EN defines bit position, not a bitmask

Signed-off-by: Igor Pylypiv <igor.pylypiv@gmail.com>
---
 drivers/watchdog/f71808e_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 3a33c53..9a1c761 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -496,7 +496,7 @@ static bool watchdog_is_running(void)
 
 	is_running = (superio_inb(watchdog.sioaddr, SIO_REG_ENABLE) & BIT(0))
 		&& (superio_inb(watchdog.sioaddr, F71808FG_REG_WDT_CONF)
-			& F71808FG_FLAG_WD_EN);
+			& BIT(F71808FG_FLAG_WD_EN));
 
 	superio_exit(watchdog.sioaddr);
 
-- 
2.7.4

