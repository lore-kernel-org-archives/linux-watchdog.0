Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.141]:61319 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756027AbaGQNOr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 Jul 2014 09:14:47 -0400
Date: Thu, 17 Jul 2014 16:06:53 +0200
From: Andreas Werner <andreas.werner@men.de>
To: Lee Jones <lee.jones@linaro.org>
CC: Andreas Werner <andreas.werner@men.de>,
	<linux-kernel@vger.kernel.org>, <sameo@linux.intel.com>,
	<cooloney@gmail.com>, <rpurdie@rpsys.net>,
	<linux-leds@vger.kernel.org>, <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] drivers/mfd/menf21bmc: introduce MEN 14F021P00
 BMC MFD Core driver
Message-ID: <20140717140653.GA8468@awelinux>
References: <cover.1405602280.git.andreas.werner@men.de>
 <e035a8a5211769e610a1337dc786f2fcc8dfd14d.1405602280.git.andreas.werner@men.de>
 <20140717124156.GF30888@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140717124156.GF30888@lee--X1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jul 17, 2014 at 01:41:56PM +0100, Lee Jones wrote:
> On Thu, 17 Jul 2014, Andreas Werner wrote:
> > The MEN 14F021P00 Board Management Controller provides an
> > I2C interface to the host to access the feature implemented in the =
BMC.
> > The BMC is a PIC Microntroller assembled on CPCI Card from MEN Mikr=
oelektronik
> > and on a few Box/Display Computer.
> >=20
> > Added MFD Core driver, supporting the I2C communication to the devi=
ce.
> >=20
> > The MFD driver currently supports the following features:
> >  	- Watchdog
> >  	- LEDs
> >=20
> > Signed-off-by: Andreas Werner <andreas.werner@men.de>
> > ---
> >  drivers/mfd/Kconfig     |  12 +++++
> >  drivers/mfd/Makefile    |   1 +
> >  drivers/mfd/menf21bmc.c | 136 ++++++++++++++++++++++++++++++++++++=
++++++++++++
> >  3 files changed, 149 insertions(+)
> >  create mode 100644 drivers/mfd/menf21bmc.c
> >=20
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index b8d9ca0..6e2cd14 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -453,6 +453,18 @@ config MFD_MAX8998
> >  	  additional drivers must be enabled in order to use the function=
ality
> >  	  of the device.
> > =20
> > +config MFD_MENF21BMC
> > +	tristate "MEN 14F021P00 Board Management Controller Support"
> > +	depends on I2C=3Dy
> > +	select MFD_CORE
> > +	help
> > +	  Say yes here to add support for the MEN 14F021P00 BMC
> > +	  which is a Board Management Controller connected to the I2C bus=
=2E
> > +	  The device supports multiple sub-devices like LED and WDT.
> > +	  This driver provides common support for accessing the devices;
> > +	  additional drivers must be enabled in order to use the
> > +	  functionality of the BMC device.
>=20
> Can you mention what those devices are here in the help text?
>

I've mentioned the sub-devices "LED" and "WDT" but i can also write
the name to the help text like "menf21bmc_wdt" and "leds-menf21bmc".
=20
> >  config EZX_PCAP
> >  	bool "Motorola EZXPCAP Support"
> >  	depends on SPI_MASTER
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 4e2bc25..37bf336 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -169,6 +169,7 @@ obj-$(CONFIG_MFD_AS3711)	+=3D as3711.o
> >  obj-$(CONFIG_MFD_AS3722)	+=3D as3722.o
> >  obj-$(CONFIG_MFD_STW481X)	+=3D stw481x.o
> >  obj-$(CONFIG_MFD_IPAQ_MICRO)	+=3D ipaq-micro.o
> > +obj-$(CONFIG_MFD_MENF21BMC)	+=3D menf21bmc.o
> > =20
> >  intel-soc-pmic-objs		:=3D intel_soc_pmic_core.o intel_soc_pmic_crc=
=2Eo
> >  obj-$(CONFIG_INTEL_SOC_PMIC)	+=3D intel-soc-pmic.o
> > diff --git a/drivers/mfd/menf21bmc.c b/drivers/mfd/menf21bmc.c
> > new file mode 100644
> > index 0000000..76f94cd
> > --- /dev/null
> > +++ b/drivers/mfd/menf21bmc.c
> > @@ -0,0 +1,136 @@
> > +/*
> > + *  MEN 14F021P00 Board Management Controller (BMC) MFD Core Drive=
r.
> > + *
> > + *  Copyright (C) 2014 MEN Mikro Elektronik Nuernberg GmbH
> > + *  Author: Andreas Werner <andreas.werner@men.de>
> > + *  All rights reserved.
>=20
> This normally resides wit the company, rather than the author.

Ok, i'w=C3=ADll the author suff.

>=20
> > + *  This program is free software; you can redistribute  it and/or=
 modify it
> > + *  under  the terms of  the GNU General  Public License as publis=
hed by the
> > + *  Free Software Foundation;  either version 2 of the  License, o=
r (at your
> > + *  option) any later version.
> > + *
>=20
> Remove this line.
>=20
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mfd/core.h>
> > +
> > +#define BMC_CMD_REV_MAJOR	0x80
> > +#define BMC_CMD_REV_MINOR	0x81
> > +#define BMC_CMD_REV_MAIN	0x82
> > +#define BMC_CMD_WDT_EXIT_PROD	0x18
> > +#define BMC_CMD_WDT_PROD_STAT	0x19
>=20
> If these are in the same address space, can you order them by number.

No problem, i will order them, they are in the same space.

>=20
> > +static struct mfd_cell menf21bmc_cell[] =3D {
> > +	{ .name =3D "menf21bmc_wdt", },
> > +	{ .name =3D "menf21bmc_led", },
> > +};
> > +
> > +static int menf21bmc_wdt_exit_prod_mode(struct i2c_client *client)
> > +{
> > +	int val, ret;
> > +
> > +	val =3D i2c_smbus_read_byte_data(client, BMC_CMD_WDT_PROD_STAT);
> > +	if (val < 0)
> > +		return val;
> > +
> > +	/*
> > +	 * Production mode should be not active after delivery of the Boa=
rd.
> > +	 * To be sure we check it, inform the user and exit the mode
> > +	 * if active.
> > +	 */
> > +	if (val =3D=3D 0x00) {
> > +		dev_info(&client->dev,
> > +			"BMC in production mode. Exit production mode\n");
> > +
> > +		ret =3D i2c_smbus_write_byte(client, BMC_CMD_WDT_EXIT_PROD);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +menf21bmc_probe(struct i2c_client *client, const struct i2c_device=
_id *ids)
> > +{
> > +	int ret;
> > +	int rev_major, rev_minor, rev_main;
> > +
> > +	if (!i2c_check_functionality(client->adapter,
> > +				     I2C_FUNC_SMBUS_BYTE_DATA |
> > +				     I2C_FUNC_SMBUS_WORD_DATA |
> > +				     I2C_FUNC_SMBUS_BYTE))
>=20
> Can you take the function call out of the if() please?

Yes I can do it.

>=20
> > +		return -ENODEV;
> > +
> > +	rev_major =3D i2c_smbus_read_word_data(client, BMC_CMD_REV_MAJOR)=
;
> > +	if (rev_major < 0) {
> > +		dev_err(&client->dev, "failed to get BMC major revision\n");
> > +		return rev_major;
> > +	}
> > +
> > +	rev_minor =3D i2c_smbus_read_word_data(client, BMC_CMD_REV_MINOR)=
;
> > +	if (rev_minor < 0) {
> > +		dev_err(&client->dev, "failed to get BMC minor revision\n");
> > +		return rev_minor;
> > +	}
> > +
> > +	rev_main =3D i2c_smbus_read_word_data(client, BMC_CMD_REV_MAIN);
> > +	if (rev_main < 0) {
> > +		dev_err(&client->dev, "failed to get BMC main revision\n");
> > +		return rev_main;
> > +	}
> > +
> > +	dev_info(&client->dev, "FW Revision: %02d.%02d.%02d\n",
> > +					rev_major, rev_minor, rev_main);
> > +
> > +	/*
> > +	 * We have to exit the Production Mode of the BMC to activate the
> > +	 * Watchdog functionality and the BIOS life sign monitoring.
> > +	 */
> > +	ret =3D menf21bmc_wdt_exit_prod_mode(client);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "failed to leave production mode\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D mfd_add_devices(&client->dev, 0, menf21bmc_cell,
> > +				ARRAY_SIZE(menf21bmc_cell), NULL, 0, NULL);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "failed to add BMC sub-devices\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int menf21bmc_remove(struct i2c_client *client)
> > +{
> > +	mfd_remove_devices(&client->dev);
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id menf21bmc_id_table[] =3D {
> > +	{ "menf21bmc", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, menf21bmc_id_table);
> > +
> > +static struct i2c_driver menf21bmc_driver =3D {
> > +	.driver		=3D {
> > +		.name	=3D "menf21bmc",
> > +		.owner	=3D THIS_MODULE,
>=20
> Remove this line, it's handled elsewhere.

Which line? the ".owner" line?

>=20
> > +	},
> > +	.id_table	=3D menf21bmc_id_table,
> > +	.probe		=3D menf21bmc_probe,
> > +	.remove		=3D menf21bmc_remove,
> > +};
> > +
> > +module_i2c_driver(menf21bmc_driver);
> > +
> > +MODULE_DESCRIPTION("MEN 14F021P00 BMC mfd core driver");
> > +MODULE_AUTHOR("Andreas Werner <andreas.werner@men.de>");
> > +MODULE_LICENSE("GPL");
>=20
> The header says that this is GPL v2.

Will change that.

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
