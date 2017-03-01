Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:52123 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbdCAJep (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 1 Mar 2017 04:34:45 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] watchdog: kempld: fix gcc-4.3 build
Date: Wed,  1 Mar 2017 10:15:29 +0100
Message-Id: <20170301091531.522161-2-arnd@arndb.de>
In-Reply-To: <20170301091531.522161-1-arnd@arndb.de>
References: <20170301091531.522161-1-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

gcc-4.3 can't decide whether the constant value in
kempld_prescaler[PRESCALER_21] is built-time constant or
not, and gets confused by the logic in do_div():

drivers/watchdog/kempld_wdt.o: In function `kempld_wdt_set_stage_timeout':
kempld_wdt.c:(.text.kempld_wdt_set_stage_timeout+0x130): undefined reference to `__aeabi_uldivmod'

This adds a call to ACCESS_ONCE() to force it to not consider
it to be constant, and leaves the more efficient normal case
in place for modern compilers, using an #ifdef to annotate
why we do this hack.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/kempld_wdt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
index 73c46b3a09ab..2f3b049ea301 100644
--- a/drivers/watchdog/kempld_wdt.c
+++ b/drivers/watchdog/kempld_wdt.c
@@ -140,12 +140,19 @@ static int kempld_wdt_set_stage_timeout(struct kempld_wdt_data *wdt_data,
 					unsigned int timeout)
 {
 	struct kempld_device_data *pld = wdt_data->pld;
-	u32 prescaler = kempld_prescaler[PRESCALER_21];
+	u32 prescaler;
 	u64 stage_timeout64;
 	u32 stage_timeout;
 	u32 remainder;
 	u8 stage_cfg;
 
+#if GCC_VERSION < 40400
+	/* work around a bug compiling do_div() */
+	prescaler = READ_ONCE(kempld_prescaler[PRESCALER_21]);
+#else
+	prescaler = kempld_prescaler[PRESCALER_21];
+#endif
+
 	if (!stage)
 		return -EINVAL;
 
-- 
2.9.0

