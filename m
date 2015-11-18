Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37815 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbbKRIVu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Nov 2015 03:21:50 -0500
Received: by wmww144 with SMTP id w144so60700573wmw.0
        for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2015 00:21:48 -0800 (PST)
Date: Wed, 18 Nov 2015 08:21:44 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v3 2/5] mfd: syscon: add a DT property to set value width
Message-ID: <20151118082144.GB3534@x1>
References: <1447700814-5391-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1447700814-5391-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151117091946.GG17829@x1>
 <20151117172649.GA11035@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20151117172649.GA11035@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 17 Nov 2015, Guenter Roeck wrote:

> On Tue, Nov 17, 2015 at 09:19:46AM +0000, Lee Jones wrote:
> > On Mon, 16 Nov 2015, Damien Riegel wrote:
> >=20
> > > Currently syscon has a fixed configuration of 32 bits for registe=
r and
> > > values widths. In some cases, it would be desirable to be able to
> > > customize the value width.
> > >=20
> > > For example, certain boards (like the ones manufactured by Techno=
logic
> > > Systems) have a FPGA that is memory-mapped, but its registers are=
 only
> > > 16-bit wide.
> > >=20
> > > This patch adds an optional "bus-width" DT binding for syscon tha=
t
> > > allows to change the width for the data bus (i.e. val_bits). If t=
his
> > > property is provided, it will also adjust the register stride to
> > > bus-width / 8. If not provided, the default configuration is used=
=2E
> > >=20
> > > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/syscon.txt |  3 +++
> > >  drivers/mfd/syscon.c                             | 12 ++++++++++=
++
> > >  2 files changed, 15 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/D=
ocumentation/devicetree/bindings/mfd/syscon.txt
> > > index fe8150b..4c9d187 100644
> > > --- a/Documentation/devicetree/bindings/mfd/syscon.txt
> > > +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
> > > @@ -13,6 +13,9 @@ Required properties:
> > >  - compatible: Should contain "syscon".
> > >  - reg: the register region can be accessed from syscon
> > > =20
> > > +Optional property:
> > > +- bus-width: width of the data bus. Can be <8>, <16>, <32>, or <=
64>.
> > > +
> > >  Examples:
> > >  gpr: iomuxc-gpr@020e0000 {
> > >  	compatible =3D "fsl,imx6q-iomuxc-gpr", "syscon";
> > > diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> > > index 176bf0f..00b0995 100644
> > > --- a/drivers/mfd/syscon.c
> > > +++ b/drivers/mfd/syscon.c
> > > @@ -47,6 +47,7 @@ static struct syscon *of_syscon_register(struct=
 device_node *np)
> > >  	struct syscon *syscon;
> > >  	struct regmap *regmap;
> > >  	void __iomem *base;
> > > +	u32 bus_width;
> > >  	int ret;
> > >  	struct regmap_config syscon_config =3D syscon_regmap_config;
> > > =20
> > > @@ -69,6 +70,17 @@ static struct syscon *of_syscon_register(struc=
t device_node *np)
> > >  	 else if (of_property_read_bool(np, "little-endian"))
> > >  		syscon_config.val_format_endian =3D REGMAP_ENDIAN_LITTLE;
> > > =20
> > > +	 ret =3D of_property_read_u32(np, "bus-width", &bus_width);
> > > +	 if (!ret) {
> >=20
> > This syntax is confusing, as we normally associate it with an error
> > condition.  Instead, I'd use:
> >=20
> >   if (of_property_read_u32(np, "bus-width", &bus_width) =3D=3D 0)
>=20
> Or maybe better
>=20
> 	if (!of_property_read_u32(np, "bus-width", &bus_width))

Not sure if it's better, but it's also suitable.

> > Or, for more clarity:
> >=20
> >   of_property_read_u32(np, "bus-width", &bus_width);
> >   if (bus_width)
> >=20
> > If you choose this version (which I think is my preferred method, d=
on't
> > forget to initialise 'bus_width' to zero.
> >=20
> Ignoring an error and depending on bus_width=3D=3D0 to determine if t=
he property
> was provided seems odd, especially since it would "hide" if the bus-w=
idth
> property is set to 0. In the original code, this would be detected as=
 error.

I'm not sure what you mean.  If bus_width=3D=3D0, then a problem has
occurred and we will not use the value.  If bus_width!=3D0 then we can
assume that it's been set and (as the comment describes) the value
will be checked for errors in regmap_init_mmio().

> > > +		 /*
> > > +		  * the property has been provided, regmap_init_mmio
> > > +		  * will return an error if these values are invalid
> > > +		  * so there is no need to check them here.
> > > +		  */
> > > +		 syscon_config.val_bits =3D bus_width;
> > > +		 syscon_config.reg_stride =3D syscon_config.val_bits / 8;
> > > +	 }
> > > +
> > >  	regmap =3D regmap_init_mmio(NULL, base, &syscon_config);
> > >  	if (IS_ERR(regmap)) {
> > >  		pr_err("regmap init failed\n");
> >=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
