Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 7/8] watchdog: bcm2835: add CONFIG_OF dependency
Date: Tue, 28 Feb 2017 22:01:22 +0100
Message-Id: <20170228210123.3404816-8-arnd@arndb.de>
In-Reply-To: <20170228210123.3404816-1-arnd@arndb.de>
References: <20170228210123.3404816-1-arnd@arndb.de>
List-ID: <linux-watchdog@vger.kernel.org>

Without CONFIG_OF, the driver fails to link:

drivers/watchdog/built-in.o: In function `bcm2835_power_off':
bcm2835_wdt.c:(.text+0x1946): undefined reference to `of_find_device_by_node'

This adds a new dependency, to allow the COMPILE_TEST check to succeed.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3216012170fa..8cb9b986ee2d 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1496,7 +1496,7 @@ config BCM63XX_WDT
 
 config BCM2835_WDT
 	tristate "Broadcom BCM2835 hardware watchdog"
-	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on ARCH_BCM2835 || (OF && COMPILE_TEST)
 	select WATCHDOG_CORE
 	help
 	  Watchdog driver for the built in watchdog hardware in Broadcom
-- 
2.9.0
