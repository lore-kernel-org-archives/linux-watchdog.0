Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58630 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab1ETEV2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 May 2011 00:21:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4K4LO63007200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-watchdog@vger.kernel.org>; Thu, 19 May 2011 23:21:27 -0500
From: Keerthy <j-keerthy@ti.com>
To: <linux-watchdog@vger.kernel.org>, <s-sabatier1@ti.com>,
	<aneesh@ti.com>, <vishwanath.bs@ti.com>
CC: <j-keerthy@ti.com>
Subject: [PATCH] Adding on die temperature check.
Date: Fri, 20 May 2011 09:51:16 +0530
Message-ID: <1305865276-22410-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/cpu/armv7/omap4/board.c         |   56 ++++++++++++++++++++++++++++++
 arch/arm/cpu/armv7/omap4/clocks.c        |    3 ++
 arch/arm/include/asm/arch-omap4/clocks.h |    3 ++
 arch/arm/include/asm/arch-omap4/omap4.h  |   32 +++++++++++++++++
 4 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/arch/arm/cpu/armv7/omap4/board.c b/arch/arm/cpu/armv7/omap4/board.c
index 5d748cf..cdb9bc1 100644
--- a/arch/arm/cpu/armv7/omap4/board.c
+++ b/arch/arm/cpu/armv7/omap4/board.c
@@ -36,6 +36,7 @@
 #include <asm/utils.h>
 #include <asm/omap_gpio.h>
 #include "omap4_mux_data.h"
+#include <asm/arch/clocks.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -109,6 +110,60 @@ void wait_for_command_complete(struct watchdog *wd_base)
 }
 
 /*
+ * On die temperature sensor check
+ * If the current temperature value is
+ * greater than T_SHUT_HOT apply warm reset
+ */
+
+void temp_sensor_check(void)
+{
+	u32 temp;
+	switch (omap4_hw_init_context()) {
+	case OMAP_INIT_CONTEXT_SPL:
+	case OMAP_INIT_CONTEXT_XIP_UBOOT:
+	case OMAP_INIT_CONTEXT_UBOOT_LOADED_BY_CH:
+		modify_reg_32(CORE_BANDGAP_COUNTER, BGAP_COUNTER_SHIFT,
+			BGAP_COUNTER_MASK, 1);
+		/* Enable continuous mode. */
+		modify_reg_32(CORE_BANDGAP_CTRL, BGAP_SINGLE_MODE_SHIFT,
+		BGAP_SINGLE_MODE_MASK, 1);
+		/* Wait for the conversion to complete. Monitor EOCZ */
+		while (!(readl(CORE_TEMP_SENSOR) & 0x100))
+			sdelay(100);
+		/* Read the temperature adc_value */
+		temp = readl(CORE_TEMP_SENSOR);
+		temp = temp & BGAP_TEMP_SENSOR_DTEMP_MASK;
+		/* If the samples are untrimmed divide by 1.2 */
+		if (readl(STD_FUSE_OPP_BGAP) == 0)
+			temp = temp * 5 / 6;
+		/*
+		 * Compare with TSHUT high temperature. If high ask the
+		 * user to shut down and restart after sometime else
+		 * Disable continuous mode.
+		 */
+		if (temp < TSHUT_HIGH_ADC_CODE) {
+			temp = readl(CORE_BANDGAP_CTRL);
+			temp = temp & ~(BGAP_SINGLE_MODE_MASK);
+			writel(temp, CORE_BANDGAP_CTRL);
+		} else {
+			printf("Device temperature too high!!!\n");
+			printf("Please turn off try booting after sometime\n");
+			bypass_dpll(CM_CLKMODE_DPLL_MPU);
+			bypass_dpll(CM_CLKMODE_DPLL_CORE);
+			bypass_dpll(CM_CLKMODE_DPLL_IVA);
+			bypass_dpll(CM_CLKMODE_DPLL_PER);
+			bypass_dpll(CM_CLKMODE_DPLL_ABE);
+			bypass_dpll(CM_CLKMODE_DPLL_USB);
+			while (1);
+		}
+		break;
+	default:
+		break;
+	}
+
+}
+
+/*
  * Routine: watchdog_init
  * Description: Shut down watch dogs
  */
@@ -299,5 +354,6 @@ void s_init(void)
 		readl(CONTROL_ID_CODE), cortex_a9_rev());
 #endif
 	prcm_init();
+	temp_sensor_check();
 	sdram_init();
 }
diff --git a/arch/arm/cpu/armv7/omap4/clocks.c b/arch/arm/cpu/armv7/omap4/clocks.c
index 8c52f21..20e8381 100644
--- a/arch/arm/cpu/armv7/omap4/clocks.c
+++ b/arch/arm/cpu/armv7/omap4/clocks.c
@@ -754,6 +754,9 @@ static void enable_clocks(const u32 *clock_domains,
  */
 static void enable_basic_clocks(void)
 {
+	/* Enable fucntional clock of on die temperature sensor */
+	writel(readl(CM_WKUP_BANDGAP_CLKCTRL) | OPTFCLKEN_TS_FCLK_MASK,
+	CM_WKUP_BANDGAP_CLKCTRL);
 	/* Enable optional additional functional clock for GPIO4 */
 	writel(readl(CM_L4PER_GPIO4_CLKCTRL) | GPIO4_CLKCTRL_OPTFCLKEN_MASK,
 	       CM_L4PER_GPIO4_CLKCTRL);
diff --git a/arch/arm/include/asm/arch-omap4/clocks.h b/arch/arm/include/asm/arch-omap4/clocks.h
index e25a6ea..8f9d9ea 100644
--- a/arch/arm/include/asm/arch-omap4/clocks.h
+++ b/arch/arm/include/asm/arch-omap4/clocks.h
@@ -397,6 +397,9 @@
 #define MODULE_CLKCTRL_IDLEST_IDLE		2
 #define MODULE_CLKCTRL_IDLEST_DISABLED		3
 
+/* CM_WKUP_BANDGAP_CLKCTRL */
+#define OPTFCLKEN_TS_FCLK_MASK			(1 << 8)
+
 /* CM_L4PER_GPIO4_CLKCTRL */
 #define GPIO4_CLKCTRL_OPTFCLKEN_MASK		(1 << 8)
 
diff --git a/arch/arm/include/asm/arch-omap4/omap4.h b/arch/arm/include/asm/arch-omap4/omap4.h
index d68a2cf..015e6e3 100644
--- a/arch/arm/include/asm/arch-omap4/omap4.h
+++ b/arch/arm/include/asm/arch-omap4/omap4.h
@@ -99,6 +99,38 @@
 /* GPMC */
 #define OMAP44XX_GPMC_BASE	0x50000000
 
+/* OMAP4460 on die TEMPERATURE SENSOR */
+#define CORE_BANDGAP_COUNTER	(OMAP44XX_L4_CORE_BASE + 0x237C)
+#define CORE_BANDGAP_CTRL	(OMAP44XX_L4_CORE_BASE + 0x2378)
+#define CORE_TEMP_SENSOR	(OMAP44XX_L4_CORE_BASE + 0x232C)
+#define STD_FUSE_OPP_BGAP	(OMAP44XX_L4_CORE_BASE + 0x2260)
+
+/* BANDGAP_COUNTER */
+#define BGAP_COUNTER_SHIFT		0
+#define BGAP_COUNTER_MASK		(0xffffff << 0)
+
+/* BANDGAP_CTRL */
+#define BGAP_SINGLE_MODE_SHIFT			31
+#define BGAP_SINGLE_MODE_MASK			(1 << 31)
+#define OMAP4_MASK_HOT_SHIFT			1
+#define OMAP4_MASK_HOT_MASK			(1 << 1)
+#define OMAP4_MASK_COLD_SHIFT			0
+#define OMAP4_MASK_COLD_MASK			(1 << 0)
+
+/* TEMP_SENSOR */
+#define BGAP_TEMPSOFF_SHIFT			13
+#define BGAP_TEMPSOFF_MASK			(1 << 13)
+#define BGAP_TEMP_SENSOR_CONTCONV_SHIFT		12
+#define BGAP_TEMP_SENSOR_CONTCONV_MASK		(1 << 12)
+#define BGAP_TEMP_SENSOR_SOC_SHIFT		11
+#define BGAP_TEMP_SENSOR_SOC_MASK		(1 << 11)
+#define BGAP_TEMP_SENSOR_EOCZ_SHIFT		10
+#define BGAP_TEMP_SENSOR_EOCZ_MASK		(1 << 10)
+#define BGAP_TEMP_SENSOR_DTEMP_SHIFT		0
+#define BGAP_TEMP_SENSOR_DTEMP_MASK		(0x3ff << 0)
+
+/* TSHUT high ADC code */
+#define TSHUT_HIGH_ADC_CODE			923
 
 /*
  * Hardware Register Details
-- 
1.7.0.4

