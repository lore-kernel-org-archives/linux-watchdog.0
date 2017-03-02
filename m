Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:60078 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbdCBMU3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Mar 2017 07:20:29 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: orion: fix compile-test dependencies
Date: Thu,  2 Mar 2017 13:09:52 +0100
Message-Id: <20170302121009.2348055-1-arnd@arndb.de>
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
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 657529fc1453..5c3deeed646a 100644
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

