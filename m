Return-Path: <moritz.fischer@ettus.com>
Return-path: <moritz.fischer@ettus.com>
Date: Fri, 14 Jul 2017 09:54:23 -0700
From: Moritz Fischer <mdf@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Moritz Fischer <mdf@kernel.org>, lee.jones@linaro.org,
	robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, wim@iguana.be,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org,
	Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [PATCH 2/2] mfd: ds1374: Add Dallas/Maxim DS1374 Multi Function
 Device
Message-ID: <20170714165423.GA9283@tyrael.ni.corp.natinst.com>
References: <1499975665-14581-1-git-send-email-mdf@kernel.org>
 <1499975665-14581-2-git-send-email-mdf@kernel.org>
 <c37eaed9-10aa-190e-fa0e-bdce9277664b@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <c37eaed9-10aa-190e-fa0e-bdce9277664b@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Thu, Jul 13, 2017 at 08:57:52PM -0700, Guenter Roeck wrote:
> On 07/13/2017 12:54 PM, Moritz Fischer wrote:
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
>=20
> [ Only reviewing watchdog part ]
>=20
> > ---
> >   drivers/mfd/Kconfig              |  10 +
> >   drivers/mfd/Makefile             |   1 +
> >   drivers/mfd/ds1374.c             | 260 ++++++++++++++++
> >   drivers/rtc/rtc-ds1374.c         | 639 ++++++++++--------------------=
---------
> >   drivers/watchdog/Kconfig         |  10 +
> >   drivers/watchdog/Makefile        |   1 +
> >   drivers/watchdog/ds1374-wdt.c    | 208 +++++++++++++
> >   include/dt-bindings/mfd/ds1374.h |  17 ++
> >   include/linux/mfd/ds1374.h       |  59 ++++
> >   9 files changed, 722 insertions(+), 483 deletions(-)
> >   create mode 100644 drivers/mfd/ds1374.c
> >   create mode 100644 drivers/watchdog/ds1374-wdt.c
> >   create mode 100644 include/dt-bindings/mfd/ds1374.h
> >   create mode 100644 include/linux/mfd/ds1374.h
> >=20
>=20
> If possible, it might be better to split the patch into multiple parts, o=
ne per subsystem.

I'll have to think about that some more ;-)
>=20
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 3eb5c93..2dfef3c 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -203,6 +203,16 @@ config MFD_CROS_EC_SPI
> >   	  response time cannot be guaranteed, we support ignoring
> >   	  'pre-amble' bytes before the response actually starts.
> > +config MFD_DS1374
> > +	tristate "Dallas/Maxim DS1374 RTC/WDT/ALARM (I2C)"
> > +	select MFD_CORE
> > +	depends on I2C
> > +	depends on REGMAP_I2C
> > +
> > +	 ---help---
> > +	  This driver supports the Dallas Maxim DS1374 multi function chip.
> > +	  The chip combines an RTC, trickle charger, Watchdog or Alarm.
> > +
> >   config MFD_ASIC3
> >   	bool "Compaq ASIC3"
> >   	depends on GPIOLIB && ARM
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index c16bf1e..b5cfcf4 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -15,6 +15,7 @@ cros_ec_core-$(CONFIG_ACPI)	+=3D cros_ec_acpi_gpe.o
> >   obj-$(CONFIG_MFD_CROS_EC)	+=3D cros_ec_core.o
> >   obj-$(CONFIG_MFD_CROS_EC_I2C)	+=3D cros_ec_i2c.o
> >   obj-$(CONFIG_MFD_CROS_EC_SPI)	+=3D cros_ec_spi.o
> > +obj-$(CONFIG_MFD_DS1374)	+=3D ds1374.o
> >   obj-$(CONFIG_MFD_EXYNOS_LPASS)	+=3D exynos-lpass.o
> >   rtsx_pci-objs			:=3D rtsx_pcr.o rts5209.o rts5229.o rtl8411.o rts5227=
=2Eo rts5249.o
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
> > + *
> > + * The trickle charger code was taken more ore less 1:1 from
> > + * drivers/rtc/rtc-1390.c
> > + *
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
> > +
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
> > +
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
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D DS1374_REG_TCR,
> > +	.volatile_table	=3D &ds1374_volatile_table,
> > +	.cache_type	=3D REGCACHE_RBTREE,
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
> > +
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
> > +
>=20
> I think those functions should go away; the calling code can use standard
> endianness conversion functions and call regmap_bulk_{read,write} directl=
y.

Sounds good. I just ported over the code that had been there, but
cleaning up is always a good idea :)

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
> > +
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
> > +
> > +	ds1374->client =3D client;
> > +	ds1374->irq =3D client->irq;
> > +	i2c_set_clientdata(client, ds1374);
> > +
> > +	/* check if we're supposed to trickle charge */
> > +	err =3D ds1374_trickle_of_init(ds1374);
> > +	if (err) {
> > +		dev_err(&client->dev, "Failed to init trickle charger!\n");
> > +		return err;
> > +	}
> > +
> > +	/* we always have a rtc */
> > +	err =3D ds1374_add_device(ds1374, &ds1374_rtc_cell);
> > +	if (err)
> > +		return err;
> > +
> > +	/* we might have a watchdog if configured that way */
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
> > +
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
> > diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
> > index 52429f0..29ce1a9 100644
> > --- a/drivers/rtc/rtc-ds1374.c
> > +++ b/drivers/rtc/rtc-ds1374.c
> > @@ -1,75 +1,38 @@
> >   /*
> > - * RTC client/driver for the Maxim/Dallas DS1374 Real-Time Clock over =
I2C
> > + * RTC driver for the Maxim/Dallas DS1374 Real-Time Clock via MFD
> >    *
> >    * Based on code by Randy Vinson <rvinson@mvista.com>,
> >    * which was based on the m41t00.c by Mark Greer <mgreer@mvista.com>.
> >    *
> > + * Copyright (C) 2017 National Instruments Corp
> >    * Copyright (C) 2014 Rose Technology
> >    * Copyright (C) 2006-2007 Freescale Semiconductor
> >    *
> > + * SPDX-License-Identifier: GPL-2.0
> > + *
> >    * 2005 (c) MontaVista Software, Inc. This file is licensed under
> >    * the terms of the GNU General Public License version 2. This program
> >    * is licensed "as is" without any warranty of any kind, whether expr=
ess
> >    * or implied.
> >    */
> > -/*
> > - * It would be more efficient to use i2c msgs/i2c_transfer directly bu=
t, as
> > - * recommened in .../Documentation/i2c/writing-clients section
> > - * "Sending and receiving", using SMBus level communication is preferr=
ed.
> > - */
> >   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> >   #include <linux/interrupt.h>
> > -#include <linux/i2c.h>
> >   #include <linux/rtc.h>
> >   #include <linux/bcd.h>
> >   #include <linux/workqueue.h>
> >   #include <linux/slab.h>
> >   #include <linux/pm.h>
> > -#ifdef CONFIG_RTC_DRV_DS1374_WDT
> > -#include <linux/fs.h>
> > -#include <linux/ioctl.h>
> > -#include <linux/miscdevice.h>
> > -#include <linux/reboot.h>
> > -#include <linux/watchdog.h>
> > -#endif
> > -
> > -#define DS1374_REG_TOD0		0x00 /* Time of Day */
> > -#define DS1374_REG_TOD1		0x01
> > -#define DS1374_REG_TOD2		0x02
> > -#define DS1374_REG_TOD3		0x03
> > -#define DS1374_REG_WDALM0	0x04 /* Watchdog/Alarm */
> > -#define DS1374_REG_WDALM1	0x05
> > -#define DS1374_REG_WDALM2	0x06
> > -#define DS1374_REG_CR		0x07 /* Control */
> > -#define DS1374_REG_CR_AIE	0x01 /* Alarm Int. Enable */
> > -#define DS1374_REG_CR_WDALM	0x20 /* 1=3DWatchdog, 0=3DAlarm */
> > -#define DS1374_REG_CR_WACE	0x40 /* WD/Alarm counter enable */
> > -#define DS1374_REG_SR		0x08 /* Status */
> > -#define DS1374_REG_SR_OSF	0x80 /* Oscillator Stop Flag */
> > -#define DS1374_REG_SR_AF	0x01 /* Alarm Flag */
> > -#define DS1374_REG_TCR		0x09 /* Trickle Charge */
> > -
> > -static const struct i2c_device_id ds1374_id[] =3D {
> > -	{ "ds1374", 0 },
> > -	{ }
> > -};
> > -MODULE_DEVICE_TABLE(i2c, ds1374_id);
> > +#include <linux/regmap.h>
> > +#include <linux/mfd/ds1374.h>
> > +#include <linux/platform_device.h>
> > -#ifdef CONFIG_OF
> > -static const struct of_device_id ds1374_of_match[] =3D {
> > -	{ .compatible =3D "dallas,ds1374" },
> > -	{ }
> > -};
> > -MODULE_DEVICE_TABLE(of, ds1374_of_match);
> > -#endif
> > -
> > -struct ds1374 {
> > -	struct i2c_client *client;
> > +struct ds1374_rtc {
> >   	struct rtc_device *rtc;
> > +	struct ds1374 *chip;
> >   	struct work_struct work;
> >   	/* The mutex protects alarm operations, and prevents a race
> > @@ -80,89 +43,44 @@ struct ds1374 {
> >   	int exiting;
> >   };
> > -static struct i2c_driver ds1374_driver;
> > -
> > -static int ds1374_read_rtc(struct i2c_client *client, u32 *time,
> > -			   int reg, int nbytes)
> > -{
> > -	u8 buf[4];
> > -	int ret;
> > -	int i;
> > -
> > -	if (WARN_ON(nbytes > 4))
> > -		return -EINVAL;
> > -
> > -	ret =3D i2c_smbus_read_i2c_block_data(client, reg, nbytes, buf);
> > -
> > -	if (ret < 0)
> > -		return ret;
> > -	if (ret < nbytes)
> > -		return -EIO;
> > -
> > -	for (i =3D nbytes - 1, *time =3D 0; i >=3D 0; i--)
> > -		*time =3D (*time << 8) | buf[i];
> > -
> > -	return 0;
> > -}
> > -
> > -static int ds1374_write_rtc(struct i2c_client *client, u32 time,
> > -			    int reg, int nbytes)
> > -{
> > -	u8 buf[4];
> > -	int i;
> > -
> > -	if (nbytes > 4) {
> > -		WARN_ON(1);
> > -		return -EINVAL;
> > -	}
> > -
> > -	for (i =3D 0; i < nbytes; i++) {
> > -		buf[i] =3D time & 0xff;
> > -		time >>=3D 8;
> > -	}
> > -
> > -	return i2c_smbus_write_i2c_block_data(client, reg, nbytes, buf);
> > -}
> > -
> > -static int ds1374_check_rtc_status(struct i2c_client *client)
> > +static int ds1374_check_rtc_status(struct ds1374_rtc *ds1374)
> >   {
> >   	int ret =3D 0;
> > -	int control, stat;
> > +	unsigned int control, stat;
> > -	stat =3D i2c_smbus_read_byte_data(client, DS1374_REG_SR);
> > -	if (stat < 0)
> > +	ret =3D regmap_read(ds1374->chip->regmap, DS1374_REG_SR, &stat);
> > +	if (ret)
> >   		return stat;
> >   	if (stat & DS1374_REG_SR_OSF)
> > -		dev_warn(&client->dev,
> > +		dev_warn(&ds1374->chip->client->dev,
> >   			 "oscillator discontinuity flagged, time unreliable\n");
> > -	stat &=3D ~(DS1374_REG_SR_OSF | DS1374_REG_SR_AF);
> > -
> > -	ret =3D i2c_smbus_write_byte_data(client, DS1374_REG_SR, stat);
> > -	if (ret < 0)
> > +	ret =3D regmap_update_bits(ds1374->chip->regmap, DS1374_REG_SR,
> > +				 DS1374_REG_SR_OSF | DS1374_REG_SR_AF, 0);
> > +	if (ret)
> >   		return ret;
> >   	/* If the alarm is pending, clear it before requesting
> >   	 * the interrupt, so an interrupt event isn't reported
> >   	 * before everything is initialized.
> >   	 */
> > -
> > -	control =3D i2c_smbus_read_byte_data(client, DS1374_REG_CR);
> > -	if (control < 0)
> > -		return control;
> > +	ret =3D regmap_read(ds1374->chip->regmap, DS1374_REG_CR, &control);
> > +	if (ret)
> > +		return ret;
> >   	control &=3D ~(DS1374_REG_CR_WACE | DS1374_REG_CR_AIE);
> > -	return i2c_smbus_write_byte_data(client, DS1374_REG_CR, control);
> > +	return regmap_write(ds1374->chip->regmap, DS1374_REG_CR, control);
> >   }
> >   static int ds1374_read_time(struct device *dev, struct rtc_time *time)
> >   {
> > -	struct i2c_client *client =3D to_i2c_client(dev);
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct ds1374_rtc *ds1374_rtc =3D platform_get_drvdata(pdev);
> >   	u32 itime;
> >   	int ret;
> > -	ret =3D ds1374_read_rtc(client, &itime, DS1374_REG_TOD0, 4);
> > +	ret =3D ds1374_read_bulk(ds1374_rtc->chip, &itime, DS1374_REG_TOD0, 4=
);
> >   	if (!ret)
> >   		rtc_time_to_tm(itime, time);
> > @@ -171,44 +89,47 @@ static int ds1374_read_time(struct device *dev, st=
ruct rtc_time *time)
> >   static int ds1374_set_time(struct device *dev, struct rtc_time *time)
> >   {
> > -	struct i2c_client *client =3D to_i2c_client(dev);
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct ds1374_rtc *ds1374_rtc =3D platform_get_drvdata(pdev);
> >   	unsigned long itime;
> >   	rtc_tm_to_time(time, &itime);
> > -	return ds1374_write_rtc(client, itime, DS1374_REG_TOD0, 4);
> > +	return ds1374_write_bulk(ds1374_rtc->chip, itime, DS1374_REG_TOD0, 4);
> >   }
> > -#ifndef CONFIG_RTC_DRV_DS1374_WDT
> >   /* The ds1374 has a decrementer for an alarm, rather than a comparato=
r.
> >    * If the time of day is changed, then the alarm will need to be
> >    * reset.
> >    */
> >   static int ds1374_read_alarm(struct device *dev, struct rtc_wkalrm *a=
larm)
> >   {
> > -	struct i2c_client *client =3D to_i2c_client(dev);
> > -	struct ds1374 *ds1374 =3D i2c_get_clientdata(client);
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct ds1374_rtc *ds1374_rtc =3D platform_get_drvdata(pdev);
> > +	struct ds1374 *ds1374 =3D ds1374_rtc->chip;
> > +
> >   	u32 now, cur_alarm;
> > -	int cr, sr;
> > +	unsigned int cr, sr;
> >   	int ret =3D 0;
> > -	if (client->irq <=3D 0)
> > +	if (ds1374->irq <=3D 0)
> >   		return -EINVAL;
> > -	mutex_lock(&ds1374->mutex);
> > +	mutex_lock(&ds1374_rtc->mutex);
> > -	cr =3D ret =3D i2c_smbus_read_byte_data(client, DS1374_REG_CR);
> > +	ret =3D regmap_read(ds1374->regmap, DS1374_REG_CR, &cr);
> >   	if (ret < 0)
> >   		goto out;
> > -	sr =3D ret =3D i2c_smbus_read_byte_data(client, DS1374_REG_SR);
> > +	ret =3D regmap_read(ds1374->regmap, DS1374_REG_SR, &sr);
> >   	if (ret < 0)
> >   		goto out;
> > -	ret =3D ds1374_read_rtc(client, &now, DS1374_REG_TOD0, 4);
> > +	ret =3D ds1374_read_bulk(ds1374_rtc->chip, &now, DS1374_REG_TOD0, 4);
> >   	if (ret)
> >   		goto out;
> > -	ret =3D ds1374_read_rtc(client, &cur_alarm, DS1374_REG_WDALM0, 3);
> > +	ret =3D ds1374_read_bulk(ds1374_rtc->chip, &cur_alarm,
> > +			       DS1374_REG_WDALM0, 3);
> >   	if (ret)
> >   		goto out;
> > @@ -217,20 +138,21 @@ static int ds1374_read_alarm(struct device *dev, =
struct rtc_wkalrm *alarm)
> >   	alarm->pending =3D !!(sr & DS1374_REG_SR_AF);
> >   out:
> > -	mutex_unlock(&ds1374->mutex);
> > +	mutex_unlock(&ds1374_rtc->mutex);
> >   	return ret;
> >   }
> >   static int ds1374_set_alarm(struct device *dev, struct rtc_wkalrm *al=
arm)
> >   {
> > -	struct i2c_client *client =3D to_i2c_client(dev);
> > -	struct ds1374 *ds1374 =3D i2c_get_clientdata(client);
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct ds1374_rtc *ds1374_rtc =3D platform_get_drvdata(pdev);
> > +	struct ds1374 *ds1374 =3D ds1374_rtc->chip;
> > +
> >   	struct rtc_time now;
> >   	unsigned long new_alarm, itime;
> > -	int cr;
> >   	int ret =3D 0;
> > -	if (client->irq <=3D 0)
> > +	if (ds1374->irq <=3D 0)
> >   		return -EINVAL;
> >   	ret =3D ds1374_read_time(dev, &now);
> > @@ -251,468 +173,219 @@ static int ds1374_set_alarm(struct device *dev,=
 struct rtc_wkalrm *alarm)
> >   	else
> >   		new_alarm -=3D itime;
> > -	mutex_lock(&ds1374->mutex);
> > -
> > -	ret =3D cr =3D i2c_smbus_read_byte_data(client, DS1374_REG_CR);
> > -	if (ret < 0)
> > -		goto out;
> > +	mutex_lock(&ds1374_rtc->mutex);
> >   	/* Disable any existing alarm before setting the new one
> > -	 * (or lack thereof). */
> > -	cr &=3D ~DS1374_REG_CR_WACE;
> > -
> > -	ret =3D i2c_smbus_write_byte_data(client, DS1374_REG_CR, cr);
> > -	if (ret < 0)
> > -		goto out;
> > +	 * (or lack thereof).
> > +	 */
> > +	ret =3D regmap_update_bits(ds1374->regmap, DS1374_REG_CR,
> > +				 DS1374_REG_CR_WACE, 0);
> > -	ret =3D ds1374_write_rtc(client, new_alarm, DS1374_REG_WDALM0, 3);
> > +	ret =3D ds1374_write_bulk(ds1374_rtc->chip, new_alarm,
> > +				DS1374_REG_WDALM0, 3);
> >   	if (ret)
> >   		goto out;
> >   	if (alarm->enabled) {
> > -		cr |=3D DS1374_REG_CR_WACE | DS1374_REG_CR_AIE;
> > -		cr &=3D ~DS1374_REG_CR_WDALM;
> > -
> > -		ret =3D i2c_smbus_write_byte_data(client, DS1374_REG_CR, cr);
> > +		ret =3D regmap_update_bits(ds1374->regmap, DS1374_REG_CR,
> > +					 DS1374_REG_CR_WACE | DS1374_REG_CR_AIE
> > +					 | DS1374_REG_CR_WDALM,
> > +					 DS1374_REG_CR_WACE
> > +					 | DS1374_REG_CR_AIE);
> >   	}
> >   out:
> > -	mutex_unlock(&ds1374->mutex);
> > +	mutex_unlock(&ds1374_rtc->mutex);
> >   	return ret;
> >   }
> > -#endif
> >   static irqreturn_t ds1374_irq(int irq, void *dev_id)
> >   {
> > -	struct i2c_client *client =3D dev_id;
> > -	struct ds1374 *ds1374 =3D i2c_get_clientdata(client);
> > +	struct ds1374_rtc *ds1374_rtc =3D dev_id;
> >   	disable_irq_nosync(irq);
> > -	schedule_work(&ds1374->work);
> > +	schedule_work(&ds1374_rtc->work);
> >   	return IRQ_HANDLED;
> >   }
> >   static void ds1374_work(struct work_struct *work)
> >   {
> > -	struct ds1374 *ds1374 =3D container_of(work, struct ds1374, work);
> > -	struct i2c_client *client =3D ds1374->client;
> > -	int stat, control;
> > +	struct ds1374_rtc *ds1374_rtc =3D container_of(work, struct ds1374_rt=
c,
> > +						     work);
> > +	unsigned int stat;
> > +	int ret;
> > -	mutex_lock(&ds1374->mutex);
> > +	mutex_lock(&ds1374_rtc->mutex);
> > -	stat =3D i2c_smbus_read_byte_data(client, DS1374_REG_SR);
> > -	if (stat < 0)
> > +	ret =3D regmap_read(ds1374_rtc->chip->regmap, DS1374_REG_SR, &stat);
> > +	if (ret)
> >   		goto unlock;
> >   	if (stat & DS1374_REG_SR_AF) {
> > -		stat &=3D ~DS1374_REG_SR_AF;
> > -		i2c_smbus_write_byte_data(client, DS1374_REG_SR, stat);
> > -
> > -		control =3D i2c_smbus_read_byte_data(client, DS1374_REG_CR);
> > -		if (control < 0)
> > +		regmap_update_bits(ds1374_rtc->chip->regmap, DS1374_REG_SR,
> > +				   DS1374_REG_SR_AF, 0);
> > +
> > +		ret =3D regmap_update_bits(ds1374_rtc->chip->regmap,
> > +					 DS1374_REG_CR, DS1374_REG_CR_WACE
> > +					 | DS1374_REG_CR_AIE,
> > +					 0);
> > +		if (ret)
> >   			goto out;
> > -		control &=3D ~(DS1374_REG_CR_WACE | DS1374_REG_CR_AIE);
> > -		i2c_smbus_write_byte_data(client, DS1374_REG_CR, control);
> > -
> > -		rtc_update_irq(ds1374->rtc, 1, RTC_AF | RTC_IRQF);
> > +		rtc_update_irq(ds1374_rtc->rtc, 1, RTC_AF | RTC_IRQF);
> >   	}
> >   out:
> > -	if (!ds1374->exiting)
> > -		enable_irq(client->irq);
> > +	if (!ds1374_rtc->exiting)
> > +		enable_irq(ds1374_rtc->chip->irq);
> >   unlock:
> > -	mutex_unlock(&ds1374->mutex);
> > +	mutex_unlock(&ds1374_rtc->mutex);
> >   }
> > -#ifndef CONFIG_RTC_DRV_DS1374_WDT
> >   static int ds1374_alarm_irq_enable(struct device *dev, unsigned int e=
nabled)
> >   {
> > -	struct i2c_client *client =3D to_i2c_client(dev);
> > -	struct ds1374 *ds1374 =3D i2c_get_clientdata(client);
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct ds1374_rtc *ds1374 =3D platform_get_drvdata(pdev);
> > +	unsigned int cr;
> >   	int ret;
> >   	mutex_lock(&ds1374->mutex);
> > -	ret =3D i2c_smbus_read_byte_data(client, DS1374_REG_CR);
> > +	ret =3D regmap_read(ds1374->chip->regmap, DS1374_REG_CR, &cr);
> >   	if (ret < 0)
> >   		goto out;
> > -	if (enabled) {
> > -		ret |=3D DS1374_REG_CR_WACE | DS1374_REG_CR_AIE;
> > -		ret &=3D ~DS1374_REG_CR_WDALM;
> > -	} else {
> > -		ret &=3D ~DS1374_REG_CR_WACE;
> > -	}
> > -	ret =3D i2c_smbus_write_byte_data(client, DS1374_REG_CR, ret);
> > -
> > +	if (enabled)
> > +		regmap_update_bits(ds1374->chip->regmap, DS1374_REG_CR,
> > +				   DS1374_REG_CR_WACE | DS1374_REG_CR_AIE |
> > +			   DS1374_REG_CR_WDALM, DS1374_REG_CR_WACE |
> > +			   DS1374_REG_CR_AIE);
> > +	else
> > +		regmap_update_bits(ds1374->chip->regmap, DS1374_REG_CR,
> > +				   DS1374_REG_CR_WACE, 0);
> >   out:
> >   	mutex_unlock(&ds1374->mutex);
> >   	return ret;
> >   }
> > -#endif
> > -static const struct rtc_class_ops ds1374_rtc_ops =3D {
> > +static const struct rtc_class_ops ds1374_rtc_alm_ops =3D {
> >   	.read_time =3D ds1374_read_time,
> >   	.set_time =3D ds1374_set_time,
> > -#ifndef CONFIG_RTC_DRV_DS1374_WDT
> >   	.read_alarm =3D ds1374_read_alarm,
> >   	.set_alarm =3D ds1374_set_alarm,
> >   	.alarm_irq_enable =3D ds1374_alarm_irq_enable,
> > -#endif
> >   };
> > -#ifdef CONFIG_RTC_DRV_DS1374_WDT
> > -/*
> > - *********************************************************************=
********
> > - *
> > - * Watchdog Driver
> > - *
> > - *********************************************************************=
********
> > - */
> > -static struct i2c_client *save_client;
> > -/* Default margin */
> > -#define WD_TIMO 131762
> > -
> > -#define DRV_NAME "DS1374 Watchdog"
> > -
> > -static int wdt_margin =3D WD_TIMO;
> > -static unsigned long wdt_is_open;
> > -module_param(wdt_margin, int, 0);
> > -MODULE_PARM_DESC(wdt_margin, "Watchdog timeout in seconds (default 32s=
)");
> > -
> > -static const struct watchdog_info ds1374_wdt_info =3D {
> > -	.identity       =3D "DS1374 WTD",
> > -	.options        =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> > -						WDIOF_MAGICCLOSE,
> > -};
> > -
> > -static int ds1374_wdt_settimeout(unsigned int timeout)
> > -{
> > -	int ret =3D -ENOIOCTLCMD;
> > -	int cr;
> > -
> > -	ret =3D cr =3D i2c_smbus_read_byte_data(save_client, DS1374_REG_CR);
> > -	if (ret < 0)
> > -		goto out;
> > -
> > -	/* Disable any existing watchdog/alarm before setting the new one */
> > -	cr &=3D ~DS1374_REG_CR_WACE;
> > -
> > -	ret =3D i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
> > -	if (ret < 0)
> > -		goto out;
> > -
> > -	/* Set new watchdog time */
> > -	ret =3D ds1374_write_rtc(save_client, timeout, DS1374_REG_WDALM0, 3);
> > -	if (ret) {
> > -		pr_info("couldn't set new watchdog time\n");
> > -		goto out;
> > -	}
> > -
> > -	/* Enable watchdog timer */
> > -	cr |=3D DS1374_REG_CR_WACE | DS1374_REG_CR_WDALM;
> > -	cr &=3D ~DS1374_REG_CR_AIE;
> > -
> > -	ret =3D i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
> > -	if (ret < 0)
> > -		goto out;
> > -
> > -	return 0;
> > -out:
> > -	return ret;
> > -}
> > -
> > -
> > -/*
> > - * Reload the watchdog timer.  (ie, pat the watchdog)
> > - */
> > -static void ds1374_wdt_ping(void)
> > -{
> > -	u32 val;
> > -	int ret =3D 0;
> > -
> > -	ret =3D ds1374_read_rtc(save_client, &val, DS1374_REG_WDALM0, 3);
> > -	if (ret)
> > -		pr_info("WD TICK FAIL!!!!!!!!!! %i\n", ret);
> > -}
> > -
> > -static void ds1374_wdt_disable(void)
> > -{
> > -	int ret =3D -ENOIOCTLCMD;
> > -	int cr;
> > -
> > -	cr =3D i2c_smbus_read_byte_data(save_client, DS1374_REG_CR);
> > -	/* Disable watchdog timer */
> > -	cr &=3D ~DS1374_REG_CR_WACE;
> > -
> > -	ret =3D i2c_smbus_write_byte_data(save_client, DS1374_REG_CR, cr);
> > -}
> > -
> > -/*
> > - * Watchdog device is opened, and watchdog starts running.
> > - */
> > -static int ds1374_wdt_open(struct inode *inode, struct file *file)
> > -{
> > -	struct ds1374 *ds1374 =3D i2c_get_clientdata(save_client);
> > -
> > -	if (MINOR(inode->i_rdev) =3D=3D WATCHDOG_MINOR) {
> > -		mutex_lock(&ds1374->mutex);
> > -		if (test_and_set_bit(0, &wdt_is_open)) {
> > -			mutex_unlock(&ds1374->mutex);
> > -			return -EBUSY;
> > -		}
> > -		/*
> > -		 *      Activate
> > -		 */
> > -		wdt_is_open =3D 1;
> > -		mutex_unlock(&ds1374->mutex);
> > -		return nonseekable_open(inode, file);
> > -	}
> > -	return -ENODEV;
> > -}
> > -
> > -/*
> > - * Close the watchdog device.
> > - */
> > -static int ds1374_wdt_release(struct inode *inode, struct file *file)
> > -{
> > -	if (MINOR(inode->i_rdev) =3D=3D WATCHDOG_MINOR)
> > -		clear_bit(0, &wdt_is_open);
> > -
> > -	return 0;
> > -}
> > -
> > -/*
> > - * Pat the watchdog whenever device is written to.
> > - */
> > -static ssize_t ds1374_wdt_write(struct file *file, const char __user *=
data,
> > -				size_t len, loff_t *ppos)
> > -{
> > -	if (len) {
> > -		ds1374_wdt_ping();
> > -		return 1;
> > -	}
> > -	return 0;
> > -}
> > -
> > -static ssize_t ds1374_wdt_read(struct file *file, char __user *data,
> > -				size_t len, loff_t *ppos)
> > -{
> > -	return 0;
> > -}
> > -
> > -/*
> > - * Handle commands from user-space.
> > - */
> > -static long ds1374_wdt_ioctl(struct file *file, unsigned int cmd,
> > -							unsigned long arg)
> > -{
> > -	int new_margin, options;
> > -
> > -	switch (cmd) {
> > -	case WDIOC_GETSUPPORT:
> > -		return copy_to_user((struct watchdog_info __user *)arg,
> > -		&ds1374_wdt_info, sizeof(ds1374_wdt_info)) ? -EFAULT : 0;
> > -
> > -	case WDIOC_GETSTATUS:
> > -	case WDIOC_GETBOOTSTATUS:
> > -		return put_user(0, (int __user *)arg);
> > -	case WDIOC_KEEPALIVE:
> > -		ds1374_wdt_ping();
> > -		return 0;
> > -	case WDIOC_SETTIMEOUT:
> > -		if (get_user(new_margin, (int __user *)arg))
> > -			return -EFAULT;
> > -
> > -		if (new_margin < 1 || new_margin > 16777216)
> > -			return -EINVAL;
> > -
> > -		wdt_margin =3D new_margin;
> > -		ds1374_wdt_settimeout(new_margin);
> > -		ds1374_wdt_ping();
> > -		/* fallthrough */
> > -	case WDIOC_GETTIMEOUT:
> > -		return put_user(wdt_margin, (int __user *)arg);
> > -	case WDIOC_SETOPTIONS:
> > -		if (copy_from_user(&options, (int __user *)arg, sizeof(int)))
> > -			return -EFAULT;
> > -
> > -		if (options & WDIOS_DISABLECARD) {
> > -			pr_info("disable watchdog\n");
> > -			ds1374_wdt_disable();
> > -		}
> > -
> > -		if (options & WDIOS_ENABLECARD) {
> > -			pr_info("enable watchdog\n");
> > -			ds1374_wdt_settimeout(wdt_margin);
> > -			ds1374_wdt_ping();
> > -		}
> > -
> > -		return -EINVAL;
> > -	}
> > -	return -ENOTTY;
> > -}
> > -
> > -static long ds1374_wdt_unlocked_ioctl(struct file *file, unsigned int =
cmd,
> > -			unsigned long arg)
> > -{
> > -	int ret;
> > -	struct ds1374 *ds1374 =3D i2c_get_clientdata(save_client);
> > -
> > -	mutex_lock(&ds1374->mutex);
> > -	ret =3D ds1374_wdt_ioctl(file, cmd, arg);
> > -	mutex_unlock(&ds1374->mutex);
> > -
> > -	return ret;
> > -}
> > -
> > -static int ds1374_wdt_notify_sys(struct notifier_block *this,
> > -			unsigned long code, void *unused)
> > -{
> > -	if (code =3D=3D SYS_DOWN || code =3D=3D SYS_HALT)
> > -		/* Disable Watchdog */
> > -		ds1374_wdt_disable();
> > -	return NOTIFY_DONE;
> > -}
> > -
> > -static const struct file_operations ds1374_wdt_fops =3D {
> > -	.owner			=3D THIS_MODULE,
> > -	.read			=3D ds1374_wdt_read,
> > -	.unlocked_ioctl		=3D ds1374_wdt_unlocked_ioctl,
> > -	.write			=3D ds1374_wdt_write,
> > -	.open                   =3D ds1374_wdt_open,
> > -	.release                =3D ds1374_wdt_release,
> > -	.llseek			=3D no_llseek,
> > -};
> > -
> > -static struct miscdevice ds1374_miscdev =3D {
> > -	.minor          =3D WATCHDOG_MINOR,
> > -	.name           =3D "watchdog",
> > -	.fops           =3D &ds1374_wdt_fops,
> > -};
> > -
> > -static struct notifier_block ds1374_wdt_notifier =3D {
> > -	.notifier_call =3D ds1374_wdt_notify_sys,
> > +static const struct rtc_class_ops ds1374_rtc_ops =3D {
> > +	.read_time =3D ds1374_read_time,
> > +	.set_time =3D ds1374_set_time,
> >   };
> > -#endif /*CONFIG_RTC_DRV_DS1374_WDT*/
> > -/*
> > - *********************************************************************=
********
> > - *
> > - *	Driver Interface
> > - *
> > - *********************************************************************=
********
> > - */
> > -static int ds1374_probe(struct i2c_client *client,
> > -			const struct i2c_device_id *id)
> > +static int ds1374_rtc_probe(struct platform_device *pdev)
> >   {
> > -	struct ds1374 *ds1374;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct ds1374 *ds1374 =3D dev_get_drvdata(dev->parent);
> > +	struct ds1374_rtc *ds1374_rtc;
> >   	int ret;
> > -	ds1374 =3D devm_kzalloc(&client->dev, sizeof(struct ds1374), GFP_KERN=
EL);
> > -	if (!ds1374)
> > +	ds1374_rtc =3D devm_kzalloc(dev, sizeof(*ds1374_rtc), GFP_KERNEL);
> > +	if (!ds1374_rtc)
> >   		return -ENOMEM;
> > +	ds1374_rtc->chip =3D ds1374;
> > -	ds1374->client =3D client;
> > -	i2c_set_clientdata(client, ds1374);
> > +	platform_set_drvdata(pdev, ds1374_rtc);
> > -	INIT_WORK(&ds1374->work, ds1374_work);
> > -	mutex_init(&ds1374->mutex);
> > +	INIT_WORK(&ds1374_rtc->work, ds1374_work);
> > +	mutex_init(&ds1374_rtc->mutex);
> > -	ret =3D ds1374_check_rtc_status(client);
> > -	if (ret)
> > +	ret =3D ds1374_check_rtc_status(ds1374_rtc);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to check rtc status\n");
> >   		return ret;
> > +	}
> > -	if (client->irq > 0) {
> > -		ret =3D devm_request_irq(&client->dev, client->irq, ds1374_irq, 0,
> > -					"ds1374", client);
> > +	/* if the mfd device indicates is configured to run with ALM
> > +	 * try to get the IRQ
> > +	 */
> > +	if (ds1374->mode =3D=3D DS1374_MODE_RTC_ALM && ds1374->irq > 0) {
> > +		ret =3D devm_request_irq(dev, ds1374->irq,
> > +				       ds1374_irq, 0, "ds1374", ds1374_rtc);
> >   		if (ret) {
> > -			dev_err(&client->dev, "unable to request IRQ\n");
> > +			dev_err(dev, "unable to request IRQ\n");
> >   			return ret;
> >   		}
> > -		device_set_wakeup_capable(&client->dev, 1);
> > +		device_set_wakeup_capable(dev, 1);
> > +		ds1374_rtc->rtc =3D devm_rtc_device_register(dev,
> > +							   "ds1374-rtc",
> > +							   &ds1374_rtc_alm_ops,
> > +							   THIS_MODULE);
> > +	} else {
> > +		ds1374_rtc->rtc =3D devm_rtc_device_register(dev, "ds1374-rtc",
> > +							   &ds1374_rtc_ops,
> > +							   THIS_MODULE);
> >   	}
> > -	ds1374->rtc =3D devm_rtc_device_register(&client->dev, client->name,
> > -						&ds1374_rtc_ops, THIS_MODULE);
> > -	if (IS_ERR(ds1374->rtc)) {
> > -		dev_err(&client->dev, "unable to register the class device\n");
> > -		return PTR_ERR(ds1374->rtc);
> > +	if (IS_ERR(ds1374_rtc->rtc)) {
> > +		dev_err(dev, "unable to register the class device\n");
> > +		return PTR_ERR(ds1374_rtc->rtc);
> >   	}
> > -
> > -#ifdef CONFIG_RTC_DRV_DS1374_WDT
> > -	save_client =3D client;
> > -	ret =3D misc_register(&ds1374_miscdev);
> > -	if (ret)
> > -		return ret;
> > -	ret =3D register_reboot_notifier(&ds1374_wdt_notifier);
> > -	if (ret) {
> > -		misc_deregister(&ds1374_miscdev);
> > -		return ret;
> > -	}
> > -	ds1374_wdt_settimeout(131072);
> > -#endif
> > -
> >   	return 0;
> >   }
> > -static int ds1374_remove(struct i2c_client *client)
> > +static int ds1374_rtc_remove(struct platform_device *pdev)
> >   {
> > -	struct ds1374 *ds1374 =3D i2c_get_clientdata(client);
> > -#ifdef CONFIG_RTC_DRV_DS1374_WDT
> > -	misc_deregister(&ds1374_miscdev);
> > -	ds1374_miscdev.parent =3D NULL;
> > -	unregister_reboot_notifier(&ds1374_wdt_notifier);
> > -#endif
> > +	struct ds1374_rtc *ds1374_rtc =3D platform_get_drvdata(pdev);
> > -	if (client->irq > 0) {
> > -		mutex_lock(&ds1374->mutex);
> > -		ds1374->exiting =3D 1;
> > -		mutex_unlock(&ds1374->mutex);
> > +	if (ds1374_rtc->chip->irq > 0) {
> > +		mutex_lock(&ds1374_rtc->mutex);
> > +		ds1374_rtc->exiting =3D 1;
> > +		mutex_unlock(&ds1374_rtc->mutex);
> > -		devm_free_irq(&client->dev, client->irq, client);
> > -		cancel_work_sync(&ds1374->work);
> > +		devm_free_irq(&pdev->dev, ds1374_rtc->chip->irq,
> > +			      ds1374_rtc);
> > +		cancel_work_sync(&ds1374_rtc->work);
> >   	}
> >   	return 0;
> >   }
> >   #ifdef CONFIG_PM_SLEEP
> > -static int ds1374_suspend(struct device *dev)
> > +static int ds1374_rtc_suspend(struct device *dev)
> >   {
> > -	struct i2c_client *client =3D to_i2c_client(dev);
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct ds1374_rtc *ds1374_rtc =3D platform_get_drvdata(pdev);
> > -	if (client->irq > 0 && device_may_wakeup(&client->dev))
> > -		enable_irq_wake(client->irq);
> > +	if (ds1374_rtc->chip->irq > 0 && device_may_wakeup(&pdev->dev))
> > +		enable_irq_wake(ds1374_rtc->chip->irq);
> >   	return 0;
> >   }
> > -static int ds1374_resume(struct device *dev)
> > +static int ds1374_rtc_resume(struct device *dev)
> >   {
> > -	struct i2c_client *client =3D to_i2c_client(dev);
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct ds1374_rtc *ds1374_rtc =3D platform_get_drvdata(pdev);
> > -	if (client->irq > 0 && device_may_wakeup(&client->dev))
> > -		disable_irq_wake(client->irq);
> > +	if (ds1374_rtc->chip->irq > 0 && device_may_wakeup(&pdev->dev))
> > +		disable_irq_wake(ds1374_rtc->chip->irq);
> >   	return 0;
> >   }
> >   #endif
> > -static SIMPLE_DEV_PM_OPS(ds1374_pm, ds1374_suspend, ds1374_resume);
> > +static SIMPLE_DEV_PM_OPS(ds1374_rtc_pm, ds1374_rtc_suspend, ds1374_rtc=
_resume);
> > -static struct i2c_driver ds1374_driver =3D {
> > +static struct platform_driver ds1374_rtc_driver =3D {
> >   	.driver =3D {
> > -		.name =3D "rtc-ds1374",
> > -		.pm =3D &ds1374_pm,
> > +		.name =3D "ds1374-rtc",
> > +		.pm =3D &ds1374_rtc_pm,
> >   	},
> > -	.probe =3D ds1374_probe,
> > -	.remove =3D ds1374_remove,
> > -	.id_table =3D ds1374_id,
> > +	.probe =3D ds1374_rtc_probe,
> > +	.remove =3D ds1374_rtc_remove,
> >   };
> > -
> > -module_i2c_driver(ds1374_driver);
> > +module_platform_driver(ds1374_rtc_driver);
> >   MODULE_AUTHOR("Scott Wood <scottwood@freescale.com>");
> > +MODULE_AUTHOR("Moritz Fischer <mdf@kernel.org>");
> >   MODULE_DESCRIPTION("Maxim/Dallas DS1374 RTC Driver");
> >   MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:ds1374-rtc");
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 52a70ee..1703611 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -120,6 +120,16 @@ config DA9062_WATCHDOG
> >   	  This driver can be built as a module. The module name is da9062_wd=
t.
> > +config DS1374_WATCHDOG
> > +	tristate "Maxim/Dallas 1374 Watchdog"
> > +	depends on MFD_DS1374
> > +	depends on REGMAP_I2C
>=20
> depends on I2C
> select REGMAP_I2C
>=20
> but doesn't the mfd driver already depend on that ?

Yeah, will fix that.
>=20
> > +	select WATCHDOG_CORE
> > +	help
> > +	  Support for the watchdog in the Maxim/Dallas DS1374 MFD.
> > +
> > +	  This driver can be built as a module. The module name is ds1374-wdt.
> > +
> >   config GPIO_WATCHDOG
> >   	tristate "Watchdog device controlled through GPIO-line"
> >   	depends on OF_GPIO
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index a2126e2..5b3b053 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -60,6 +60,7 @@ obj-$(CONFIG_ORION_WATCHDOG) +=3D orion_wdt.o
> >   obj-$(CONFIG_SUNXI_WATCHDOG) +=3D sunxi_wdt.o
> >   obj-$(CONFIG_RN5T618_WATCHDOG) +=3D rn5t618_wdt.o
> >   obj-$(CONFIG_COH901327_WATCHDOG) +=3D coh901327_wdt.o
> > +obj-$(CONFIG_DS1374_WATCHDOG)	+=3D ds1374-wdt.o
> >   obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) +=3D stmp3xxx_rtc_wdt.o
> >   obj-$(CONFIG_NUC900_WATCHDOG) +=3D nuc900_wdt.o
> >   obj-$(CONFIG_TS4800_WATCHDOG) +=3D ts4800_wdt.o
> > diff --git a/drivers/watchdog/ds1374-wdt.c b/drivers/watchdog/ds1374-wd=
t.c
> > new file mode 100644
> > index 0000000..d221560
> > --- /dev/null
> > +++ b/drivers/watchdog/ds1374-wdt.c
> > @@ -0,0 +1,208 @@
> > +/*
> > + * Copyright (c) 2017, National Instruments Corp.
> > + *
> > + * Dallas/Maxim DS1374 Watchdog Driver, heavily based on the older
> > + * drivers/rtc/rtc-ds1374.c implementation
> > + *
> > + * SPDX-License-Identifier: GPL-2.0
> > + *
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/watchdog.h>
> > +#include <linux/slab.h>
> > +#include <linux/regmap.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/mfd/ds1374.h>
> > +
> alphabetic order, please.

Ok.
>=20
> > +#define DS1374_WDT_RATE 4096 /* Hz */
> > +#define DS1374_WDT_MIN_TIMEOUT 1 /* seconds */
> > +#define DS1374_WDT_DEFAULT_TIMEOUT 30 /* seconds */
> > +
> Please use tabs
>=20

Will do.
> > +static bool nowayout =3D WATCHDOG_NOWAYOUT;
> > +module_param(nowayout, bool, 0444);
> > +MODULE_PARM_DESC(nowayout,
> > +		 "Watchdog cannot be stopped once started (default=3D"
> > +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> > +
> > +static unsigned int timeout;
> > +module_param(timeout, int, 0444);
> > +MODULE_PARM_DESC(timeout, "Watchdog timeout");
> > +
> > +struct ds1374_wdt {
> > +	struct ds1374 *chip;
> > +	struct device *dev;
> > +	struct watchdog_device wdd;
> > +};
> > +
> > +static int ds1374_wdt_stop(struct watchdog_device *wdog)
> > +{
> > +	struct ds1374_wdt *ds1374_wdt =3D watchdog_get_drvdata(wdog);
> > +	int err;
> > +
> > +	err =3D regmap_update_bits(ds1374_wdt->chip->regmap, DS1374_REG_CR,
> > +				 DS1374_REG_CR_WACE, 0);
> > +	if (err)
> > +		return err;
> > +
> > +	if (ds1374_wdt->chip->remapped_reset)
> > +		return regmap_update_bits(ds1374_wdt->chip->regmap,
> > +					  DS1374_REG_CR, DS1374_REG_CR_WDSTR,
> > +					  0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ds1374_wdt_ping(struct watchdog_device *wdog)
> > +{
> > +	struct ds1374_wdt *ds1374_wdt =3D watchdog_get_drvdata(wdog);
> > +	u32 val;
> > +	int err;
> > +
> > +	err =3D ds1374_read_bulk(ds1374_wdt->chip, &val, DS1374_REG_WDALM0, 3=
);
>=20
> Why not just regmap_bulk_read() ?

Good catch.
>=20
> > +	if (err < 0)
> > +		return err;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ds1374_wdt_set_timeout(struct watchdog_device *wdog,
> > +				  unsigned int t)
> > +{
> > +	struct ds1374_wdt *ds1374_wdt =3D watchdog_get_drvdata(wdog);
> > +	struct regmap *regmap =3D ds1374_wdt->chip->regmap;
> > +	unsigned int timeout =3D DS1374_WDT_RATE * t;
> > +	u8 remapped =3D ds1374_wdt->chip->remapped_reset
> > +		? DS1374_REG_CR_WDSTR : 0;
>=20
> I personally prefer to split initialization from declaration if the initi=
alization
> requires continuation lines.

Yeah, it's kludgy. Will redo it.
>=20
> > +	int err;
> > +
> > +	err =3D regmap_update_bits(regmap, DS1374_REG_CR,
> > +				 DS1374_REG_CR_WACE | DS1374_REG_CR_AIE, 0);
> > +
> > +	err =3D ds1374_write_bulk(ds1374_wdt->chip, timeout,
> > +				DS1374_REG_WDALM0, 3);
>=20
> Why not just regmap_bulk_write() ?

Agreed.
>=20
> The mixed use of mfd driver functions and regmap functions is confusing.
> I think it would be better to avoid it.
>=20
> > +	if (err) {
> > +		dev_err(ds1374_wdt->dev, "couldn't set new watchdog time\n");
>=20
> Is that noise necessary ? Same elsewhere. The error is returned to user s=
pace,
> which should be sufficient.

Ok, will get rid of it.
>=20
> > +		return err;
> > +	}
> > +
> > +	ds1374_wdt->wdd.timeout =3D t;
>=20
>         wdog->timeout =3D t;
>=20
> > +
> > +	return regmap_update_bits(regmap, DS1374_REG_CR,
> > +				  (DS1374_REG_CR_WACE | DS1374_REG_CR_WDALM |
> > +				   DS1374_REG_CR_AIE | DS1374_REG_CR_WDSTR),
> > +				  (DS1374_REG_CR_WACE | DS1374_REG_CR_WDALM |
> > +				   DS1374_REG_CR_AIE | remapped));
>=20
> Some unnecessary ( )

Agreed.
>=20
> > +}
> > +
> > +static int ds1374_wdt_start(struct watchdog_device *wdog)
> > +{
> > +	int err;
> > +	struct ds1374_wdt *ds1374_wdt =3D watchdog_get_drvdata(wdog);
> > +
> > +	err =3D ds1374_wdt_set_timeout(wdog, wdog->timeout);
> > +	if (err) {
> > +		dev_err(ds1374_wdt->dev, "%s: failed to set timeout (%d) %u\n",
> > +			__func__, err, wdog->timeout);
> > +		return err;
> > +	}
> > +
> > +	err =3D ds1374_wdt_ping(wdog);
> > +	if (err) {
> > +		dev_err(ds1374_wdt->dev, "%s: failed to ping (%d)\n", __func__,
> > +			err);

I assume you'd want to get rid of that one too?
> > +		return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct watchdog_info ds1374_wdt_info =3D {
> > +	.identity       =3D "DS1374 WTD",
> > +	.options        =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING
> > +			| WDIOF_MAGICCLOSE,
> > +};
> > +
> > +static const struct watchdog_ops ds1374_wdt_ops =3D {
> > +	.owner		=3D THIS_MODULE,
> > +	.start		=3D ds1374_wdt_start,
> > +	.stop		=3D ds1374_wdt_stop,
> > +	.set_timeout	=3D ds1374_wdt_set_timeout,
> > +	.ping		=3D ds1374_wdt_ping,
> > +};
> > +
> > +static int ds1374_wdt_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct ds1374 *ds1374 =3D dev_get_drvdata(dev->parent);
> > +	struct ds1374_wdt *priv;
> > +	int err;
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +	priv->chip =3D ds1374;
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	priv->wdd.info		=3D &ds1374_wdt_info;
> > +	priv->wdd.ops		=3D &ds1374_wdt_ops;
> > +	priv->wdd.min_timeout	=3D DS1374_WDT_MIN_TIMEOUT;
> > +	priv->wdd.timeout	=3D DS1374_WDT_DEFAULT_TIMEOUT;
> > +	priv->wdd.max_timeout	=3D 0x1ffffff / DS1374_WDT_RATE;
> > +	priv->wdd.parent	=3D dev->parent;
> > +
> > +	watchdog_init_timeout(&priv->wdd, timeout, dev);
> > +	watchdog_set_nowayout(&priv->wdd, nowayout);
> > +	watchdog_stop_on_reboot(&priv->wdd);
> > +	watchdog_set_drvdata(&priv->wdd, priv);
> > +
> > +	err =3D devm_watchdog_register_device(dev, &priv->wdd);
> > +	if (err) {
> > +		dev_err(dev, "Failed to register watchdog device\n");
> > +		return err;
> > +	}
> > +
> > +	dev_info(dev, "Registered DS1374 Watchdog\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int ds1374_wdt_remove(struct platform_device *pdev)
> > +{
> > +	struct ds1374_wdt *priv =3D platform_get_drvdata(pdev);
> > +
> > +	if (!nowayout)
> > +		ds1374_wdt_stop(&priv->wdd);
> > +
>=20
> This may bypass MAGICCLOSE: If the watchdog daemon is killed and the modu=
le removed,
> the watchdog will be stopped. Is this really what you want ? If so, why s=
et MAGICCLOSE
> in the first place ?

So your suggestion would be:

- if (!nowayout)
-	ds1374_wdt_stop(&priv->wdd)

>=20
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int ds1374_wdt_suspend(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int ds1374_wdt_resume(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> Those functions are quite pointless.

Agreed.

>=20
> > +static SIMPLE_DEV_PM_OPS(ds1374_wdt_pm, ds1374_wdt_suspend, ds1374_wdt=
_resume);
> > +
> > +static struct platform_driver ds1374_wdt_driver =3D {
> > +	.probe =3D ds1374_wdt_probe,
> > +	.remove =3D ds1374_wdt_remove,
> > +	.driver =3D {
> > +		.name =3D "ds1374-wdt",
> > +		.pm =3D &ds1374_wdt_pm,
> > +	},
> > +};
> > +module_platform_driver(ds1374_wdt_driver);
> > +
> > +MODULE_AUTHOR("Moritz Fischer <mdf@kernel.org>");
> > +MODULE_DESCRIPTION("Maxim/Dallas DS1374 WDT Driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:ds1374-wdt");
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
> > + */
> > +
> > +#ifndef __DT_BINDINGS_MFD_DS1374_H__
> > +#define __DT_BINDINGS_MFD_DS1374_H__
> > +
> > +#define DALLAS_MODE_RTC		0
> > +#define DALLAS_MODE_ALM		1
> > +#define DALLAS_MODE_WDT		2
> > +
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
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
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
> > +
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
> > +
> > +int ds1374_read_bulk(struct ds1374 *ds1374, u32 *time, int reg, int nb=
ytes);
> > +
> > +int ds1374_write_bulk(struct ds1374 *ds1374, u32 time, int reg, int nb=
ytes);
> > +
> > +#endif /* MFD_DS1374_H */
> >=20
>=20

Thanks for your review!

Moritz

PS: I haven't forgotten about the cros-ec-hwmon, I'll get back to that at
one point ;-)

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZaPc9AAoJEL5CEHepFqovp1cH+wc1R4A3z95fQBpwsPrkdlbi
UUJfSEZk6NzGJcdwGp54y05JqGGHYMjPL4cDq+EP57z54WbtSS93lAZPGds2jvBt
MJXYT1YyYcFDwoSt6RjqzWJefWeFPBNFJMiAB7o6IUSF4EVybLIk6fTdAcIdNh4a
iNRQAfH2aVgAkjAoOoEwIwfNG+SE5k/5/M3Tv/ohxC5AcpbN78PGpzj2pEQGHZe5
fyfdA8cbNQLEwlfLqPu6mwjoZcr8Fh0D7pT8Ew3xplZI8SLRfK887M5HZPGxDeYH
k+TKFvzzK793AYYmXWI2B+R14KCzfkQAGwBrPv504BsDUWkBT8GbWFfWlwyuj3g=
=BOCt
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
