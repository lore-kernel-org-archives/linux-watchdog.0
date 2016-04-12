Return-path: <sudipm.mukherjee@gmail.com>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Haavard Skinnemoen <hskinnemoen@gmail.com>,
	Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: linux-kernel@vger.kernel.org,
	kernel-testers@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] watchdog: dw_wdt: dont build for avr32
Date: Tue, 12 Apr 2016 11:21:43 +0530
Message-Id: <1460440303-20640-1-git-send-email-sudipm.mukherjee@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

The build of avr32 allmodconfig fails with the error:
ERROR: "__avr32_udiv64" [drivers/watchdog/kempld_wdt.ko] undefined!

Exclude this driver from the build of avr32.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

avr32 build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/122158665

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index fb94765..61041ba 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -981,7 +981,7 @@ config HP_WATCHDOG
 
 config KEMPLD_WDT
 	tristate "Kontron COM Watchdog Timer"
-	depends on MFD_KEMPLD
+	depends on MFD_KEMPLD && !AVR32
 	select WATCHDOG_CORE
 	help
 	  Support for the PLD watchdog on some Kontron ETX and COMexpress
-- 
1.9.1
