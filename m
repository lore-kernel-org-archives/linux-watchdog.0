Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:64461 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbaH2G7W (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 Aug 2014 02:59:22 -0400
Received: by mail-ie0-f181.google.com with SMTP id rp18so2277146iec.40
        for <linux-watchdog@vger.kernel.org>; Thu, 28 Aug 2014 23:59:21 -0700 (PDT)
Date: Fri, 29 Aug 2014 07:59:15 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Bryan Wu <cooloney@gmail.com>
Cc: Andreas Werner <andreas.werner@men.de>,
	lkml <linux-kernel@vger.kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>, linux@roeck-us.net,
	lm-sensors@lm-sensors.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	"rpurdie@rpsys.net" <rpurdie@rpsys.net>,
	Linux LED Subsystem <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] drivers/leds/leds-menf21bmc: introduce MEN
 14F021P00 BMC LED driver
Message-ID: <20140829065915.GZ24579@lee--X1>
References: <cover.1409161615.git.andreas.werner@men.de>
 <e91e4f47cda55c03fa1d0a54c0891341d73adfa6.1409161615.git.andreas.werner@men.de>
 <CAK5ve-+zjZBw_HXWm9kGE5Vbv=R2SO4P2dB_0opzLHTAV-BQ0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <CAK5ve-+zjZBw_HXWm9kGE5Vbv=R2SO4P2dB_0opzLHTAV-BQ0Q@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 28 Aug 2014, Bryan Wu wrote:

> On Wed, Aug 27, 2014 at 10:52 AM, Andreas Werner <andreas.werner@men.=
de> wrote:
> > Added driver to support the 14F021P00 BMC LEDs.
> > The BMC is a Board Management Controller including four LEDs which
> > can be switched on and off.
> >
>=20
> Please go ahead with my Ack
> Acked-by: Bryan Wu <cooloney@gmail.com>
>=20
> Lee, will you merge this through your tree? I think we do that in one
> shot is better.

Yes, that's fine.  Pull-request to follow.

> > Signed-off-by: Andreas Werner <andreas.werner@men.de>
> > ---
> >  drivers/leds/Kconfig          |   9 +++
> >  drivers/leds/Makefile         |   1 +
> >  drivers/leds/leds-menf21bmc.c | 131 ++++++++++++++++++++++++++++++=
++++++++++++
> >  3 files changed, 141 insertions(+)
> >  create mode 100644 drivers/leds/leds-menf21bmc.c
> >
> > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > index 27cf0cd..ec03457 100644
> > --- a/drivers/leds/Kconfig
> > +++ b/drivers/leds/Kconfig
> > @@ -458,6 +458,15 @@ config LEDS_OT200
> >           This option enables support for the LEDs on the Bachmann =
OT200.
> >           Say Y to enable LEDs on the Bachmann OT200.
> >
> > +config LEDS_MENF21BMC
> > +       tristate "LED support for the MEN 14F021P00 BMC"
> > +       depends on LEDS_CLASS && MFD_MENF21BMC
> > +       help
> > +         Say Y here to include support for the MEN 14F021P00 BMC L=
EDs.
> > +
> > +         This driver can also be built as a module. If so the modu=
le
> > +         will be called leds-menf21bmc.
> > +
> >  comment "LED driver for blink(1) USB RGB LED is under Special HID =
drivers (HID_THINGM)"
> >
> >  config LEDS_BLINKM
> > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > index 3c03666..cadc433 100644
> > --- a/drivers/leds/Makefile
> > +++ b/drivers/leds/Makefile
> > @@ -53,6 +53,7 @@ obj-$(CONFIG_LEDS_MAX8997)            +=3D leds-m=
ax8997.o
> >  obj-$(CONFIG_LEDS_LM355x)              +=3D leds-lm355x.o
> >  obj-$(CONFIG_LEDS_BLINKM)              +=3D leds-blinkm.o
> >  obj-$(CONFIG_LEDS_VERSATILE)           +=3D leds-versatile.o
> > +obj-$(CONFIG_LEDS_MENF21BMC)           +=3D leds-menf21bmc.o
> >
> >  # LED SPI Drivers
> >  obj-$(CONFIG_LEDS_DAC124S085)          +=3D leds-dac124s085.o
> > diff --git a/drivers/leds/leds-menf21bmc.c b/drivers/leds/leds-menf=
21bmc.c
> > new file mode 100644
> > index 0000000..89dd577
> > --- /dev/null
> > +++ b/drivers/leds/leds-menf21bmc.c
> > @@ -0,0 +1,131 @@
> > +/*
> > + *  MEN 14F021P00 Board Management Controller (BMC) LEDs Driver.
> > + *
> > + *  This is the core LED driver of the MEN 14F021P00 BMC.
> > + *  There are four LEDs available which can be switched on and off=
=2E
> > + *  STATUS LED, HOT SWAP LED, USER LED 1, USER LED 2
> > + *
> > + *  Copyright (C) 2014 MEN Mikro Elektronik Nuernberg GmbH
> > + *
> > + *  This program is free software; you can redistribute  it and/or=
 modify it
> > + *  under  the terms of  the GNU General  Public License as publis=
hed by the
> > + *  Free Software Foundation;  either version 2 of the  License, o=
r (at your
> > + *  option) any later version.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/leds.h>
> > +#include <linux/i2c.h>
> > +
> > +#define BMC_CMD_LED_GET_SET    0xA0
> > +#define BMC_BIT_LED_STATUS     BIT(0)
> > +#define BMC_BIT_LED_HOTSWAP    BIT(1)
> > +#define BMC_BIT_LED_USER1      BIT(2)
> > +#define BMC_BIT_LED_USER2      BIT(3)
> > +
> > +struct menf21bmc_led {
> > +       struct led_classdev cdev;
> > +       u8 led_bit;
> > +       const char *name;
> > +       struct i2c_client *i2c_client;
> > +};
> > +
> > +static struct menf21bmc_led leds[] =3D {
> > +       {
> > +               .name =3D "menf21bmc:led_status",
> > +               .led_bit =3D BMC_BIT_LED_STATUS,
> > +       },
> > +       {
> > +               .name =3D "menf21bmc:led_hotswap",
> > +               .led_bit =3D BMC_BIT_LED_HOTSWAP,
> > +       },
> > +       {
> > +               .name =3D "menf21bmc:led_user1",
> > +               .led_bit =3D BMC_BIT_LED_USER1,
> > +       },
> > +       {
> > +               .name =3D "menf21bmc:led_user2",
> > +               .led_bit =3D BMC_BIT_LED_USER2,
> > +       }
> > +};
> > +
> > +static DEFINE_MUTEX(led_lock);
> > +
> > +static void
> > +menf21bmc_led_set(struct led_classdev *led_cdev, enum led_brightne=
ss value)
> > +{
> > +       int led_val;
> > +       struct menf21bmc_led *led =3D container_of(led_cdev,
> > +                                       struct menf21bmc_led, cdev)=
;
> > +
> > +       mutex_lock(&led_lock);
> > +       led_val =3D i2c_smbus_read_byte_data(led->i2c_client,
> > +                                          BMC_CMD_LED_GET_SET);
> > +       if (led_val < 0)
> > +               goto err_out;
> > +
> > +       if (value =3D=3D LED_OFF)
> > +               led_val &=3D ~led->led_bit;
> > +       else
> > +               led_val |=3D led->led_bit;
> > +
> > +       i2c_smbus_write_byte_data(led->i2c_client,
> > +                                 BMC_CMD_LED_GET_SET, led_val);
> > +err_out:
> > +       mutex_unlock(&led_lock);
> > +}
> > +
> > +static int menf21bmc_led_probe(struct platform_device *pdev)
> > +{
> > +       int i;
> > +       int ret;
> > +       struct i2c_client *i2c_client =3D to_i2c_client(pdev->dev.p=
arent);
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(leds); i++) {
> > +               leds[i].cdev.name =3D leds[i].name;
> > +               leds[i].cdev.brightness_set =3D menf21bmc_led_set;
> > +               leds[i].i2c_client =3D i2c_client;
> > +               ret =3D led_classdev_register(&pdev->dev, &leds[i].=
cdev);
> > +               if (ret < 0)
> > +                       goto err_free_leds;
> > +       }
> > +       dev_info(&pdev->dev, "MEN 140F21P00 BMC LED device enabled\=
n");
> > +
> > +       return 0;
> > +
> > +err_free_leds:
> > +       dev_err(&pdev->dev, "failed to register LED device\n");
> > +
> > +       for (i =3D i - 1; i >=3D 0; i--)
> > +               led_classdev_unregister(&leds[i].cdev);
> > +
> > +       return ret;
> > +}
> > +
> > +static int menf21bmc_led_remove(struct platform_device *pdev)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(leds); i++)
> > +               led_classdev_unregister(&leds[i].cdev);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct platform_driver menf21bmc_led =3D {
> > +       .probe          =3D menf21bmc_led_probe,
> > +       .remove         =3D menf21bmc_led_remove,
> > +       .driver         =3D {
> > +               .name           =3D "menf21bmc_led",
> > +               .owner          =3D THIS_MODULE,
> > +       },
> > +};
> > +
> > +module_platform_driver(menf21bmc_led);
> > +
> > +MODULE_AUTHOR("Andreas Werner <andreas.werner@men.de>");
> > +MODULE_DESCRIPTION("MEN 14F021P00 BMC led driver");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:menf21bmc_led");
> >

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
