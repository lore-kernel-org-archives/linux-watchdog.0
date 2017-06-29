Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:43834 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753734AbdF2Vkk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 29 Jun 2017 17:40:40 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v6 14/16] phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module
Date: Thu, 29 Jun 2017 23:39:49 +0200
Message-Id: <20170629213951.31176-15-hauke@hauke-m.de>
In-Reply-To: <20170629213951.31176-1-hauke@hauke-m.de>
References: <20170629213951.31176-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
the PHY interfaces for each core. The phy instances can be passed to the
dwc2 driver, which already supports the generic phy interface.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  42 ++++
 arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-lantiq-rcu-usb2.c                  | 275 +++++++++++++++++++++
 5 files changed, 338 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
 create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c

diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
new file mode 100644
index 000000000000..c538baa2ba54
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
@@ -0,0 +1,42 @@
+Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
+===========================================
+
+This binding describes the USB PHY hardware provided by the RCU module on the
+Lantiq XWAY SoCs.
+
+This driver has to be a sub node of the Lantiq RCU block.
+
+-------------------------------------------------------------------------------
+Required properties (controller (parent) node):
+- compatible	: Should be one of
+			"lantiq,ase-usb2-phy"
+			"lantiq,danube-usb2-phy"
+			"lantiq,xrx100-usb2-phy"
+			"lantiq,xrx200-usb2-phy"
+			"lantiq,xrx300-usb2-phy"
+- offset-phy	: Offset of the USB PHY configuration register
+- offset-ana	: Offset of the USB Analog configuration register
+- clocks	: References to the (PMU) "ctrl" and "phy" clk gates.
+- clock-names	: Must be one of the following:
+			"ctrl"
+			"phy"
+- resets	: References to the RCU USB configuration reset bits.
+- reset-names	: Must be one of the following:
+			"phy" (optional)
+			"ctrl" (shared)
+
+-------------------------------------------------------------------------------
+Example for the USB PHYs on an xRX200 SoC:
+	usb_phy0: usb2-phy@18 {
+		compatible = "lantiq,xrx200-usb2-phy";
+		reg = <0x18 4>, <0x38 4>;
+
+		offset-phy = <0x18>;
+		offset-ana = <0x38>;
+		clocks = <&pmu PMU_GATE_USB0_CTRL>,
+			 <&pmu PMU_GATE_USB0_PHY>;
+		clock-names = "ctrl", "phy";
+		resets = <&reset1 4 4>, <&reset0 4 4>;
+		reset-names = "phy", "ctrl";
+		#phy-cells = <0>;
+	};
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 87eab4d288e5..732d27c5ba20 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -469,8 +469,8 @@ void __init ltq_soc_init(void)
 
 	if (of_machine_is_compatible("lantiq,grx390") ||
 	    of_machine_is_compatible("lantiq,ar10")) {
-		clkdev_add_pmu("1e101000.usb", "phy", 1, 2, PMU_ANALOG_USB0_P);
-		clkdev_add_pmu("1e106000.usb", "phy", 1, 2, PMU_ANALOG_USB1_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@18", "phy", 1, 2, PMU_ANALOG_USB0_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@34", "phy", 1, 2, PMU_ANALOG_USB1_P);
 		/* rc 0 */
 		clkdev_add_pmu("1d900000.pcie", "phy", 1, 2, PMU_ANALOG_PCIE0_P);
 		clkdev_add_pmu("1d900000.pcie", "msi", 1, 1, PMU1_PCIE_MSI);
@@ -490,8 +490,8 @@ void __init ltq_soc_init(void)
 		else
 			clkdev_add_static(CLOCK_133M, CLOCK_133M,
 						CLOCK_133M, CLOCK_133M);
-		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
-		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@18", "ctrl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@18", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e180000.etop", "ppe", 1, 0, PMU_PPE);
 		clkdev_add_cgu("1e180000.etop", "ephycgu", CGU_EPHY);
 		clkdev_add_pmu("1e180000.etop", "ephy", 1, 0, PMU_EPHY);
@@ -526,10 +526,10 @@ void __init ltq_soc_init(void)
 	} else if (of_machine_is_compatible("lantiq,vr9")) {
 		clkdev_add_static(ltq_vr9_cpu_hz(), ltq_vr9_fpi_hz(),
 				ltq_vr9_fpi_hz(), ltq_vr9_pp32_hz());
-		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
-		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0 | PMU_AHBM);
-		clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
-		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1 | PMU_AHBM);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@18", "phy", 1, 0, PMU_USB0_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@18", "ctrl", 1, 0, PMU_USB0 | PMU_AHBM);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@34", "phy", 1, 0, PMU_USB1_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@34", "ctrl", 1, 0, PMU_USB1 | PMU_AHBM);
 		clkdev_add_pmu("1d900000.pcie", "phy", 1, 1, PMU1_PCIE_PHY);
 		clkdev_add_pmu("1d900000.pcie", "bus", 1, 0, PMU_PCIE_CLK);
 		clkdev_add_pmu("1d900000.pcie", "msi", 1, 1, PMU1_PCIE_MSI);
@@ -550,8 +550,8 @@ void __init ltq_soc_init(void)
 	} else if (of_machine_is_compatible("lantiq,ar9")) {
 		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
 				ltq_ar9_fpi_hz(), CLOCK_250M);
-		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
-		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@18", "ctrl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@18", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1);
 		clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
 		clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
@@ -562,8 +562,8 @@ void __init ltq_soc_init(void)
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
 				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
-		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
-		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@18", "ctrl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1f203000.rcu:usb2-phy@18", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index afaf7b643eeb..f7f6bfca20fc 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -507,6 +507,14 @@ config PHY_CYGNUS_PCIE
 	  Enable this to support the Broadcom Cygnus PCIe PHY.
 	  If unsure, say N.
 
+config PHY_LANTIQ_RCU_USB2
+	tristate "Lantiq XWAY SoC RCU based USB PHY"
+	depends on SOC_TYPE_XWAY
+	depends on OF
+	select GENERIC_PHY
+	help
+	  Support for the USB PHY(s) on the Lantiq XWAY family SoCs.
+
 source "drivers/phy/tegra/Kconfig"
 
 config PHY_NS2_PCIE
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index f8047b4639fa..d6ba19233001 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
 obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
 obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
 obj-$(CONFIG_PHY_CYGNUS_PCIE)		+= phy-bcm-cygnus-pcie.o
+obj-$(CONFIG_PHY_LANTIQ_RCU_USB2)	+= phy-lantiq-rcu-usb2.o
 obj-$(CONFIG_ARCH_TEGRA) += tegra/
 obj-$(CONFIG_PHY_NS2_PCIE)		+= phy-bcm-ns2-pcie.o
 obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
diff --git a/drivers/phy/phy-lantiq-rcu-usb2.c b/drivers/phy/phy-lantiq-rcu-usb2.c
new file mode 100644
index 000000000000..9cde229f108f
--- /dev/null
+++ b/drivers/phy/phy-lantiq-rcu-usb2.c
@@ -0,0 +1,275 @@
+/*
+ * Lantiq XWAY SoC RCU module based USB 1.1/2.0 PHY driver
+ *
+ * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ * Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+/* Transmitter HS Pre-Emphasis Enable */
+#define RCU_CFG1_TX_PEE		BIT(0)
+/* Disconnect Threshold */
+#define RCU_CFG1_DIS_THR_MASK	0x00038000
+#define RCU_CFG1_DIS_THR_SHIFT	15
+
+struct ltq_rcu_usb2_bits {
+	u8 hostmode;
+	u8 slave_endianness;
+	u8 host_endianness;
+	bool have_ana_cfg;
+};
+
+struct ltq_rcu_usb2_priv {
+	struct regmap			*regmap;
+	u32				phy_reg_offset;
+	u32				ana_cfg1_reg_offset;
+	const struct ltq_rcu_usb2_bits	*reg_bits;
+	struct device			*dev;
+	struct phy			*phy;
+	struct clk			*ctrl_gate_clk;
+	struct clk			*phy_gate_clk;
+	struct reset_control		*ctrl_reset;
+	struct reset_control		*phy_reset;
+};
+
+static const struct ltq_rcu_usb2_bits xway_rcu_usb2_reg_bits = {
+	.hostmode = 11,
+	.slave_endianness = 9,
+	.host_endianness = 10,
+	.have_ana_cfg = false,
+};
+
+static const struct ltq_rcu_usb2_bits xrx100_rcu_usb2_reg_bits = {
+	.hostmode = 11,
+	.slave_endianness = 17,
+	.host_endianness = 10,
+	.have_ana_cfg = false,
+};
+
+static const struct ltq_rcu_usb2_bits xrx200_rcu_usb2_reg_bits = {
+	.hostmode = 11,
+	.slave_endianness = 9,
+	.host_endianness = 10,
+	.have_ana_cfg = true,
+};
+
+static const struct of_device_id ltq_rcu_usb2_phy_of_match[] = {
+	{
+		.compatible = "lantiq,ase-usb2-phy",
+		.data = &xway_rcu_usb2_reg_bits,
+	},
+	{
+		.compatible = "lantiq,danube-usb2-phy",
+		.data = &xway_rcu_usb2_reg_bits,
+	},
+	{
+		.compatible = "lantiq,xrx100-usb2-phy",
+		.data = &xrx100_rcu_usb2_reg_bits,
+	},
+	{
+		.compatible = "lantiq,xrx200-usb2-phy",
+		.data = &xrx200_rcu_usb2_reg_bits,
+	},
+	{
+		.compatible = "lantiq,xrx300-usb2-phy",
+		.data = &xrx200_rcu_usb2_reg_bits,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ltq_rcu_usb2_phy_of_match);
+
+
+static int ltq_rcu_usb2_phy_power_on(struct phy *phy)
+{
+	struct ltq_rcu_usb2_priv *priv = phy_get_drvdata(phy);
+
+	reset_control_deassert(priv->phy_reset);
+
+	return 0;
+}
+
+static int ltq_rcu_usb2_phy_power_off(struct phy *phy)
+{
+	struct ltq_rcu_usb2_priv *priv = phy_get_drvdata(phy);
+
+	reset_control_assert(priv->phy_reset);
+
+	return 0;
+}
+
+static struct phy_ops ltq_rcu_usb2_phy_ops = {
+	.power_on	= ltq_rcu_usb2_phy_power_on,
+	.power_off	= ltq_rcu_usb2_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int ltq_rcu_usb2_start_cores(struct ltq_rcu_usb2_priv *priv)
+{
+	struct device *dev = priv->dev;
+	int ret;
+
+	/* Power on the USB core. */
+	ret = clk_prepare_enable(priv->ctrl_gate_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable CTRL gate\n");
+		return ret;
+	}
+
+	/*
+	 * Power on the USB PHY. We have to do it early because
+	 * otherwise the second core won't turn on properly.
+	 */
+	ret = clk_prepare_enable(priv->phy_gate_clk);
+	if (ret) {
+		clk_disable_unprepare(priv->ctrl_gate_clk);
+		dev_err(dev, "failed to enable PHY gate\n");
+		return ret;
+	}
+
+	if (priv->reg_bits->have_ana_cfg) {
+		regmap_update_bits(priv->regmap, priv->ana_cfg1_reg_offset,
+			RCU_CFG1_TX_PEE, RCU_CFG1_TX_PEE);
+		regmap_update_bits(priv->regmap, priv->ana_cfg1_reg_offset,
+			RCU_CFG1_DIS_THR_MASK, 7 << RCU_CFG1_DIS_THR_SHIFT);
+	}
+
+	/* Configure core to host mode */
+	regmap_update_bits(priv->regmap, priv->phy_reg_offset,
+			   BIT(priv->reg_bits->hostmode), 0);
+
+	/* Select DMA endianness (Host-endian: big-endian) */
+	regmap_update_bits(priv->regmap, priv->phy_reg_offset,
+		BIT(priv->reg_bits->slave_endianness), 0);
+	regmap_update_bits(priv->regmap, priv->phy_reg_offset,
+		BIT(priv->reg_bits->host_endianness),
+		BIT(priv->reg_bits->host_endianness));
+
+	/* Reset USB core throgh reset controller */
+	reset_control_deassert(priv->ctrl_reset);
+
+	reset_control_assert(priv->phy_reset);
+
+	return 0;
+}
+
+static int ltq_rcu_usb2_of_probe(struct ltq_rcu_usb2_priv *priv)
+{
+	struct device *dev = priv->dev;
+	int ret;
+
+	priv->reg_bits = of_device_get_match_data(dev);
+
+	priv->regmap = syscon_node_to_regmap(dev->of_node->parent);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(dev, "Failed to lookup RCU regmap\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	priv->ctrl_gate_clk = devm_clk_get(dev, "ctrl");
+	if (IS_ERR(priv->ctrl_gate_clk)) {
+		dev_err(dev, "Unable to get USB ctrl gate clk\n");
+		return PTR_ERR(priv->ctrl_gate_clk);
+	}
+
+	priv->phy_gate_clk = devm_clk_get(dev, "phy");
+	if (IS_ERR(priv->phy_gate_clk)) {
+		dev_err(dev, "Unable to get USB phy gate clk\n");
+		return PTR_ERR(priv->phy_gate_clk);
+	}
+
+	priv->ctrl_reset = devm_reset_control_get_shared(dev, "ctrl");
+	if (IS_ERR(priv->ctrl_reset)) {
+		if (PTR_ERR(priv->ctrl_reset) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get 'ctrl' reset\n");
+		return PTR_ERR(priv->ctrl_reset);
+	}
+
+	priv->phy_reset = devm_reset_control_get_optional(dev, "phy");
+	if (IS_ERR(priv->phy_reset))
+		return PTR_ERR(priv->phy_reset);
+
+	ret = device_property_read_u32(dev, "offset-phy",
+				       &priv->phy_reg_offset);
+	if (ret) {
+		dev_err(dev, "Failed to get RCU PHY reg offset\n");
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "offset-ana",
+				       &priv->ana_cfg1_reg_offset);
+	if (ret && priv->reg_bits->have_ana_cfg) {
+		dev_dbg(dev, "Failed to get RCU ANA CFG1 reg offset\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ltq_rcu_usb2_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ltq_rcu_usb2_priv *priv;
+	struct phy_provider *provider;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	ret = ltq_rcu_usb2_of_probe(priv);
+	if (ret)
+		return ret;
+
+	priv->phy = devm_phy_create(dev, dev->of_node, &ltq_rcu_usb2_phy_ops);
+	if (IS_ERR(priv->phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(priv->phy);
+	}
+
+	phy_set_drvdata(priv->phy, priv);
+
+	ret = ltq_rcu_usb2_start_cores(priv);
+	if (ret)
+		return ret;
+
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(provider)) {
+		clk_disable_unprepare(priv->phy_gate_clk);
+		clk_disable_unprepare(priv->ctrl_gate_clk);
+		return PTR_ERR(provider);
+	}
+
+	dev_set_drvdata(priv->dev, priv);
+	return 0;
+}
+
+static struct platform_driver ltq_rcu_usb2_phy_driver = {
+	.probe	= ltq_rcu_usb2_phy_probe,
+	.driver = {
+		.name	= "lantiq-rcu-usb2-phy",
+		.of_match_table	= ltq_rcu_usb2_phy_of_match,
+	}
+};
+module_platform_driver(ltq_rcu_usb2_phy_driver);
+
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
+MODULE_DESCRIPTION("Lantiq XWAY USB2 PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

