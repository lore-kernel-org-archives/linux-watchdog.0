Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:40873 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757725AbbLBXVK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Dec 2015 18:21:10 -0500
Date: Wed, 2 Dec 2015 18:21:02 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <linux@arm.linux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, kernel@savoirfairelinux.com
Subject: Re: [PATCH v7 2/6] mfd: syscon: add a DT property to set value width
Message-ID: <20151202232102.GB6055@localhost>
References: <1448899191-13891-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448899191-13891-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151130190015.GA31006@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151130190015.GA31006@rob-hp-laptop>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Lee, Arnd,

I had to make changes in this patch to address Rob's comments.
reg-io-width is now in bytes while bus-width was a value in bits. Could
you please review this patch ?

Thanks,
Damien

On Mon, Nov 30, 2015 at 01:00:15PM -0600, Rob Herring wrote:
> On Mon, Nov 30, 2015 at 10:59:47AM -0500, Damien Riegel wrote:
> > Currently syscon has a fixed configuration of 32 bits for register and
> > values widths. In some cases, it would be desirable to be able to
> > customize the value width.
> > 
> > For example, certain boards (like the ones manufactured by Technologic
> > Systems) have a FPGA that is memory-mapped, but its registers are only
> > 16-bit wide.
> > 
> > This patch adds an optional "reg-io-width" DT binding for syscon that
> > allows to change the width for the data bus (i.e. val_bits). If this
> > property is provided, it will also set the register stride to
> > reg-io-width's value. If not provided, the default configuration is
> > used.
> > 
> > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.txt |  4 ++++
> >  drivers/mfd/syscon.c                             | 13 +++++++++++++
> >  2 files changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
> > index fe8150b..408f768 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.txt
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
> > @@ -13,6 +13,10 @@ Required properties:
> >  - compatible: Should contain "syscon".
> >  - reg: the register region can be accessed from syscon
> >  
> > +Optional property:
> > +- reg-io-width: the size (in bytes) of the IO accesses that should be
> > +  performed on the device.
> > +
> >  Examples:
> >  gpr: iomuxc-gpr@020e0000 {
> >  	compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
> > diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> > index 176bf0f..b7aabee 100644
> > --- a/drivers/mfd/syscon.c
> > +++ b/drivers/mfd/syscon.c
> > @@ -47,6 +47,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
> >  	struct syscon *syscon;
> >  	struct regmap *regmap;
> >  	void __iomem *base;
> > +	u32 reg_io_width;
> >  	int ret;
> >  	struct regmap_config syscon_config = syscon_regmap_config;
> >  
> > @@ -69,6 +70,18 @@ static struct syscon *of_syscon_register(struct device_node *np)
> >  	 else if (of_property_read_bool(np, "little-endian"))
> >  		syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
> >  
> > +	/*
> > +	 * search for reg-io-width property in DT. If it is not provided,
> > +	 * default to 4 bytes. regmap_init_mmio will return an error if values
> > +	 * are invalid so there is no need to check them here.
> > +	 */
> > +	ret = of_property_read_u32(np, "reg-io-width", &reg_io_width);
> > +	if (ret)
> > +		reg_io_width = 4;
> > +
> > +	syscon_config.reg_stride = reg_io_width;
> > +	syscon_config.val_bits = reg_io_width * 8;
> > +
> >  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
> >  	if (IS_ERR(regmap)) {
> >  		pr_err("regmap init failed\n");
> > -- 
> > 2.5.0
> > 
