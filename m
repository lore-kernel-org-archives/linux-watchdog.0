Return-Path: <p.paillet@st.com>
Return-path: <p.paillet@st.com>
From: Pascal PAILLET-LME <p.paillet@st.com>
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com"
	<mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org"
	<broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org"
	<benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
CC: Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH v3 4/8] regulator: stpmic1: add stpmic1 regulator driver
Date: Mon, 8 Oct 2018 16:29:40 +0000
Message-ID: <1539016176-4072-5-git-send-email-p.paillet@st.com>
References: <1539016176-4072-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1539016176-4072-1-git-send-email-p.paillet@st.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

From: pascal paillet <p.paillet@st.com>

The stpmic1 PMIC embeds several regulators and switches with
different capabilities.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
changes in v3:
* Rename struct stpmic1_dev by struct stpmic1.
* Remove useless struct stpmic1_device_data.=20
* Fix typo in commit message.
* Add email address in MODULE_AUTHOR.

 drivers/regulator/Kconfig             |  12 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/stpmic1_regulator.c | 674 ++++++++++++++++++++++++++++++=
++++
 3 files changed, 687 insertions(+)
 create mode 100644 drivers/regulator/stpmic1_regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6e96ef1..026d480 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -803,6 +803,18 @@ config REGULATOR_STM32_VREFBUF
 	  This driver can also be built as a module. If so, the module
 	  will be called stm32-vrefbuf.
=20
+config REGULATOR_STPMIC1
+	tristate "STMicroelectronics STPMIC1 PMIC Regulators"
+	depends on MFD_STPMIC1
+	help
+	  This driver supports STMicroelectronics STPMIC1 PMIC voltage
+	  regulators and switches. The STPMIC1 regulators supply power to
+	  an application processor as well as to external system
+	  peripherals such as DDR, Flash memories and system devices.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stpmic1_regulator.
+
 config REGULATOR_TI_ABB
 	tristate "TI Adaptive Body Bias on-chip LDO"
 	depends on ARCH_OMAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index eac4d79..300bc4c 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_REGULATOR_S5M8767) +=3D s5m8767.o
 obj-$(CONFIG_REGULATOR_SC2731) +=3D sc2731-regulator.o
 obj-$(CONFIG_REGULATOR_SKY81452) +=3D sky81452-regulator.o
 obj-$(CONFIG_REGULATOR_STM32_VREFBUF) +=3D stm32-vrefbuf.o
+obj-$(CONFIG_REGULATOR_STPMIC1) +=3D stpmic1_regulator.o
 obj-$(CONFIG_REGULATOR_STW481X_VMMC) +=3D stw481x-vmmc.o
 obj-$(CONFIG_REGULATOR_SY8106A) +=3D sy8106a-regulator.o
 obj-$(CONFIG_REGULATOR_TI_ABB) +=3D ti-abb-regulator.o
diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpm=
ic1_regulator.c
new file mode 100644
index 0000000..96f1808
--- /dev/null
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -0,0 +1,674 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) STMicroelectronics 2018
+// Author: Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+
+#include <linux/interrupt.h>
+#include <linux/mfd/stpmic1.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+/**
+ * stpmic1 regulator description
+ * @desc: regulator framework description
+ * @mask_reset_reg: mask reset register address
+ * @mask_reset_mask: mask rank and mask reset register mask
+ * @icc_reg: icc register address
+ * @icc_mask: icc register mask
+ */
+struct stpmic1_regulator_cfg {
+	struct regulator_desc desc;
+	u8 mask_reset_reg;
+	u8 mask_reset_mask;
+	u8 icc_reg;
+	u8 icc_mask;
+};
+
+/**
+ * stpmic1 regulator data: this structure is used as driver data
+ * @regul_id: regulator id
+ * @reg_node: DT node of regulator (unused on non-DT platforms)
+ * @cfg: stpmic specific regulator description
+ * @mask_reset: mask_reset bit value
+ * @irq_curlim: current limit interrupt number
+ * @regmap: point to parent regmap structure
+ */
+struct stpmic1_regulator {
+	unsigned int regul_id;
+	struct device_node *reg_node;
+	struct stpmic1_regulator_cfg *cfg;
+	u8 mask_reset;
+	int irq_curlim;
+	struct regmap *regmap;
+};
+
+static int stpmic1_set_mode(struct regulator_dev *rdev, unsigned int mode)=
;
+static unsigned int stpmic1_get_mode(struct regulator_dev *rdev);
+static int stpmic1_set_icc(struct regulator_dev *rdev);
+static int stpmic1_regulator_parse_dt(void *driver_data);
+static unsigned int stpmic1_map_mode(unsigned int mode);
+
+enum {
+	STPMIC1_BUCK1 =3D 0,
+	STPMIC1_BUCK2 =3D 1,
+	STPMIC1_BUCK3 =3D 2,
+	STPMIC1_BUCK4 =3D 3,
+	STPMIC1_LDO1 =3D 4,
+	STPMIC1_LDO2 =3D 5,
+	STPMIC1_LDO3 =3D 6,
+	STPMIC1_LDO4 =3D 7,
+	STPMIC1_LDO5 =3D 8,
+	STPMIC1_LDO6 =3D 9,
+	STPMIC1_VREF_DDR =3D 10,
+	STPMIC1_BOOST =3D 11,
+	STPMIC1_VBUS_OTG =3D 12,
+	STPMIC1_SW_OUT =3D 13,
+};
+
+/* Enable time worst case is 5000mV/(2250uV/uS) */
+#define PMIC_ENABLE_TIME_US 2200
+
+#define STPMIC1_BUCK_MODE_NORMAL 0
+#define STPMIC1_BUCK_MODE_LP BUCK_HPLP_ENABLE_MASK
+
+struct regulator_linear_range buck1_ranges[] =3D {
+	REGULATOR_LINEAR_RANGE(600000, 0, 30, 25000),
+	REGULATOR_LINEAR_RANGE(1350000, 31, 63, 0),
+};
+
+struct regulator_linear_range buck2_ranges[] =3D {
+	REGULATOR_LINEAR_RANGE(1000000, 0, 17, 0),
+	REGULATOR_LINEAR_RANGE(1050000, 18, 19, 0),
+	REGULATOR_LINEAR_RANGE(1100000, 20, 21, 0),
+	REGULATOR_LINEAR_RANGE(1150000, 22, 23, 0),
+	REGULATOR_LINEAR_RANGE(1200000, 24, 25, 0),
+	REGULATOR_LINEAR_RANGE(1250000, 26, 27, 0),
+	REGULATOR_LINEAR_RANGE(1300000, 28, 29, 0),
+	REGULATOR_LINEAR_RANGE(1350000, 30, 31, 0),
+	REGULATOR_LINEAR_RANGE(1400000, 32, 33, 0),
+	REGULATOR_LINEAR_RANGE(1450000, 34, 35, 0),
+	REGULATOR_LINEAR_RANGE(1500000, 36, 63, 0),
+};
+
+struct regulator_linear_range buck3_ranges[] =3D {
+	REGULATOR_LINEAR_RANGE(1000000, 0, 19, 0),
+	REGULATOR_LINEAR_RANGE(1100000, 20, 23, 0),
+	REGULATOR_LINEAR_RANGE(1200000, 24, 27, 0),
+	REGULATOR_LINEAR_RANGE(1300000, 28, 31, 0),
+	REGULATOR_LINEAR_RANGE(1400000, 32, 35, 0),
+	REGULATOR_LINEAR_RANGE(1500000, 36, 55, 100000),
+	REGULATOR_LINEAR_RANGE(3400000, 56, 63, 0),
+
+};
+
+struct regulator_linear_range buck4_ranges[] =3D {
+	REGULATOR_LINEAR_RANGE(600000, 0, 27, 25000),
+	REGULATOR_LINEAR_RANGE(1300000, 28, 29, 0),
+	REGULATOR_LINEAR_RANGE(1350000, 30, 31, 0),
+	REGULATOR_LINEAR_RANGE(1400000, 32, 33, 0),
+	REGULATOR_LINEAR_RANGE(1450000, 34, 35, 0),
+	REGULATOR_LINEAR_RANGE(1500000, 36, 60, 100000),
+	REGULATOR_LINEAR_RANGE(3900000, 61, 63, 0),
+
+};
+
+struct regulator_linear_range ldo1_ranges[] =3D {
+	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
+	REGULATOR_LINEAR_RANGE(1700000, 8, 24, 100000),
+	REGULATOR_LINEAR_RANGE(3300000, 25, 31, 0),
+
+};
+
+struct regulator_linear_range ldo2_ranges[] =3D {
+	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
+	REGULATOR_LINEAR_RANGE(1700000, 8, 24, 100000),
+	REGULATOR_LINEAR_RANGE(3300000, 25, 30, 0),
+
+};
+
+struct regulator_linear_range ldo3_ranges[] =3D {
+	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
+	REGULATOR_LINEAR_RANGE(1700000, 8, 24, 100000),
+	REGULATOR_LINEAR_RANGE(3300000, 25, 30, 0),
+	/* with index 31 LDO3 is in DDR mode */
+	REGULATOR_LINEAR_RANGE(500000, 31, 31, 0),
+};
+
+struct regulator_linear_range ldo5_ranges[] =3D {
+	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
+	REGULATOR_LINEAR_RANGE(1700000, 8, 30, 100000),
+	REGULATOR_LINEAR_RANGE(3900000, 31, 31, 0),
+};
+
+struct regulator_linear_range ldo6_ranges[] =3D {
+	REGULATOR_LINEAR_RANGE(900000, 0, 24, 100000),
+	REGULATOR_LINEAR_RANGE(3300000, 25, 31, 0),
+};
+
+static struct regulator_ops stpmic1_ldo_ops =3D {
+	.list_voltage =3D regulator_list_voltage_linear_range,
+	.map_voltage =3D regulator_map_voltage_linear_range,
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
+	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
+	.set_pull_down =3D regulator_set_pull_down_regmap,
+	.set_over_current_protection =3D stpmic1_set_icc,
+};
+
+static struct regulator_ops stpmic1_ldo3_ops =3D {
+	.list_voltage =3D regulator_list_voltage_linear_range,
+	.map_voltage =3D regulator_map_voltage_iterate,
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
+	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
+	.set_pull_down =3D regulator_set_pull_down_regmap,
+	.get_bypass =3D regulator_get_bypass_regmap,
+	.set_bypass =3D regulator_set_bypass_regmap,
+	.set_over_current_protection =3D stpmic1_set_icc,
+};
+
+static struct regulator_ops stpmic1_ldo4_fixed_regul_ops =3D {
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.set_pull_down =3D regulator_set_pull_down_regmap,
+	.set_over_current_protection =3D stpmic1_set_icc,
+};
+
+static struct regulator_ops stpmic1_buck_ops =3D {
+	.list_voltage =3D regulator_list_voltage_linear_range,
+	.map_voltage =3D regulator_map_voltage_linear_range,
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
+	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
+	.set_pull_down =3D regulator_set_pull_down_regmap,
+	.set_mode =3D stpmic1_set_mode,
+	.get_mode =3D stpmic1_get_mode,
+	.set_over_current_protection =3D stpmic1_set_icc,
+};
+
+static struct regulator_ops stpmic1_vref_ddr_ops =3D {
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.set_pull_down =3D regulator_set_pull_down_regmap,
+};
+
+static struct regulator_ops stpmic1_switch_regul_ops =3D {
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.set_over_current_protection =3D stpmic1_set_icc,
+};
+
+#define REG_LDO(ids, base) { \
+	.name =3D #ids, \
+	.id =3D STPMIC1_##ids, \
+	.n_voltages =3D 32, \
+	.ops =3D &stpmic1_ldo_ops, \
+	.linear_ranges =3D base ## _ranges, \
+	.n_linear_ranges =3D ARRAY_SIZE(base ## _ranges), \
+	.type =3D REGULATOR_VOLTAGE, \
+	.owner =3D THIS_MODULE, \
+	.vsel_reg =3D ids##_ACTIVE_CR, \
+	.vsel_mask =3D LDO_VOLTAGE_MASK, \
+	.enable_reg =3D ids##_ACTIVE_CR, \
+	.enable_mask =3D LDO_ENABLE_MASK, \
+	.enable_val =3D 1, \
+	.disable_val =3D 0, \
+	.enable_time =3D PMIC_ENABLE_TIME_US, \
+	.pull_down_reg =3D ids##_PULL_DOWN_REG, \
+	.pull_down_mask =3D ids##_PULL_DOWN_MASK, \
+	.supply_name =3D #base, \
+}
+
+#define REG_LDO3(ids, base) { \
+	.name =3D #ids, \
+	.id =3D STPMIC1_##ids, \
+	.n_voltages =3D 32, \
+	.ops =3D &stpmic1_ldo3_ops, \
+	.linear_ranges =3D ldo3_ranges, \
+	.n_linear_ranges =3D ARRAY_SIZE(ldo3_ranges), \
+	.type =3D REGULATOR_VOLTAGE, \
+	.owner =3D THIS_MODULE, \
+	.vsel_reg =3D LDO3_ACTIVE_CR, \
+	.vsel_mask =3D LDO_VOLTAGE_MASK, \
+	.enable_reg =3D LDO3_ACTIVE_CR, \
+	.enable_mask =3D LDO_ENABLE_MASK, \
+	.enable_val =3D 1, \
+	.disable_val =3D 0, \
+	.enable_time =3D PMIC_ENABLE_TIME_US, \
+	.bypass_reg =3D LDO3_ACTIVE_CR, \
+	.bypass_mask =3D LDO_BYPASS_MASK, \
+	.bypass_val_on =3D LDO_BYPASS_MASK, \
+	.bypass_val_off =3D 0, \
+	.pull_down_reg =3D ids##_PULL_DOWN_REG, \
+	.pull_down_mask =3D ids##_PULL_DOWN_MASK, \
+	.supply_name =3D #base, \
+}
+
+#define REG_LDO4(ids, base) { \
+	.name =3D #ids, \
+	.id =3D STPMIC1_##ids, \
+	.n_voltages =3D 1, \
+	.ops =3D &stpmic1_ldo4_fixed_regul_ops, \
+	.type =3D REGULATOR_VOLTAGE, \
+	.owner =3D THIS_MODULE, \
+	.min_uV =3D 3300000, \
+	.fixed_uV =3D 3300000, \
+	.enable_reg =3D LDO4_ACTIVE_CR, \
+	.enable_mask =3D LDO_ENABLE_MASK, \
+	.enable_val =3D 1, \
+	.disable_val =3D 0, \
+	.enable_time =3D PMIC_ENABLE_TIME_US, \
+	.pull_down_reg =3D ids##_PULL_DOWN_REG, \
+	.pull_down_mask =3D ids##_PULL_DOWN_MASK, \
+	.supply_name =3D #base, \
+}
+
+#define REG_BUCK(ids, base) { \
+	.name =3D #ids, \
+	.id =3D STPMIC1_##ids, \
+	.ops =3D &stpmic1_buck_ops, \
+	.n_voltages =3D 64, \
+	.linear_ranges =3D base ## _ranges, \
+	.n_linear_ranges =3D ARRAY_SIZE(base ## _ranges), \
+	.type =3D REGULATOR_VOLTAGE, \
+	.owner =3D THIS_MODULE, \
+	.vsel_reg =3D ids##_ACTIVE_CR, \
+	.vsel_mask =3D BUCK_VOLTAGE_MASK, \
+	.enable_reg =3D ids##_ACTIVE_CR, \
+	.enable_mask =3D BUCK_ENABLE_MASK, \
+	.enable_val =3D 1, \
+	.disable_val =3D 0, \
+	.enable_time =3D PMIC_ENABLE_TIME_US, \
+	.of_map_mode =3D stpmic1_map_mode, \
+	.pull_down_reg =3D ids##_PULL_DOWN_REG, \
+	.pull_down_mask =3D ids##_PULL_DOWN_MASK, \
+	.supply_name =3D #base, \
+}
+
+#define REG_VREF_DDR(ids, base) { \
+	.name =3D #ids, \
+	.id =3D STPMIC1_##ids, \
+	.n_voltages =3D 1, \
+	.ops =3D &stpmic1_vref_ddr_ops, \
+	.type =3D REGULATOR_VOLTAGE, \
+	.owner =3D THIS_MODULE, \
+	.min_uV =3D 500000, \
+	.fixed_uV =3D 500000, \
+	.enable_reg =3D VREF_DDR_ACTIVE_CR, \
+	.enable_mask =3D BUCK_ENABLE_MASK, \
+	.enable_val =3D 1, \
+	.disable_val =3D 0, \
+	.enable_time =3D PMIC_ENABLE_TIME_US, \
+	.pull_down_reg =3D ids##_PULL_DOWN_REG, \
+	.pull_down_mask =3D ids##_PULL_DOWN_MASK, \
+	.supply_name =3D #base, \
+}
+
+#define REG_SWITCH(ids, base, reg, mask, val) { \
+	.name =3D #ids, \
+	.id =3D STPMIC1_##ids, \
+	.n_voltages =3D 1, \
+	.ops =3D &stpmic1_switch_regul_ops, \
+	.type =3D REGULATOR_VOLTAGE, \
+	.owner =3D THIS_MODULE, \
+	.min_uV =3D 0, \
+	.fixed_uV =3D 5000000, \
+	.enable_reg =3D (reg), \
+	.enable_mask =3D (mask), \
+	.enable_val =3D (val), \
+	.disable_val =3D 0, \
+	.enable_time =3D PMIC_ENABLE_TIME_US, \
+	.supply_name =3D #base, \
+}
+
+struct stpmic1_regulator_cfg stpmic1_regulator_cfgs[] =3D {
+	[STPMIC1_BUCK1] =3D {
+		.desc =3D REG_BUCK(BUCK1, buck1),
+		.icc_reg =3D BUCKS_ICCTO_CR,
+		.icc_mask =3D BIT(0),
+		.mask_reset_reg =3D BUCKS_MASK_RESET_CR,
+		.mask_reset_mask =3D BIT(0),
+	},
+	[STPMIC1_BUCK2] =3D {
+		.desc =3D REG_BUCK(BUCK2, buck2),
+		.icc_reg =3D BUCKS_ICCTO_CR,
+		.icc_mask =3D BIT(1),
+		.mask_reset_reg =3D BUCKS_MASK_RESET_CR,
+		.mask_reset_mask =3D BIT(1),
+	},
+	[STPMIC1_BUCK3] =3D {
+		.desc =3D REG_BUCK(BUCK3, buck3),
+		.icc_reg =3D BUCKS_ICCTO_CR,
+		.icc_mask =3D BIT(2),
+		.mask_reset_reg =3D BUCKS_MASK_RESET_CR,
+		.mask_reset_mask =3D BIT(2),
+	},
+	[STPMIC1_BUCK4] =3D {
+		.desc =3D REG_BUCK(BUCK4, buck4),
+		.icc_reg =3D BUCKS_ICCTO_CR,
+		.icc_mask =3D BIT(3),
+		.mask_reset_reg =3D BUCKS_MASK_RESET_CR,
+		.mask_reset_mask =3D BIT(3),
+	},
+	[STPMIC1_LDO1] =3D {
+		.desc =3D REG_LDO(LDO1, ldo1),
+		.icc_reg =3D LDOS_ICCTO_CR,
+		.icc_mask =3D BIT(0),
+		.mask_reset_reg =3D LDOS_MASK_RESET_CR,
+		.mask_reset_mask =3D BIT(0),
+	},
+	[STPMIC1_LDO2] =3D {
+		.desc =3D REG_LDO(LDO2, ldo2),
+		.icc_reg =3D LDOS_ICCTO_CR,
+		.icc_mask =3D BIT(1),
+		.mask_reset_reg =3D LDOS_MASK_RESET_CR,
+		.mask_reset_mask =3D BIT(1),
+	},
+	[STPMIC1_LDO3] =3D {
+		.desc =3D REG_LDO3(LDO3, ldo3),
+		.icc_reg =3D LDOS_ICCTO_CR,
+		.icc_mask =3D BIT(2),
+		.mask_reset_reg =3D LDOS_MASK_RESET_CR,
+		.mask_reset_mask =3D BIT(2),
+	},
+	[STPMIC1_LDO4] =3D {
+		.desc =3D REG_LDO4(LDO4, ldo4),
+		.icc_reg =3D LDOS_ICCTO_CR,
+		.icc_mask =3D BIT(3),
+		.mask_reset_reg =3D LDOS_MASK_RESET_CR,
+		.mask_reset_mask =3D BIT(3),
+	},
+	[STPMIC1_LDO5] =3D {
+		.desc =3D REG_LDO(LDO5, ldo5),
+		.icc_reg =3D LDOS_ICCTO_CR,
+		.icc_mask =3D BIT(4),
+		.mask_reset_reg =3D LDOS_MASK_RESET_CR,
+		.mask_reset_mask =3D BIT(4),
+	},
+	[STPMIC1_LDO6] =3D {
+		.desc =3D REG_LDO(LDO6, ldo6),
+		.icc_reg =3D LDOS_ICCTO_CR,
+		.icc_mask =3D BIT(5),
+		.mask_reset_reg =3D LDOS_MASK_RESET_CR,
+		.mask_reset_mask =3D BIT(5),
+	},
+	[STPMIC1_VREF_DDR] =3D {
+		.desc =3D REG_VREF_DDR(VREF_DDR, vref_ddr),
+		.mask_reset_reg =3D LDOS_MASK_RESET_CR,
+		.mask_reset_mask =3D BIT(6),
+	},
+	[STPMIC1_BOOST] =3D {
+		.desc =3D REG_SWITCH(BOOST, boost, BST_SW_CR,
+				   BOOST_ENABLED,
+				   BOOST_ENABLED),
+		.icc_reg =3D BUCKS_ICCTO_CR,
+		.icc_mask =3D BIT(6),
+	},
+	[STPMIC1_VBUS_OTG] =3D {
+		.desc =3D REG_SWITCH(VBUS_OTG, pwr_sw1, BST_SW_CR,
+				   USBSW_OTG_SWITCH_ENABLED,
+				   USBSW_OTG_SWITCH_ENABLED),
+		.icc_reg =3D BUCKS_ICCTO_CR,
+		.icc_mask =3D BIT(4),
+	},
+	[STPMIC1_SW_OUT] =3D {
+		.desc =3D REG_SWITCH(SW_OUT, pwr_sw2, BST_SW_CR,
+				   SWIN_SWOUT_ENABLED,
+				   SWIN_SWOUT_ENABLED),
+		.icc_reg =3D BUCKS_ICCTO_CR,
+		.icc_mask =3D BIT(5),
+	},
+};
+
+static unsigned int stpmic1_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case STPMIC1_BUCK_MODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	case STPMIC1_BUCK_MODE_LP:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return -EINVAL;
+	}
+}
+
+static unsigned int stpmic1_get_mode(struct regulator_dev *rdev)
+{
+	int value;
+
+	regmap_read(rdev->regmap, rdev->desc->enable_reg, &value);
+
+	if (value & STPMIC1_BUCK_MODE_LP)
+		return REGULATOR_MODE_STANDBY;
+
+	return REGULATOR_MODE_NORMAL;
+}
+
+static int stpmic1_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	int value;
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		value =3D STPMIC1_BUCK_MODE_NORMAL;
+		break;
+	case REGULATOR_MODE_STANDBY:
+		value =3D STPMIC1_BUCK_MODE_LP;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
+				  STPMIC1_BUCK_MODE_LP, value);
+}
+
+static int stpmic1_set_icc(struct regulator_dev *rdev)
+{
+	struct stpmic1_regulator *regul =3D rdev_get_drvdata(rdev);
+
+	/* enable switch off in case of over current */
+	return regmap_update_bits(regul->regmap, regul->cfg->icc_reg,
+				  regul->cfg->icc_mask, regul->cfg->icc_mask);
+}
+
+static irqreturn_t stpmic1_curlim_irq_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev =3D (struct regulator_dev *)data;
+
+	mutex_lock(&rdev->mutex);
+
+	/* Send an overcurrent notification */
+	regulator_notifier_call_chain(rdev,
+				      REGULATOR_EVENT_OVER_CURRENT,
+				      NULL);
+
+	mutex_unlock(&rdev->mutex);
+
+	return IRQ_HANDLED;
+}
+
+static int stpmic1_regulator_init(struct platform_device *pdev,
+				  struct regulator_dev *rdev)
+{
+	struct stpmic1_regulator *regul =3D rdev_get_drvdata(rdev);
+	int ret =3D 0;
+
+	/* set mask reset */
+	if (regul->mask_reset && regul->cfg->mask_reset_reg !=3D 0) {
+		ret =3D regmap_update_bits(regul->regmap,
+					 regul->cfg->mask_reset_reg,
+					 regul->cfg->mask_reset_mask,
+					 regul->cfg->mask_reset_mask);
+		if (ret) {
+			dev_err(&pdev->dev, "set mask reset failed\n");
+			return ret;
+		}
+	}
+
+	/* setup an irq handler for over-current detection */
+	if (regul->irq_curlim > 0) {
+		ret =3D devm_request_threaded_irq(&pdev->dev,
+						regul->irq_curlim, NULL,
+						stpmic1_curlim_irq_handler,
+						IRQF_ONESHOT | IRQF_SHARED,
+						pdev->name, rdev);
+		if (ret) {
+			dev_err(&pdev->dev, "Request IRQ failed\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
+#define MATCH(_name, _id) \
+	[STPMIC1_##_id] =3D { \
+		.name =3D #_name, \
+		.desc =3D &stpmic1_regulator_cfgs[STPMIC1_##_id].desc, \
+	}
+
+static struct of_regulator_match stpmic1_regulators_matches[] =3D {
+	MATCH(buck1, BUCK1),
+	MATCH(buck2, BUCK2),
+	MATCH(buck3, BUCK3),
+	MATCH(buck4, BUCK4),
+	MATCH(ldo1, LDO1),
+	MATCH(ldo2, LDO2),
+	MATCH(ldo3, LDO3),
+	MATCH(ldo4, LDO4),
+	MATCH(ldo5, LDO5),
+	MATCH(ldo6, LDO6),
+	MATCH(vref_ddr, VREF_DDR),
+	MATCH(boost, BOOST),
+	MATCH(pwr_sw1, VBUS_OTG),
+	MATCH(pwr_sw2, SW_OUT),
+};
+
+static int stpmic1_regulator_parse_dt(void *driver_data)
+{
+	struct stpmic1_regulator *regul =3D
+		(struct stpmic1_regulator *)driver_data;
+
+	if (!regul)
+		return -EINVAL;
+
+	if (of_get_property(regul->reg_node, "st,mask-reset", NULL))
+		regul->mask_reset =3D 1;
+
+	regul->irq_curlim =3D of_irq_get(regul->reg_node, 0);
+
+	return 0;
+}
+
+static struct
+regulator_dev *stpmic1_regulator_register(struct platform_device *pdev, in=
t id,
+					  struct regulator_init_data *init_data,
+					  struct stpmic1_regulator *regul)
+{
+	struct stpmic1 *pmic_dev =3D dev_get_drvdata(pdev->dev.parent);
+	struct regulator_dev *rdev;
+	struct regulator_config config =3D {};
+
+	config.dev =3D &pdev->dev;
+	config.init_data =3D init_data;
+	config.of_node =3D stpmic1_regulators_matches[id].of_node;
+	config.regmap =3D pmic_dev->regmap;
+	config.driver_data =3D regul;
+
+	regul->regul_id =3D id;
+	regul->reg_node =3D config.of_node;
+	regul->cfg =3D &stpmic1_regulator_cfgs[id];
+	regul->regmap =3D pmic_dev->regmap;
+
+	rdev =3D devm_regulator_register(&pdev->dev, &regul->cfg->desc, &config);
+	if (IS_ERR(rdev)) {
+		dev_err(&pdev->dev, "failed to register %s regulator\n",
+			regul->cfg->desc.name);
+	}
+
+	return rdev;
+}
+
+static int stpmic1_regulator_probe(struct platform_device *pdev)
+{
+	struct regulator_dev *rdev;
+	struct stpmic1_regulator *regul;
+	struct regulator_init_data *init_data;
+	struct device_node *np;
+	int i, ret;
+
+	np =3D pdev->dev.of_node;
+
+	ret =3D of_regulator_match(&pdev->dev, np,
+				 stpmic1_regulators_matches,
+				 ARRAY_SIZE(stpmic1_regulators_matches));
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"Error in PMIC regulator device tree node");
+		return ret;
+	}
+
+	regul =3D devm_kzalloc(&pdev->dev, ARRAY_SIZE(stpmic1_regulator_cfgs) *
+			     sizeof(struct stpmic1_regulator),
+			     GFP_KERNEL);
+	if (!regul)
+		return -ENOMEM;
+
+	for (i =3D 0; i < ARRAY_SIZE(stpmic1_regulator_cfgs); i++) {
+		/* Parse DT & find regulators to register */
+		init_data =3D stpmic1_regulators_matches[i].init_data;
+		if (init_data)
+			init_data->regulator_init =3D &stpmic1_regulator_parse_dt;
+
+		rdev =3D stpmic1_regulator_register(pdev, i, init_data, regul);
+		if (IS_ERR(rdev))
+			return PTR_ERR(rdev);
+
+		ret =3D stpmic1_regulator_init(pdev, rdev);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to initialize regulator %d\n", ret);
+			return ret;
+		}
+
+		regul++;
+	}
+
+	dev_dbg(&pdev->dev, "stpmic1_regulator driver probed\n");
+
+	return 0;
+}
+
+static const struct of_device_id of_pmic_regulator_match[] =3D {
+	{ .compatible =3D "st,stpmic1-regulators" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, of_pmic_regulator_match);
+
+static struct platform_driver stpmic1_regulator_driver =3D {
+	.driver =3D {
+		.name =3D "stpmic1-regulator",
+		.of_match_table =3D of_match_ptr(of_pmic_regulator_match),
+	},
+	.probe =3D stpmic1_regulator_probe,
+};
+
+module_platform_driver(stpmic1_regulator_driver);
+
+MODULE_DESCRIPTION("STPMIC1 PMIC voltage regulator driver");
+MODULE_AUTHOR("Pascal Paillet <p.paillet@st.com>");
+MODULE_LICENSE("GPL v2");
--=20
1.9.1
