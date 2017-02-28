Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 8/8] watchdog: kempld: revert to full dependency
Date: Tue, 28 Feb 2017 22:01:23 +0100
Message-Id: <20170228210123.3404816-9-arnd@arndb.de>
In-Reply-To: <20170228210123.3404816-1-arnd@arndb.de>
References: <20170228210123.3404816-1-arnd@arndb.de>
List-ID: <linux-watchdog@vger.kernel.org>

The kempld watchdog driver requires the respective MFD driver:

drivers/watchdog/built-in.o: In function `kempld_wdt_probe':
kempld_wdt.c:(.text+0x5c78): undefined reference to `kempld_get_mutex'
kempld_wdt.c:(.text+0x5c84): undefined reference to `kempld_read8'
kempld_wdt.c:(.text+0x5c8e): undefined reference to `kempld_release_mutex'
kempld_wdt.c:(.text+0x5d1c): undefined reference to `kempld_read8'
kempld_wdt.c:(.text+0x5d2c): undefined reference to `kempld_write8'

This adds the Kconfig dependency back.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 8cb9b986ee2d..fcaab3139a5c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1064,7 +1064,7 @@ config HP_WATCHDOG
 
 config KEMPLD_WDT
 	tristate "Kontron COM Watchdog Timer"
-	depends on MFD_KEMPLD || COMPILE_TEST
+	depends on MFD_KEMPLD
 	select WATCHDOG_CORE
 	help
 	  Support for the PLD watchdog on some Kontron ETX and COMexpress
-- 
2.9.0
