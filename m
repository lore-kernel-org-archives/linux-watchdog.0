Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:40007 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751375AbdHGNmO (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 7 Aug 2017 09:42:14 -0400
Subject: Re: [PATCH v8 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To: ralf@linux-mips.org, Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de
References: <20170802225717.24408-1-hauke@hauke-m.de>
 <20170802225717.24408-15-hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <c5f6e6d6-c374-5066-7dc1-1632c8af1286@hauke-m.de>
Date: Mon, 7 Aug 2017 15:41:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170802225717.24408-15-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Kishon,

On 08/03/2017 12:57 AM, Hauke Mehrtens wrote:
> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
> the PHY interfaces for each core. The phy instances can be passed to the
> dwc2 driver, which already supports the generic phy interface.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>

Kishon could you please review this patch and give an Ack or Nack, I
would like to merge this thorough Ralf's mips tree.

> ---
>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  43 +++
>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>  drivers/phy/Kconfig                                |   1 +
>  drivers/phy/Makefile                               |   2 +-
>  drivers/phy/lantiq/Kconfig                         |  10 +
>  drivers/phy/lantiq/Makefile                        |   1 +
>  drivers/phy/lantiq/phy-lantiq-rcu-usb2.c           | 290 +++++++++++++++++++++
>  7 files changed, 358 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>  create mode 100644 drivers/phy/lantiq/Kconfig
>  create mode 100644 drivers/phy/lantiq/Makefile
>  create mode 100644 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> new file mode 100644
> index 000000000000..76036c5c5d11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> @@ -0,0 +1,43 @@
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
> +- clocks	: References to the (PMU) "ctrl" and "phy" clk gates.
> +- clock-names	: Must be one of the following:
> +			"ctrl"
> +			"phy"
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
> +		clocks = <&pmu PMU_GATE_USB0_CTRL>,
> +			 <&pmu PMU_GATE_USB0_PHY>;
> +		clock-names = "ctrl", "phy";
> +		resets = <&reset1 4 4>, <&reset0 4 4>;
> +		reset-names = "phy", "ctrl";
> +		#phy-cells = <0>;
> +	};
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index 87eab4d288e5..f76978e4da32 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
....
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
> index 000000000000..a2d5006b3dc7
> --- /dev/null
> +++ b/drivers/phy/lantiq/Kconfig
> @@ -0,0 +1,10 @@
> +#
> +# Phy drivers for Lantiq / Intel platforms
> +#
> +config PHY_LANTIQ_RCU_USB2
> +	tristate "Lantiq XWAY SoC RCU based USB PHY"
> +	depends on SOC_TYPE_XWAY
> +	depends on OF
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
> index 000000000000..8f5687737b50
> --- /dev/null
> +++ b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
> @@ -0,0 +1,290 @@

.....

> +
> +	ret = of_address_to_resource(dev->of_node->parent, 0, &res_parent);
> +	if (ret)
> +		return ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "Failed to get RCU PHY reg offset\n");
> +		return ret;

I will return -ENOENT here.

> +	}
> +
> +	if (res->start < res_parent.start)
> +		return -ENOENT;
> +	priv->phy_reg_offset = res->start - res_parent.start;
> +
> +	if (priv->reg_bits->have_ana_cfg) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (!res) {
> +			dev_err(dev, "Failed to get RCU ANA CFG1 reg offset\n");
> +			return ret;

I will return -ENOENT here.

> +		}
> +
> +		if (res->start < res_parent.start)
> +			return -ENOENT;
> +		priv->ana_cfg1_reg_offset = res->start - res_parent.start;
> +	}
> +
