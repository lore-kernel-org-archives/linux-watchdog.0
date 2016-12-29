Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/2] watchdog: Enable COMPILE_TEST where possible
Date: Thu, 29 Dec 2016 09:39:34 -0800
Message-Id: <1483033175-19563-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Building all watchdog drivers is all but impossible since many depend
on platforms which are not enabled by test builds. Add dependency on
COMPILE_TEST where possible to improve the situation.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Tested with:
	alpha:allmodconfig
	arm:allmodconfig
	arm64:allmodconfig
	m68k:allmodconfig
	mips:allmodconfig
	parisc:allmodconfig
	powerpc:allmodconfig
	s390:allmodconfig
	sparc32:allmodconfig
	sparc64:allmodconfig
	x86:allmodconfig
	xtensa:allmodconfig

 drivers/watchdog/Kconfig | 134 +++++++++++++++++++++++------------------------
 1 file changed, 67 insertions(+), 67 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e20eb42864ef..d49ac4c509dc 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -73,7 +73,7 @@ config SOFT_WATCHDOG
 
 config DA9052_WATCHDOG
 	tristate "Dialog DA9052 Watchdog"
-	depends on PMIC_DA9052
+	depends on PMIC_DA9052 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog in the DA9052 PMIC. Watchdog trigger
@@ -85,7 +85,7 @@ config DA9052_WATCHDOG
 
 config DA9055_WATCHDOG
 	tristate "Dialog Semiconductor DA9055 Watchdog"
-	depends on MFD_DA9055
+	depends on MFD_DA9055 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  If you say yes here you get support for watchdog on the Dialog
@@ -96,7 +96,7 @@ config DA9055_WATCHDOG
 
 config DA9063_WATCHDOG
 	tristate "Dialog DA9063 Watchdog"
-	depends on MFD_DA9063
+	depends on MFD_DA9063 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog in the DA9063 PMIC.
@@ -105,7 +105,7 @@ config DA9063_WATCHDOG
 
 config DA9062_WATCHDOG
 	tristate "Dialog DA9062/61 Watchdog"
-	depends on MFD_DA9062
+	depends on MFD_DA9062 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog in the DA9062 and DA9061 PMICs.
@@ -133,7 +133,7 @@ config GPIO_WATCHDOG_ARCH_INITCALL
 
 config MENF21BMC_WATCHDOG
 	tristate "MEN 14F021P00 BMC Watchdog"
-	depends on MFD_MENF21BMC
+	depends on MFD_MENF21BMC || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include support for the MEN 14F021P00 BMC Watchdog.
@@ -168,7 +168,7 @@ config WDAT_WDT
 
 config WM831X_WATCHDOG
 	tristate "WM831x watchdog"
-	depends on MFD_WM831X
+	depends on MFD_WM831X || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog in the WM831x AudioPlus PMICs.  When
@@ -176,7 +176,7 @@ config WM831X_WATCHDOG
 
 config WM8350_WATCHDOG
 	tristate "WM8350 watchdog"
-	depends on MFD_WM8350
+	depends on MFD_WM8350 || ((X86 || ARM) && COMPILE_TEST)
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog in the WM8350 AudioPlus PMIC.  When
@@ -209,7 +209,7 @@ config ZIIRAVE_WATCHDOG
 
 config ARM_SP805_WATCHDOG
 	tristate "ARM SP805 Watchdog"
-	depends on (ARM || ARM64) && ARM_AMBA
+	depends on (ARM || ARM64) && (ARM_AMBA || COMPILE_TEST)
 	select WATCHDOG_CORE
 	help
 	  ARM Primecell SP805 Watchdog timer. This will reboot your system when
@@ -237,7 +237,7 @@ config ARM_SBSA_WATCHDOG
 
 config ASM9260_WATCHDOG
 	tristate "Alphascale ASM9260 watchdog"
-	depends on MACH_ASM9260
+	depends on MACH_ASM9260 || COMPILE_TEST
 	depends on OF
 	select WATCHDOG_CORE
 	select RESET_CONTROLLER
@@ -247,14 +247,14 @@ config ASM9260_WATCHDOG
 
 config AT91RM9200_WATCHDOG
 	tristate "AT91RM9200 watchdog"
-	depends on SOC_AT91RM9200 && MFD_SYSCON
+	depends on (SOC_AT91RM9200 && MFD_SYSCON) || COMPILE_TEST
 	help
 	  Watchdog timer embedded into AT91RM9200 chips. This will reboot your
 	  system when the timeout is reached.
 
 config AT91SAM9X_WATCHDOG
 	tristate "AT91SAM9X / AT91CAP9 watchdog"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Watchdog timer embedded into AT91SAM9X and AT91CAP9 chips. This will
@@ -262,7 +262,7 @@ config AT91SAM9X_WATCHDOG
 
 config SAMA5D4_WATCHDOG
 	tristate "Atmel SAMA5D4 Watchdog Timer"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Atmel SAMA5D4 watchdog timer is embedded into SAMA5D4 chips.
@@ -293,7 +293,7 @@ config 21285_WATCHDOG
 
 config 977_WATCHDOG
 	tristate "NetWinder WB83C977 watchdog"
-	depends on FOOTBRIDGE && ARCH_NETWINDER
+	depends on (FOOTBRIDGE && ARCH_NETWINDER) || (ARM && COMPILE_TEST)
 	help
 	  Say Y here to include support for the WB977 watchdog included in
 	  NetWinder machines. Alternatively say M to compile the driver as
@@ -333,7 +333,7 @@ config HAVE_S3C2410_WATCHDOG
 
 config S3C2410_WATCHDOG
 	tristate "S3C2410 Watchdog"
-	depends on HAVE_S3C2410_WATCHDOG
+	depends on HAVE_S3C2410_WATCHDOG || COMPILE_TEST
 	select WATCHDOG_CORE
 	select MFD_SYSCON if ARCH_EXYNOS5
 	help
@@ -372,7 +372,7 @@ config DW_WATCHDOG
 
 config EP93XX_WATCHDOG
 	tristate "EP93xx Watchdog"
-	depends on ARCH_EP93XX
+	depends on ARCH_EP93XX || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
@@ -383,7 +383,7 @@ config EP93XX_WATCHDOG
 
 config OMAP_WATCHDOG
 	tristate "OMAP Watchdog"
-	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
+	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Support for TI OMAP1610/OMAP1710/OMAP2420/OMAP3430/OMAP4430 watchdog.  Say 'Y'
@@ -403,7 +403,7 @@ config PNX4008_WATCHDOG
 
 config IOP_WATCHDOG
 	tristate "IOP Watchdog"
-	depends on ARCH_IOP13XX
+	depends on ARCH_IOP13X
 	select WATCHDOG_NOWAYOUT if (ARCH_IOP32X || ARCH_IOP33X)
 	help
 	  Say Y here if to include support for the watchdog timer
@@ -419,7 +419,7 @@ config IOP_WATCHDOG
 
 config DAVINCI_WATCHDOG
 	tristate "DaVinci watchdog"
-	depends on ARCH_DAVINCI || ARCH_KEYSTONE
+	depends on ARCH_DAVINCI || ARCH_KEYSTONE || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
@@ -432,7 +432,7 @@ config DAVINCI_WATCHDOG
 
 config ORION_WATCHDOG
 	tristate "Orion watchdog"
-	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU
+	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU || COMPILE_TEST
 	depends on ARM
 	select WATCHDOG_CORE
 	help
@@ -443,7 +443,7 @@ config ORION_WATCHDOG
 
 config RN5T618_WATCHDOG
 	tristate "Ricoh RN5T618 watchdog"
-	depends on MFD_RN5T618
+	depends on MFD_RN5T618 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  If you say yes here you get support for watchdog on the Ricoh
@@ -454,7 +454,7 @@ config RN5T618_WATCHDOG
 
 config SUNXI_WATCHDOG
 	tristate "Allwinner SoCs watchdog support"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include support for the watchdog timer
@@ -464,7 +464,7 @@ config SUNXI_WATCHDOG
 
 config COH901327_WATCHDOG
 	bool "ST-Ericsson COH 901 327 watchdog"
-	depends on ARCH_U300
+	depends on ARCH_U300 || (ARM && COMPILE_TEST)
 	default y if MACH_U300
 	select WATCHDOG_CORE
 	help
@@ -475,7 +475,7 @@ config COH901327_WATCHDOG
 
 config TWL4030_WATCHDOG
 	tristate "TWL4030 Watchdog"
-	depends on TWL4030_CORE
+	depends on TWL4030_CORE || ((X86 || ARM) && COMPILE_TEST)
 	select WATCHDOG_CORE
 	help
 	  Support for TI TWL4030 watchdog.  Say 'Y' here to enable the
@@ -483,7 +483,7 @@ config TWL4030_WATCHDOG
 
 config STMP3XXX_RTC_WATCHDOG
 	tristate "Freescale STMP3XXX & i.MX23/28 watchdog"
-	depends on RTC_DRV_STMP
+	depends on RTC_DRV_STMP || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include support for the watchdog timer inside
@@ -493,7 +493,7 @@ config STMP3XXX_RTC_WATCHDOG
 
 config NUC900_WATCHDOG
 	tristate "Nuvoton NUC900 watchdog"
-	depends on ARCH_W90X900
+	depends on ARCH_W90X900 || COMPILE_TEST
 	help
 	  Say Y here if to include support for the watchdog timer
 	  for the Nuvoton NUC900 series SoCs.
@@ -513,7 +513,7 @@ config TS4800_WATCHDOG
 
 config TS72XX_WATCHDOG
 	tristate "TS-72XX SBC Watchdog"
-	depends on MACH_TS72XX
+	depends on MACH_TS72XX || COMPILE_TEST
 	help
 	  Technologic Systems TS-7200, TS-7250 and TS-7260 boards have
 	  watchdog timer implemented in a external CPLD chip. Say Y here
@@ -531,7 +531,7 @@ config MAX63XX_WATCHDOG
 
 config MAX77620_WATCHDOG
 	tristate "Maxim Max77620 Watchdog Timer"
-	depends on MFD_MAX77620
+	depends on MFD_MAX77620 || COMPILE_TEST
 	help
 	 This is the driver for the Max77620 watchdog timer.
 	 Say 'Y' here to enable the watchdog timer support for
@@ -540,7 +540,7 @@ config MAX77620_WATCHDOG
 
 config IMX2_WDT
 	tristate "IMX2+ Watchdog"
-	depends on ARCH_MXC || ARCH_LAYERSCAPE
+	depends on ARCH_MXC || ARCH_LAYERSCAPE || COMPILE_TEST
 	select REGMAP_MMIO
 	select WATCHDOG_CORE
 	help
@@ -554,7 +554,7 @@ config IMX2_WDT
 
 config UX500_WATCHDOG
 	tristate "ST-Ericsson Ux500 watchdog"
-	depends on MFD_DB8500_PRCMU
+	depends on MFD_DB8500_PRCMU || (ARM && COMPILE_TEST)
 	select WATCHDOG_CORE
 	default y
 	help
@@ -566,7 +566,7 @@ config UX500_WATCHDOG
 
 config RETU_WATCHDOG
 	tristate "Retu watchdog"
-	depends on MFD_RETU
+	depends on MFD_RETU || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Retu watchdog driver for Nokia Internet Tablets (770, N800,
@@ -578,7 +578,7 @@ config RETU_WATCHDOG
 
 config MOXART_WDT
 	tristate "MOXART watchdog"
-	depends on ARCH_MOXART
+	depends on ARCH_MOXART || COMPILE_TEST
 	help
 	  Say Y here to include Watchdog timer support for the watchdog
 	  existing on the MOXA ART SoC series platforms.
@@ -588,7 +588,7 @@ config MOXART_WDT
 
 config SIRFSOC_WATCHDOG
 	tristate "SiRFSOC watchdog"
-	depends on ARCH_SIRF
+	depends on ARCH_SIRF || COMPILE_TEST
 	select WATCHDOG_CORE
 	default y
 	help
@@ -597,7 +597,7 @@ config SIRFSOC_WATCHDOG
 
 config ST_LPC_WATCHDOG
 	tristate "STMicroelectronics LPC Watchdog"
-	depends on ARCH_STI
+	depends on ARCH_STI || COMPILE_TEST
 	depends on OF
 	select WATCHDOG_CORE
 	help
@@ -621,7 +621,7 @@ config TEGRA_WATCHDOG
 config QCOM_WDT
 	tristate "QCOM watchdog"
 	depends on HAS_IOMEM
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include Watchdog timer support for the watchdog found
@@ -633,7 +633,7 @@ config QCOM_WDT
 
 config MESON_GXBB_WATCHDOG
 	tristate "Amlogic Meson GXBB SoCs watchdog support"
-	depends on ARCH_MESON
+	depends on ARCH_MESON || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include support for the watchdog timer
@@ -643,7 +643,7 @@ config MESON_GXBB_WATCHDOG
 
 config MESON_WATCHDOG
 	tristate "Amlogic Meson SoCs watchdog support"
-	depends on ARCH_MESON
+	depends on ARCH_MESON || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include support for the watchdog timer
@@ -653,7 +653,7 @@ config MESON_WATCHDOG
 
 config MEDIATEK_WATCHDOG
 	tristate "Mediatek SoCs watchdog support"
-	depends on ARCH_MEDIATEK
+	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include support for the watchdog timer
@@ -663,7 +663,7 @@ config MEDIATEK_WATCHDOG
 
 config DIGICOLOR_WATCHDOG
 	tristate "Conexant Digicolor SoCs watchdog support"
-	depends on ARCH_DIGICOLOR
+	depends on ARCH_DIGICOLOR || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include support for the watchdog timer
@@ -685,7 +685,7 @@ config LPC18XX_WATCHDOG
 
 config ATLAS7_WATCHDOG
 	tristate "CSRatlas7 watchdog"
-	depends on ARCH_ATLAS7
+	depends on ARCH_ATLAS7 || COMPILE_TEST
 	help
 	  Say Y here to include Watchdog timer support for the watchdog
 	  existing on the CSRatlas7 series platforms.
@@ -718,7 +718,7 @@ config ASPEED_WATCHDOG
 
 config AT32AP700X_WDT
 	tristate "AT32AP700x watchdog"
-	depends on CPU_AT32AP700X
+	depends on CPU_AT32AP700X || COMPILE_TEST
 	help
 	  Watchdog timer embedded into AT32AP700x devices. This will reboot
 	  your system when the timeout is reached.
@@ -822,7 +822,7 @@ config SP5100_TCO
 
 config GEODE_WDT
 	tristate "AMD Geode CS5535/CS5536 Watchdog"
-	depends on CS5535_MFGPT
+	depends on CS5535_MFGPT || (X86 && COMPILE_TEST)
 	help
 	  This driver enables a watchdog capability built into the
 	  CS5535/CS5536 companion chips for the AMD Geode GX and LX
@@ -835,7 +835,7 @@ config GEODE_WDT
 
 config SC520_WDT
 	tristate "AMD Elan SC520 processor Watchdog"
-	depends on MELAN
+	depends on MELAN || COMPILE_TEST
 	help
 	  This is the driver for the hardware watchdog built in to the
 	  AMD "Elan" SC520 microcomputer commonly used in embedded systems.
@@ -1034,7 +1034,7 @@ config HP_WATCHDOG
 
 config KEMPLD_WDT
 	tristate "Kontron COM Watchdog Timer"
-	depends on MFD_KEMPLD
+	depends on MFD_KEMPLD || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Support for the PLD watchdog on some Kontron ETX and COMexpress
@@ -1108,7 +1108,7 @@ config NV_TCO
 
 config RDC321X_WDT
 	tristate "RDC R-321x SoC watchdog"
-	depends on X86_RDC321X
+	depends on X86_RDC321X || COMPILE_TEST
 	help
 	  This is the driver for the built in hardware watchdog
 	  in the RDC R-321x SoC.
@@ -1353,21 +1353,21 @@ config M54xx_WATCHDOG
 
 config ATH79_WDT
 	tristate "Atheros AR71XX/AR724X/AR913X hardware watchdog"
-	depends on ATH79
+	depends on ATH79 || (ARM && COMPILE_TEST)
 	help
 	  Hardware driver for the built-in watchdog timer on the Atheros
 	  AR71XX/AR724X/AR913X SoCs.
 
 config BCM47XX_WDT
 	tristate "Broadcom BCM47xx Watchdog Timer"
-	depends on BCM47XX || ARCH_BCM_5301X
+	depends on BCM47XX || ARCH_BCM_5301X || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Hardware driver for the Broadcom BCM47xx Watchdog Timer.
 
 config RC32434_WDT
 	tristate "IDT RC32434 SoC Watchdog Timer"
-	depends on MIKROTIK_RB532
+	depends on MIKROTIK_RB532 || (MIPS && COMPILE_TEST)
 	help
 	  Hardware driver for the IDT RC32434 SoC built-in
 	  watchdog timer.
@@ -1377,7 +1377,7 @@ config RC32434_WDT
 
 config INDYDOG
 	tristate "Indy/I2 Hardware Watchdog"
-	depends on SGI_HAS_INDYDOG
+	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST)
 	help
 	  Hardware driver for the Indy's/I2's watchdog. This is a
 	  watchdog timer that will reboot the machine after a 60 second
@@ -1386,14 +1386,14 @@ config INDYDOG
 
 config JZ4740_WDT
 	tristate "Ingenic jz4740 SoC hardware watchdog"
-	depends on MACH_JZ4740
+	depends on MACH_JZ4740 || (MIPS && COMPILE_TEST)
 	select WATCHDOG_CORE
 	help
 	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
 
 config WDT_MTX1
 	tristate "MTX-1 Hardware Watchdog"
-	depends on MIPS_MTX1
+	depends on MIPS_MTX1 || (MIPS && COMPILE_TEST)
 	help
 	  Hardware driver for the MTX-1 boards. This is a watchdog timer that
 	  will reboot the machine after a 100 seconds timer expired.
@@ -1409,7 +1409,7 @@ config PNX833X_WDT
 
 config SIBYTE_WDOG
 	tristate "Sibyte SoC hardware watchdog"
-	depends on CPU_SB1
+	depends on CPU_SB1 || (MIPS && COMPILE_TEST)
 	help
 	  Watchdog driver for the built in watchdog hardware in Sibyte
 	  SoC processors.  There are apparently two watchdog timers
@@ -1422,13 +1422,13 @@ config SIBYTE_WDOG
 
 config AR7_WDT
 	tristate "TI AR7 Watchdog Timer"
-	depends on AR7
+	depends on AR7 || (MIPS && COMPILE_TEST)
 	help
 	  Hardware driver for the TI AR7 Watchdog Timer.
 
 config TXX9_WDT
 	tristate "Toshiba TXx9 Watchdog Timer"
-	depends on CPU_TX39XX || CPU_TX49XX
+	depends on CPU_TX39XX || CPU_TX49XX || (MIPS && COMPILE_TEST)
 	select WATCHDOG_CORE
 	help
 	  Hardware driver for the built-in watchdog timer on TXx9 MIPS SoCs.
@@ -1464,7 +1464,7 @@ config BCM63XX_WDT
 
 config BCM2835_WDT
 	tristate "Broadcom BCM2835 hardware watchdog"
-	depends on ARCH_BCM2835
+	depends on ARCH_BCM2835 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Watchdog driver for the built in watchdog hardware in Broadcom
@@ -1475,7 +1475,7 @@ config BCM2835_WDT
 
 config BCM_KONA_WDT
 	tristate "BCM Kona Watchdog"
-	depends on ARCH_BCM_MOBILE
+	depends on ARCH_BCM_MOBILE || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog timer on the following Broadcom BCM281xx
@@ -1487,7 +1487,7 @@ config BCM_KONA_WDT
 
 config BCM_KONA_WDT_DEBUG
 	bool "DEBUGFS support for BCM Kona Watchdog"
-	depends on BCM_KONA_WDT
+	depends on BCM_KONA_WDT || COMPILE_TEST
 	help
 	  If enabled, adds /sys/kernel/debug/bcm_kona_wdt/info which provides
 	  access to the driver's internal data structures as well as watchdog
@@ -1534,21 +1534,21 @@ config LOONGSON1_WDT
 config RALINK_WDT
 	tristate "Ralink SoC watchdog"
 	select WATCHDOG_CORE
-	depends on RALINK
+	depends on RALINK || (MIPS && COMPILE_TEST)
 	help
 	  Hardware driver for the Ralink SoC Watchdog Timer.
 
 config MT7621_WDT
 	tristate "Mediatek SoC watchdog"
 	select WATCHDOG_CORE
-	depends on SOC_MT7620 || SOC_MT7621
+	depends on SOC_MT7620 || SOC_MT7621 || (MIPS && COMPILE_TEST)
 	help
 	  Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
 
 config PIC32_WDT
 	tristate "Microchip PIC32 hardware watchdog"
 	select WATCHDOG_CORE
-	depends on MACH_PIC32
+	depends on MACH_PIC32 || (MIPS && COMPILE_TEST)
 	help
 	  Watchdog driver for the built in watchdog hardware in a PIC32.
 
@@ -1561,7 +1561,7 @@ config PIC32_WDT
 config PIC32_DMT
 	tristate "Microchip PIC32 Deadman Timer"
 	select WATCHDOG_CORE
-	depends on MACH_PIC32
+	depends on MACH_PIC32 || (MIPS && COMPILE_TEST)
 	help
 	  Watchdog driver for PIC32 instruction fetch counting timer. This specific
 	  timer is typically be used in misson critical and safety critical
@@ -1583,7 +1583,7 @@ config GEF_WDT
 
 config MPC5200_WDT
 	bool "MPC52xx Watchdog Timer"
-	depends on PPC_MPC52xx
+	depends on PPC_MPC52xx || COMPILE_TEST
 	help
 	  Use General Purpose Timer (GPT) 0 on the MPC5200 as Watchdog.
 
@@ -1602,11 +1602,11 @@ config 8xxx_WDT
 
 config MV64X60_WDT
 	tristate "MV64X60 (Marvell Discovery) Watchdog Timer"
-	depends on MV64X60
+	depends on MV64X60 || COMPILE_TEST
 
 config PIKA_WDT
 	tristate "PIKA FPGA Watchdog"
-	depends on WARP
+	depends on WARP || (PPC64 && COMPILE_TEST)
 	default y
 	help
 	  This enables the watchdog in the PIKA FPGA. Currently used on
@@ -1656,7 +1656,7 @@ config MEN_A21_WDT
 
 config WATCHDOG_RTAS
 	tristate "RTAS watchdog"
-	depends on PPC_RTAS
+	depends on PPC_RTAS || (PPC64 && COMPILE_TEST)
 	help
 	  This driver adds watchdog support for the RTAS watchdog.
 
@@ -1684,7 +1684,7 @@ config DIAG288_WATCHDOG
 
 config SH_WDT
 	tristate "SuperH Watchdog"
-	depends on SUPERH && (CPU_SH3 || CPU_SH4)
+	depends on SUPERH && (CPU_SH3 || CPU_SH4 || COMPILE_TEST)
 	select WATCHDOG_CORE
 	help
 	  This driver adds watchdog support for the integrated watchdog in the
@@ -1743,7 +1743,7 @@ config WATCHDOG_SUN4V
 
 config XEN_WDT
 	tristate "Xen Watchdog support"
-	depends on XEN
+	depends on XEN || (X86 && COMPILE_TEST)
 	help
 	  Say Y here to support the hypervisor watchdog capability provided
 	  by Xen 4.0 and newer.  The watchdog timeout period is normally one
@@ -1751,7 +1751,7 @@ config XEN_WDT
 
 config UML_WATCHDOG
 	tristate "UML watchdog"
-	depends on UML
+	depends on UML || COMPILE_TEST
 
 #
 # ISA-based Watchdog Cards
-- 
2.7.4
