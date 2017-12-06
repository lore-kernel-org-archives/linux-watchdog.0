Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:63234 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdLFVDk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 6 Dec 2017 16:03:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jimmy Vance <jimmy.vance@hpe.com>, Wim Van Sebroeck <wim@iguana.be>
Cc: Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: hpwdt: fix unused variable warning
Date: Wed,  6 Dec 2017 22:02:37 +0100
Message-Id: <20171206210250.1222757-1-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The new hpwdt_my_nmi() function is used conditionally, which produces
a harmless warning in some configurations:

drivers/watchdog/hpwdt.c:478:12: error: 'hpwdt_my_nmi' defined but not used [-Werror=unused-function]

This moves it inside of the #ifdef that protects its caller, to silence
the warning.

Fixes: 621174a92851 ("watchdog: hpwdt: Check source of NMI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/hpwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index e61658310381..f1f00dfc0e68 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -475,12 +475,12 @@ static int hpwdt_time_left(void)
 	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
 }
 
+#ifdef CONFIG_HPWDT_NMI_DECODING
 static int hpwdt_my_nmi(void)
 {
 	return ioread8(hpwdt_nmistat) & 0x6;
 }
 
-#ifdef CONFIG_HPWDT_NMI_DECODING
 /*
  *	NMI Handler
  */
-- 
2.9.0

