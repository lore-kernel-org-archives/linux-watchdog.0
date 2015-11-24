Return-path: <lee.jones@linaro.org>
Date: Tue, 24 Nov 2015 08:20:36 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, robh+dt@kernel.org,
	shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	Arnd Bergmann <arnd@arndb.de>, kernel@savoirfairelinux.com
Subject: Re: [PATCH v4 2/5] mfd: syscon: add a DT property to set value width
Message-ID: <20151124082036.GE807@x1>
References: <1448291861-28543-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448291861-28543-3-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1448291861-28543-3-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, 23 Nov 2015, Damien Riegel wrote:

> Currently syscon has a fixed configuration of 32 bits for register and
> values widths. In some cases, it would be desirable to be able to
> customize the value width.
> 
> For example, certain boards (like the ones manufactured by Technologic
> Systems) have a FPGA that is memory-mapped, but its registers are only
> 16-bit wide.
> 
> This patch adds an optional "bus-width" DT binding for syscon that
> allows to change the width for the data bus (i.e. val_bits). If this
> property is provided, it will also adjust the register stride to
> bus-width / 8. If not provided, the default configuration is used.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.txt |  3 +++
>  drivers/mfd/syscon.c                             | 13 +++++++++++++
>  2 files changed, 16 insertions(+)

Works for me.

For my own reference:
  Acked-by: Lee Jones <lee.jones@linaro.org>

How would you like this set to be handled?

> diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
> index fe8150b..4c9d187 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.txt
> +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
> @@ -13,6 +13,9 @@ Required properties:
>  - compatible: Should contain "syscon".
>  - reg: the register region can be accessed from syscon
>  
> +Optional property:
> +- bus-width: width of the data bus. Can be <8>, <16>, <32>, or <64>.
> +
>  Examples:
>  gpr: iomuxc-gpr@020e0000 {
>  	compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 176bf0f..5a93d80 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -47,6 +47,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
>  	struct syscon *syscon;
>  	struct regmap *regmap;
>  	void __iomem *base;
> +	u32 bus_width;
>  	int ret;
>  	struct regmap_config syscon_config = syscon_regmap_config;
>  
> @@ -69,6 +70,18 @@ static struct syscon *of_syscon_register(struct device_node *np)
>  	 else if (of_property_read_bool(np, "little-endian"))
>  		syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
>  
> +	/*
> +	 * search for bus-width property in DT. If it is not provided, default
> +	 * to 32-bit. regmap_init_mmio will return an error if syscon_config's
> +	 * values are invalid so there is no need to check them here.
> +	 */
> +	ret = of_property_read_u32(np, "bus-width", &bus_width);
> +	if (ret)
> +		bus_width = 32;
> +
> +	syscon_config.val_bits = bus_width;
> +	syscon_config.reg_stride = syscon_config.val_bits / 8;
> +
>  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
>  	if (IS_ERR(regmap)) {
>  		pr_err("regmap init failed\n");

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
