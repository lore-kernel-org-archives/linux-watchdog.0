Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:54029 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753741AbdKNKyH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Nov 2017 05:54:07 -0500
From: Matt Redfearn <matt.redfearn@mips.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "# 4 . 11 +" <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: indydog: Add dependency on SGI_HAS_INDYDOG
Date: Tue, 14 Nov 2017 10:52:54 +0000
Message-ID: <1510656774-31464-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
enabled building the Indy watchdog driver when COMPILE_TEST is enabled.
However, the driver makes reference to symbols that are only defined for
certain platforms are selected in the config. These platforms select
SGI_HAS_INDYDOG. Without this, link time errors result, for example
when building a MIPS allyesconfig.

drivers/watchdog/indydog.o: In function `indydog_write':
indydog.c:(.text+0x18): undefined reference to `sgimc'
indydog.c:(.text+0x1c): undefined reference to `sgimc'
drivers/watchdog/indydog.o: In function `indydog_start':
indydog.c:(.text+0x54): undefined reference to `sgimc'
indydog.c:(.text+0x58): undefined reference to `sgimc'
drivers/watchdog/indydog.o: In function `indydog_stop':
indydog.c:(.text+0xa4): undefined reference to `sgimc'
drivers/watchdog/indydog.o:indydog.c:(.text+0xa8): more undefined
references to `sgimc' follow
make: *** [Makefile:1005: vmlinux] Error 1

Fix this by ensuring that CONFIG_INDIDOG can only be selected when the
necessary dependent platform symbols are built in.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: <stable@vger.kernel.org> # 4.11 +
---

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ca200d1f310a..d96e2e7544fc 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1451,7 +1451,7 @@ config RC32434_WDT
 
 config INDYDOG
 	tristate "Indy/I2 Hardware Watchdog"
-	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST)
+	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST && SGI_HAS_INDYDOG)
 	help
 	  Hardware driver for the Indy's/I2's watchdog. This is a
 	  watchdog timer that will reboot the machine after a 60 second
-- 
2.7.4

