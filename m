Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39083 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693Ab2BGIin convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Feb 2012 03:38:43 -0500
MIME-Version: 1.0
In-Reply-To: <1328102793-4313-3-git-send-email-s.hauer@pengutronix.de>
References: <1328102793-4313-1-git-send-email-s.hauer@pengutronix.de> <1328102793-4313-3-git-send-email-s.hauer@pengutronix.de>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Tue, 7 Feb 2012 09:38:22 +0100
Message-ID: <CAH9NwWfmNZ6iSCMX4e-7Vn=tmQTz447Z_fAfyc5YNaBzUhvt-w@mail.gmail.com>
Subject: Re: [PATCH 2/3] i2c: Add Congatec CGEB I2C driver
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
	kernel@pengutronix.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Christian Gmeiner, MSc



2012/2/1 Sascha Hauer <s.hauer@pengutronix.de>:
> This driver provides a I2C bus driver for the CGEB interface
> found on some Congatec x86 modules. No devices are registered
> on the bus, the user has to do this via the i2c device /sys
> interface.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> =C2=A0drivers/i2c/busses/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A07 +
> =C2=A0drivers/i2c/busses/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A01 +
> =C2=A0drivers/i2c/busses/i2c-congatec-cgeb.c | =C2=A0206 ++++++++++++++=
++++++++++++++++++
> =C2=A03 files changed, 214 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 drivers/i2c/busses/i2c-congatec-cgeb.c
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index a3afac4..cc8eb22 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -696,6 +696,13 @@ config I2C_EG20T
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ML7213/ML7223 is companion chip for I=
ntel Atom E6xx series.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ML7213/ML7223 is completely compatibl=
e for Intel EG20T PCH.
>
> +config I2C_CONGATEC_CGEB
> + =C2=A0 =C2=A0 =C2=A0 tristate "Congatec CGEB I2C driver"
> + =C2=A0 =C2=A0 =C2=A0 depends on MFD_CONGATEC_CGEB
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 This driver provides support for the I2C =
busses accssable via
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 the Congatec CGEB interface found on Cong=
atec boards.
> +
> =C2=A0comment "External I2C/SMBus adapter drivers"
>
> =C2=A0config I2C_DIOLAN_U2C
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index fba6da6..4aab659 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_I2C_VERSATILE) =C2=A0 +=3D i2c-versatile=
.o
> =C2=A0obj-$(CONFIG_I2C_OCTEON) =C2=A0 =C2=A0 =C2=A0 +=3D i2c-octeon.o
> =C2=A0obj-$(CONFIG_I2C_XILINX) =C2=A0 =C2=A0 =C2=A0 +=3D i2c-xiic.o
> =C2=A0obj-$(CONFIG_I2C_EG20T) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D i2c-eg20=
t.o
> +obj-$(CONFIG_I2C_CONGATEC_CGEB) =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D i2c-co=
ngatec-cgeb.o
>
> =C2=A0# External I2C/SMBus adapter drivers
> =C2=A0obj-$(CONFIG_I2C_DIOLAN_U2C) =C2=A0 +=3D i2c-diolan-u2c.o
> diff --git a/drivers/i2c/busses/i2c-congatec-cgeb.c b/drivers/i2c/busse=
s/i2c-congatec-cgeb.c
> new file mode 100644
> index 0000000..a387662
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-congatec-cgeb.c
> @@ -0,0 +1,206 @@
> +/*
> + * CGEB i2c driver
> + *
> + * (c) 2011 Sascha Hauer, Pengutronix
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License as published b=
y
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/congatec-cgeb.h>
> +
> +#define CG_I2C_FLAG_START =C2=A0 0x00080 =C2=A0 =C2=A0/* send START co=
ndition */
> +#define CG_I2C_FLAG_STOP =C2=A0 =C2=A00x00040 =C2=A0 =C2=A0/* send STO=
P condition */
> +#define CG_I2C_FLAG_ALL_ACK 0x08000 =C2=A0 =C2=A0/* send ACK on all re=
ad bytes */
> +#define CG_I2C_FLAG_ALL_NAK 0x04000 =C2=A0 =C2=A0/* send NAK on all re=
ad bytes */
> +
> +struct cgeb_i2c_priv {
> + =C2=A0 =C2=A0 =C2=A0 struct cgeb_board_data =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*board;
> + =C2=A0 =C2=A0 =C2=A0 struct i2c_adapter =C2=A0 =C2=A0 =C2=A0adapter;
> + =C2=A0 =C2=A0 =C2=A0 int unit;
> +};
> +
> +static u32 cgeb_i2c_func(struct i2c_adapter *adapter)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static int cgeb_i2c_set_speed(struct cgeb_i2c_priv *priv, int speed)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct cgeb_function_parameters fps;
> +
> + =C2=A0 =C2=A0 =C2=A0 memset(&fps, 0, sizeof(fps));
> +
> + =C2=A0 =C2=A0 =C2=A0 fps.unit =3D priv->unit;
> + =C2=A0 =C2=A0 =C2=A0 fps.pars[0] =3D speed;
> +
> + =C2=A0 =C2=A0 =C2=A0 return cgeb_call(priv->board, &fps, CgebI2CSetFr=
equency);
> +}
> +
> +static int cgeb_i2c_xfer(struct i2c_adapter *adapter,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i2c_msg *msgs=
, int num)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct cgeb_function_parameters fps;
> + =C2=A0 =C2=A0 =C2=A0 int i, ret;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long flags =3D CG_I2C_FLAG_START;
> + =C2=A0 =C2=A0 =C2=A0 struct cgeb_i2c_priv *priv =3D i2c_get_adapdata(=
adapter);
> + =C2=A0 =C2=A0 =C2=A0 unsigned long rdlen, wrlen;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char *rdbuf, *wrbuf, *raw_wrbuf;
> + =C2=A0 =C2=A0 =C2=A0 unsigned short lmax =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* With cgeb the I2C address is part of the=
 write data
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* buffer, so allocate a buffer with the le=
ngth of the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* longest write buffer + 1
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < num; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(msgs[i].flags =
& I2C_M_RD))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 lmax =3D max(lmax, msgs[i].len);
> +
> + =C2=A0 =C2=A0 =C2=A0 raw_wrbuf =3D kmalloc(lmax + 1, GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (!raw_wrbuf)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < num; i++) {
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msgs[i].flags & =
I2C_M_RD) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 rdbuf =3D msgs[i].buf;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 rdlen =3D msgs[i].len;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 wrbuf =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 wrlen =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 rdbuf =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 rdlen =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 wrbuf =3D msgs[i].buf;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 wrlen =3D msgs[i].len;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raw_wrbuf[0] =3D msg=
s[i].addr << 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (wrlen)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 memcpy(&raw_wrbuf[1], wrbuf, wrlen);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msgs[i].flags & =
I2C_M_RD)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 raw_wrbuf[0] |=3D 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D num - 1=
)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 flags |=3D CG_I2C_FLAG_STOP;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&adapter->de=
v,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "%s: rd: %p/%ld wr: %p/%ld flags: 0x%=
08lx %s\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, rdbuf, rdlen, raw_wrbuf, wr=
len + 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msgs[i].flags & I2C_M_RD ? "READ" : "=
WRITE");
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&fps, 0, size=
of(fps));
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fps.unit =3D priv->u=
nit;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fps.pars[0] =3D wrle=
n + 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fps.pars[1] =3D rdle=
n;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fps.pars[2] =3D flag=
s;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fps.iptr =3D raw_wrb=
uf;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fps.optr =3D rdbuf;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D cgeb_call(pr=
iv->board, &fps, CgebI2CTransfer);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D -EREMOTEIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto out;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D num;
> +
> +out:
> + =C2=A0 =C2=A0 =C2=A0 kfree(raw_wrbuf);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +
> +}
> +
> +static struct i2c_algorithm cgeb_i2c_algo =3D {
> + =C2=A0 =C2=A0 =C2=A0 .master_xfer =C2=A0 =C2=A0=3D cgeb_i2c_xfer,
> + =C2=A0 =C2=A0 =C2=A0 .functionality =C2=A0=3D cgeb_i2c_func,
> +};
> +
> +static int __devinit cgeb_i2c_probe(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct cgeb_i2c_priv *priv;
> + =C2=A0 =C2=A0 =C2=A0 struct cgeb_pdata *pdata =3D pdev->dev.platform_=
data;
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv),=
 GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (!priv)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 strcpy(priv->adapter.name, pdev->name);
> + =C2=A0 =C2=A0 =C2=A0 priv->adapter.owner =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D THIS_MODULE;
> + =C2=A0 =C2=A0 =C2=A0 priv->adapter.algo =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D &cgeb_i2c_algo;
> + =C2=A0 =C2=A0 =C2=A0 priv->adapter.dev.parent =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D &pdev->dev;
> + =C2=A0 =C2=A0 =C2=A0 priv->unit =3D pdata->unit;
> + =C2=A0 =C2=A0 =C2=A0 priv->board =3D pdata->board;
> + =C2=A0 =C2=A0 =C2=A0 i2c_set_adapdata(&priv->adapter, priv);
> +
> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, priv);
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D cgeb_i2c_set_speed(priv, 400000);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* not a critic=
al error, we can continue with the default speed.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_warn(&pdev->dev,=
 "Could not set speed to 400KHz\n");
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_add_adapter(&priv->adapter);
> + =C2=A0 =C2=A0 =C2=A0 if (ret < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, =
"registration failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 dev_info(&pdev->dev, "registered\n");
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +};
> +
> +static int __devexit cgeb_i2c_remove(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct cgeb_i2c_priv *priv =3D platform_get_drvd=
ata(pdev);
> +
> + =C2=A0 =C2=A0 =C2=A0 i2c_del_adapter(&priv->adapter);
> +
> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, NULL);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static struct platform_driver cgeb_i2c_driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D cge=
b_i2c_probe,
> + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __exit_p=
(cgeb_i2c_remove),
> + =C2=A0 =C2=A0 =C2=A0 .driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D "cg=
eb-i2c",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =C2=A0=3D THI=
S_MODULE,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +static int __init cgeb_i2c_driver_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return platform_driver_register(&cgeb_i2c_driver=
);
> +}
> +
> +static void __exit cgeb_i2c_driver_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&cgeb_i2c_driver);
> +}
> +
> +module_init(cgeb_i2c_driver_init);
> +module_exit(cgeb_i2c_driver_exit);
> +
> +MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
> +MODULE_DESCRIPTION("cgeb i2c driver");
> +MODULE_LICENSE("GPL");
> --
> 1.7.2.5
>

Patch looks good and runs nicely with some i2c devices (eeprom, io
expander, temp sensors,...)

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: UU UU -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- 39 -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
50: UU UU -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

Tested-by: Christian Gmeiner <christian.gmeiner@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
