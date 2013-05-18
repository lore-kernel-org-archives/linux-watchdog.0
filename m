Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:36775 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab3ERWhf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 May 2013 18:37:35 -0400
From: Tomasz Figa <tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, jhbird.choi@samsung.com,
	Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 4/6] ARM: SAMSUNG: Let platforms use the new watchdog reset driver
Date: Sun, 19 May 2013 00:37:05 +0200
Message-Id: <1368916627-23139-5-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
References: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch moves all platforms using the legacy watchdog reset helper
function to the new watchdog reset driver.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/Kconfig                | 3 +++
 arch/arm/mach-s3c24xx/Kconfig   | 2 ++
 arch/arm/mach-s3c24xx/s3c2410.c | 3 ++-
 arch/arm/mach-s3c24xx/s3c244x.c | 3 ++-
 arch/arm/mach-s3c64xx/common.c  | 8 +++++++-
 arch/arm/mach-s5p64x0/common.c  | 4 +++-
 arch/arm/mach-s5pc100/common.c  | 3 ++-
 7 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7b7ab65..676df53 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -731,6 +731,7 @@ config ARCH_S3C64XX
 	select SAMSUNG_CLKSRC
 	select SAMSUNG_GPIOLIB_4BIT
 	select SAMSUNG_IRQ_VIC_TIMER
+	select SAMSUNG_WDT_RESET
 	select USB_ARCH_HAS_OHCI
 	help
 	  Samsung S3C64XX series based systems
@@ -746,6 +747,7 @@ config ARCH_S5P64X0
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
+	select SAMSUNG_WDT_RESET
 	help
 	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
 	  SMDK6450.
@@ -762,6 +764,7 @@ config ARCH_S5PC100
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
+	select SAMSUNG_WDT_RESET
 	help
 	  Samsung S5PC100 series based systems
 
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index f2f7088..f8d1912 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -31,6 +31,7 @@ config CPU_S3C2410
 	select S3C2410_CPUFREQ if CPU_FREQ_S3C24XX
 	select S3C2410_PM if PM
 	select SAMSUNG_HRT
+	select SAMSUNG_WDT_RESET
 	help
 	  Support for S3C2410 and S3C2410A family from the S3C24XX line
 	  of Samsung Mobile CPUs.
@@ -81,6 +82,7 @@ config CPU_S3C2442
 config CPU_S3C244X
 	def_bool y
 	depends on CPU_S3C2440 || CPU_S3C2442
+	select SAMSUNG_WDT_RESET
 
 config CPU_S3C2443
 	bool "SAMSUNG S3C2443"
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index d850ea5..ff384ac 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -138,6 +138,7 @@ void __init s3c2410_init_clocks(int xtal)
 	s3c2410_baseclk_add();
 	s3c24xx_register_clock(&s3c2410_armclk);
 	clkdev_add_table(s3c2410_clk_lookup, ARRAY_SIZE(s3c2410_clk_lookup));
+	samsung_wdt_reset_init(S3C24XX_VA_WATCHDOG);
 }
 
 struct bus_type s3c2410_subsys = {
@@ -201,7 +202,7 @@ void s3c2410_restart(char mode, const char *cmd)
 		soft_restart(0);
 	}
 
-	arch_wdt_reset();
+	samsung_wdt_reset();
 
 	/* we'll take a jump through zero as a poor second */
 	soft_restart(0);
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
index 2a35edb..d0423e2 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c24xx/s3c244x.c
@@ -133,6 +133,7 @@ void __init s3c244x_init_clocks(int xtal)
 	s3c24xx_register_baseclocks(xtal);
 	s3c244x_setup_clocks();
 	s3c2410_baseclk_add();
+	samsung_wdt_reset_init(S3C24XX_VA_WATCHDOG);
 }
 
 /* Since the S3C2442 and S3C2440 share items, put both subsystems here */
@@ -202,7 +203,7 @@ void s3c244x_restart(char mode, const char *cmd)
 	if (mode == 's')
 		soft_restart(0);
 
-	arch_wdt_reset();
+	samsung_wdt_reset();
 
 	/* we'll take a jump through zero as a poor second */
 	soft_restart(0);
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 0b9c0ba..1aed6f4 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -183,6 +183,12 @@ core_initcall(s3c64xx_dev_init);
 
 void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 {
+	/*
+	 * FIXME: there is no better place to put this at the moment
+	 * (samsung_wdt_reset_init needs clocks)
+	 */
+	samsung_wdt_reset_init(S3C_VA_WATCHDOG);
+
 	printk(KERN_DEBUG "%s: initialising interrupts\n", __func__);
 
 	/* initialise the pair of VICs */
@@ -378,7 +384,7 @@ arch_initcall(s3c64xx_init_irq_eint);
 void s3c64xx_restart(char mode, const char *cmd)
 {
 	if (mode != 's')
-		arch_wdt_reset();
+		samsung_wdt_reset();
 
 	/* if all else fails, or mode was for soft, jump to 0 */
 	soft_restart(0);
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index 8ae5800..76d0053 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -173,6 +173,8 @@ void __init s5p64x0_init_io(struct map_desc *mach_desc, int size)
 	s5p_init_cpu(S5P64X0_SYS_ID);
 
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+	samsung_wdt_reset_init(S3C_VA_WATCHDOG);
+
 }
 
 void __init s5p6440_map_io(void)
@@ -440,7 +442,7 @@ arch_initcall(s5p64x0_init_irq_eint);
 void s5p64x0_restart(char mode, const char *cmd)
 {
 	if (mode != 's')
-		arch_wdt_reset();
+		samsung_wdt_reset();
 
 	soft_restart(0);
 }
diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
index cc6e561..5110315 100644
--- a/arch/arm/mach-s5pc100/common.c
+++ b/arch/arm/mach-s5pc100/common.c
@@ -178,6 +178,7 @@ void __init s5pc100_init_clocks(int xtal)
 	s5p_register_clocks(xtal);
 	s5pc100_register_clocks();
 	s5pc100_setup_clocks();
+	samsung_wdt_reset_init(S3C_VA_WATCHDOG);
 }
 
 void __init s5pc100_init_irq(void)
@@ -219,7 +220,7 @@ void __init s5pc100_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 void s5pc100_restart(char mode, const char *cmd)
 {
 	if (mode != 's')
-		arch_wdt_reset();
+		samsung_wdt_reset();
 
 	soft_restart(0);
 }
-- 
1.8.2.1

