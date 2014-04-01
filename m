Return-Path: <Li.Xiubo@freescale.com>
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>, "wim@iguana.be" <wim@iguana.be>,
	"w.sang@pengutronix.de" <w.sang@pengutronix.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"broonie@linaro.org" <broonie@linaro.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "swarren@nvidia.com" <swarren@nvidia.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv2 2/2] watchdog: imx2_wdt: Add big-endian support
Date: Tue, 1 Apr 2014 02:24:12 +0000
Message-ID: <1c79a81bbd7b4cc79689cb907e81e893@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395800500-22655-1-git-send-email-Li.Xiubo@freescale.com>
 <1395800500-22655-3-git-send-email-Li.Xiubo@freescale.com>
 <5338E1E8.4030700@roeck-us.net>
 <28375308b05f4cf4bc7d1559f2524c1b@BY2PR03MB505.namprd03.prod.outlook.com>
 <533A1A4B.2090503@roeck-us.net>
In-Reply-To: <533A1A4B.2090503@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

> > It's actually the following ones first, which will support 16-bits
> > Values for regmap-mmio:
> >
> > https://patchwork.kernel.org/patch/3896321/
> > https://patchwork.kernel.org/patch/3896331/
> > https://patchwork.kernel.org/patch/3901021/
> >
> > And the then the following one, which will support the LE endian:
> > http://www.spinics.net/lists/kernel/msg1714375.html
> >
> So what is the plan for this patch ? Seems to me it would make more sense
> to convert the driver to regmap.
>=20

@Guenter, @Mark,

Yes, I do think so too and there has already regmap-mmio version patch
Series about the IMX2 Watchdog driver, but those regmap patches for
supporting the 16-bit values are in Mark's tree and the IMX2 Watchdog
will depend on them.

How to deal with this situation ?


The regmap patches depended by IMX2 Watchdog:

1, https://patchwork.kernel.org/patch/3896321/   =3D=3D=3D> <applied>
   regmap: mmio: add regmap_mmio_{regsize, count}_check.=20
   https://patchwork.kernel.org/patch/3896331/   =3D=3D=3D> <applied>
   regmap: mmio: Add support for 1/2/8 bytes wide register address.
   https://patchwork.kernel.org/patch/3901021/   =3D=3D=3D> <applied>
   regmap: mmio: Add regmap_mmio_regbits_check.


2, The above three and this one are a must.
   https://patchwork.kernel.org/patch/3912671/   =3D=3D=3D> <pending>
   regmap: mmio: Fix the bug of 'offset' value parsing.


3, The following ones are not a must, but will make the IMX2
   Watchdog much simplifier.
   https://patchwork.kernel.org/patch/3912401/   =3D=3D=3D> <pending>
   regmap: implement LE formatting/parsing for 16/32-bit values.
   https://patchwork.kernel.org/patch/3912751/   =3D=3D=3D> <pending>
   regmap: add DT endianness binding support.
   https://patchwork.kernel.org/patch/3912741/   =3D=3D=3D> <pending>
   regmap: Add the DT binding documentation for endianness


The above all have been test using SAI(32-bit regmap-mmio),=20
SGTL5000(codec 16-bit regmap-i2c) and IMX2 Watchdog(16-bit
regmap-mmio).


I'll send the regmap-mmio based patch series for IMX2 Watchdog.


Thanks,

Best Regards,
Xiubo
