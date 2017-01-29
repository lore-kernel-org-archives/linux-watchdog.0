Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: RDC321X_WDT always depends on PCI
Date: Sun, 29 Jan 2017 11:18:57 -0800
Message-Id: <1485717537-18083-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Without this dependency, platforms not supporting PCI (such as m68k)
report the following build warning when building allmodconfig
or allyesconfig.

drivers/watchdog/rdc321x_wdt.c: In function 'rdc321x_wdt_ioctl':
./arch/m68k/include/asm/uaccess_mm.h:61:1: warning:
	'value' may be used uninitialized in this function

Fixes: f4c3de659054 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
We could merge this into the original patch. I decided to keep it
separate to avaoid having to resend that patch and to rebase my tree.
Note that the SHA may change if the original patch is applied from e-mail.

 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ba116f8bf3ee..89b50f6d258f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1120,6 +1120,7 @@ config NV_TCO
 config RDC321X_WDT
 	tristate "RDC R-321x SoC watchdog"
 	depends on X86_RDC321X || COMPILE_TEST
+	depends on PCI
 	help
 	  This is the driver for the built in hardware watchdog
 	  in the RDC R-321x SoC.
-- 
2.7.4
