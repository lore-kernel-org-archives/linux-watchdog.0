Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/8] mfd: db8500-prcmu: fix stub helper interface
Date: Tue, 28 Feb 2017 22:01:17 +0100
Message-Id: <20170228210123.3404816-3-arnd@arndb.de>
In-Reply-To: <20170228210123.3404816-1-arnd@arndb.de>
References: <20170228210123.3404816-1-arnd@arndb.de>
List-ID: <linux-watchdog@vger.kernel.org>

When the db8500 watchdog is enabled without the PRCMU, we get a lot of
warnings about duplicate or missing helper functions:

In file included from drivers/watchdog/ux500_wdt.c:21:0:
include/linux/mfd/dbx500-prcmu.h:422:19: error: redefinition of 'prcmu_abb_read'
 static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)

This removes the duplicate function definitions and moves the helpers in
dbx500-prcmu outside of the #ifdef that hides them.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/mfd/db8500-prcmu.h | 27 ----------------------
 include/linux/mfd/dbx500-prcmu.h | 49 ++++++++++++++++++++--------------------
 2 files changed, 25 insertions(+), 51 deletions(-)

diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
index 7ba67b55b312..ac9b8a6b8e9c 100644
--- a/include/linux/mfd/db8500-prcmu.h
+++ b/include/linux/mfd/db8500-prcmu.h
@@ -500,17 +500,12 @@ void prcmu_configure_auto_pm(struct prcmu_auto_pm_config *sleep,
 	struct prcmu_auto_pm_config *idle);
 bool prcmu_is_auto_pm_enabled(void);
 
-int prcmu_config_clkout(u8 clkout, u8 source, u8 div);
 int prcmu_set_clock_divider(u8 clock, u8 divider);
 int db8500_prcmu_config_hotdog(u8 threshold);
 int db8500_prcmu_config_hotmon(u8 low, u8 high);
 int db8500_prcmu_start_temp_sense(u16 cycles32k);
 int db8500_prcmu_stop_temp_sense(void);
-int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size);
-int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size);
 
-int prcmu_ac_wake_req(void);
-void prcmu_ac_sleep_req(void);
 void db8500_prcmu_modem_reset(void);
 
 int db8500_prcmu_config_a9wdog(u8 num, bool sleep_auto_off);
@@ -608,11 +603,6 @@ static inline bool prcmu_is_auto_pm_enabled(void)
 	return false;
 }
 
-static inline int prcmu_config_clkout(u8 clkout, u8 source, u8 div)
-{
-	return 0;
-}
-
 static inline int prcmu_set_clock_divider(u8 clock, u8 divider)
 {
 	return 0;
@@ -638,23 +628,6 @@ static inline int db8500_prcmu_stop_temp_sense(void)
 	return 0;
 }
 
-static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
-{
-	return -ENOSYS;
-}
-
-static inline int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size)
-{
-	return -ENOSYS;
-}
-
-static inline int prcmu_ac_wake_req(void)
-{
-	return 0;
-}
-
-static inline void prcmu_ac_sleep_req(void) {}
-
 static inline void db8500_prcmu_modem_reset(void) {}
 
 static inline void db8500_prcmu_system_reset(u16 reset_code) {}
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index 2e2c6a63a065..533459c7ad08 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -376,30 +376,6 @@ static inline void prcmu_write_masked(unsigned int reg, u32 mask, u32 value)
 	db8500_prcmu_write_masked(reg, mask, value);
 }
 
-static inline int prcmu_enable_a9wdog(u8 id)
-{
-	return db8500_prcmu_enable_a9wdog(id);
-}
-
-static inline int prcmu_disable_a9wdog(u8 id)
-{
-	return db8500_prcmu_disable_a9wdog(id);
-}
-
-static inline int prcmu_kick_a9wdog(u8 id)
-{
-	return db8500_prcmu_kick_a9wdog(id);
-}
-
-static inline int prcmu_load_a9wdog(u8 id, u32 timeout)
-{
-	return db8500_prcmu_load_a9wdog(id, timeout);
-}
-
-static inline int prcmu_config_a9wdog(u8 num, bool sleep_auto_off)
-{
-	return db8500_prcmu_config_a9wdog(num, sleep_auto_off);
-}
 #else
 
 static inline void prcmu_early_init(u32 phy_base, u32 size) {}
@@ -569,6 +545,31 @@ static inline void prcmu_write_masked(unsigned int reg, u32 mask, u32 value) {}
 
 #endif
 
+static inline int prcmu_enable_a9wdog(u8 id)
+{
+	return db8500_prcmu_enable_a9wdog(id);
+}
+
+static inline int prcmu_disable_a9wdog(u8 id)
+{
+	return db8500_prcmu_disable_a9wdog(id);
+}
+
+static inline int prcmu_kick_a9wdog(u8 id)
+{
+	return db8500_prcmu_kick_a9wdog(id);
+}
+
+static inline int prcmu_load_a9wdog(u8 id, u32 timeout)
+{
+	return db8500_prcmu_load_a9wdog(id, timeout);
+}
+
+static inline int prcmu_config_a9wdog(u8 num, bool sleep_auto_off)
+{
+	return db8500_prcmu_config_a9wdog(num, sleep_auto_off);
+}
+
 static inline void prcmu_set(unsigned int reg, u32 bits)
 {
 	prcmu_write_masked(reg, bits, bits);
-- 
2.9.0
