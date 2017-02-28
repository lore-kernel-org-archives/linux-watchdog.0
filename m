Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/8] watchdog: wm831x watchdog really needs mfd
Date: Tue, 28 Feb 2017 22:01:18 +0100
Message-Id: <20170228210123.3404816-4-arnd@arndb.de>
In-Reply-To: <20170228210123.3404816-1-arnd@arndb.de>
References: <20170228210123.3404816-1-arnd@arndb.de>
List-ID: <linux-watchdog@vger.kernel.org>

The wm831x watchdog driver can now be built without the wm831x mfd
driver, which results in a link error:

(.text+0x1a95c): undefined reference to `wm831x_set_bits'
(.text+0x1a95c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `wm831x_set_bits'
(.text+0x1a968): undefined reference to `wm831x_reg_lock'
(.text+0x1a968): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `wm831x_reg_lock'
(.text+0x1a9dc): undefined reference to `wm831x_reg_unlock'
(.text+0x1a9dc): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `wm831x_reg_unlock'

This adds back the dependency that was removed. We can still build test
this driver on all architectures by enabling the MFD driver for it first.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 6ca2f3ae7f1e..34a927703d64 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -176,7 +176,7 @@ config WDAT_WDT
 
 config WM831X_WATCHDOG
 	tristate "WM831x watchdog"
-	depends on MFD_WM831X || COMPILE_TEST
+	depends on MFD_WM831X
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog in the WM831x AudioPlus PMICs.  When
-- 
2.9.0
