Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/8] watchdog: menf21bmc: add I2C dependency
Date: Tue, 28 Feb 2017 22:01:20 +0100
Message-Id: <20170228210123.3404816-6-arnd@arndb.de>
In-Reply-To: <20170228210123.3404816-1-arnd@arndb.de>
References: <20170228210123.3404816-1-arnd@arndb.de>
List-ID: <linux-watchdog@vger.kernel.org>

This driver fails to link when CONFIG_I2C is disabled or a loadable module while
the watchdog is built-in:

drivers/watchdog/built-in.o: In function `menf21bmc_wdt_shutdown':
menf21bmc_wdt.c:(.text+0x9b44): undefined reference to `i2c_smbus_write_word_data'
menf21bmc_wdt.c:(.text+0x9b44): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `i2c_smbus_write_word_data'

This adds a Kconfig dependency for it, to enforce a valid configuration.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index de52495ef150..ab0ec389e436 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -142,6 +142,7 @@ config GPIO_WATCHDOG_ARCH_INITCALL
 config MENF21BMC_WATCHDOG
 	tristate "MEN 14F021P00 BMC Watchdog"
 	depends on MFD_MENF21BMC || COMPILE_TEST
+	depends on I2C
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include support for the MEN 14F021P00 BMC Watchdog.
-- 
2.9.0
