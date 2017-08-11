Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:38113 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbdHKKZQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 11 Aug 2017 06:25:16 -0400
Subject: Re: [PATCH v9 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To: Hauke Mehrtens <hauke@hauke-m.de>, <ralf@linux-mips.org>
References: <20170808225247.32266-1-hauke@hauke-m.de>
 <20170808225247.32266-15-hauke@hauke-m.de>
CC: <linux-mips@linux-mips.org>, <linux-mtd@lists.infradead.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <martin.blumenstingl@googlemail.com>, <john@phrozen.org>,
        <linux-spi@vger.kernel.org>, <hauke.mehrtens@intel.com>,
        <robh@kernel.org>, <andy.shevchenko@gmail.com>,
        <p.zabel@pengutronix.de>, <mark.rutland@arm.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b0e370cc-90cd-07c5-6d74-528189ac1614@ti.com>
Date: Fri, 11 Aug 2017 15:53:53 +0530
MIME-Version: 1.0
In-Reply-To: <20170808225247.32266-15-hauke@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On Wednesday 09 August 2017 04:22 AM, Hauke Mehrtens wrote:
> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
> the PHY interfaces for each core. The phy instances can be passed to the
> dwc2 driver, which already supports the generic phy interface.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

> ---
>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  40 ++++
>  arch/mips/lantiq/xway/sysctrl.c                    |  36 +--
>  drivers/phy/Kconfig                                |   1 +
>  drivers/phy/Makefile                               |   2 +-
>  drivers/phy/lantiq/Kconfig                         |   9 +
>  drivers/phy/lantiq/Makefile                        |   1 +
>  drivers/phy/lantiq/phy-lantiq-rcu-usb2.c           | 254 +++++++++++++++++++++
>  7 files changed, 324 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>  create mode 100644 drivers/phy/lantiq/Kconfig
>  create mode 100644 drivers/phy/lantiq/Makefile
>  create mode 100644 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> new file mode 100644
> index 000000000000..d8d25063dd5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> @@ -0,0 +1,40 @@
> +Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
> +===========================================
> +
> +This binding describes the USB PHY hardware provided by the RCU module on the
> +Lantiq XWAY SoCs.
> +
> +This driver has to be a sub node of the Lantiq RCU block.
> +
> +-------------------------------------------------------------------------------
> +Required properties (controller (parent) node):
> +- compatible	: Should be one of
> +			"lantiq,ase-usb2-phy"
> +			"lantiq,danube-usb2-phy"
> +			"lantiq,xrx100-usb2-phy"
> +			"lantiq,xrx200-usb2-phy"
> +			"lantiq,xrx300-usb2-phy"
> +- reg		: Defines the following sets of registers in the parent
> +		  syscon device
> +			- Offset of the USB PHY configuration register
> +			- Offset of the USB Analog configuration
> +			  register (only for xrx200 and xrx200)
> +- clocks	: References to the (PMU) "phy" clk gate.
> +- clock-names	: Must be "phy"
> +- resets	: References to the RCU USB configuration reset bits.
> +- reset-names	: Must be one of the following:
> +			"phy" (optional)
> +			"ctrl" (shared)
> +
> +-------------------------------------------------------------------------------
> +Example for the USB PHYs on an xRX200 SoC:
> +	usb_phy0: usb2-phy@18 {
> +		compatible = "lantiq,xrx200-usb2-phy";
> +		reg = <0x18 4>, <0x38 4>;
> +
> +		clocks = <&pmu PMU_GATE_USB0_PHY>;
> +		clock-names = "phy";
> +		resets = <&reset1 4 4>, <&reset0 4 4>;
> +		reset-names = "phy", "ctrl";
> +		#phy-cells = <0>;
> +	};
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index 87eab4d288e5..7611c3013793 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -469,8 +469,8 @@ void __init ltq_soc_init(void)
>  
>  	if (of_machine_is_compatible("lantiq,grx390") ||
>  	    of_machine_is_compatible("lantiq,ar10")) {
> -		clkdev_add_pmu("1e101000.usb", "phy", 1, 2, PMU_ANALOG_USB0_P);
> -		clkdev_add_pmu("1e106000.usb", "phy", 1, 2, PMU_ANALOG_USB1_P);
> +		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 2, PMU_ANALOG_USB0_P);
> +		clkdev_add_pmu("1f203034.usb2-phy", "phy", 1, 2, PMU_ANALOG_USB1_P);
>  		/* rc 0 */
>  		clkdev_add_pmu("1d900000.pcie", "phy", 1, 2, PMU_ANALOG_PCIE0_P);
>  		clkdev_add_pmu("1d900000.pcie", "msi", 1, 1, PMU1_PCIE_MSI);
> @@ -490,8 +490,8 @@ void __init ltq_soc_init(void)
>  		else
>  			clkdev_add_static(CLOCK_133M, CLOCK_133M,
>  						CLOCK_133M, CLOCK_133M);
> -		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
> -		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
> +		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
> +		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
>  		clkdev_add_pmu("1e180000.etop", "ppe", 1, 0, PMU_PPE);
>  		clkdev_add_cgu("1e180000.etop", "ephycgu", CGU_EPHY);
>  		clkdev_add_pmu("1e180000.etop", "ephy", 1, 0, PMU_EPHY);
> @@ -500,8 +500,8 @@ void __init ltq_soc_init(void)
>  	} else if (of_machine_is_compatible("lantiq,grx390")) {
>  		clkdev_add_static(ltq_grx390_cpu_hz(), ltq_grx390_fpi_hz(),
>  				  ltq_grx390_fpi_hz(), ltq_grx390_pp32_hz());
> -		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
> -		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1);
> +		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
> +		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1);
>  		/* rc 2 */
>  		clkdev_add_pmu("1a800000.pcie", "phy", 1, 2, PMU_ANALOG_PCIE2_P);
>  		clkdev_add_pmu("1a800000.pcie", "msi", 1, 1, PMU1_PCIE2_MSI);
> @@ -513,8 +513,8 @@ void __init ltq_soc_init(void)
>  	} else if (of_machine_is_compatible("lantiq,ar10")) {
>  		clkdev_add_static(ltq_ar10_cpu_hz(), ltq_ar10_fpi_hz(),
>  				  ltq_ar10_fpi_hz(), ltq_ar10_pp32_hz());
> -		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
> -		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1);
> +		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
> +		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1);
>  		clkdev_add_pmu("1e108000.eth", NULL, 0, 0, PMU_SWITCH |
>  			       PMU_PPE_DP | PMU_PPE_TC);
>  		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
> @@ -526,10 +526,10 @@ void __init ltq_soc_init(void)
>  	} else if (of_machine_is_compatible("lantiq,vr9")) {
>  		clkdev_add_static(ltq_vr9_cpu_hz(), ltq_vr9_fpi_hz(),
>  				ltq_vr9_fpi_hz(), ltq_vr9_pp32_hz());
> -		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
> -		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0 | PMU_AHBM);
> -		clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
> -		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1 | PMU_AHBM);
> +		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
> +		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
> +		clkdev_add_pmu("1f203034.usb2-phy", "phy", 1, 0, PMU_USB1_P);
> +		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1 | PMU_AHBM);
>  		clkdev_add_pmu("1d900000.pcie", "phy", 1, 1, PMU1_PCIE_PHY);
>  		clkdev_add_pmu("1d900000.pcie", "bus", 1, 0, PMU_PCIE_CLK);
>  		clkdev_add_pmu("1d900000.pcie", "msi", 1, 1, PMU1_PCIE_MSI);
> @@ -550,10 +550,10 @@ void __init ltq_soc_init(void)
>  	} else if (of_machine_is_compatible("lantiq,ar9")) {
>  		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
>  				ltq_ar9_fpi_hz(), CLOCK_250M);
> -		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
> -		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
> -		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1);
> -		clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
> +		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
> +		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
> +		clkdev_add_pmu("1f203034.usb2-phy", "phy", 1, 0, PMU_USB1_P);
> +		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1);
>  		clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
>  		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
>  		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
> @@ -562,8 +562,8 @@ void __init ltq_soc_init(void)
>  	} else {
>  		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
>  				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
> -		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
> -		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
> +		clkdev_add_pmu("1f203018.usb2-phy", "ctrl", 1, 0, PMU_USB0);
> +		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
>  		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
>  		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
>  		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index c1807d4a0079..968088ceaeb3 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -52,6 +52,7 @@ source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
>  source "drivers/phy/hisilicon/Kconfig"
> +source "drivers/phy/lantiq/Kconfig"
>  source "drivers/phy/marvell/Kconfig"
>  source "drivers/phy/motorola/Kconfig"
>  source "drivers/phy/qualcomm/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index f252201e0ec9..a8b9439a5d8e 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -7,9 +7,9 @@ obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
>  obj-$(CONFIG_PHY_MT65XX_USB3)		+= phy-mt65xx-usb3.o
>  obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
>  obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
> -
>  obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
>  obj-$(CONFIG_ARCH_MESON)		+= amlogic/
> +obj-$(CONFIG_LANTIQ)			+= lantiq/
>  obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
>  obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
>  obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
> diff --git a/drivers/phy/lantiq/Kconfig b/drivers/phy/lantiq/Kconfig
> new file mode 100644
> index 000000000000..326d88a6417d
> --- /dev/null
> +++ b/drivers/phy/lantiq/Kconfig
> @@ -0,0 +1,9 @@
> +#
> +# Phy drivers for Lantiq / Intel platforms
> +#
> +config PHY_LANTIQ_RCU_USB2
> +	tristate "Lantiq XWAY SoC RCU based USB PHY"
> +	depends on OF && (SOC_TYPE_XWAY || COMPILE_TEST)
> +	select GENERIC_PHY
> +	help
> +	  Support for the USB PHY(s) on the Lantiq / Intel XWAY family SoCs.
> diff --git a/drivers/phy/lantiq/Makefile b/drivers/phy/lantiq/Makefile
> new file mode 100644
> index 000000000000..f73eb56a5416
> --- /dev/null
> +++ b/drivers/phy/lantiq/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_PHY_LANTIQ_RCU_USB2)	+= phy-lantiq-rcu-usb2.o
> diff --git a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
> new file mode 100644
> index 000000000000..986224fca9e9
> --- /dev/null
> +++ b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
> @@ -0,0 +1,254 @@
> +/*
> + * Lantiq XWAY SoC RCU module based USB 1.1/2.0 PHY driver
> + *
> + * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + * Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +/* Transmitter HS Pre-Emphasis Enable */
> +#define RCU_CFG1_TX_PEE		BIT(0)
> +/* Disconnect Threshold */
> +#define RCU_CFG1_DIS_THR_MASK	0x00038000
> +#define RCU_CFG1_DIS_THR_SHIFT	15
> +
> +struct ltq_rcu_usb2_bits {
> +	u8 hostmode;
> +	u8 slave_endianness;
> +	u8 host_endianness;
> +	bool have_ana_cfg;
> +};
> +
> +struct ltq_rcu_usb2_priv {
> +	struct regmap			*regmap;
> +	unsigned int			phy_reg_offset;
> +	unsigned int			ana_cfg1_reg_offset;
> +	const struct ltq_rcu_usb2_bits	*reg_bits;
> +	struct device			*dev;
> +	struct phy			*phy;
> +	struct clk			*phy_gate_clk;
> +	struct reset_control		*ctrl_reset;
> +	struct reset_control		*phy_reset;
> +};
> +
> +static const struct ltq_rcu_usb2_bits xway_rcu_usb2_reg_bits = {
> +	.hostmode = 11,
> +	.slave_endianness = 9,
> +	.host_endianness = 10,
> +	.have_ana_cfg = false,
> +};
> +
> +static const struct ltq_rcu_usb2_bits xrx100_rcu_usb2_reg_bits = {
> +	.hostmode = 11,
> +	.slave_endianness = 17,
> +	.host_endianness = 10,
> +	.have_ana_cfg = false,
> +};
> +
> +static const struct ltq_rcu_usb2_bits xrx200_rcu_usb2_reg_bits = {
> +	.hostmode = 11,
> +	.slave_endianness = 9,
> +	.host_endianness = 10,
> +	.have_ana_cfg = true,
> +};
> +
> +static const struct of_device_id ltq_rcu_usb2_phy_of_match[] = {
> +	{
> +		.compatible = "lantiq,ase-usb2-phy",
> +		.data = &xway_rcu_usb2_reg_bits,
> +	},
> +	{
> +		.compatible = "lantiq,danube-usb2-phy",
> +		.data = &xway_rcu_usb2_reg_bits,
> +	},
> +	{
> +		.compatible = "lantiq,xrx100-usb2-phy",
> +		.data = &xrx100_rcu_usb2_reg_bits,
> +	},
> +	{
> +		.compatible = "lantiq,xrx200-usb2-phy",
> +		.data = &xrx200_rcu_usb2_reg_bits,
> +	},
> +	{
> +		.compatible = "lantiq,xrx300-usb2-phy",
> +		.data = &xrx200_rcu_usb2_reg_bits,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ltq_rcu_usb2_phy_of_match);
> +
> +static int ltq_rcu_usb2_phy_init(struct phy *phy)
> +{
> +	struct ltq_rcu_usb2_priv *priv = phy_get_drvdata(phy);
> +
> +	if (priv->reg_bits->have_ana_cfg) {
> +		regmap_update_bits(priv->regmap, priv->ana_cfg1_reg_offset,
> +			RCU_CFG1_TX_PEE, RCU_CFG1_TX_PEE);
> +		regmap_update_bits(priv->regmap, priv->ana_cfg1_reg_offset,
> +			RCU_CFG1_DIS_THR_MASK, 7 << RCU_CFG1_DIS_THR_SHIFT);
> +	}
> +
> +	/* Configure core to host mode */
> +	regmap_update_bits(priv->regmap, priv->phy_reg_offset,
> +			   BIT(priv->reg_bits->hostmode), 0);
> +
> +	/* Select DMA endianness (Host-endian: big-endian) */
> +	regmap_update_bits(priv->regmap, priv->phy_reg_offset,
> +		BIT(priv->reg_bits->slave_endianness), 0);
> +	regmap_update_bits(priv->regmap, priv->phy_reg_offset,
> +		BIT(priv->reg_bits->host_endianness),
> +		BIT(priv->reg_bits->host_endianness));
> +
> +	return 0;
> +}
> +
> +static int ltq_rcu_usb2_phy_power_on(struct phy *phy)
> +{
> +	struct ltq_rcu_usb2_priv *priv = phy_get_drvdata(phy);
> +	struct device *dev = priv->dev;
> +	int ret;
> +
> +	reset_control_deassert(priv->phy_reset);
> +
> +	ret = clk_prepare_enable(priv->phy_gate_clk);
> +	if (ret)
> +		dev_err(dev, "failed to enable PHY gate\n");
> +
> +	return ret;
> +}
> +
> +static int ltq_rcu_usb2_phy_power_off(struct phy *phy)
> +{
> +	struct ltq_rcu_usb2_priv *priv = phy_get_drvdata(phy);
> +
> +	reset_control_assert(priv->phy_reset);
> +
> +	clk_disable_unprepare(priv->phy_gate_clk);
> +
> +	return 0;
> +}
> +
> +static struct phy_ops ltq_rcu_usb2_phy_ops = {
> +	.init		= ltq_rcu_usb2_phy_init,
> +	.power_on	= ltq_rcu_usb2_phy_power_on,
> +	.power_off	= ltq_rcu_usb2_phy_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int ltq_rcu_usb2_of_parse(struct ltq_rcu_usb2_priv *priv,
> +				 struct platform_device *pdev)
> +{
> +	struct device *dev = priv->dev;
> +	const __be32 *offset;
> +	int ret;
> +
> +	priv->reg_bits = of_device_get_match_data(dev);
> +
> +	priv->regmap = syscon_node_to_regmap(dev->of_node->parent);
> +	if (IS_ERR(priv->regmap)) {
> +		dev_err(dev, "Failed to lookup RCU regmap\n");
> +		return PTR_ERR(priv->regmap);
> +	}
> +
> +	offset = of_get_address(dev->of_node, 0, NULL, NULL);
> +	if (!offset) {
> +		dev_err(dev, "Failed to get RCU PHY reg offset\n");
> +		return -ENOENT;
> +	}
> +	priv->phy_reg_offset = __be32_to_cpu(*offset);
> +
> +	if (priv->reg_bits->have_ana_cfg) {
> +		offset = of_get_address(dev->of_node, 1, NULL, NULL);
> +		if (!offset) {
> +			dev_err(dev, "Failed to get RCU ANA CFG1 reg offset\n");
> +			return -ENOENT;
> +		}
> +		priv->ana_cfg1_reg_offset = __be32_to_cpu(*offset);
> +	}
> +
> +	priv->phy_gate_clk = devm_clk_get(dev, "phy");
> +	if (IS_ERR(priv->phy_gate_clk)) {
> +		dev_err(dev, "Unable to get USB phy gate clk\n");
> +		return PTR_ERR(priv->phy_gate_clk);
> +	}
> +
> +	priv->ctrl_reset = devm_reset_control_get_shared(dev, "ctrl");
> +	if (IS_ERR(priv->ctrl_reset)) {
> +		if (PTR_ERR(priv->ctrl_reset) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get 'ctrl' reset\n");
> +		return PTR_ERR(priv->ctrl_reset);
> +	}
> +
> +	priv->phy_reset = devm_reset_control_get_optional(dev, "phy");
> +	if (IS_ERR(priv->phy_reset))
> +		return PTR_ERR(priv->phy_reset);
> +
> +	return 0;
> +}
> +
> +static int ltq_rcu_usb2_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ltq_rcu_usb2_priv *priv;
> +	struct phy_provider *provider;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +
> +	ret = ltq_rcu_usb2_of_parse(priv, pdev);
> +	if (ret)
> +		return ret;
> +
> +	/* Reset USB core through reset controller */
> +	reset_control_deassert(priv->ctrl_reset);
> +
> +	reset_control_assert(priv->phy_reset);
> +
> +	priv->phy = devm_phy_create(dev, dev->of_node, &ltq_rcu_usb2_phy_ops);
> +	if (IS_ERR(priv->phy)) {
> +		dev_err(dev, "failed to create PHY\n");
> +		return PTR_ERR(priv->phy);
> +	}
> +
> +	phy_set_drvdata(priv->phy, priv);
> +
> +	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(provider))
> +		return PTR_ERR(provider);
> +
> +	dev_set_drvdata(priv->dev, priv);
> +	return 0;
> +}
> +
> +static struct platform_driver ltq_rcu_usb2_phy_driver = {
> +	.probe	= ltq_rcu_usb2_phy_probe,
> +	.driver = {
> +		.name	= "lantiq-rcu-usb2-phy",
> +		.of_match_table	= ltq_rcu_usb2_phy_of_match,
> +	}
> +};
> +module_platform_driver(ltq_rcu_usb2_phy_driver);
> +
> +MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
> +MODULE_DESCRIPTION("Lantiq XWAY USB2 PHY driver");
> +MODULE_LICENSE("GPL v2");
> 
