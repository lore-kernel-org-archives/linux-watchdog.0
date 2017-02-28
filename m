Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/8] watchdog: geode: restore hard CS5535_MFGPT dependency
Date: Tue, 28 Feb 2017 22:01:19 +0100
Message-Id: <20170228210123.3404816-5-arnd@arndb.de>
In-Reply-To: <20170228210123.3404816-1-arnd@arndb.de>
References: <20170228210123.3404816-1-arnd@arndb.de>
List-ID: <linux-watchdog@vger.kernel.org>

Wtihout CONFIG_CS5535_MFGPT, the driver does not link right:

drivers/watchdog/built-in.o: In function `geodewdt_probe':
geodewdt.c:(.init.text+0xca3): undefined reference to `cs5535_mfgpt_alloc_timer'
geodewdt.c:(.init.text+0xcd4): undefined reference to `cs5535_mfgpt_write'
geodewdt.c:(.init.text+0xcef): undefined reference to `cs5535_mfgpt_toggle_event'

This adds back the dependency on this base driver.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 34a927703d64..de52495ef150 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -851,7 +851,7 @@ config SP5100_TCO
 
 config GEODE_WDT
 	tristate "AMD Geode CS5535/CS5536 Watchdog"
-	depends on CS5535_MFGPT || (X86 && COMPILE_TEST)
+	depends on CS5535_MFGPT
 	help
 	  This driver enables a watchdog capability built into the
 	  CS5535/CS5536 companion chips for the AMD Geode GX and LX
-- 
2.9.0
