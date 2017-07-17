Return-Path: <moritz.fischer@ettus.com>
Return-path: <moritz.fischer@ettus.com>
Date: Mon, 17 Jul 2017 11:14:09 -0700
From: Moritz Fischer <mdf@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, wim@iguana.be,
	linux@roeck-us.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [PATCH 2/2] mfd: ds1374: Add Dallas/Maxim DS1374 Multi Function
 Device
Message-ID: <20170717181409.GB8750@tyrael.ni.corp.natinst.com>
References: <1499975665-14581-1-git-send-email-mdf@kernel.org>
 <1499975665-14581-2-git-send-email-mdf@kernel.org>
 <20170717075117.btnhbmgpofwn7zdk@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20170717075117.btnhbmgpofwn7zdk@dell>
List-ID: <linux-watchdog@vger.kernel.org>


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Mon, Jul 17, 2017 at 08:51:17AM +0100, Lee Jones wrote:
> On Thu, 13 Jul 2017, Moritz Fischer wrote:
>=20
> > From: Moritz Fischer <moritz.fischer@ettus.com>
> >=20
> > Add support for the Maxim/Dallas DS1374 RTC/WDT with trickle charger.
> > The device can either be configured as simple RTC, as simple RTC with
> > Alarm (IRQ) as well as simple RTC with watchdog timer.
> >=20
> > Break up the old monolithic driver in drivers/rtc/rtc-ds1374.c into:
> > - rtc part in drivers/rtc/rtc-ds1374.c
> > - watchdog part under drivers/watchdog/ds1374-wdt.c
> > - mfd part drivers/mfd/ds1374.c
> >=20
> > The MFD part takes care of trickle charging and mode selection,
> > since the usage modes of a) RTC + Alarm or b) RTC + WDT
> > are mutually exclusive.
> >=20
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/mfd/Kconfig              |  10 +
> >  drivers/mfd/Makefile             |   1 +
> >  drivers/mfd/ds1374.c             | 260 ++++++++++++++++
> >  drivers/rtc/rtc-ds1374.c         | 639 ++++++++++---------------------=
--------
>=20
> It looks like this should now depend on MFD_DS1374, right?
>=20
> >  drivers/watchdog/Kconfig         |  10 +
> >  drivers/watchdog/Makefile        |   1 +
> >  drivers/watchdog/ds1374-wdt.c    | 208 +++++++++++++
>=20
> The RTC and Watchdog drivers need to be split out of this patch and
> placed into their own.  Then we can take them through their respective
> subsystem trees and do not have to rely on immutable branches for
> unification.

Ok, I haven't found a good way to keep this bisectable in that case. I'm
open to suggestions. If the consensus ends up being to split it up, I'm
more than happy to separate it out into multiple patches.

>=20
> >  include/dt-bindings/mfd/ds1374.h |  17 ++
> >  include/linux/mfd/ds1374.h       |  59 ++++
> >  9 files changed, 722 insertions(+), 483 deletions(-)
> >  create mode 100644 drivers/mfd/ds1374.c
> >  create mode 100644 drivers/watchdog/ds1374-wdt.c
> >  create mode 100644 include/dt-bindings/mfd/ds1374.h
> >  create mode 100644 include/linux/mfd/ds1374.h
> >=20
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 3eb5c93..2dfef3c 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -203,6 +203,16 @@ config MFD_CROS_EC_SPI
> >  	  response time cannot be guaranteed, we support ignoring
> >  	  'pre-amble' bytes before the response actually starts.
> > =20
> > +config MFD_DS1374
> > +	tristate "Dallas/Maxim DS1374 RTC/WDT/ALARM (I2C)"
> > +	select MFD_CORE
> > +	depends on I2C
> > +	depends on REGMAP_I2C
> > +
> > +	 ---help---
>=20
> This is an old style of help.  Please remove the '-'s.
Will do.

>=20
> > +	  This driver supports the Dallas Maxim DS1374 multi function chip.
>=20
> "Multi-Functional"
Ok.
>=20
> > +	  The chip combines an RTC, trickle charger, Watchdog or Alarm.
>=20
> Why is "trickle charger" not capitalised?

No particular reason. Will fix.
>=20
> > +
> >  config MFD_ASIC3
> >  	bool "Compaq ASIC3"
> >  	depends on GPIOLIB && ARM
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index c16bf1e..b5cfcf4 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -15,6 +15,7 @@ cros_ec_core-$(CONFIG_ACPI)	+=3D cros_ec_acpi_gpe.o
> >  obj-$(CONFIG_MFD_CROS_EC)	+=3D cros_ec_core.o
> >  obj-$(CONFIG_MFD_CROS_EC_I2C)	+=3D cros_ec_i2c.o
> >  obj-$(CONFIG_MFD_CROS_EC_SPI)	+=3D cros_ec_spi.o
> > +obj-$(CONFIG_MFD_DS1374)	+=3D ds1374.o
> >  obj-$(CONFIG_MFD_EXYNOS_LPASS)	+=3D exynos-lpass.o
> > =20
> >  rtsx_pci-objs			:=3D rtsx_pcr.o rts5209.o rts5229.o rtl8411.o rts5227.=
o rts5249.o
> > diff --git a/drivers/mfd/ds1374.c b/drivers/mfd/ds1374.c
> > new file mode 100644
> > index 0000000..a0cfa1b
> > --- /dev/null
> > +++ b/drivers/mfd/ds1374.c
> > @@ -0,0 +1,260 @@
> > +/*
> > + * Copyright (c) 2017, National Instruments Corp.
> > + *
> > + * Dallas/Maxim DS1374 Multi Function Device Driver
>=20
> "Functional"
>=20
> > + * The trickle charger code was taken more ore less 1:1 from
>=20
> "or"
>=20
> > + * drivers/rtc/rtc-1390.c
>=20
> Why does this need to be documented in this file?
>=20
> If the Trickle Charger code is in here (I haven't been down that far
> yet) you need to move it out into a more appropriate subsystem.

Any suggestions? Most of the RTC drivers keep the trickle charge code in
RTC drivers. I can either do that, or see if somwhere under
drivers/power/supply makes sense.

>=20
> > + * SPDX-License-Identifier: GPL-2.0
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/i2c.h>
> > +#include <linux/slab.h>
> > +#include <linux/pm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/ds1374.h>
>=20
> Alphabetical.

Ok, will do.
>=20
> > +#define DS1374_TRICKLE_CHARGER_ENABLE	0xa0
> > +#define DS1374_TRICKLE_CHARGER_ENABLE_MASK 0xe0
> > +
> > +#define DS1374_TRICKLE_CHARGER_250_OHM	0x01
> > +#define DS1374_TRICKLE_CHARGER_2K_OHM	0x02
> > +#define DS1374_TRICKLE_CHARGER_4K_OHM	0x03
> > +#define DS1374_TRICKLE_CHARGER_ROUT_MASK 0x03
> > +
> > +#define DS1374_TRICKLE_CHARGER_NO_DIODE	0x04
> > +#define DS1374_TRICKLE_CHARGER_DIODE	0x08
> > +#define DS1374_TRICKLE_CHARGER_DIODE_MASK 0xc
>=20
> Are these tabs or spaces, or a mixture?

It's a mix, I'll fix that.
>=20
> Did you run checkpatch.pl?

I did.
>=20
> > +static const struct regmap_range volatile_ranges[] =3D {
> > +	regmap_reg_range(DS1374_REG_TOD0, DS1374_REG_WDALM2),
> > +	regmap_reg_range(DS1374_REG_SR, DS1374_REG_SR),
> > +};
> > +
> > +static const struct regmap_access_table ds1374_volatile_table =3D {
> > +	.yes_ranges =3D volatile_ranges,
> > +	.n_yes_ranges =3D ARRAY_SIZE(volatile_ranges),
> > +};
> > +
> > +static struct regmap_config ds1374_regmap_config =3D {
>=20
> Genuine question: Can this be const?

Yes.
>=20
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D DS1374_REG_TCR,
> > +	.volatile_table	=3D &ds1374_volatile_table,
> > +	.cache_type	=3D REGCACHE_RBTREE,
>=20
> It might just be the patch format, but can you check if this is
> tabs/spaces?  If you're using tabs, please ensure they are all
> aligned.

Will fix.
>=20
> > +};
> > +
> > +static struct mfd_cell ds1374_wdt_cell =3D {
> > +	.name =3D "ds1374-wdt",
> > +};
> > +
> > +static struct mfd_cell ds1374_rtc_cell =3D {
> > +	.name =3D "ds1374-rtc",
> > +};
> > +
> > +static int ds1374_add_device(struct ds1374 *chip,
> > +			     struct mfd_cell *cell)
> > +{
> > +	cell->platform_data =3D chip;
> > +	cell->pdata_size =3D sizeof(*chip);
> > +
> > +	return mfd_add_devices(&chip->client->dev, PLATFORM_DEVID_AUTO,
> > +			       cell, 1, NULL, 0, NULL);
> > +}
>=20
> This function appears to serve no purpose.  Why don't you just use
> mfd_add_devices() instead?

Yeah, can do.
>=20
> > +static int ds1374_trickle_of_init(struct ds1374 *ds1374)
> > +{
> > +	u32 ohms =3D 0;
> > +	u8 value;
> > +	struct i2c_client *client =3D ds1374->client;
> > +
> > +	if (of_property_read_u32(client->dev.of_node, "trickle-resistor-ohms",
> > +				 &ohms))
> > +		return 0;
> > +
> > +	/* Enable charger */
> > +	value =3D DS1374_TRICKLE_CHARGER_ENABLE;
> > +	if (of_property_read_bool(client->dev.of_node, "trickle-diode-disable=
"))
> > +		value |=3D DS1374_TRICKLE_CHARGER_NO_DIODE;
> > +	else
> > +		value |=3D DS1374_TRICKLE_CHARGER_DIODE;
> > +
> > +	/* Resistor select */
> > +	switch (ohms) {
> > +	case 250:
> > +		value |=3D DS1374_TRICKLE_CHARGER_250_OHM;
> > +		break;
> > +	case 2000:
> > +		value |=3D DS1374_TRICKLE_CHARGER_2K_OHM;
> > +		break;
> > +	case 4000:
> > +		value |=3D DS1374_TRICKLE_CHARGER_4K_OHM;
> > +		break;
> > +	default:
> > +		dev_warn(&client->dev,
> > +			 "Unsupported ohm value %02ux in dt\n", ohms);
> > +		return -EINVAL;
> > +	}
> > +	dev_dbg(&client->dev, "Trickle charge value is 0x%02x\n", value);
> > +
> > +	return regmap_write(ds1374->regmap, DS1374_REG_TCR, value);
> > +}
> > +
> > +int ds1374_read_bulk(struct ds1374 *ds1374, u32 *time, int reg, int nb=
ytes)
> > +{
> > +	u8 buf[4];
> > +	int ret;
> > +	int i;
> > +
> > +	if (WARN_ON(nbytes > 4))
> > +		return -EINVAL;
> > +
> > +	ret =3D regmap_bulk_read(ds1374->regmap, reg, buf, nbytes);
> > +	if (ret) {
> > +		dev_err(&ds1374->client->dev,
> > +			"Failed to bulkread n =3D %d at R%d\n",
> > +			nbytes, reg);
> > +		return ret;
> > +	}
> > +
> > +	for (i =3D nbytes - 1, *time =3D 0; i >=3D 0; i--)
> > +		*time =3D (*time << 8) | buf[i];
>=20
> You need at least a comment to explain what's happening here.

It's an endian conversion. Can probably be replaced with normal
endian conversion functions as Guenter suggested.

I'll try to get rid of the function and use regmap_bulk_read/write
>=20
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(ds1374_read_bulk);
> > +
> > +int ds1374_write_bulk(struct ds1374 *ds1374, u32 time, int reg, int nb=
ytes)
> > +{
> > +	u8 buf[4];
> > +	int i;
> > +
> > +	if (nbytes > 4) {
> > +		WARN_ON(1);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i =3D 0; i < nbytes; i++) {
> > +		buf[i] =3D time & 0xff;
> > +		time >>=3D 8;
> > +	}
>=20
> Same here.
>=20
> > +	return regmap_bulk_write(ds1374->regmap, reg, buf, nbytes);
> > +}
> > +EXPORT_SYMBOL_GPL(ds1374_write_bulk);
> > +
> > +static int ds1374_probe(struct i2c_client *client,
> > +			const struct i2c_device_id *id)
> > +{
> > +	struct ds1374 *ds1374;
> > +	u32 mode;
> > +	int err;
> > +
> > +	ds1374 =3D devm_kzalloc(&client->dev, sizeof(struct ds1374), GFP_KERN=
EL);
> > +	if (!ds1374)
> > +		return -ENOMEM;
> > +
> > +	ds1374->regmap =3D devm_regmap_init_i2c(client, &ds1374_regmap_config=
);
> > +	if (IS_ERR(ds1374->regmap))
> > +		return PTR_ERR(ds1374->regmap);
> > +
> > +	if (IS_ENABLED(CONFIG_OF) && client->dev.of_node) {
> > +		err =3D of_property_read_u32(client->dev.of_node,
> > +					   "dallas,mode", &mode);
> > +		if (err < 0) {
> > +			dev_err(&client->dev, "missing dallas,mode property\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		ds1374->remapped_reset
> > +			=3D of_property_read_bool(client->dev.of_node,
> > +						"dallas,remap-reset");
> > +
> > +		ds1374->mode =3D (enum ds1374_mode)mode;
> > +	} else if (IS_ENABLED(CONFIG_RTC_DRV_DS1374_WDT)) {
> > +		ds1374->mode =3D DS1374_MODE_RTC_WDT;
> > +	} else {
> > +		ds1374->mode =3D DS1374_MODE_RTC_ALM;
> > +	}
>=20
> This is non-standard.  So if OF is enabled, you're taking the 'mode'
> from platform data (DT) and if it's not, you're relying on Kconfig.
> May I suggest that you pick platform data OR Kconfig, but not mix the
> two.

Yeah was a (failed) attempt to not break people that relied on the
Kconfig option. But I'm fine with just making it OF based.
>=20
> > +	ds1374->client =3D client;
> > +	ds1374->irq =3D client->irq;
> > +	i2c_set_clientdata(client, ds1374);
> > +
> > +	/* check if we're supposed to trickle charge */
>=20
> "Check".
>=20
> > +	err =3D ds1374_trickle_of_init(ds1374);
> > +	if (err) {
> > +		dev_err(&client->dev, "Failed to init trickle charger!\n");
> > +		return err;
> > +	}
> > +
> > +	/* we always have a rtc */
>=20
> "We", "an RTC".
>=20
> Or
>=20
> "The RTC is always available."
>=20
> > +	err =3D ds1374_add_device(ds1374, &ds1374_rtc_cell);
> > +	if (err)
> > +		return err;
> > +
> > +	/* we might have a watchdog if configured that way */
>=20
> "We"
>=20
> > +	if (ds1374->mode =3D=3D DS1374_MODE_RTC_WDT)
> > +		return ds1374_add_device(ds1374, &ds1374_wdt_cell);
> > +
> > +	return err;
> > +}
> > +
> > +static const struct i2c_device_id ds1374_id[] =3D {
> > +	{ "ds1374", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ds1374_id);
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id ds1374_of_match[] =3D {
> > +	{ .compatible =3D "dallas,ds1374" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ds1374_of_match);
> > +#endif
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int ds1374_suspend(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int ds1374_resume(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +#endif
>=20
> These seem pointless.
>=20
> I'm sure there will be a nice MACRO you can use instead.

Yeah, will fix.
>=20
> > +static SIMPLE_DEV_PM_OPS(ds1374_pm, ds1374_suspend, ds1374_resume);
> > +
> > +static struct i2c_driver ds1374_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "ds1374",
> > +		.of_match_table =3D of_match_ptr(ds1374_of_match),
> > +		.pm =3D &ds1374_pm,
> > +	},
> > +	.probe =3D ds1374_probe,
> > +	.id_table =3D ds1374_id,
> > +};
> > +
> > +static int __init ds1374_init(void)
> > +{
> > +	return i2c_add_driver(&ds1374_driver);
> > +}
> > +subsys_initcall(ds1374_init);
> > +
> > +static void __exit ds1374_exit(void)
> > +{
> > +	i2c_del_driver(&ds1374_driver);
> > +}
> > +module_exit(ds1374_exit);
> > +
> > +MODULE_AUTHOR("Moritz Fischer <mdf@kernel.org>");
> > +MODULE_DESCRIPTION("Maxim/Dallas DS1374 MFD Driver");
> > +MODULE_LICENSE("GPL");
>=20
> This conflicts with your header.
>=20
> [...]
>=20
> > diff --git a/include/dt-bindings/mfd/ds1374.h b/include/dt-bindings/mfd=
/ds1374.h
> > new file mode 100644
> > index 0000000..b33cd5e
> > --- /dev/null
> > +++ b/include/dt-bindings/mfd/ds1374.h
> > @@ -0,0 +1,17 @@
> > +/*
> > + * This header provides macros for Maxim/Dallas DS1374 DT bindings
> > + *
> > + * Copyright (C) 2017 National Instruments Corp
> > + *
> > + * SPDX-License-Identifier: GPL-2.0
> > + *
>=20
> This line is superfluous.
>=20
> > + */
> > +
> > +#ifndef __DT_BINDINGS_MFD_DS1374_H__
> > +#define __DT_BINDINGS_MFD_DS1374_H__
> > +
> > +#define DALLAS_MODE_RTC		0
> > +#define DALLAS_MODE_ALM		1
> > +#define DALLAS_MODE_WDT		2
>=20
> What's stopping these becoming out of line with the #defines in the
> other header file?  You should probably use these for comparison
> instead.
>=20
> > +#endif /* __DT_BINDINGS_MFD_DS1374_H__ */
> > diff --git a/include/linux/mfd/ds1374.h b/include/linux/mfd/ds1374.h
> > new file mode 100644
> > index 0000000..7b697f8
> > --- /dev/null
> > +++ b/include/linux/mfd/ds1374.h
> > @@ -0,0 +1,59 @@
> > +/*
> > + * Copyright (c) 2017, National Instruments Corp.
> > + *
> > + * Multi Function Device for Dallas/Maxim DS1374 RTC/WDT
>=20
> "Functional"
>=20
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
>=20
> Do you have to use the long licence here?
Nope, will replace with SPDX.
>=20
> > + */
> > +
> > +#ifndef MFD_DS1374_H
> > +#define MFD_DS1374_H
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/regmap.h>
> > +
> > +enum ds1374_mode {
> > +	DS1374_MODE_RTC_ONLY,
> > +	DS1374_MODE_RTC_ALM,
> > +	DS1374_MODE_RTC_WDT,
> > +};
>=20
> Please see above.

Yeah, will get rid of them.
>=20
> > +/* Register definitions to for all subdrivers
> > + */
> > +#define DS1374_REG_TOD0		0x00 /* Time of Day */
> > +#define DS1374_REG_TOD1		0x01
> > +#define DS1374_REG_TOD2		0x02
> > +#define DS1374_REG_TOD3		0x03
> > +#define DS1374_REG_WDALM0	0x04 /* Watchdog/Alarm */
> > +#define DS1374_REG_WDALM1	0x05
> > +#define DS1374_REG_WDALM2	0x06
> > +#define DS1374_REG_CR		0x07 /* Control */
> > +#define DS1374_REG_CR_AIE	0x01 /* Alarm Int. Enable */
> > +#define DS1374_REG_CR_WDSTR	0x08 /* 1=3DReset on INT, 0=3DRreset on RS=
T */
> > +#define DS1374_REG_CR_WDALM	0x20 /* 1=3DWatchdog, 0=3DAlarm */
> > +#define DS1374_REG_CR_WACE	0x40 /* WD/Alarm counter enable */
> > +#define DS1374_REG_SR		0x08 /* Status */
> > +#define DS1374_REG_SR_OSF	0x80 /* Oscillator Stop Flag */
> > +#define DS1374_REG_SR_AF	0x01 /* Alarm Flag */
> > +#define DS1374_REG_TCR		0x09 /* Trickle Charge */
> > +
> > +struct ds1374 {
> > +	struct i2c_client *client;
> > +	struct regmap *regmap;
> > +	int irq;
> > +	enum ds1374_mode mode;
> > +	bool remapped_reset;
> > +};
>=20
> This could do with a KernelDoc header.
>=20
> > +int ds1374_read_bulk(struct ds1374 *ds1374, u32 *time, int reg, int nb=
ytes);
> > +
> > +int ds1374_write_bulk(struct ds1374 *ds1374, u32 time, int reg, int nb=
ytes);
>=20
> Do these two just read time?
>=20
> If so, the nomenclature could be improved.

The can most likely be replaced completely by regmap_bulk_read()/write()
>=20
> > +#endif /* MFD_DS1374_H */
>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

Thanks for your feedback,

Moritz

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZbP5vAAoJEL5CEHepFqovB5UH/j1FYsrXUj062MU73zTAp4rv
x10X4bD+zbGOI8UELhwMGp+9EZ06BoWWFCjIfuCYTC/IpunrXZCbJ/uDRQFrjhUV
PsPz7xBkZBI9hpa1koJGLgUdEA4ultdM7RK+GpFJ2dStzJlU34DsKQGV7QQ4h6hc
KnH25XKbXCfEqRjRV4IbV7xTzxcWMnkSDPKog66IMoz3sDehoXwUkQ8nXy4AQMyF
JurFeZzfhiA0XJ8CI0seiIIO1Z/Dxy8c88PEVJQPR0eUZT7blk7dOQClXAlP/xMj
lbYHNpwmRjoFZTjpCoUP7EpOl74ubb7t6qh4jMckfcy83/lqQlKayZDeMF1yAfk=
=4c6o
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
