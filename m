Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:35662 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751048AbdEVFaZ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 22 May 2017 01:30:25 -0400
Subject: Re: [PATCH v2 07/15] MIPS: lantiq: Convert the xbar driver to a
 platform_driver
To: Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org
References: <20170521130918.27446-1-hauke@hauke-m.de>
 <20170521130918.27446-8-hauke@hauke-m.de>
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, robh@kernel.org
From: John Crispin <john@phrozen.org>
Message-ID: <71c88b1c-3ed1-8f30-1dbd-dbd4c7bb5cdc@phrozen.org>
Date: Mon, 22 May 2017 07:30:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170521130918.27446-8-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 21/05/17 15:09, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> This allows using the xbar driver on ARX300 based SoCs which require the
> same xbar setup as the xRX200 chipsets because the xbar driver
> initialization is not guarded by an xRX200 specific
> of_machine_is_compatible condition anymore. Additionally the new driver
> takes a syscon phandle to configure the XBAR endianness bits in RCU
> (before this was done in arch/mips/lantiq/xway/reset.c and also
> guarded by an VRX200 specific if-statement).
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   .../devicetree/bindings/mips/lantiq/xbar.txt       |  24 +++++
>   MAINTAINERS                                        |   1 +
>   arch/mips/lantiq/xway/reset.c                      |   4 -
>   arch/mips/lantiq/xway/sysctrl.c                    |  41 ---------
>   drivers/soc/Makefile                               |   1 +
>   drivers/soc/lantiq/Makefile                        |   1 +
>   drivers/soc/lantiq/xbar.c                          | 101 +++++++++++++++++++++
>   7 files changed, 128 insertions(+), 45 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>   create mode 100644 drivers/soc/lantiq/Makefile
>   create mode 100644 drivers/soc/lantiq/xbar.c
>
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/xbar.txt b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
> new file mode 100644
> index 000000000000..7e1ea5299744
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
> @@ -0,0 +1,24 @@
> +Lantiq XWAY SoC XBAR binding
> +============================
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible	: Should be one of
> +				"lantiq,xbar-xway"
> +				"lantiq,xbar-xrx200"
> +- reg		: The address and length of the XBAR registers
> +
> +Optional properties:
> +- lantiq,rcu-syscon	: A phandle and offset to the endianness configuration
> +			  registers in the RCU module
> +
> +
> +-------------------------------------------------------------------------------
> +Example for the XBAR on the xRX200 SoCs:
> +	xbar0: xbar@400000 {
> +		compatible = "lantiq,xbar-xway";
> +		reg = <0x400000 0x1000>;
> +		big-endian;
> +		lantiq,rcu-syscon = <&rcu0 0x4c>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f7d568b8f133..11c33f7d63ba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7434,6 +7434,7 @@ M:	John Crispin <john@phrozen.org>
>   L:	linux-mips@linux-mips.org
>   S:	Maintained
>   F:	arch/mips/lantiq
> +F:	drivers/soc/lantiq
>   
>   LAPB module
>   L:	linux-x25@vger.kernel.org
> diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
> index 83fd65d76e81..b6752c95a600 100644
> --- a/arch/mips/lantiq/xway/reset.c
> +++ b/arch/mips/lantiq/xway/reset.c
> @@ -373,10 +373,6 @@ static int __init mips_reboot_setup(void)
>   	    of_machine_is_compatible("lantiq,vr9"))
>   		ltq_usb_init();
>   
> -	if (of_machine_is_compatible("lantiq,vr9"))
> -		ltq_rcu_w32(ltq_rcu_r32(RCU_AHB_ENDIAN) | RCU_VR9_BE_AHB1S,
> -			    RCU_AHB_ENDIAN);
> -
>   	_machine_restart = ltq_machine_restart;
>   	_machine_halt = ltq_machine_halt;
>   	pm_power_off = ltq_machine_power_off;
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index 95bec460b651..706639a343bc 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -145,15 +145,7 @@ static u32 pmu_clk_cr_b[] = {
>   #define pmu_w32(x, y)	ltq_w32((x), pmu_membase + (y))
>   #define pmu_r32(x)	ltq_r32(pmu_membase + (x))
>   
> -#define XBAR_ALWAYS_LAST	0x430
> -#define XBAR_FPI_BURST_EN	BIT(1)
> -#define XBAR_AHB_BURST_EN	BIT(2)
> -
> -#define xbar_w32(x, y)	ltq_w32((x), ltq_xbar_membase + (y))
> -#define xbar_r32(x)	ltq_r32(ltq_xbar_membase + (x))
> -
>   static void __iomem *pmu_membase;
> -static void __iomem *ltq_xbar_membase;
>   void __iomem *ltq_cgu_membase;
>   void __iomem *ltq_ebu_membase;
>   
> @@ -293,16 +285,6 @@ static void pci_ext_disable(struct clk *clk)
>   	ltq_cgu_w32((1 << 31) | (1 << 30), pcicr);
>   }
>   
> -static void xbar_fpi_burst_disable(void)
> -{
> -	u32 reg;
> -
> -	/* bit 1 as 1 --burst; bit 1 as 0 -- single */
> -	reg = xbar_r32(XBAR_ALWAYS_LAST);
> -	reg &= ~XBAR_FPI_BURST_EN;
> -	xbar_w32(reg, XBAR_ALWAYS_LAST);
> -}
> -
>   /* enable a clockout source */
>   static int clkout_enable(struct clk *clk)
>   {
> @@ -459,26 +441,6 @@ void __init ltq_soc_init(void)
>   	if (!pmu_membase || !ltq_cgu_membase || !ltq_ebu_membase)
>   		panic("Failed to remap core resources");
>   
> -	if (of_machine_is_compatible("lantiq,vr9")) {
> -		struct resource res_xbar;
> -		struct device_node *np_xbar =
> -				of_find_compatible_node(NULL, NULL,
> -							"lantiq,xbar-xway");
> -
> -		if (!np_xbar)
> -			panic("Failed to load xbar nodes from devicetree");
> -		if (of_address_to_resource(np_xbar, 0, &res_xbar))
> -			panic("Failed to get xbar resources");
> -		if (!request_mem_region(res_xbar.start, resource_size(&res_xbar),
> -			res_xbar.name))
> -			panic("Failed to get xbar resources");
> -
> -		ltq_xbar_membase = ioremap_nocache(res_xbar.start,
> -						   resource_size(&res_xbar));
> -		if (!ltq_xbar_membase)
> -			panic("Failed to remap xbar resources");
> -	}
> -
>   	/* make sure to unprotect the memory region where flash is located */
>   	ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_BUSCON0) & ~EBU_WRDIS, LTQ_EBU_BUSCON0);
>   
> @@ -605,7 +567,4 @@ void __init ltq_soc_init(void)
>   		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
>   		clkdev_add_pmu("1e100400.serial", NULL, 1, 0, PMU_ASC0);
>   	}
> -
> -	if (of_machine_is_compatible("lantiq,vr9"))
> -		xbar_fpi_burst_disable();
>   }
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 824b44281efa..009b5de74a24 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_DOVE)		+= dove/
>   obj-$(CONFIG_MACH_DOVE)		+= dove/
>   obj-y				+= fsl/
>   obj-$(CONFIG_ARCH_MXC)		+= imx/
> +obj-$(CONFIG_SOC_XWAY)		+= lantiq/
>   obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
>   obj-$(CONFIG_ARCH_QCOM)		+= qcom/
>   obj-$(CONFIG_ARCH_RENESAS)	+= renesas/
> diff --git a/drivers/soc/lantiq/Makefile b/drivers/soc/lantiq/Makefile
> new file mode 100644
> index 000000000000..7411bd23d58e
> --- /dev/null
> +++ b/drivers/soc/lantiq/Makefile
> @@ -0,0 +1 @@
> +obj-y				+= xbar.o
> diff --git a/drivers/soc/lantiq/xbar.c b/drivers/soc/lantiq/xbar.c
> new file mode 100644
> index 000000000000..89590e189efc
> --- /dev/null
> +++ b/drivers/soc/lantiq/xbar.c
> @@ -0,0 +1,101 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2011-2015 John Crispin <blogic@openwrt.org>

Hi Hauke,

my openwrt email addr is no longer valid. please use my phrozen.org one.

     John
> + *  Copyright (C) 2015 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + */
> +
> +#include <linux/ioport.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +
> +#include <lantiq_soc.h>
> +
> +#define XBAR_ALWAYS_LAST	0x430
> +#define XBAR_FPI_BURST_EN	BIT(1)
> +#define XBAR_AHB_BURST_EN	BIT(2)
> +
> +#define RCU_VR9_BE_AHB1S	0x00000008
> +
> +static int ltq_xbar_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct resource res_xbar;
> +	struct regmap *rcu_regmap;
> +	void __iomem *xbar_membase;
> +	u32 rcu_ahb_endianness_reg_offset;
> +	u32 rcu_ahb_endianness_val;
> +	int ret;
> +
> +	ret = of_address_to_resource(np, 0, &res_xbar);
> +	if (ret) {
> +		dev_err(dev, "Failed to get xbar resources");
> +		return ret;
> +	}
> +
> +	if (!devm_request_mem_region(dev, res_xbar.start,
> +				     resource_size(&res_xbar),
> +		res_xbar.name)) {
> +		dev_err(dev, "Failed to get xbar resources");
> +		return -ENODEV;
> +	}
> +
> +	xbar_membase = devm_ioremap_nocache(dev, res_xbar.start,
> +						resource_size(&res_xbar));
> +	if (!xbar_membase) {
> +		dev_err(dev, "Failed to remap xbar resources");
> +		return -ENODEV;
> +	}
> +
> +	/* RCU configuration is optional */
> +	rcu_regmap = syscon_regmap_lookup_by_phandle(np, "lantiq,rcu-syscon");
> +	if (!IS_ERR_OR_NULL(rcu_regmap)) {
> +		if (of_property_read_u32_index(np, "lantiq,rcu-syscon", 1,
> +			&rcu_ahb_endianness_reg_offset)) {
> +			dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
> +			return -EINVAL;
> +		}
> +
> +		if (of_device_is_big_endian(np))
> +			rcu_ahb_endianness_val = RCU_VR9_BE_AHB1S;
> +		else
> +			rcu_ahb_endianness_val = 0;
> +
> +		if (regmap_update_bits(rcu_regmap,
> +					rcu_ahb_endianness_reg_offset,
> +					RCU_VR9_BE_AHB1S,
> +					rcu_ahb_endianness_val))
> +			dev_warn(&pdev->dev,
> +				"Failed to configure RCU AHB endianness\n");
> +	}
> +
> +	/* disable fpi burst */
> +	ltq_w32_mask(XBAR_FPI_BURST_EN, 0,
> +		     xbar_membase + XBAR_ALWAYS_LAST);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id xbar_match[] = {
> +	{ .compatible = "lantiq,xbar-xway" },
> +	{ .compatible = "lantiq,xbar-xrx200" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, xbar_match);
> +
> +static struct platform_driver xbar_driver = {
> +	.probe = ltq_xbar_probe,
> +	.driver = {
> +		.name = "xbar-xway",
> +		.of_match_table = xbar_match,
> +	},
> +};
> +
> +builtin_platform_driver(xbar_driver);

