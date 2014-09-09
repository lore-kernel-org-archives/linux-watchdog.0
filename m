Return-path: <Li.Xiubo@freescale.com>
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "wim@iguana.be" <wim@iguana.be>, "mpa@pengutronix.de"
	<mpa@pengutronix.de>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCHv2] watchdog: imx2_wdt: Convert to use regmap framework's
 endianness method.
Date: Tue, 9 Sep 2014 01:37:22 +0000
Message-ID: <7f0ca96002794780b7ff98269bb05c89@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1408953277-2069-1-git-send-email-Li.Xiubo@freescale.com>
 <54446636ab294eed83c4a4e3d405dfe7@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <20140905160640.GB12374@roeck-us.net>
In-Reply-To: <20140905160640.GB12374@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

Get it.

Thanks very much.

BRs
Xiubo




> -----Original Message-----
> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
> Sent: Saturday, September 06, 2014 12:07 AM
> To: Xiubo Li-B47053
> Cc: wim@iguana.be; mpa@pengutronix.de; linux-watchdog@vger.kernel.org; li=
nux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCHv2] watchdog: imx2_wdt: Convert to use regmap framewor=
k's
> endianness method.
>=20
> On Fri, Sep 05, 2014 at 07:11:31AM +0000, Li.Xiubo@freescale.com wrote:
> > Hi,
> >
> > Ping :)
> >
> Wim usually picks up patches shortly before the next release window opens=
.
>=20
> It is in my watchdog-next branch, so it is not forgotten. I'll send a pul=
l
> request to Wim after -rc5.
>=20
> Wim, I am wondering - should I ask Stephen to add my watchdog-next branch=
 to
> linux-next ? I know it isn't really perfect, and there is no guarantee th=
at
> you will accept the patches in my branch, but it would expose the pending
> patches to earlier visibility in -next.
>=20
> Thanks,
> Guenter
>=20
> > Thanks,
> >
> > BRs
> > Xiubo
> >
> >
> > > -----Original Message-----
> > > From: Xiubo Li [mailto:Li.Xiubo@freescale.com]
> > > Sent: Monday, August 25, 2014 3:55 PM
> > > To: wim@iguana.be; linux@roeck-us.net; mpa@pengutronix.de; linux-
> > > watchdog@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Xiubo L=
i-
> B47053
> > > Subject: [PATCHv2] watchdog: imx2_wdt: Convert to use regmap framewor=
k's
> > > endianness method.
> > >
> > > Regmap framework will contain some patches to handle endianess, and t=
here
> > > does not need any parsing of endianness DT properties of individual d=
river,
> > > so we can savely remove it here.
> > >
> > > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > > Cc: Markus Pargmann <mpa@pengutronix.de>
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >
> > > Changes in v2:
> > > - Remove useless header file.
> > >
> > >
> > >
> > >
> > >  Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt | 4 ++--
> > >  drivers/watchdog/imx2_wdt.c                                | 9 +----=
----
> > >  2 files changed, 3 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.t=
xt
> > > b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> > > index e52ba2d..9e1ebe2 100644
> > > --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> > > +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> > > @@ -6,8 +6,8 @@ Required properties:
> > >  - interrupts : Should contain WDT interrupt
> > >
> > >  Optional property:
> > > -- big-endian: If present the watchdog device's registers are impleme=
nted
> > > -  in big endian mode, otherwise in little mode.
> > > +- big-endian: Boolean property, required if all the i.MX WDT registe=
rs
> > > +  are big-endian rather than little-endian.
> > >
> > >  Examples:
> > >
> > > diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.=
c
> > > index 68c3d37..afc8738 100644
> > > --- a/drivers/watchdog/imx2_wdt.c
> > > +++ b/drivers/watchdog/imx2_wdt.c
> > > @@ -28,7 +28,6 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > >  #include <linux/moduleparam.h>
> > > -#include <linux/of_address.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/timer.h>
> > > @@ -182,7 +181,7 @@ static struct watchdog_ops imx2_wdt_ops =3D {
> > >  	.set_timeout =3D imx2_wdt_set_timeout,
> > >  };
> > >
> > > -static struct regmap_config imx2_wdt_regmap_config =3D {
> > > +static const struct regmap_config imx2_wdt_regmap_config =3D {
> > >  	.reg_bits =3D 16,
> > >  	.reg_stride =3D 2,
> > >  	.val_bits =3D 16,
> > > @@ -191,12 +190,10 @@ static struct regmap_config imx2_wdt_regmap_con=
fig =3D
> {
> > >
> > >  static int __init imx2_wdt_probe(struct platform_device *pdev)
> > >  {
> > > -	struct device_node *np =3D pdev->dev.of_node;
> > >  	struct imx2_wdt_device *wdev;
> > >  	struct watchdog_device *wdog;
> > >  	struct resource *res;
> > >  	void __iomem *base;
> > > -	bool big_endian;
> > >  	int ret;
> > >  	u32 val;
> > >
> > > @@ -204,10 +201,6 @@ static int __init imx2_wdt_probe(struct
> platform_device
> > > *pdev)
> > >  	if (!wdev)
> > >  		return -ENOMEM;
> > >
> > > -	big_endian =3D of_property_read_bool(np, "big-endian");
> > > -	if (big_endian)
> > > -		imx2_wdt_regmap_config.val_format_endian =3D REGMAP_ENDIAN_BIG;
> > > -
> > >  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >  	base =3D devm_ioremap_resource(&pdev->dev, res);
> > >  	if (IS_ERR(base))
> > > --
> > > 1.8.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
