Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:59135 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbdEOPvj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 15 May 2017 11:51:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: orion: don't build for ARCH_EBSA110
Date: Mon, 15 May 2017 17:50:19 +0200
Message-Id: <20170515155040.1521131-1-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The randconfig builder caught another corner case with this driver that
fails to build for EBSA110 since that has its own MMIO handlers and
lacks atomic_io_modify:

drivers/watchdog/orion_wdt.o: In function `orion_stop':
orion_wdt.c:(.text.orion_stop+0x28): undefined reference to `atomic_io_modify'
orion_wdt.c:(.text.orion_stop+0x3c): undefined reference to `atomic_io_modify'
drivers/watchdog/orion_wdt.o: In function `armada370_wdt_clock_init':
orion_wdt.c:(.text.armada370_wdt_clock_init+0x2c): undefined reference to `atomic_io_modify'
drivers/watchdog/orion_wdt.o: In function `armada375_stop':
orion_wdt.c:(.text.armada375_stop+0x28): undefined reference to `atomic_io_modify'
orion_wdt.c:(.text.armada375_stop+0x58): undefined reference to `atomic_io_modify'

The best workaround I can think of is to add another Kconfig dependency.
We could add atomic_io_modify() for ebsa110 in theory, but it seemed
wrong because that platform would never actually use it.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 52a70ee6014f..feead0dbfc55 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -453,7 +453,7 @@ config DAVINCI_WATCHDOG
 config ORION_WATCHDOG
 	tristate "Orion watchdog"
 	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU || COMPILE_TEST
-	depends on ARM
+	depends on ARM && !ARCH_EBSA110
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
-- 
2.9.0

