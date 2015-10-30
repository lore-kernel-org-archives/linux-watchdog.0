Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:48938 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760771AbbJ3UIT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 16:08:19 -0400
Date: Fri, 30 Oct 2015 16:08:13 -0400
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v2 2/5] mfd: ts4800-syscon: add driver for TS-4800 syscon
Message-ID: <20151030200812.GB8666@localhost>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446150450-22093-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151030175656.GF4058@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20151030175656.GF4058@x1>
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 30, 2015 at 05:56:56PM +0000, Lee Jones wrote:
> On Thu, 29 Oct 2015, Damien Riegel wrote:
>=20
> > Driver for TS-4800 syscon. These registers belong to a FPGA that is
> > memory mapped and are used for counters, enable various IPs in the =
=46PGA,
> > control LEDs, control IOs, etc.
> >=20
> > Currently, only the watchdog is handled.
>=20
> Why do you require your own syscon driver?
>=20
> What's wrong with the generic one?
>=20

The generic one uses a regmap_config with reg_stride set to 4 and val_b=
its
to 32.

TS-4800 syscon registers are 16-bit wide and must be accessed with 16
bit read and writes:
http://wiki.embeddedarm.com/wiki/TS-4800#Syscon

I will address the other issues in the next version (split commit,
license issue, style, and superfluous remove).

> > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > ---
> >  .../devicetree/bindings/mfd/ts4800-syscon.txt      | 12 ++++
>=20
> Separate patch please.
>=20
> >  drivers/mfd/Kconfig                                |  7 ++
> >  drivers/mfd/Makefile                               |  1 +
> >  drivers/mfd/ts4800-syscon.c                        | 84 ++++++++++=
++++++++++++
> >  include/linux/mfd/ts4800-syscon.h                  | 24 +++++++
> >  5 files changed, 128 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ts4800-sy=
scon.txt
> >  create mode 100644 drivers/mfd/ts4800-syscon.c
> >  create mode 100644 include/linux/mfd/ts4800-syscon.h
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/ts4800-syscon.tx=
t b/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
> > new file mode 100644
> > index 0000000..8dbc12c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
> > @@ -0,0 +1,12 @@
> > +Technologic Systems Syscon
> > +
> > +Required properties:
> > +- compatible : must be "ts,ts4800-syscon"
> > +- reg : physical base address and length of memory mapped region
> > +
> > +Example:
> > +
> > +syscon@b0010000 {
> > +	compatible =3D "ts,ts4800-syscon";
> > +	reg =3D <0xb0010000 0x3d>;
> > +};
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 3f68dd2..8f03dce 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1302,6 +1302,13 @@ config MFD_TC6393XB
> >  	help
> >  	  Support for Toshiba Mobile IO Controller TC6393XB
> > =20
> > +config MFD_TS4800_SYSCON
> > +	tristate "TS-4800 Syscon Support"
> > +	select REGMAP
> > +	select REGMAP_MMIO
> > +	help
> > +	  Support for TS-4800's FPGA Syscon registers
> > +
> >  config MFD_VX855
> >  	tristate "VIA VX855/VX875 integrated south bridge"
> >  	depends on PCI
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index ea40e07..e2c0f1b 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -181,6 +181,7 @@ obj-$(CONFIG_MFD_HI6421_PMIC)	+=3D hi6421-pmic-=
core.o
> >  obj-$(CONFIG_MFD_DLN2)		+=3D dln2.o
> >  obj-$(CONFIG_MFD_RT5033)	+=3D rt5033.o
> >  obj-$(CONFIG_MFD_SKY81452)	+=3D sky81452.o
> > +obj-$(CONFIG_MFD_TS4800_SYSCON)	+=3D ts4800-syscon.o
> > =20
> >  intel-soc-pmic-objs		:=3D intel_soc_pmic_core.o intel_soc_pmic_crc=
=2Eo
> >  obj-$(CONFIG_INTEL_SOC_PMIC)	+=3D intel-soc-pmic.o
> > diff --git a/drivers/mfd/ts4800-syscon.c b/drivers/mfd/ts4800-sysco=
n.c
> > new file mode 100644
> > index 0000000..1e42e96
> > --- /dev/null
> > +++ b/drivers/mfd/ts4800-syscon.c
> > @@ -0,0 +1,84 @@
> > +/*
> > + * Device driver for TS-4800 FPGA's syscon
> > + *
> > + * Copyright (c) 2015 - Savoir-faire Linux
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License as publish=
ed by
> > + * the Free Software Foundation; either version 2 of the License, =
or
> > + * (at your option) any later version.
>=20
> Why is the MFD v2+ and the Watchdog driver only v2?
>=20
> > + * This program is distributed in the hope it will be useful, but =
WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABIL=
ITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public L=
icense for
> > + * more details.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/mfd/ts4800-syscon.h>
>=20
> Alphabetical.
>=20
> > +
> > +
>=20
> Superfluous '\n'.
>=20
> > +static const struct regmap_config ts4800_regmap_config =3D {
> > +	.reg_bits =3D 32,
> > +	.reg_stride =3D 2,
> > +	.val_bits =3D 16,
> > +};
> > +
> > +static int ts4800_syscon_probe(struct platform_device *pdev)
> > +{
> > +	struct ts4800_syscon *syscon;
> > +	struct resource *res;
> > +	void __iomem *base;
> > +
> > +	syscon =3D devm_kzalloc(&pdev->dev, sizeof(*syscon), GFP_KERNEL);
> > +	if (!syscon)
> > +		return -ENOMEM;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	base =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	syscon->regmap =3D devm_regmap_init_mmio_clk(&pdev->dev, NULL, ba=
se,
> > +						   &ts4800_regmap_config);
> > +	if (IS_ERR(syscon->regmap)) {
> > +		dev_err(&pdev->dev,
> > +			"regmap init failed: %ld\n",
> > +			PTR_ERR(syscon->regmap));
> > +		return PTR_ERR(syscon->regmap);
> > +	}
> > +
> > +	platform_set_drvdata(pdev, syscon);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ts4800_syscon_remove(struct platform_device *pdev)
> > +{
> > +	return 0;
> > +}
>=20
> If it doesn't do anything, don't provide it.
>=20
> > +static const struct of_device_id ts4800_syscon_of_match[] =3D {
> > +	{ .compatible =3D "ts,ts4800-syscon", },
> > +	{ },
> > +};
> > +
> > +static struct platform_driver ts4800_syscon_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D "ts4800_syscon",
> > +		.of_match_table =3D ts4800_syscon_of_match,
> > +	},
> > +	.probe	=3D ts4800_syscon_probe,
> > +	.remove	=3D ts4800_syscon_remove,
> > +};
> > +module_platform_driver(ts4800_syscon_driver);
> > +
> > +MODULE_AUTHOR("Damien Riegel <damien.riegel@savoirfairelinux.com>"=
);
> > +MODULE_DESCRIPTION("TS-4800 Syscon driver");
> > +MODULE_LICENSE("GPL v2");
>=20
> This does not match the header.
>=20
> > diff --git a/include/linux/mfd/ts4800-syscon.h b/include/linux/mfd/=
ts4800-syscon.h
> > new file mode 100644
> > index 0000000..3d29184
> > --- /dev/null
> > +++ b/include/linux/mfd/ts4800-syscon.h
> > @@ -0,0 +1,24 @@
> > +/*
> > + * Copyright (c) 2015 - Savoir-faire Linux
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License as publish=
ed by
> > + * the Free Software Foundation; either version 2 of the License, =
or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope it will be useful, but =
WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABIL=
ITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public L=
icense for
> > + * more details.
> > + */
> > +
> > +#ifndef __LINUX_MFD_TS4800_SYSCON_H
> > +#define __LINUX_MFD_TS4800_SYSCON_H
> > +
> > +#include <linux/regmap.h>
> > +
> > +struct ts4800_syscon {
> > +	struct regmap		*regmap;
> > +};
> > +
> > +#endif /* __LINUX_MFD_TS4800_SYSCON_H */
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
