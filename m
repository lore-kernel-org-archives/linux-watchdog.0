Return-path: <stwiss.opensource@diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Keerthy <a0393675@ti.com>, Lee Jones <lee.jones@linaro.org>
CC: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>,
	"Guenter Roeck" <linux@roeck-us.net>, LINUX-INPUT
	<linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>,
	LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource
	<Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui
	<rui.zhang@intel.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1 01/10] mfd: da9061: MFD core support
Date: Thu, 6 Oct 2016 16:34:04 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE244D@SW-EX-MBX02.diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <c9726b1f01300da7693324b0c1ff7f71dcbc275d.1475743411.git.stwiss.opensource@diasemi.com>
 <1eca0af9-64d5-7476-2847-71ecf9331395@ti.com>
In-Reply-To: <1eca0af9-64d5-7476-2847-71ecf9331395@ti.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

On 06 October 2016 11:38, Keerthy [mailto:a0393675@ti.com], wrote:

> > regmap_config which lists the correct readble, writable and volatile
>=20
> /s/readble/readable

Done

[...]

> >  static struct resource da9062_core_resources[] =3D {
> >  	DEFINE_RES_NAMED(DA9062_IRQ_VDD_WARN, 1, "VDD_WARN",
> IORESOURCE_IRQ),
> >  };
> > @@ -142,7 +257,7 @@ static const struct mfd_cell da9062_devs[] =3D {
> >  		.name		=3D "da9062-watchdog",
> >  		.num_resources	=3D
> ARRAY_SIZE(da9062_wdt_resources),
> >  		.resources	=3D da9062_wdt_resources,
> > -		.of_compatible  =3D "dlg,da9062-wdt",
> > +		.of_compatible  =3D "dlg,da9062-watchdog",
>=20
> Any particular reason why this compatible needs to be changed?

Yes. It was incorrect in the original DA9062 submission.
The binding said "dlg,da9062-watchdog", but the MFD component implemented i=
t
incorrectly as "dlg,da9062-wdt" in the da9062.txt binding file. This fixes =
that error.=20

The watchdog driver did not use the compatible during probe for da9062. But=
, it now
checks the compatible string as part of  this patch set.

[...]

> > +static const struct of_device_id da9062_dt_ids[] =3D {
> > +	{ .compatible =3D "dlg,da9062", .data =3D (void *)COMPAT_TYPE_DA9062,
> },
> > +	{ .compatible =3D "dlg,da9061", .data =3D (void *)COMPAT_TYPE_DA9061,
> },
>=20
> WARNING: DT compatible string "dlg,da9061" appears un-documented --
> check ./Documentation/devicetree/bindings/
> #622: FILE: drivers/mfd/da9062-core.c:822:
> +	{ .compatible =3D "dlg,da9061", .data =3D (void *)COMPAT_TYPE_DA9061,
> },
>=20
> Might want to re-order patches so that you have the compatibles
> documented before usage

Ah. I ordered them last because I thought the driver would need approval be=
fore
the device tree docs were accepted. On second look, that doesn't make much =
sense.

I will change my scripts to complete the checkpatch.pl on the e-mails to be=
 sent to LKML
(instead of the whole files) so this sort of thing doesn't happen again.

I will re-order the patches from V1 when doing V2.

> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, da9062_dt_ids);
> > +
> >  static int da9062_i2c_probe(struct i2c_client *i2c,
> >  	const struct i2c_device_id *id)
> >  {
> >  	struct da9062 *chip;
> > +	const struct of_device_id *match;
> >  	unsigned int irq_base;
> > +	const struct mfd_cell *cell;
> > +	const struct regmap_irq_chip *irq_chip;
> > +	const struct regmap_config *config;
> > +	int cell_num;
>=20
> No need of cell_num.
[...]

> > +		cell_num =3D ARRAY_SIZE(da9061_devs);
>=20
> No need of the above assignment
[...]

> > +		cell_num =3D ARRAY_SIZE(da9062_devs);
>=20
> No need of the above assignment
>=20
> > +	ret =3D mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE, cell,
> > +			      cell_num, NULL, irq_base,
>=20
> Use ARRAY_SIZE(cell) instead if cell_num

Okay. Can do that.
It will appear in V2.

Regards,
Steve
