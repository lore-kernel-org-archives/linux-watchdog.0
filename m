Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36645 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753915AbdEUNJv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 21 May 2017 09:09:51 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 09/15] reset: Add a reset controller driver for the Lantiq XWAY based SoCs
Date: Sun, 21 May 2017 15:09:12 +0200
Message-Id: <20170521130918.27446-10-hauke@hauke-m.de>
In-Reply-To: <20170521130918.27446-1-hauke@hauke-m.de>
References: <20170521130918.27446-1-hauke@hauke-m.de>
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
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/reset/lantiq,rcu-reset.txt |  30 +++
 drivers/reset/Kconfig                              |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-lantiq-rcu.c                   | 201 +++++++++++++++++++++
 4 files changed, 238 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
 create mode 100644 drivers/reset/reset-lantiq-rcu.c

diff --git a/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt b/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
new file mode 100644
index 000000000000..ac57c4a1b191
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
@@ -0,0 +1,30 @@
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
+			  reset line, should be 2.
+			  The first cell takes the reset set bit and the
+			  second cell takes the status bit.
+
+-------------------------------------------------------------------------------
+Example for the reset-controllers on the xRX200 SoCs:
+	rcu_reset0: rcu_reset {
+		compatible = "lantiq,rcu-reset";
+		lantiq,rcu-syscon = <&rcu0 0x10 0x14>;
+		#reset-cells = <2>;
+	};
+
+	rcu_reset1: rcu_reset {
+		compatible = "lantiq,rcu-reset";
+		lantiq,rcu-syscon = <&rcu0 0x48 0x24>;
+		#reset-cells = <2>;
+	};
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index d21c07ccc94e..632e82155590 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -41,6 +41,12 @@ config RESET_IMX7
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
 
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
index 02a74db94339..b19e77847b98 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
+obj-$(CONFIG_RESET_LANTIQ_RCU) += reset-lantiq-rcu.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
diff --git a/drivers/reset/reset-lantiq-rcu.c b/drivers/reset/reset-lantiq-rcu.c
new file mode 100644
index 000000000000..f24191beed56
--- /dev/null
+++ b/drivers/reset/reset-lantiq-rcu.c
@@ -0,0 +1,201 @@
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
+struct lantiq_rcu_reset_priv {
+	struct reset_controller_dev rcdev;
+	struct device *dev;
+	struct regmap *regmap;
+	u32 reset_offset;
+	u32 status_offset;
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
+	unsigned int status = (id >> 8) & 0x1f;
+	u32 val;
+	int ret;
+
+	if (status >= rcdev->nr_resets)
+		return -EINVAL;
+
+	ret = regmap_read(priv->regmap, priv->status_offset, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & BIT(status));
+}
+
+static int lantiq_rcu_reset_update(struct reset_controller_dev *rcdev,
+				   unsigned long id, bool assert)
+{
+	struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
+	int ret, retry = LANTIQ_RCU_RESET_TIMEOUT;
+	unsigned int set = id & 0x1f;
+	u32 val;
+
+	if (set >= rcdev->nr_resets)
+		return -EINVAL;
+
+	if (assert)
+		val = BIT(set);
+	else
+		val = 0;
+
+	ret = regmap_update_bits(priv->regmap, priv->reset_offset, BIT(set),
+				 val);
+	if (ret) {
+		dev_err(priv->dev, "Failed to set reset bit %u\n", set);
+		return ret;
+	}
+
+	do {} while (--retry && lantiq_rcu_reset_status(rcdev, id) != assert);
+	if (!retry) {
+		dev_err(priv->dev, "Failed to %s bit %u\n",
+			assert ? "assert" : "deassert", set);
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
+	return 0;
+}
+
+static int lantiq_rcu_reset_xlate(struct reset_controller_dev *rcdev,
+				  const struct of_phandle_args *reset_spec)
+{
+	unsigned int status, set;
+
+	set = reset_spec->args[0];
+	status = reset_spec->args[1];
+
+	return (status << 8) | set;
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
+	priv->rcdev.nr_resets = 32;
+	priv->rcdev.of_xlate = lantiq_rcu_reset_xlate;
+	priv->rcdev.of_reset_n_cells = 2;
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

