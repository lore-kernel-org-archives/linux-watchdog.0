Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-arm-kernel@lists.infradead.org,
	James Hogan <james.hogan@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>,
	Naidu Tellapati <naidu.tellapati@gmail.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: imgdpc: select WATCHDOG_CORE
Date: Mon, 25 Jan 2016 17:06:27 +0100
Message-Id: <1453737991-1960626-1-git-send-email-arnd@arndb.de>
List-ID: <linux-watchdog@vger.kernel.org>

The imgpdc_wdt driver can be built on all architectures with
CONFIG_COMPILE_TEST, but fails if no other watchdog driver is
enabled:

drivers/watchdog/built-in.o: In function `pdc_wdt_remove':
imgpdc_wdt.c:(.text+0x74): undefined reference to `watchdog_unregister_device'

This adds the normal 'select WATCHDOG_CORE' that is needed to
ensure the driver always builds cleanly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 4f0e7be0da34..0dc61f1a552e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1383,6 +1383,7 @@ config IMGPDC_WDT
 	tristate "Imagination Technologies PDC Watchdog Timer"
 	depends on HAS_IOMEM
 	depends on METAG || MIPS || COMPILE_TEST
+	select WATCHDOG_CORE
 	help
 	  Driver for Imagination Technologies PowerDown Controller
 	  Watchdog Timer.
-- 
2.7.0
