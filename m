Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:62097 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbdCMQmP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 13 Mar 2017 12:42:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] watchdog: orion: fix compile-test dependencies
Date: Mon, 13 Mar 2017 17:40:48 +0100
Message-Id: <20170313164105.1038960-1-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

I ran into one corner case with the orion watchdog using the
atomic_io_modify interface:

drivers/watchdog/orion_wdt.o: In function `orion_stop':
orion_wdt.c:(.text.orion_stop+0x28): undefined reference to `atomic_io_modify'
drivers/watchdog/orion_wdt.o: In function `armada375_stop':
orion_wdt.c:(.text.armada375_stop+0x28): undefined reference to `atomic_io_modify'

This function is available on all 32-bit ARM builds except for ebsa110, so
we have to specifically exclude that from compile-testing.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Originally submitted on March 2, still needed to address the one remaining
kernelci.org build failure in v4.11-rc2:

https://kernelci.org/build/id/58c5dbdc59b514108e645533/
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 52a70ee6014f..8b9049dac094 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -452,7 +452,7 @@ config DAVINCI_WATCHDOG
 
 config ORION_WATCHDOG
 	tristate "Orion watchdog"
-	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU || COMPILE_TEST
+	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU || (COMPILE_TEST && !ARCH_EBSA110)
 	depends on ARM
 	select WATCHDOG_CORE
 	help
-- 
2.9.0

