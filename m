Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:56618 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359AbbLGTwG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 7 Dec 2015 14:52:06 -0500
Date: Mon, 7 Dec 2015 14:42:18 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20151207194218.GB6030@localhost>
References: <1448899191-13891-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448899191-13891-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151207094020.GF3384@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20151207094020.GF3384@x1>
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Dec 07, 2015 at 09:40:20AM +0000, Lee Jones wrote:
> On Mon, 30 Nov 2015, Damien Riegel wrote:
>=20
> > Currently syscon has a fixed configuration of 32 bits for register =
and
> > values widths. In some cases, it would be desirable to be able to
> > customize the value width.
> >=20
> > For example, certain boards (like the ones manufactured by Technolo=
gic
> > Systems) have a FPGA that is memory-mapped, but its registers are o=
nly
> > 16-bit wide.
> >=20
> > This patch adds an optional "reg-io-width" DT binding for syscon th=
at
> > allows to change the width for the data bus (i.e. val_bits). If thi=
s
> > property is provided, it will also set the register stride to
> > reg-io-width's value. If not provided, the default configuration is
> > used.
> >=20
> > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.txt |  4 ++++
> >  drivers/mfd/syscon.c                             | 13 ++++++++++++=
+
> >  2 files changed, 17 insertions(+)
>=20
> Applied, thanks.
>=20
Hi Lee,

Good to see this patch applied. What's going on now with the other
patches of this serie ? How should I handle them ?

Thanks,
Damien

> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Doc=
umentation/devicetree/bindings/mfd/syscon.txt
> > index fe8150b..408f768 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.txt
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
> > @@ -13,6 +13,10 @@ Required properties:
> >  - compatible: Should contain "syscon".
> >  - reg: the register region can be accessed from syscon
> > =20
> > +Optional property:
> > +- reg-io-width: the size (in bytes) of the IO accesses that should=
 be
> > +  performed on the device.
> > +
> >  Examples:
> >  gpr: iomuxc-gpr@020e0000 {
> >  	compatible =3D "fsl,imx6q-iomuxc-gpr", "syscon";
> > diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> > index 176bf0f..b7aabee 100644
> > --- a/drivers/mfd/syscon.c
> > +++ b/drivers/mfd/syscon.c
> > @@ -47,6 +47,7 @@ static struct syscon *of_syscon_register(struct d=
evice_node *np)
> >  	struct syscon *syscon;
> >  	struct regmap *regmap;
> >  	void __iomem *base;
> > +	u32 reg_io_width;
> >  	int ret;
> >  	struct regmap_config syscon_config =3D syscon_regmap_config;
> > =20
> > @@ -69,6 +70,18 @@ static struct syscon *of_syscon_register(struct =
device_node *np)
> >  	 else if (of_property_read_bool(np, "little-endian"))
> >  		syscon_config.val_format_endian =3D REGMAP_ENDIAN_LITTLE;
> > =20
> > +	/*
> > +	 * search for reg-io-width property in DT. If it is not provided,
> > +	 * default to 4 bytes. regmap_init_mmio will return an error if v=
alues
> > +	 * are invalid so there is no need to check them here.
> > +	 */
> > +	ret =3D of_property_read_u32(np, "reg-io-width", &reg_io_width);
> > +	if (ret)
> > +		reg_io_width =3D 4;
> > +
> > +	syscon_config.reg_stride =3D reg_io_width;
> > +	syscon_config.val_bits =3D reg_io_width * 8;
> > +
> >  	regmap =3D regmap_init_mmio(NULL, base, &syscon_config);
> >  	if (IS_ERR(regmap)) {
> >  		pr_err("regmap init failed\n");
>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
