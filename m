Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/8] mfd: retu: add inline alternatives for CONFIG_RETU=n
Date: Tue, 28 Feb 2017 22:01:16 +0100
Message-Id: <20170228210123.3404816-2-arnd@arndb.de>
In-Reply-To: <20170228210123.3404816-1-arnd@arndb.de>
References: <20170228210123.3404816-1-arnd@arndb.de>
List-ID: <linux-watchdog@vger.kernel.org>

The retu watchdog calls into the respective mfd driver, but fails to
link if that is diabled:

drivers/watchdog/built-in.o: In function `retu_wdt_set_timeout':
ziirave_wdt.c:(.text+0x8c88): undefined reference to `retu_write'
ziirave_wdt.c:(.text+0x8c88): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `retu_write'
drivers/watchdog/built-in.o: In function `retu_wdt_start':
ziirave_wdt.c:(.text+0x8cc8): undefined reference to `retu_write'
ziirave_wdt.c:(.text+0x8cc8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `retu_write'

This adds inline stub helpers that let us build the driver anyway.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig | 2 +-
 include/linux/mfd/retu.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c831b7967bf9..6ca2f3ae7f1e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -585,7 +585,7 @@ config UX500_WATCHDOG
 
 config RETU_WATCHDOG
 	tristate "Retu watchdog"
-	depends on MFD_RETU || COMPILE_TEST
+	depends on MFD_RETU || (COMPILE_TEST && MFD_RETU=n)
 	select WATCHDOG_CORE
 	help
 	  Retu watchdog driver for Nokia Internet Tablets (770, N800,
diff --git a/include/linux/mfd/retu.h b/include/linux/mfd/retu.h
index 65471c4a3926..a6828e899775 100644
--- a/include/linux/mfd/retu.h
+++ b/include/linux/mfd/retu.h
@@ -11,8 +11,13 @@
 
 struct retu_dev;
 
+#if IS_ENABLED(CONFIG_MFD_RETU)
 int retu_read(struct retu_dev *, u8);
 int retu_write(struct retu_dev *, u8, u16);
+#else
+static inline int retu_read(struct retu_dev *dev, u8 r)		{ return -EINVAL; }
+static inline int retu_write(struct retu_dev *dev, u8 r, u16 v)	{ return -EINVAL; }
+#endif
 
 /* Registers */
 #define RETU_REG_WATCHDOG	0x17		/* Watchdog */
-- 
2.9.0
