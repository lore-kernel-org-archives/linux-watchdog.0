Return-Path: <Li.Xiubo@freescale.com>
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "wim@iguana.be" <wim@iguana.be>, "shawn.guo@linaro.org"
	<shawn.guo@linaro.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv4 2/2] watchdog: imx2_wdt: convert to use regmap API.
Date: Fri, 4 Apr 2014 02:09:14 +0000
Message-ID: <45be66f717074e4b85c5fc531e05045f@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1396487059-15298-1-git-send-email-Li.Xiubo@freescale.com>
 <1396487059-15298-3-git-send-email-Li.Xiubo@freescale.com>
 <20140403163604.GA11832@roeck-us.net>
 <6563b26412a7457ba38e2dcf0bdcb643@BY2PR03MB505.namprd03.prod.outlook.com>
 <533E0FB3.6070305@roeck-us.net>
In-Reply-To: <533E0FB3.6070305@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

> > This is caused by not compiling the regmap core.
> >
> > Could you add the following patch to have a try ?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 79d2589..3e55fa9 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -369,6 +369,7 @@ config MAX63XX_WATCHDOG
> >   config IMX2_WDT
> >          tristate "IMX2+ Watchdog"
> >          depends on ARCH_MXC
> > +       select REGMAP_MMIO
> >          help
> >            This is the driver for the hardware watchdog
> >            on the Freescale IMX2 and later processors.
> > --------------------------
> >
> > If it's okey, I'll sent the v5 series to fix this.
> >
> Yes, that fixes the problem.
>=20


I'll send the v5 series to fix this.

Thanks very much.
