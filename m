Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49258 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756402AbdDQTaD (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Apr 2017 15:30:03 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/13] MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd
Date: Mon, 17 Apr 2017 21:29:38 +0200
Message-Id: <20170417192942.32219-10-hauke@hauke-m.de>
In-Reply-To: <20170417192942.32219-1-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Compared to the old xrx200_phy_fw driver the new version has multiple
enhancements. The name of the firmware files does not have to be added
to all .dts files anymore - one now configures the GPHY mode (FE or GE)
instead. Each GPHY can now also boot separate firmware (thus mixing of
GE and FE GPHYs is now possible).
The new implementation is based on the RCU syscon-mfd and uses the
reeset_controller framework instead of raw RCU register reads/writes.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  54 +++++
 arch/mips/lantiq/xway/sysctrl.c                    |   4 +-
 drivers/soc/lantiq/Makefile                        |   1 +
 drivers/soc/lantiq/gphy.c                          | 242 +++++++++++++++++++++
 include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 ++
 5 files changed, 314 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
 create mode 100644 drivers/soc/lantiq/gphy.c
 create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h

diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
new file mode 100644
index 000000000000..d525c7ce9f0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
@@ -0,0 +1,54 @@
+Lantiq XWAY SoC GPHY binding
+============================
+
+This binding describes a software-defined ethernet PHY, provided by the RCU
+module on newer Lantiq XWAY SoCs (xRX200 and newer).
+This depends on binary firmware blobs which must be provided by userspace.
+
+
+-------------------------------------------------------------------------------
+Required properties (controller (parent) node):
+- compatible		: Should be one of
+				"lantiq,xrx200a1x-rcu-gphy"
+				"lantiq,xrx200a2x-rcu-gphy"
+				"lantiq,xrx300-rcu-gphy"
+				"lantiq,xrx330-rcu-gphy"
+- lantiq,rcu-syscon	: A phandle and offset to the GPHY address registers in
+			  the RCU
+- resets		: Must reference the RCU GPHY reset bit
+- reset-names		: One entry, value must be "gphy" or optional "gphy2"
+
+Optional properties (port (child) node):
+- lantiq,gphy-mode	: GPHY_MODE_GE (default) or GPHY_MODE_FE as defined in
+			  <dt-bindings/mips/lantiq_xway_gphy.h>
+- clocks		: A reference to the (PMU) GPHY clock gate
+- clock-names		: If clocks is given then this must be "gphy"
+
+
+-------------------------------------------------------------------------------
+Example for the GPHys on the xRX200 SoCs:
+
+#include <dt-bindings/mips/lantiq_rcu_gphy.h>
+	gphy0: rcu_gphy@0 {
+		compatible = "lantiq,xrx200a2x-rcu-gphy";
+		reg = <0>;
+
+		lantiq,rcu-syscon = <&rcu0 0x20>;
+		resets = <&rcu_reset0 31>, <&rcu_reset1 7>;
+		reset-names = "gphy", "gphy2";
+		lantiq,gphy-mode = <GPHY_MODE_GE>;
+		clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
+		clock-names = "gphy";
+	};
+
+	gphy1: rcu_gphy@1 {
+		compatible = "lantiq,xrx200a2x-rcu-gphy";
+		reg = <0>;
+
+		lantiq,rcu-syscon = <&rcu0 0x68>;
+		resets = <&rcu_reset0 29>, <&rcu_reset1 6>;
+		reset-names = "gphy", "gphy2";
+		lantiq,gphy-mode = <GPHY_MODE_FE>;
+		clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
+		clock-names = "gphy";
+	};
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 706639a343bc..5764d3ddce69 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -518,7 +518,7 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu("1e108000.eth", NULL, 0, 0, PMU_SWITCH |
 			       PMU_PPE_DP | PMU_PPE_TC);
 		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
-		clkdev_add_pmu("1f203000.rcu", "gphy", 1, 0, PMU_GPHY);
+		clkdev_add_pmu("1f203000.rcu:rcu_gphy@0", "gphy", 1, 0, PMU_GPHY);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "afe", 1, 2, PMU_ANALOG_DSL_AFE);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
@@ -541,7 +541,7 @@ void __init ltq_soc_init(void)
 				PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
 				PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
 				PMU_PPE_QSB | PMU_PPE_TOP);
-		clkdev_add_pmu("1f203000.rcu", "gphy", 0, 0, PMU_GPHY);
+		clkdev_add_pmu("1f203000.rcu:rcu_gphy@0", "gphy", 0, 0, PMU_GPHY);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
diff --git a/drivers/soc/lantiq/Makefile b/drivers/soc/lantiq/Makefile
index 7411bd23d58e..c5503183740f 100644
--- a/drivers/soc/lantiq/Makefile
+++ b/drivers/soc/lantiq/Makefile
@@ -1 +1,2 @@
 obj-y				+= xbar.o
+obj-$(CONFIG_XRX200_PHY_FW)	+= gphy.o
diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
new file mode 100644
index 000000000000..4218cbd9478e
--- /dev/null
+++ b/drivers/soc/lantiq/gphy.c
@@ -0,0 +1,242 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
+ */
+
+#include <linux/delay.h>
+#include <dt-bindings/mips/lantiq_rcu_gphy.h>
+#include <linux/firmware.h>
+#include <linux/dma-mapping.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/reboot.h>
+#include <linux/reset.h>
+#include <linux/of_platform.h>
+
+#include <lantiq_soc.h>
+
+#define XRX200_GPHY_FW_ALIGN	(16 * 1024)
+
+struct xway_gphy_priv {
+	struct clk *gphy_clk_gate;
+	struct reset_control *gphy_reset;
+	struct reset_control *gphy_reset2;
+	struct regmap *regmap;
+	struct notifier_block gphy_reboot_nb;
+	u32 reg_offset;
+	char *fw_name;
+};
+
+struct xway_gphy_match_data {
+	char *fe_firmware_name;
+	char *ge_firmware_name;
+};
+
+static const struct xway_gphy_match_data xrx200a1x_gphy_data = {
+	.fe_firmware_name = "lantiq/xrx200_phy22f_a14.bin",
+	.ge_firmware_name = "lantiq/xrx200_phy11g_a14.bin",
+};
+
+static const struct xway_gphy_match_data xrx200a2x_gphy_data = {
+	.fe_firmware_name = "lantiq/xrx200_phy22f_a22.bin",
+	.ge_firmware_name = "lantiq/xrx200_phy11g_a22.bin",
+};
+
+static const struct xway_gphy_match_data xrx300_gphy_data = {
+	.fe_firmware_name = "lantiq/xrx300_phy22f_a21.bin",
+	.ge_firmware_name = "lantiq/xrx300_phy11g_a21.bin",
+};
+
+static const struct of_device_id xway_gphy_match[] = {
+	{ .compatible = "lantiq,xrx200a1x-rcu-gphy", .data = &xrx200a1x_gphy_data },
+	{ .compatible = "lantiq,xrx200a2x-rcu-gphy", .data = &xrx200a2x_gphy_data },
+	{ .compatible = "lantiq,xrx300-rcu-gphy", .data = &xrx300_gphy_data },
+	{ .compatible = "lantiq,xrx330-rcu-gphy", .data = &xrx300_gphy_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xway_gphy_match);
+
+static struct xway_gphy_priv *to_xway_gphy_priv(struct notifier_block *nb)
+{
+	return container_of(nb, struct xway_gphy_priv, gphy_reboot_nb);
+}
+
+static int xway_gphy_reboot_notify(struct notifier_block *reboot_nb,
+				   unsigned long code, void *unused)
+{
+	struct xway_gphy_priv *priv = to_xway_gphy_priv(reboot_nb);
+
+	if (priv) {
+		reset_control_assert(priv->gphy_reset);
+		reset_control_assert(priv->gphy_reset2);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int xway_gphy_load(struct platform_device *pdev,
+			  const char *fw_name, dma_addr_t *dev_addr)
+{
+	const struct firmware *fw;
+	void *fw_addr;
+	size_t size;
+	int ret;
+
+	dev_info(&pdev->dev, "requesting %s\n", fw_name);
+	ret = request_firmware(&fw, fw_name, &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to load firmware: %s, error: %i\n",
+			fw_name, ret);
+		return ret;
+	}
+
+	/*
+	 * GPHY cores need the firmware code in a persistent and contiguous
+	 * memory area with a 16 kB boundary aligned start address
+	 */
+	size = fw->size + XRX200_GPHY_FW_ALIGN;
+
+	fw_addr = dma_alloc_coherent(&pdev->dev, size, dev_addr, GFP_KERNEL);
+	if (fw_addr) {
+		fw_addr = PTR_ALIGN(fw_addr, XRX200_GPHY_FW_ALIGN);
+		*dev_addr = ALIGN(*dev_addr, XRX200_GPHY_FW_ALIGN);
+		memcpy(fw_addr, fw->data, fw->size);
+	} else {
+		dev_err(&pdev->dev, "failed to alloc firmware memory\n");
+		ret = -ENOMEM;
+	}
+
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int xway_gphy_of_probe(struct platform_device *pdev,
+				struct xway_gphy_priv *priv)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *match = of_match_node(xway_gphy_match, np);
+	const struct xway_gphy_match_data *gphy_fw_name_cfg;
+	u32 gphy_mode;
+
+	gphy_fw_name_cfg = match->data;
+
+	/* Ignore all errors since this clock is optional. */
+	priv->gphy_clk_gate = devm_clk_get(&pdev->dev, "gphy");
+
+	priv->regmap = syscon_regmap_lookup_by_phandle(np,
+							"lantiq,rcu-syscon");
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&pdev->dev, "Failed to lookup RCU regmap\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	if (of_property_read_u32_index(np, "lantiq,rcu-syscon", 1,
+		&priv->reg_offset)) {
+		dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
+		return -EINVAL;
+	}
+
+	priv->gphy_reset = devm_reset_control_get(&pdev->dev, "gphy");
+	if (IS_ERR_OR_NULL(priv->gphy_reset)) {
+		dev_err(&pdev->dev, "Failed to lookup gphy reset\n");
+		return PTR_ERR(priv->gphy_reset);
+	}
+
+	priv->gphy_reset2 = devm_reset_control_get_optional(&pdev->dev, "gphy2");
+	if (IS_ERR(priv->gphy_reset2)) {
+		if (PTR_ERR(priv->gphy_reset2) == -EPROBE_DEFER)
+			return PTR_ERR(priv->gphy_reset2);
+		priv->gphy_reset2 = NULL;
+	}
+
+	if (of_property_read_u32(np, "lantiq,gphy-mode", &gphy_mode))
+		/* Default to GE mode */
+		gphy_mode = GPHY_MODE_GE;
+
+	switch (gphy_mode) {
+	case GPHY_MODE_FE:
+		priv->fw_name = gphy_fw_name_cfg->fe_firmware_name;
+		break;
+	case GPHY_MODE_GE:
+		priv->fw_name = gphy_fw_name_cfg->ge_firmware_name;
+		break;
+	default:
+		dev_err(&pdev->dev, "Unknown GPHY mode %d\n", gphy_mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int xway_gphy_probe(struct platform_device *pdev)
+{
+	struct xway_gphy_priv *priv;
+	dma_addr_t fw_addr = 0;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = xway_gphy_of_probe(pdev, priv);
+	if (ret)
+		return ret;
+
+	if (!IS_ERR_OR_NULL(priv->gphy_clk_gate))
+		clk_prepare_enable(priv->gphy_clk_gate);
+
+	ret = xway_gphy_load(pdev, priv->fw_name, &fw_addr);
+	if (ret)
+		return ret;
+
+	reset_control_assert(priv->gphy_reset);
+	reset_control_assert(priv->gphy_reset2);
+
+	ret = regmap_write(priv->regmap, priv->reg_offset, fw_addr);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to configure FW addr\n");
+		return ret;
+	}
+
+	reset_control_deassert(priv->gphy_reset);
+	reset_control_deassert(priv->gphy_reset2);
+
+	/* assert the gphy reset because it can hang after a reboot: */
+	priv->gphy_reboot_nb.notifier_call = xway_gphy_reboot_notify;
+	priv->gphy_reboot_nb.priority = -1;
+
+	ret = register_reboot_notifier(&priv->gphy_reboot_nb);
+	if (ret)
+		dev_warn(&pdev->dev, "Failed to register reboot notifier\n");
+
+	platform_set_drvdata(pdev, priv);
+
+	return ret;
+}
+
+static struct platform_driver xway_gphy_driver = {
+	.probe = xway_gphy_probe,
+	.driver = {
+		.name = "xway-rcu-gphy",
+		.of_match_table = xway_gphy_match,
+	},
+};
+
+module_platform_driver(xway_gphy_driver);
+
+MODULE_FIRMWARE("lantiq/xrx300_phy11g_a21.bin");
+MODULE_FIRMWARE("lantiq/xrx300_phy22f_a21.bin");
+MODULE_FIRMWARE("lantiq/xrx200_phy11g_a14.bin");
+MODULE_FIRMWARE("lantiq/xrx200_phy11g_a22.bin");
+MODULE_FIRMWARE("lantiq/xrx200_phy22f_a14.bin");
+MODULE_FIRMWARE("lantiq/xrx200_phy22f_a22.bin");
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
+MODULE_DESCRIPTION("Lantiq XWAY GPHY Firmware Loader");
+MODULE_LICENSE("GPL");
diff --git a/include/dt-bindings/mips/lantiq_rcu_gphy.h b/include/dt-bindings/mips/lantiq_rcu_gphy.h
new file mode 100644
index 000000000000..fa1a63773342
--- /dev/null
+++ b/include/dt-bindings/mips/lantiq_rcu_gphy.h
@@ -0,0 +1,15 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
+ */
+#ifndef _DT_BINDINGS_MIPS_LANTIQ_RCU_GPHY_H
+#define _DT_BINDINGS_MIPS_LANTIQ_RCU_GPHY_H
+
+#define GPHY_MODE_GE	1
+#define GPHY_MODE_FE	2
+
+#endif /* _DT_BINDINGS_MIPS_LANTIQ_RCU_GPHY_H */
-- 
2.11.0

