Return-path: <root@danube-imgworks.hb.imgtec.org>
From: Naidu.Tellapati@imgtec.com
To: wim@iguana.be, linux@roeck-us.net, James.Hartley@imgtec.com,
        abrestic@chromium.org, Ezequiel.Garcia@imgtec.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Jude.Abraham@imgtec.com, Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: [PATCH 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
Date: Wed, 12 Nov 2014 20:48:02 +0530
Message-Id: <1415805483-26268-2-git-send-email-Naidu.Tellapati@imgtec.com>
In-Reply-To: <1415805483-26268-1-git-send-email-Naidu.Tellapati@imgtec.com>
References: <1415805483-26268-1-git-send-email-Naidu.Tellapati@imgtec.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

This commit adds support for ImgTec PowerDown Controller Watchdog Timer.

Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
---
 drivers/watchdog/Kconfig      |  167 ++++++------------
 drivers/watchdog/Makefile     |   12 +-
 drivers/watchdog/imgpdc_wdt.c |  388 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 450 insertions(+), 117 deletions(-)
 create mode 100644 drivers/watchdog/imgpdc_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index d0107d4..13fb1b2 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -87,15 +87,6 @@ config DA9055_WATCHDOG
 	  This driver can also be built as a module.  If so, the module
 	  will be called da9055_wdt.
 
-config DA9063_WATCHDOG
-	tristate "Dialog DA9063 Watchdog"
-	depends on MFD_DA9063
-	select WATCHDOG_CORE
-	help
-	  Support for the watchdog in the DA9063 PMIC.
-
-	  This driver can be built as a module. The module name is da9063_wdt.
-
 config GPIO_WATCHDOG
 	tristate "Watchdog device controlled through GPIO-line"
 	depends on OF_GPIO
@@ -104,16 +95,6 @@ config GPIO_WATCHDOG
 	  If you say yes here you get support for watchdog device
 	  controlled through GPIO-line.
 
-config MENF21BMC_WATCHDOG
-	tristate "MEN 14F021P00 BMC Watchdog"
-	depends on MFD_MENF21BMC
-	select WATCHDOG_CORE
-	help
-	  Say Y here to include support for the MEN 14F021P00 BMC Watchdog.
-
-	  This driver can also be built as a module. If so the module
-	  will be called menf21bmc_wdt.
-
 config WM831X_WATCHDOG
 	tristate "WM831x watchdog"
 	depends on MFD_WM831X
@@ -130,16 +111,6 @@ config WM8350_WATCHDOG
 	  Support for the watchdog in the WM8350 AudioPlus PMIC.  When
 	  the watchdog triggers the system will be reset.
 
-config XILINX_WATCHDOG
-	tristate "Xilinx Watchdog timer"
-	depends on HAS_IOMEM
-	select WATCHDOG_CORE
-	help
-	  Watchdog driver for the xps_timebase_wdt ip core.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called of_xilinx_wdt.
-
 # ALPHA Architecture
 
 # ARM Architecture
@@ -167,14 +138,6 @@ config AT91SAM9X_WATCHDOG
 	  Watchdog timer embedded into AT91SAM9X and AT91CAP9 chips. This will
 	  reboot your system when the timeout is reached.
 
-config CADENCE_WATCHDOG
-	tristate "Cadence Watchdog Timer"
-	depends on ARM
-	select WATCHDOG_CORE
-	help
-	  Say Y here if you want to include support for the watchdog
-	  timer in the Xilinx Zynq.
-
 config 21285_WATCHDOG
 	tristate "DC21285 watchdog"
 	depends on FOOTBRIDGE
@@ -300,7 +263,7 @@ config PNX4008_WATCHDOG
 
 config IOP_WATCHDOG
 	tristate "IOP Watchdog"
-	depends on ARCH_IOP13XX
+	depends on PLAT_IOP
 	select WATCHDOG_NOWAYOUT if (ARCH_IOP32X || ARCH_IOP33X)
 	help
 	  Say Y here if to include support for the watchdog timer
@@ -329,7 +292,7 @@ config DAVINCI_WATCHDOG
 
 config ORION_WATCHDOG
 	tristate "Orion watchdog"
-	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU
+	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
@@ -337,17 +300,6 @@ config ORION_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called orion_wdt.
 
-config RN5T618_WATCHDOG
-	tristate "Ricoh RN5T618 watchdog"
-	depends on MFD_RN5T618
-	select WATCHDOG_CORE
-	help
-	  If you say yes here you get support for watchdog on the Ricoh
-	  RN5T618 PMIC.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called rn5t618_wdt.
-
 config SUNXI_WATCHDOG
 	tristate "Allwinner SoCs watchdog support"
 	depends on ARCH_SUNXI
@@ -417,8 +369,6 @@ config MAX63XX_WATCHDOG
 config IMX2_WDT
 	tristate "IMX2+ Watchdog"
 	depends on ARCH_MXC
-	select REGMAP_MMIO
-	select WATCHDOG_CORE
 	help
 	  This is the driver for the hardware watchdog
 	  on the Freescale IMX2 and later processors.
@@ -471,40 +421,6 @@ config SIRFSOC_WATCHDOG
 	  Support for CSR SiRFprimaII and SiRFatlasVI watchdog. When
 	  the watchdog triggers the system will be reset.
 
-config TEGRA_WATCHDOG
-	tristate "Tegra watchdog"
-	depends on (ARCH_TEGRA || COMPILE_TEST) && HAS_IOMEM
-	select WATCHDOG_CORE
-	help
-	  Say Y here to include support for the watchdog timer
-	  embedded in NVIDIA Tegra SoCs.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called tegra_wdt.
-
-config QCOM_WDT
-	tristate "QCOM watchdog"
-	depends on HAS_IOMEM
-	depends on ARCH_QCOM
-	select WATCHDOG_CORE
-	help
-	  Say Y here to include Watchdog timer support for the watchdog found
-	  on QCOM chipsets.  Currently supported targets are the MSM8960,
-	  APQ8064, and IPQ8064.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called qcom_wdt.
-
-config MESON_WATCHDOG
-	tristate "Amlogic Meson SoCs watchdog support"
-	depends on ARCH_MESON
-	select WATCHDOG_CORE
-	help
-	  Say Y here to include support for the watchdog timer
-	  in Amlogic Meson SoCs.
-	  To compile this driver as a module, choose M here: the
-	  module will be called meson_wdt.
-
 # AVR32 Architecture
 
 config AT32AP700X_WDT
@@ -617,7 +533,7 @@ config GEODE_WDT
 
 config SC520_WDT
 	tristate "AMD Elan SC520 processor Watchdog"
-	depends on MELAN
+	depends on X86
 	help
 	  This is the driver for the hardware watchdog built in to the
 	  AMD "Elan" SC520 microcomputer commonly used in embedded systems.
@@ -727,19 +643,6 @@ config INTEL_SCU_WATCHDOG
 
 	  To compile this driver as a module, choose M here.
 
-config INTEL_MID_WATCHDOG
-	tristate "Intel MID Watchdog Timer"
-	depends on X86_INTEL_MID
-	select WATCHDOG_CORE
-	---help---
-	  Watchdog timer driver built into the Intel SCU for Intel MID
-	  Platforms.
-
-	  This driver currently supports only the watchdog evolution
-	  implementation in SCU, available for Merrifield generation.
-
-	  To compile this driver as a module, choose M here.
-
 config ITCO_WDT
 	tristate "Intel TCO Timer/Watchdog"
 	depends on (X86 || IA64) && PCI
@@ -912,7 +815,7 @@ config 60XX_WDT
 
 config SBC8360_WDT
 	tristate "SBC8360 Watchdog Timer"
-	depends on X86_32
+	depends on X86
 	---help---
 
 	  This is the driver for the hardware watchdog on the SBC8360 Single
@@ -1015,6 +918,36 @@ config W83627HF_WDT
 
 	  Most people will say N.
 
+config W83697HF_WDT
+	tristate "W83697HF/W83697HG Watchdog Timer"
+	depends on X86
+	---help---
+	  This is the driver for the hardware watchdog on the W83697HF/HG
+	  chipset as used in Dedibox/VIA motherboards (and likely others).
+	  This watchdog simply watches your kernel to make sure it doesn't
+	  freeze, and if it does, it reboots your computer after a certain
+	  amount of time.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called w83697hf_wdt.
+
+	  Most people will say N.
+
+config W83697UG_WDT
+	tristate "W83697UG/W83697UF Watchdog Timer"
+	depends on X86
+	---help---
+	  This is the driver for the hardware watchdog on the W83697UG/UF
+	  chipset as used in MSI Fuzzy CX700 VIA motherboards (and likely others).
+	  This watchdog simply watches your kernel to make sure it doesn't
+	  freeze, and if it does, it reboots your computer after a certain
+	  amount of time.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called w83697ug_wdt.
+
+	  Most people will say N.
+
 config W83877F_WDT
 	tristate "W83877F (EMACS) Watchdog Timer"
 	depends on X86
@@ -1090,6 +1023,18 @@ config M54xx_WATCHDOG
 
 # MicroBlaze Architecture
 
+config XILINX_WATCHDOG
+	tristate "Xilinx Watchdog timer"
+	depends on MICROBLAZE
+	---help---
+	  Watchdog driver for the xps_timebase_wdt ip core.
+
+	  IMPORTANT: The xps_timebase_wdt parent must have the property
+	  "clock-frequency" at device tree.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called of_xilinx_wdt.
+
 # MIPS Architecture
 
 config ATH79_WDT
@@ -1215,7 +1160,7 @@ config BCM2835_WDT
 
 config BCM_KONA_WDT
 	tristate "BCM Kona Watchdog"
-	depends on ARCH_BCM_MOBILE
+	depends on ARCH_BCM
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog timer on the following Broadcom BCM281xx
@@ -1235,6 +1180,15 @@ config BCM_KONA_WDT_DEBUG
 
 	  If in doubt, say 'N'.
 
+config IMGPDC_WDT
+	tristate "Imagination Technologies PDC Watchdog Timer"
+	help
+	  Driver for Imagination Technologies PowerDown Controller
+          Watchdog Timer.
+
+          To compile this driver as a loadable module, choose M here.
+          The module will be called imgpdc_wdt.
+
 config LANTIQ_WDT
 	tristate "Lantiq SoC watchdog"
 	depends on LANTIQ
@@ -1342,20 +1296,17 @@ config WATCHDOG_RTAS
 
 # S390 Architecture
 
-config DIAG288_WATCHDOG
-	tristate "System z diag288 Watchdog"
+config ZVM_WATCHDOG
+	tristate "z/VM Watchdog Timer"
 	depends on S390
-	select WATCHDOG_CORE
 	help
 	  IBM s/390 and zSeries machines running under z/VM 5.1 or later
 	  provide a virtual watchdog timer to their guest that cause a
 	  user define Control Program command to be executed after a
 	  timeout.
-	  LPAR provides a very similar interface. This driver handles
-	  both.
 
 	  To compile this driver as a module, choose M here. The module
-	  will be called diag288_wdt.
+	  will be called vmwatchdog.
 
 # SUPERH (sh + sh64) Architecture
 
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index c569ec8..467973c 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -32,7 +32,6 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
 obj-$(CONFIG_ARM_SP805_WATCHDOG) += sp805_wdt.o
 obj-$(CONFIG_AT91RM9200_WATCHDOG) += at91rm9200_wdt.o
 obj-$(CONFIG_AT91SAM9X_WATCHDOG) += at91sam9_wdt.o
-obj-$(CONFIG_CADENCE_WATCHDOG) += cadence_wdt.o
 obj-$(CONFIG_OMAP_WATCHDOG) += omap_wdt.o
 obj-$(CONFIG_TWL4030_WATCHDOG) += twl4030_wdt.o
 obj-$(CONFIG_21285_WATCHDOG) += wdt285.o
@@ -48,7 +47,6 @@ obj-$(CONFIG_IOP_WATCHDOG) += iop_wdt.o
 obj-$(CONFIG_DAVINCI_WATCHDOG) += davinci_wdt.o
 obj-$(CONFIG_ORION_WATCHDOG) += orion_wdt.o
 obj-$(CONFIG_SUNXI_WATCHDOG) += sunxi_wdt.o
-obj-$(CONFIG_RN5T618_WATCHDOG) += rn5t618_wdt.o
 obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
 obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) += stmp3xxx_rtc_wdt.o
 obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
@@ -59,10 +57,7 @@ obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
 obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o
 obj-$(CONFIG_MOXART_WDT) += moxart_wdt.o
 obj-$(CONFIG_SIRFSOC_WATCHDOG) += sirfsoc_wdt.o
-obj-$(CONFIG_QCOM_WDT) += qcom-wdt.o
 obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
-obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
-obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
@@ -111,12 +106,13 @@ obj-$(CONFIG_SMSC_SCH311X_WDT) += sch311x_wdt.o
 obj-$(CONFIG_SMSC37B787_WDT) += smsc37b787_wdt.o
 obj-$(CONFIG_VIA_WDT) += via_wdt.o
 obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
+obj-$(CONFIG_W83697HF_WDT) += w83697hf_wdt.o
+obj-$(CONFIG_W83697UG_WDT) += w83697ug_wdt.o
 obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
 obj-$(CONFIG_W83977F_WDT) += w83977f_wdt.o
 obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
 obj-$(CONFIG_INTEL_SCU_WATCHDOG) += intel_scu_watchdog.o
-obj-$(CONFIG_INTEL_MID_WATCHDOG) += intel-mid_wdt.o
 
 # M32R Architecture
 
@@ -142,6 +138,7 @@ obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
 octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
 obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
 obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
+obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
 
 # PARISC Architecture
 
@@ -157,7 +154,6 @@ obj-$(CONFIG_MEN_A21_WDT) += mena21_wdt.o
 obj-$(CONFIG_WATCHDOG_RTAS) += wdrtas.o
 
 # S390 Architecture
-obj-$(CONFIG_DIAG288_WATCHDOG) += diag288_wdt.o
 
 # SUPERH (sh + sh64) Architecture
 obj-$(CONFIG_SH_WDT) += shwdt.o
@@ -177,10 +173,8 @@ obj-$(CONFIG_XEN_WDT) += xen_wdt.o
 # Architecture Independent
 obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
 obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
-obj-$(CONFIG_DA9063_WATCHDOG) += da9063_wdt.o
 obj-$(CONFIG_GPIO_WATCHDOG)	+= gpio_wdt.o
 obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
 obj-$(CONFIG_WM8350_WATCHDOG) += wm8350_wdt.o
 obj-$(CONFIG_MAX63XX_WATCHDOG) += max63xx_wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
-obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
new file mode 100644
index 0000000..df9ff1c
--- /dev/null
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -0,0 +1,388 @@
+/*
+ * Imagination Technologies PowerDown Controller Watchdog Timer.
+ *
+ * Copyright (c) 2014 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Based on drivers/watchdog/sunxi_wdt.c Copyright (c) 2013 Carlo Caione
+ *                                                     2012 Henrik Nordstrom
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/watchdog.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/log2.h>
+#include <linux/slab.h>
+
+/* registers */
+#define PDC_WD_SW_RESET			0x000
+#define PDC_WD_CONFIG			0x004
+#define PDC_WD_TICKLE1			0x008
+#define PDC_WD_TICKLE2			0x00c
+#define PDC_WD_IRQ_STATUS		0x010
+#define PDC_WD_IRQ_CLEAR		0x014
+#define PDC_WD_IRQ_EN			0x018
+
+/* field masks */
+#define PDC_WD_CONFIG_REMIND		0x00001f00
+#define PDC_WD_CONFIG_REMIND_SHIFT	8
+#define PDC_WD_CONFIG_DELAY		0x0000001f
+#define PDC_WD_CONFIG_DELAY_SHIFT	0
+#define PDC_WD_TICKLE_STATUS		0x00000007
+#define PDC_WD_TICKLE_STATUS_SHIFT	0
+#define PDC_WD_IRQ_REMIND		0x00000001
+
+/* constants */
+#define PDC_WD_TICKLE1_MAGIC		0xabcd1234
+#define PDC_WD_TICKLE2_MAGIC		0x4321dcba
+#define PDC_WD_TICKLE_STATUS_HRESET	0x0  /* Hard reset */
+#define PDC_WD_TICKLE_STATUS_TIMEOUT	0x1  /* Timeout */
+#define PDC_WD_TICKLE_STATUS_TICKLE	0x2  /* Tickled incorrectly */
+#define PDC_WD_TICKLE_STATUS_SRESET	0x3  /* Soft reset */
+#define PDC_WD_TICKLE_STATUS_USER	0x4  /* User reset */
+
+/* timeout in seconds */
+#define PDC_WD_MIN_TIMEOUT		1
+#define PDC_WD_MAX_TIMEOUT		131072
+#define PDC_WD_DEFAULT_TIMEOUT		64
+#define PDC_WD_DEFAULT_PRETIMEOUT	PDC_WD_MAX_TIMEOUT
+#define MIN_TIMEOUT_SHIFT		14  /* Clock rate 32768Hz=2^(14+1)*/
+
+static int timeout = PDC_WD_DEFAULT_TIMEOUT;
+static int pretimeout = PDC_WD_DEFAULT_PRETIMEOUT;
+static bool nowayout = WATCHDOG_NOWAYOUT;
+
+struct pdc_wdt_dev {
+	struct watchdog_device wdt_dev;
+	int irq;
+	struct clk *clk;
+	void __iomem *base;
+	unsigned int pretimeout;
+};
+
+static int pdc_wdt_keepalive(struct watchdog_device *wdt_dev)
+{
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	writel(PDC_WD_TICKLE1_MAGIC, wdt->base + PDC_WD_TICKLE1);
+	writel(PDC_WD_TICKLE2_MAGIC, wdt->base + PDC_WD_TICKLE2);
+
+	return 0;
+}
+
+static int pdc_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	unsigned int val;
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	val = readl(wdt->base + PDC_WD_CONFIG);
+	val &= ~BIT(31);
+	writel(val, wdt->base + PDC_WD_CONFIG);
+	/* Must tickle to finish the stop */
+	pdc_wdt_keepalive(wdt_dev);
+
+	return 0;
+}
+
+static int pdc_wdt_set_timeout(struct watchdog_device *wdt_dev,
+			       unsigned int new_timeout)
+{
+	unsigned int val;
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	if (new_timeout < PDC_WD_MIN_TIMEOUT ||
+	    new_timeout > PDC_WD_MAX_TIMEOUT)
+		return -EINVAL;
+
+	wdt->wdt_dev.timeout = new_timeout;
+
+	/* round up to the next power of 2 */
+	new_timeout = order_base_2(new_timeout);
+	val = readl(wdt->base + PDC_WD_CONFIG);
+
+	/* number of 32.768KHz clocks, 2^(n+1) (14 is 1 sec) */
+	val &= ~PDC_WD_CONFIG_DELAY;
+	val |= (new_timeout + MIN_TIMEOUT_SHIFT) << PDC_WD_CONFIG_DELAY_SHIFT;
+	writel(val, wdt->base + PDC_WD_CONFIG);
+
+	return 0;
+}
+
+static int pdc_wdt_set_pretimeout(struct watchdog_device *wdt_dev,
+				  unsigned int new_pretimeout)
+{
+	int delay;
+	unsigned int val;
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+       /*
+	* Pretimeout is measured in seconds before main timeout.
+	* Subtract and round it once, and it will effectively change
+	* if the main timeout is changed.
+	*/
+	delay = wdt->wdt_dev.timeout;
+	if (!new_pretimeout)
+		new_pretimeout = PDC_WD_MAX_TIMEOUT;
+	else if (new_pretimeout > 0 && new_pretimeout < delay)
+		new_pretimeout = delay - new_pretimeout;
+	else
+		return -EINVAL;
+
+	pretimeout = new_pretimeout;
+	new_pretimeout = ilog2(new_pretimeout);
+	val = readl(wdt->base + PDC_WD_CONFIG);
+
+	/* number of 32.768KHz clocks, 2^(n+1) (14 is 1 sec) */
+	val &= ~PDC_WD_CONFIG_REMIND;
+	val |= (new_pretimeout + MIN_TIMEOUT_SHIFT)
+				<< PDC_WD_CONFIG_REMIND_SHIFT;
+	writel(val, wdt->base + PDC_WD_CONFIG);
+	wdt->pretimeout = pretimeout;
+
+	return 0;
+}
+
+/* Start the watchdog timer (delay should already be set */
+static int pdc_wdt_start(struct watchdog_device *wdt_dev)
+{
+	int ret;
+	unsigned int val;
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	ret = pdc_wdt_set_timeout(&wdt->wdt_dev, wdt->wdt_dev.timeout);
+	if (ret < 0)
+		return ret;
+
+	val = readl(wdt->base + PDC_WD_CONFIG);
+	val |= BIT(31);
+	writel(val, wdt->base + PDC_WD_CONFIG);
+
+	return 0;
+}
+
+static long pdc_wdt_ioctl(struct watchdog_device  *wdt_dev,
+			  unsigned int cmd, unsigned long arg)
+{
+	int ret = -ENOIOCTLCMD;
+	unsigned int new_pretimeout;
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	switch (cmd) {
+	case WDIOC_SETPRETIMEOUT:
+		if (get_user(new_pretimeout, p))
+			return -EFAULT;
+
+		ret = pdc_wdt_set_pretimeout(wdt_dev, new_pretimeout);
+		if (ret < 0)
+			return ret;
+
+		/* fallthrough */
+	case WDIOC_GETPRETIMEOUT:
+		ret = put_user(wdt->pretimeout, (int __user *)arg);
+		break;
+	}
+
+	return ret;
+}
+
+
+static irqreturn_t pdc_wdt_isr(int irq, void *dev_id)
+{
+	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(dev_id);
+	unsigned int stat = readl(pdc_wdt->base + PDC_WD_IRQ_STATUS);
+	/*
+	 * The behaviour of the remind interrupt should depend on what userland
+	 * asks for, either do nothing, panic the system or inform userland.
+	 * Unfortunately this is not part of the main linux interface, and is
+	 * currently implemented only in the ipmi watchdog driver (in
+	 * drivers/char). This could be added at a later time.
+	 */
+	writel(stat, pdc_wdt->base + PDC_WD_IRQ_CLEAR);
+	return IRQ_HANDLED;
+}
+
+static struct watchdog_info pdc_wdt_info = {
+	.options		= WDIOF_SETTIMEOUT |
+				  WDIOF_KEEPALIVEPING |
+				  WDIOF_PRETIMEOUT |
+				  WDIOF_MAGICCLOSE,
+	.identity = "PDC Watchdog",
+};
+
+/* Kernel interface */
+
+static const struct watchdog_ops pdc_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= pdc_wdt_start,
+	.stop		= pdc_wdt_stop,
+	.ping		= pdc_wdt_keepalive,
+	.set_timeout	= pdc_wdt_set_timeout,
+	.ioctl		= pdc_wdt_ioctl,
+};
+
+static int pdc_wdt_probe(struct platform_device *pdev)
+{
+	int ret, val, irq;
+	struct resource *res;
+	struct pdc_wdt_dev *pdc_wdt;
+
+	pdc_wdt = devm_kzalloc(&pdev->dev, sizeof(*pdc_wdt), GFP_KERNEL);
+	if (!pdc_wdt)
+		return -ENOMEM;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "cannot find wdt IRQ resource\n");
+		return irq;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pdc_wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pdc_wdt->base))
+		return PTR_ERR(pdc_wdt->base);
+
+	pdc_wdt->clk = devm_clk_get(&pdev->dev, "wdt");
+	if (IS_ERR(pdc_wdt->clk)) {
+		dev_err(&pdev->dev, "failed to get the clock.\n");
+		return PTR_ERR(pdc_wdt->clk);
+	}
+
+	ret = clk_prepare_enable(pdc_wdt->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not prepare or enable wdt clock.\n");
+		return ret;
+	}
+
+	pdc_wdt->wdt_dev.info = &pdc_wdt_info;
+	pdc_wdt->wdt_dev.ops = &pdc_wdt_ops;
+	pdc_wdt->wdt_dev.timeout = PDC_WD_DEFAULT_TIMEOUT;
+	pdc_wdt->wdt_dev.max_timeout = PDC_WD_MAX_TIMEOUT;
+	pdc_wdt->wdt_dev.min_timeout = PDC_WD_MIN_TIMEOUT;
+	pdc_wdt->wdt_dev.parent = &pdev->dev;
+
+	watchdog_init_timeout(&pdc_wdt->wdt_dev, timeout, &pdev->dev);
+
+	/* Enable remind interrupts */
+	writel(PDC_WD_IRQ_REMIND, pdc_wdt->base + PDC_WD_IRQ_EN);
+	pdc_wdt_stop(&pdc_wdt->wdt_dev);
+	/* Set timeouts before userland has a chance to start the timer */
+	pdc_wdt_set_timeout(&pdc_wdt->wdt_dev, timeout);
+	pdc_wdt_set_pretimeout(&pdc_wdt->wdt_dev, pretimeout);
+
+	/* Find what caused the last reset */
+	val = readl(pdc_wdt->base + PDC_WD_TICKLE1);
+	val = (val & PDC_WD_TICKLE_STATUS) >> PDC_WD_TICKLE_STATUS_SHIFT;
+	switch (val) {
+	case PDC_WD_TICKLE_STATUS_TICKLE:
+	case PDC_WD_TICKLE_STATUS_TIMEOUT:
+		pdc_wdt->wdt_dev.bootstatus |= WDIOF_CARDRESET;
+		dev_info(&pdev->dev,
+			"watchdog module last reset due to timeout\n");
+		break;
+	case PDC_WD_TICKLE_STATUS_HRESET:
+		dev_info(&pdev->dev,
+			"watchdog module last reset due to hard reset\n");
+		break;
+	case PDC_WD_TICKLE_STATUS_SRESET:
+		dev_info(&pdev->dev,
+			"watchdog module last reset due to soft reset\n");
+		break;
+	case PDC_WD_TICKLE_STATUS_USER:
+		dev_info(&pdev->dev,
+			"watchdog module last reset due to user reset\n");
+		break;
+	default:
+		dev_info(&pdev->dev,
+			"contains an illegal status code (%08x)\n", val);
+		break;
+	}
+
+	watchdog_set_nowayout(&pdc_wdt->wdt_dev, nowayout);
+
+	platform_set_drvdata(pdev, pdc_wdt);
+	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
+
+	ret = watchdog_register_device(&pdc_wdt->wdt_dev);
+	if (ret) {
+		clk_disable_unprepare(pdc_wdt->clk);
+		return ret;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, pdc_wdt_isr,
+			       IRQ_TYPE_LEVEL_HIGH, dev_name(&pdev->dev), pdev);
+	if (ret) {
+		watchdog_unregister_device(&pdc_wdt->wdt_dev);
+		clk_disable_unprepare(pdc_wdt->clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pdc_wdt_remove(struct platform_device *pdev)
+{
+	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(&pdc_wdt->wdt_dev);
+	clk_disable_unprepare(pdc_wdt->clk);
+	watchdog_set_drvdata(&pdc_wdt->wdt_dev, NULL);
+
+	return 0;
+}
+
+static void pdc_wdt_shutdown(struct platform_device *pdev)
+{
+	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
+
+	pdc_wdt_stop(&pdc_wdt->wdt_dev);
+}
+
+static const struct of_device_id pdc_wdt_match[] = {
+	{ .compatible = "img,pistachio-pdc-wdt" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pdc_wdt_match);
+
+static struct platform_driver pdc_wdt_driver = {
+	.driver = {
+		.name = "imgpdc-wdt",
+		.of_match_table	= pdc_wdt_match,
+	},
+	.probe = pdc_wdt_probe,
+	.remove = pdc_wdt_remove,
+	.shutdown = pdc_wdt_shutdown,
+};
+module_platform_driver(pdc_wdt_driver);
+
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout,
+	"PDC watchdog timer delay in seconds ("
+	__MODULE_STRING(PDC_WD_MIN_TIMEOUT)" <= timeout <= "
+	__MODULE_STRING(PDC_WD_MAX_TIMEOUT)
+	"; default = " __MODULE_STRING(PDC_WD_DEFAULT_TIMEOUT) ")");
+
+module_param(pretimeout, int, 0);
+MODULE_PARM_DESC(pretimeout,
+	"PDC watchdog timer remind in seconds ("
+	__MODULE_STRING(PDC_WD_MIN_TIMEOUT)" <= pretimeout <= "
+	__MODULE_STRING(PDC_WD_MAX_TIMEOUT)
+	"; default = " __MODULE_STRING(PDC_WD_DEFAULT_PRETIMEOUT) ")");
+
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+	"Watchdog cannot be stopped once started (default = "
+		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Jude Abraham <Jude.Abraham@imgtec.com>");
+MODULE_AUTHOR("Naidu Tellapati <Naidu.Tellapati@imgtec.com>");
+MODULE_DESCRIPTION("Imagination Technologies PDC Watchdog Timer Driver");
+MODULE_ALIAS("platform:img_pdc_wdt");
-- 
1.7.0.4
