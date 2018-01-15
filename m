Return-Path: <arnd@arndb.de>
Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Lee Jones <lee.jones@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>,
	Guenter Roeck <linux@roeck-us.net>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: rave-sp: add NVMEM dependency
Date: Mon, 15 Jan 2018 17:10:33 +0100
Message-Id: <20180115161052.684821-1-arnd@arndb.de>
List-ID: <linux-watchdog@vger.kernel.org>

We can build this driver with or without NVMEM, but not built-in
when NVMEM is a loadable module:

drivers/watchdog/rave-sp-wdt.o: In function `rave_sp_wdt_probe':
rave-sp-wdt.c:(.text+0x27c): undefined reference to `nvmem_cell_get'
rave-sp-wdt.c:(.text+0x290): undefined reference to `nvmem_cell_read'
rave-sp-wdt.c:(.text+0x2c4): undefined reference to `nvmem_cell_put'

This adds a Kconfig dependency to enforce that.

Fixes: c3bb33345721 ("watchdog: Add RAVE SP watchdog driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 34d1c6851fa7..c09369f80989 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -226,6 +226,7 @@ config ZIIRAVE_WATCHDOG
 config RAVE_SP_WATCHDOG
 	tristate "RAVE SP Watchdog timer"
 	depends on RAVE_SP_CORE
+	depends on NVMEM || !NVMEM
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog on RAVE SP device.
-- 
2.9.0
