Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33965 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbbJ3SAI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 14:00:08 -0400
Received: by wmff134 with SMTP id f134so17511323wmf.1
        for <linux-watchdog@vger.kernel.org>; Fri, 30 Oct 2015 11:00:07 -0700 (PDT)
Date: Fri, 30 Oct 2015 17:52:40 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v2 3/5] watchdog: ts4800: add driver for TS-4800 watchdog
Message-ID: <20151030175240.GE4058@x1>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446150450-22093-4-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151030172807.GD4058@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20151030172807.GD4058@x1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

<whoops, I fat fingered the keyboard and sent this too early>

> Where is your change-log?
>=20
> I have no idea what the intention of this patch is.

=46YI, the reason I left editing and subsequently sent by mistake was
that I had to jump out to look at the subject in order to find the aim
of this patch.

> > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > ---
> >  .../devicetree/bindings/mfd/ts4800-syscon.txt      |   8 +
> >  .../devicetree/bindings/watchdog/ts4800-wdt.txt    |  12 ++
>=20
> These should be in a seperate patch.
>=20
> >  drivers/mfd/Kconfig                                |   1 +
> >  drivers/mfd/ts4800-syscon.c                        |  13 +-
> >  drivers/watchdog/Kconfig                           |  10 +
> >  drivers/watchdog/Makefile                          |   1 +
> >  drivers/watchdog/ts4800_wdt.c                      | 216 +++++++++=
++++++++++++
> >  7 files changed, 260 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/ts48=
00-wdt.txt
> >  create mode 100644 drivers/watchdog/ts4800_wdt.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/ts4800-syscon.tx=
t b/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
> > index 8dbc12c..8c0fd1d 100644
> > --- a/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
> > +++ b/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
> > @@ -4,9 +4,17 @@ Required properties:
> >  - compatible : must be "ts,ts4800-syscon"
> >  - reg : physical base address and length of memory mapped region
> > =20
> > +The driver exposes following subdevices:

s/exposes/registers/

> > +- a watchdog: see ../watchdog/ts4800-wdt.txt

Remove the 'a'.

> >  Example:
> > =20
> >  syscon@b0010000 {
> >  	compatible =3D "ts,ts4800-syscon";
> >  	reg =3D <0xb0010000 0x3d>;
> > +
> > +	wdt@e {
> > +		compatible =3D "ts,ts4800-wdt";
> > +		offset =3D <0xe>;
> > +	};
> >  };
> > diff --git a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.=
txt b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> > new file mode 100644
> > index 0000000..a9305c2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> > @@ -0,0 +1,12 @@
> > +Technologic Systems Watchdog
> > +
> > +Required properties:
> > +- compatible : must be "ts,ts4800-wdt"
> > +- offset : offset of the feed register from syscon base

What's a 'feed' register?

Also, 'offset' is a generic property that is undocumented in this
context.  *If* there is no other generic interface to achieve whatever
it is you're trying to achieve, then you probably want a vendor
specific property.  However, I'm pretty sure there will be other
means.

Does the 'feed' register change from platform to platform?

> > +Example:
> > +
> > +wdt1: wdt@b0010000 {
> > +	compatible =3D "ts,ts4800-wdt";
> > +	offset =3D <0xe>;

Why don't you have a 'reg' property?

> > +};
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 8f03dce..95ba036 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1304,6 +1304,7 @@ config MFD_TC6393XB
> > =20
> >  config MFD_TS4800_SYSCON
> >  	tristate "TS-4800 Syscon Support"
> > +	select MFD_CORE
> >  	select REGMAP
> >  	select REGMAP_MMIO
> >  	help
>=20
> This change is orthogonal and has not place in this patch.

Meaning all of your drviers/mfd changes.

> > diff --git a/drivers/mfd/ts4800-syscon.c b/drivers/mfd/ts4800-sysco=
n.c
> > index 1e42e96..03b3b04a 100644
> > --- a/drivers/mfd/ts4800-syscon.c
> > +++ b/drivers/mfd/ts4800-syscon.c
> > @@ -24,6 +24,13 @@
> >  #include <linux/mfd/ts4800-syscon.h>
> > =20
> > =20
> > +static const struct mfd_cell ts4800_syscon_cells[] =3D {
> > +	{
> > +		.name =3D "ts4800-watchdog",
> > +		.of_compatible =3D "ts,ts4800-wdt",
> > +	},
> > +};
> > +
> >  static const struct regmap_config ts4800_regmap_config =3D {
> >  	.reg_bits =3D 32,
> >  	.reg_stride =3D 2,
> > @@ -56,11 +63,15 @@ static int ts4800_syscon_probe(struct platform_=
device *pdev)
> > =20
> >  	platform_set_drvdata(pdev, syscon);
> > =20
> > -	return 0;
> > +	return mfd_add_devices(&pdev->dev, -1, ts4800_syscon_cells,

Please use the correct #define instead of -1.

> > +			       ARRAY_SIZE(ts4800_syscon_cells),
> > +			       NULL, 0, NULL);
> >  }
> > =20
> >  static int ts4800_syscon_remove(struct platform_device *pdev)
> >  {
> > +	mfd_remove_devices(&pdev->dev);
> > +
> >  	return 0;
> >  }
> > =20
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 241fafd..aaa42b8 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -417,6 +417,16 @@ config NUC900_WATCHDOG
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called nuc900_wdt.
> > =20
> > +config TS4800_WATCHDOG
> > +	tristate "TS-4800 Watchdog"
> > +	depends on OF
> > +	depends on MFD_TS4800_SYSCON
> > +	select WATCHDOG_CORE
> > +	help
> > +	  Technologic Systems TS-4800 has watchdog timer implemented in
> > +	  an external FPGA. Say Y here if you want to support for the
> > +	  watchdog timer on TS-4800 board.
> > +
> >  config TS72XX_WATCHDOG
> >  	tristate "TS-72XX SBC Watchdog"
> >  	depends on MACH_TS72XX
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index 59ea9a1..435fc93 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -52,6 +52,7 @@ obj-$(CONFIG_RN5T618_WATCHDOG) +=3D rn5t618_wdt.o
> >  obj-$(CONFIG_COH901327_WATCHDOG) +=3D coh901327_wdt.o
> >  obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) +=3D stmp3xxx_rtc_wdt.o
> >  obj-$(CONFIG_NUC900_WATCHDOG) +=3D nuc900_wdt.o
> > +obj-$(CONFIG_TS4800_WATCHDOG) +=3D ts4800_wdt.o
> >  obj-$(CONFIG_TS72XX_WATCHDOG) +=3D ts72xx_wdt.o
> >  obj-$(CONFIG_IMX2_WDT) +=3D imx2_wdt.o
> >  obj-$(CONFIG_UX500_WATCHDOG) +=3D ux500_wdt.o
> > diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts480=
0_wdt.c
> > new file mode 100644
> > index 0000000..9b9e638
> > --- /dev/null
> > +++ b/drivers/watchdog/ts4800_wdt.c
> > @@ -0,0 +1,216 @@
> > +/*
> > + * ts4800_wdt.c - Watchdog driver for TS-4800 based boards

Not sure what Wim's view are, but it's usually better *not* to put
filenames in C files.

> > + * Copyright (c) 2015 - Savoir-faire Linux
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2. This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/watchdog.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/mfd/ts4800-syscon.h>

Alphabetical.

> > +static bool nowayout =3D WATCHDOG_NOWAYOUT;
> > +module_param(nowayout, bool, 0);
> > +MODULE_PARM_DESC(nowayout,
> > +	"Watchdog cannot be stopped once started (default=3D"
> > +	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> > +
> > +

Superfluous '\n'.

> > +/* possible feed values */
> > +#define TS4800_WDT_FEED_2S	0x1
> > +#define TS4800_WDT_FEED_10S	0x2
> > +#define TS4800_WDT_DISABLE	0x3

Nit: Tabbing.  Alignment.

> > +
> > +

Superfluous '\n'.

[...]

> > +MODULE_AUTHOR("Damien Riegel <damien.riegel@savoirfairelinux.com>"=
);
> > +MODULE_LICENSE("GPL");

GPL v2

> > +MODULE_ALIAS("platform:ts4800_wdt");
>=20

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
