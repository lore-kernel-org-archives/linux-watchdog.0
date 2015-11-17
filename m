Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43124 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbbKQR04 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Nov 2015 12:26:56 -0500
Date: Tue, 17 Nov 2015 09:26:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lee Jones <lee.jones@linaro.org>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v3 2/5] mfd: syscon: add a DT property to set value width
Message-ID: <20151117172649.GA11035@roeck-us.net>
References: <1447700814-5391-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1447700814-5391-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151117091946.GG17829@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20151117091946.GG17829@x1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Nov 17, 2015 at 09:19:46AM +0000, Lee Jones wrote:
> On Mon, 16 Nov 2015, Damien Riegel wrote:
> 
> > Currently syscon has a fixed configuration of 32 bits for register and
> > values widths. In some cases, it would be desirable to be able to
> > customize the value width.
> > 
> > For example, certain boards (like the ones manufactured by Technologic
> > Systems) have a FPGA that is memory-mapped, but its registers are only
> > 16-bit wide.
> > 
> > This patch adds an optional "bus-width" DT binding for syscon that
> > allows to change the width for the data bus (i.e. val_bits). If this
> > property is provided, it will also adjust the register stride to
> > bus-width / 8. If not provided, the default configuration is used.
> > 
> > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.txt |  3 +++
> >  drivers/mfd/syscon.c                             | 12 ++++++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
> > index fe8150b..4c9d187 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.txt
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
> > @@ -13,6 +13,9 @@ Required properties:
> >  - compatible: Should contain "syscon".
> >  - reg: the register region can be accessed from syscon
> >  
> > +Optional property:
> > +- bus-width: width of the data bus. Can be <8>, <16>, <32>, or <64>.
> > +
> >  Examples:
> >  gpr: iomuxc-gpr@020e0000 {
> >  	compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
> > diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> > index 176bf0f..00b0995 100644
> > --- a/drivers/mfd/syscon.c
> > +++ b/drivers/mfd/syscon.c
> > @@ -47,6 +47,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
> >  	struct syscon *syscon;
> >  	struct regmap *regmap;
> >  	void __iomem *base;
> > +	u32 bus_width;
> >  	int ret;
> >  	struct regmap_config syscon_config = syscon_regmap_config;
> >  
> > @@ -69,6 +70,17 @@ static struct syscon *of_syscon_register(struct device_node *np)
> >  	 else if (of_property_read_bool(np, "little-endian"))
> >  		syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
> >  
> > +	 ret = of_property_read_u32(np, "bus-width", &bus_width);
> > +	 if (!ret) {
> 
> This syntax is confusing, as we normally associate it with an error
> condition.  Instead, I'd use:
> 
>   if (of_property_read_u32(np, "bus-width", &bus_width) == 0)

Or maybe better

	if (!of_property_read_u32(np, "bus-width", &bus_width))

> 
> Or, for more clarity:
> 
>   of_property_read_u32(np, "bus-width", &bus_width);
>   if (bus_width)
> 
> If you choose this version (which I think is my preferred method, don't
> forget to initialise 'bus_width' to zero.
> 
Ignoring an error and depending on bus_width==0 to determine if the property
was provided seems odd, especially since it would "hide" if the bus-width
property is set to 0. In the original code, this would be detected as error.

Guenter

> > +		 /*
> > +		  * the property has been provided, regmap_init_mmio
> > +		  * will return an error if these values are invalid
> > +		  * so there is no need to check them here.
> > +		  */
> > +		 syscon_config.val_bits = bus_width;
> > +		 syscon_config.reg_stride = syscon_config.val_bits / 8;
> > +	 }
> > +
> >  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
> >  	if (IS_ERR(regmap)) {
> >  		pr_err("regmap init failed\n");
> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
