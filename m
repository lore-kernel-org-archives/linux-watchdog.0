Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63569 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbdCAJep (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 1 Mar 2017 04:34:45 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] watchdog: retu: restore MFD dependency
Date: Wed,  1 Mar 2017 10:15:31 +0100
Message-Id: <20170301091531.522161-4-arnd@arndb.de>
In-Reply-To: <20170301091531.522161-1-arnd@arndb.de>
References: <20170301091531.522161-1-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The retu watchdog calls into the respective mfd driver, but fails to
link if that is diabled:

drivers/watchdog/built-in.o: In function `retu_wdt_set_timeout':
ziirave_wdt.c:(.text+0x8c88): undefined reference to `retu_write'
ziirave_wdt.c:(.text+0x8c88): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `retu_write'
drivers/watchdog/built-in.o: In function `retu_wdt_start':
ziirave_wdt.c:(.text+0x8cc8): undefined reference to `retu_write'
ziirave_wdt.c:(.text+0x8cc8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `retu_write'

This restores the dependency as it was before

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index a199e8536ce4..52a70ee6014f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -586,7 +586,7 @@ config UX500_WATCHDOG
 
 config RETU_WATCHDOG
 	tristate "Retu watchdog"
-	depends on MFD_RETU || COMPILE_TEST
+	depends on MFD_RETU
 	select WATCHDOG_CORE
 	help
 	  Retu watchdog driver for Nokia Internet Tablets (770, N800,
-- 
2.9.0

