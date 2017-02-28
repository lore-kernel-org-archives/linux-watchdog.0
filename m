Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6/8] watchdog: sp805: add back AMBA dependency
Date: Tue, 28 Feb 2017 22:01:21 +0100
Message-Id: <20170228210123.3404816-7-arnd@arndb.de>
In-Reply-To: <20170228210123.3404816-1-arnd@arndb.de>
References: <20170228210123.3404816-1-arnd@arndb.de>
List-ID: <linux-watchdog@vger.kernel.org>

The driver fails to link if ARM_AMBA is disabled:

drivers/watchdog/sp805_wdt.o: In function `sp805_wdt_driver_init':
sp805_wdt.c:(.init.text+0x4): undefined reference to `amba_driver_register'

It seems that the COMPILE_TEST was added in the wrong place, as there
is no architecture dependency, but a bus dependency. This moves
the dependency accordingly.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ab0ec389e436..3216012170fa 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -218,7 +218,7 @@ config ZIIRAVE_WATCHDOG
 
 config ARM_SP805_WATCHDOG
 	tristate "ARM SP805 Watchdog"
-	depends on (ARM || ARM64) && (ARM_AMBA || COMPILE_TEST)
+	depends on (ARM || ARM64 || COMPILE_TEST) && ARM_AMBA
 	select WATCHDOG_CORE
 	help
 	  ARM Primecell SP805 Watchdog timer. This will reboot your system when
-- 
2.9.0
