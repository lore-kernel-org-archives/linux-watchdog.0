Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.113]:53843 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755908AbaH0KAt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 27 Aug 2014 06:00:49 -0400
Date: Wed, 27 Aug 2014 12:52:05 +0200
From: Andreas Werner <andreas.werner@men.de>
To: Lee Jones <lee.jones@linaro.org>
CC: Andreas Werner <andreas.werner@men.de>,
	<linux-kernel@vger.kernel.org>, <sameo@linux.intel.com>,
	<wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<cooloney@gmail.com>, <rpurdie@rpsys.net>,
	<linux-leds@vger.kernel.org>, <jdelvare@suse.de>,
	<linux@roeck-us.net>, <lm-sensors@lm-sensors.org>,
	<johannes.thumshirn@men.de>
Subject: Re: [PATCH v5 1/4] drivers/mfd/menf21bmc: introduce MEN 14F021P00
 BMC MFD Core driver
Message-ID: <20140827105204.GA2083@awelinux>
References: <cover.1409074255.git.andreas.werner@men.de>
 <67faa70de03924edc768002df17b02e47256260c.1409074255.git.andreas.werner@men.de>
 <20140827072633.GY26707@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20140827072633.GY26707@lee--X1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 08:26:33AM +0100, Lee Jones wrote:
> On Tue, 26 Aug 2014, Andreas Werner wrote:
> > The MEN 14F021P00 Board Management Controller provides an
> > I2C interface to the host to access the feature implemented in the BM=
C.
> > The BMC is a PIC Microntroller assembled on CPCI Card from MEN Mikroe=
lektronik
> > and on a few Box/Display Computer.
> >=20
> > Added MFD Core driver, supporting the I2C communication to the device=
.
> >=20
> > The MFD driver currently supports the following features:
> >  	- Watchdog
> >  	- LEDs
> > 	- Hwmon (voltage monitoring)
> >=20
> > Signed-off-by: Andreas Werner <andreas.werner@men.de>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/Kconfig     |  12 +++++
> >  drivers/mfd/Makefile    |   1 +
> >  drivers/mfd/menf21bmc.c | 132 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> >  3 files changed, 145 insertions(+)
> >  create mode 100644 drivers/mfd/menf21bmc.c
> >=20
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index b8d9ca0..6a9f101 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -453,6 +453,18 @@ config MFD_MAX8998
> >  	  additional drivers must be enabled in order to use the functional=
ity
> >  	  of the device.
> > =20
> > +config MFD_MENF21BMC
> > +	tristate "MEN 14F021P00 Board Management Controller Support"
> > +	depends on I2C
> > +	select MFD_CORE
> > +	help
> > +	  Say yes here to add support for the MEN 14F021P00 BMC
> > +	  which is a Board Management Controller connected to the I2C bus.
> > +	  The device supports multiple sub-devices like LED, HWMON  and WDT=
.
>=20
> Nit: Whitespace error.
>=20

I run checkpatch but did not find any whitespace error.
Where is it?

...

> > +MODULE_DEVICE_TABLE(i2c, menf21bmc_id_table);
> > +
> > +static struct i2c_driver menf21bmc_driver =3D {
> > +	.driver.name	=3D "menf21bmc",
> > +	.id_table	=3D menf21bmc_id_table,
> > +	.probe		=3D menf21bmc_probe,
> > +	.remove		=3D menf21bmc_remove,
> > +};
>=20
> No DT support?
>=20

No not at the moment because it is used only on x86 system.

> > +module_i2c_driver(menf21bmc_driver);
> > +
> > +MODULE_DESCRIPTION("MEN 14F021P00 BMC mfd core driver");
>=20
> s/mfd/MFD
>=20
> > +MODULE_AUTHOR("Andreas Werner <andreas.werner@men.de>");
> > +MODULE_LICENSE("GPL v2");
>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
