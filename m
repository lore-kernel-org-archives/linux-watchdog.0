Return-Path: <groeck7@gmail.com>
Return-path: <groeck7@gmail.com>
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Hogan <jhogan@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: indydog: Drop test builds
Date: Mon, 15 Jan 2018 19:05:50 -0800
Message-Id: <1516071950-14207-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Due to changes in MIPS default configuration, mips:allmodconfig fails
to build with the following error.

ERROR: "sgimc" [drivers/watchdog/indydog.ko] undefined!
scripts/Makefile.modpost:92: recipe for target '__modpost' failed

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ca200d1f310a..5a606a4aee6a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1451,7 +1451,7 @@ config RC32434_WDT
 
 config INDYDOG
 	tristate "Indy/I2 Hardware Watchdog"
-	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST)
+	depends on SGI_HAS_INDYDOG
 	help
 	  Hardware driver for the Indy's/I2's watchdog. This is a
 	  watchdog timer that will reboot the machine after a 60 second
-- 
2.7.4
