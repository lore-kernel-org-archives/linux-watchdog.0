Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49252 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756646AbdDQTaC (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Apr 2017 15:30:02 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/13] reset: Add a reset controller driver for the Lantiq XWAY based SoCs
Date: Mon, 17 Apr 2017 21:29:37 +0200
Message-Id: <20170417192942.32219-9-hauke@hauke-m.de>
In-Reply-To: <20170417192942.32219-1-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The reset controllers (on xRX200 and newer SoCs have two of them) are
provided by the RCU module. This was initially implemented as a simple
reset controller. However, the RCU module provides more functionality
(ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
The old reset controller driver implementation from
arch/mips/lantiq/xway/reset.c did not honor this fact.

For some devices the request and the status bits are different.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../devicetree/bindings/reset/lantiq,rcu-reset.txt |  43 ++++
 arch/mips/lantiq/xway/reset.c                      |  68 ------
 drivers/reset/Kconfig                              |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-lantiq-rcu.c                   | 231 +++++++++++++++++++++
 5 files changed, 281 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
 create mode 100644 drivers/reset/reset-lantiq-rcu.c

diff --git a/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt b/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
new file mode 100644
index 000000000000..7f097d16bbb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
@@ -0,0 +1,43 @@
+Lantiq XWAY SoC RCU reset controller binding
+============================================
+
+This binding describes a reset-controller found on the RCU module on Lantiq
+XWAY SoCs.
+
+
+-------------------------------------------------------------------------------
+Required properties (controller (parent) node):
+- compatible		: Should be "lantiq,rcu-reset"
+- lantiq,rcu-syscon	: A phandle to the RCU syscon, the reset register
+			  offset and the status register offset.
+- #reset-cells		: Specifies the number of cells needed to encode the
+			  reset line, should be 1.
+
+Optional properties:
+- reset-status		: The request status bit. For some bits the request bit
+			  and the status bit are different. This is depending
+			  on the SoC. If the reset-status bit does not match
+			  the reset-request bit, put the reset number into the
+			  reset-request property and the status bit at the same
+			  index into the reset-status property. If no
+			  reset-request bit is given here, the driver assume
+			  status and request bit are the same.
+- reset-request		: The reset request bit, to map it to the reset-status
+			  bit.
+
+
+-------------------------------------------------------------------------------
+Example for the reset-controllers on the xRX200 SoCs:
+	rcu_reset0: rcu_reset {
+		compatible = "lantiq,rcu-reset";
+		lantiq,rcu-syscon = <&rcu0 0x10 0x14>;
+		#reset-cells = <1>;
+		reset-request = <31>, <29>, <21>, <19>, <16>, <12>;
+		reset-status  = <30>, <28>, <16>, <25>, <5>,  <24>;
+	};
+
+	rcu_reset1: rcu_reset {
+		compatible = "lantiq,rcu-reset";
+		lantiq,rcu-syscon = <&rcu0 0x48 0x24>;
+		#reset-cells = <1>;
+	};
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 2dedcf939901..5cb9309b0047 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -194,74 +194,6 @@ int xrx200_gphy_boot(struct device *dev, unsigned int id, dma_addr_t dev_addr)
 	return 0;
 }
 
-/* reset a io domain for u micro seconds */
-void ltq_reset_once(unsigned int module, ulong u)
-{
-	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) | module, RCU_RST_REQ);
-	udelay(u);
-	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) & ~module, RCU_RST_REQ);
-}
-
-static int ltq_assert_device(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	u32 val;
-
-	if (id < 8)
-		return -1;
-
-	val = ltq_rcu_r32(RCU_RST_REQ);
-	val |= BIT(id);
-	ltq_rcu_w32(val, RCU_RST_REQ);
-
-	return 0;
-}
-
-static int ltq_deassert_device(struct reset_controller_dev *rcdev,
-				  unsigned long id)
-{
-	u32 val;
-
-	if (id < 8)
-		return -1;
-
-	val = ltq_rcu_r32(RCU_RST_REQ);
-	val &= ~BIT(id);
-	ltq_rcu_w32(val, RCU_RST_REQ);
-
-	return 0;
-}
-
-static int ltq_reset_device(struct reset_controller_dev *rcdev,
-			       unsigned long id)
-{
-	ltq_assert_device(rcdev, id);
-	return ltq_deassert_device(rcdev, id);
-}
-
-static const struct reset_control_ops reset_ops = {
-	.reset = ltq_reset_device,
-	.assert = ltq_assert_device,
-	.deassert = ltq_deassert_device,
-};
-
-static struct reset_controller_dev reset_dev = {
-	.ops			= &reset_ops,
-	.owner			= THIS_MODULE,
-	.nr_resets		= 32,
-	.of_reset_n_cells	= 1,
-};
-
-void ltq_rst_init(void)
-{
-	reset_dev.of_node = of_find_compatible_node(NULL, NULL,
-						"lantiq,xway-reset");
-	if (!reset_dev.of_node)
-		pr_err("Failed to find reset controller node");
-	else
-		reset_controller_register(&reset_dev);
-}
-
 static void ltq_machine_restart(char *command)
 {
 	u32 val = ltq_rcu_r32(RCU_RST_REQ);
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index f4cdfe94b9ec..8962ba44248c 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -27,6 +27,12 @@ config RESET_BERLIN
 	help
 	  This enables the reset controller driver for Marvell Berlin SoCs.
 
+config RESET_LANTIQ_RCU
+	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
+	default SOC_TYPE_XWAY
+	help
+	  This enables the reset controller driver for Lantiq / Intel XWAY SoCs.
+
 config RESET_LPC18XX
 	bool "LPC18xx/43xx Reset Driver" if COMPILE_TEST
 	default ARCH_LPC18XX
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 2cd3f6c45165..97b0a844b849 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_TEGRA) += tegra/
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
+obj-$(CONFIG_RESET_LANTIQ_RCU) += reset-lantiq-rcu.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
diff --git a/drivers/reset/reset-lantiq-rcu.c b/drivers/reset/reset-lantiq-rcu.c
new file mode 100644
index 000000000000..6178112ca5b4
--- /dev/null
+++ b/drivers/reset/reset-lantiq-rcu.c
@@ -0,0 +1,231 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2013-2015 Lantiq Beteiligungs-GmbH & Co.KG
+ *  Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/of_platform.h>
+
+#define LANTIQ_RCU_RESET_TIMEOUT	1000000
+
+struct lantiq_rcu_reset_translation {
+	int request;
+	int status;
+};
+
+struct lantiq_rcu_reset_priv {
+	struct reset_controller_dev rcdev;
+	struct device *dev;
+	struct regmap *regmap;
+	u32 reset_offset;
+	u32 status_offset;
+	int trans_number;
+	struct lantiq_rcu_reset_translation *trans;
+};
+
+static struct lantiq_rcu_reset_priv *to_lantiq_rcu_reset_priv(
+	struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct lantiq_rcu_reset_priv, rcdev);
+}
+
+static int lantiq_rcu_reset_status(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
+	u32 val;
+	int ret, i;
+
+	if (id >= rcdev->nr_resets)
+		return -EINVAL;
+
+	for (i = 0; i < priv->trans_number; i++) {
+		if (id == priv->trans[i].request) {
+			id = priv->trans[i].status;
+			break;
+		}
+	}
+
+	ret = regmap_read(priv->regmap, priv->status_offset, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & BIT(id));
+}
+
+static int lantiq_rcu_reset_update(struct reset_controller_dev *rcdev,
+				   unsigned long id, bool assert)
+{
+	struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
+	u32 val;
+	int ret, retry = LANTIQ_RCU_RESET_TIMEOUT;
+
+	if (id >= rcdev->nr_resets)
+		return -EINVAL;
+
+	if (assert)
+		val = BIT(id);
+	else
+		val = 0;
+
+	ret = regmap_update_bits(priv->regmap, priv->reset_offset, BIT(id),
+				 val);
+	if (ret) {
+		dev_err(priv->dev, "Failed to set reset bit %lu\n", id);
+		return ret;
+	}
+
+	do {} while (--retry && lantiq_rcu_reset_status(rcdev, id) != assert);
+	if (!retry) {
+		dev_err(priv->dev, "Failed to %s bit %lu\n",
+			assert ? "assert" : "deassert", id);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int lantiq_rcu_reset_assert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	return lantiq_rcu_reset_update(rcdev, id, true);
+}
+
+static int lantiq_rcu_reset_deassert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return lantiq_rcu_reset_update(rcdev, id, false);
+}
+
+static int lantiq_rcu_reset_reset(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	int ret;
+
+	ret = lantiq_rcu_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return lantiq_rcu_reset_deassert(rcdev, id);
+}
+
+static struct reset_control_ops lantiq_rcu_reset_ops = {
+	.assert = lantiq_rcu_reset_assert,
+	.deassert = lantiq_rcu_reset_deassert,
+	.status = lantiq_rcu_reset_status,
+	.reset	= lantiq_rcu_reset_reset,
+};
+
+static int lantiq_rcu_reset_of_probe(struct platform_device *pdev,
+			       struct lantiq_rcu_reset_priv *priv)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int cnt, i, ret;
+
+	priv->regmap = syscon_regmap_lookup_by_phandle(np,
+							"lantiq,rcu-syscon");
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&pdev->dev, "Failed to lookup RCU regmap\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	if (of_property_read_u32_index(np, "lantiq,rcu-syscon", 1,
+		&priv->reset_offset)) {
+		dev_err(&pdev->dev, "Failed to get RCU reset offset\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32_index(np, "lantiq,rcu-syscon", 2,
+		&priv->status_offset)) {
+		dev_err(&pdev->dev, "Failed to get RCU status offset\n");
+		return -EINVAL;
+	}
+
+	cnt = of_property_count_elems_of_size(np, "reset-request", sizeof(u32));
+	if (cnt <= 0)
+		return 0;
+
+	priv->trans = devm_kmalloc_array(&pdev->dev, cnt, sizeof(*priv->trans),
+					 GFP_KERNEL);
+	if (!priv->trans)
+		return -ENOMEM;
+
+	for (i = 0; i < cnt; i++) {
+		ret = of_property_read_u32_index(np, "reset-request", i,
+						 &priv->trans[i].request);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to get reset-request at index %i\n",
+				i);
+			return ret;
+		}
+		ret = of_property_read_u32_index(np, "reset-status", i,
+						 &priv->trans[i].status);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to get reset-status at index %i\n",
+				i);
+			return ret;
+		}
+	}
+	priv->trans_number = cnt;
+
+	return 0;
+}
+
+static int lantiq_rcu_reset_probe(struct platform_device *pdev)
+{
+	struct lantiq_rcu_reset_priv *priv;
+	int err;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	err = lantiq_rcu_reset_of_probe(pdev, priv);
+	if (err)
+		return err;
+
+	priv->rcdev.ops = &lantiq_rcu_reset_ops;
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.of_node = pdev->dev.of_node;
+	priv->rcdev.of_reset_n_cells = 1;
+	priv->rcdev.nr_resets = 32;
+
+	err = reset_controller_register(&priv->rcdev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static const struct of_device_id lantiq_rcu_reset_dt_ids[] = {
+	{ .compatible = "lantiq,rcu-reset", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lantiq_rcu_reset_dt_ids);
+
+static struct platform_driver lantiq_rcu_reset_driver = {
+	.probe	= lantiq_rcu_reset_probe,
+	.driver = {
+		.name		= "lantiq-rcu-reset",
+		.of_match_table	= lantiq_rcu_reset_dt_ids,
+	},
+};
+module_platform_driver(lantiq_rcu_reset_driver);
+
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
+MODULE_DESCRIPTION("Lantiq XWAY RCU Reset Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.11.0

