Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33859 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbdDCOMT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Apr 2017 10:12:19 -0400
Received: by mail-wr0-f170.google.com with SMTP id l43so173146535wre.1
        for <linux-watchdog@vger.kernel.org>; Mon, 03 Apr 2017 07:12:18 -0700 (PDT)
Date: Mon, 3 Apr 2017 15:12:14 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V7 4/7] mfd: da9061: MFD core support
Message-ID: <20170403141214.q6ndii6c47pqfqx6@dell>
References: <cover.1490712213.git.stwiss.opensource@diasemi.com>
 <8987877cc54940358c5b7a65ca003cedc5586f0d.1490712213.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8987877cc54940358c5b7a65ca003cedc5586f0d.1490712213.git.stwiss.opensource@diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Mar 2017, Steve Twiss wrote:

> From: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> MFD support for DA9061 is provided as part of the DA9062 device driver.
>=20
> The registers header file adds two new chip variant IDs defined in DA90=
61
> and DA9062 hardware. The core header file adds new software enumeration=
s
> for listing the valid DA9061 IRQs and a da9062_compatible_types enumera=
tion
> for distinguishing between DA9061/62 devices in software.
>=20
> The core source code adds a new .compatible of_device_id entry. This is
> extended from DA9062 to support both "dlg,da9061" and "dlg,da9062". The
> .data entry now holds a reference to the enumerated device type.
>=20
> A new regmap_irq_chip model is added for DA9061 and this supports the n=
ew
> list of regmap_irq entries. A new mfd_cell da9061_devs[] array lists th=
e
> new sub system components for DA9061. Support is added for a new DA9061
> regmap_config which lists the correct readable, writable and volatile
> ranges for this chip.
>=20
> The probe function uses the device tree compatible string to switch on =
the
> da9062_compatible_types and configure the correct mfd cells, irq chip a=
nd
> regmap config.
> =20
> Kconfig is updated to reflect support for DA9061 and DA9062 PMICs.
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> Acked-for-mfd-by: Lee Jones <lee.jones@linaro.org>
>=20
> Hi Lee, that Ack was from your earlier posting:
> https://lkml.org/lkml/2017/1/4/328 this was
> Regards, Steve.
>=20
> This patch applies against linux-next and v4.11-rc3
>=20
> v6 -> v7
>  - Remove compilation warning when casting a void * to an integer on
>    ARCH=3Dx86_64 using -Wpointer-to-int-cast.
>  - Recommendation uintptr_t cast: https://lkml.org/lkml/2017/3/28/292
>  - Compile tested ARCH=3Dx86_64
>=20
> v5 -> v6
>  - Rebased from v4.9 to v4.11-rc3
>  - Modify Copyright to match Dialog latest legal statement
>  - Fixed "braces {} should be used on all arms" checkpatch warning
>=20
> v4 -> v5
>  - NO CODE CHANGE
>  - Rebased from v4.8 to v4.9
>=20
> v3 -> v4
>  - Patch renamed from [PATCH V3 5/9] to [PATCH V4 4/8]
>  - Removed DEFINE_RES_NAMED() macros for DA9061 resources and replaced
>    them with DEFINE_RES_IRQ_NAMED().
>  - Removed whitespace
>  - Reverted change for badly defined mfd_cell da9062_devs of_compatible
>    string from "dlg,da9062-watchdog" back to "dlg,da9062-wdt"
>=20
> v2 -> v3
>  - NO CODE CHANGE
>  - Patch renamed from [PATCH V2 05/10] to [PATCH V3 5/9]
>=20
> v1 -> v2
>  - Patch renamed from [PATCH V1 01/10] to [PATCH V2 05/10] -- these
>    changes were made to fix checkpatch warnings caused by the patch
>    set dependency order
>  - Fixed typo in the commit message "readble" to "readable"
>  - Removed the explicit cross-check to decide if there is a conflict
>    between the device tree compatible string and the hardware definitio=
n.
>    This patch assumes the device tree is correctly written and therefor=
e
>    removes the need for a hardware/DT sanity check.
>  - Removed extra semicolon in drivers/mfd/da9062-core.c:877
>  - Re-write compatible entries into numerical order
>=20
> Lee,
>=20
> Changes as described in the version history above.
>=20
> As previously:
> This patch adds support for the DA9061 PMIC. This is done as part of th=
e
> existing DA9062 device driver by extending the of_device_id match table=
.
> This in turn allows new MFD cells, irq chip and regmap definitions to
> support DA9061.
>=20
> Regards,
> Steve Twiss, Dialog Semiconductor
>=20
>=20
>  drivers/mfd/Kconfig                  |   5 +-
>  drivers/mfd/da9062-core.c            | 427 +++++++++++++++++++++++++++=
++++++--
>  include/linux/mfd/da9062/core.h      |  29 ++-
>  include/linux/mfd/da9062/registers.h |   5 +-
>  4 files changed, 443 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 55ecdfb..29cc11a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -263,13 +263,14 @@ config MFD_DA9055
>  	  called "da9055"
> =20
>  config MFD_DA9062
> -	tristate "Dialog Semiconductor DA9062 PMIC Support"
> +	tristate "Dialog Semiconductor DA9062/61 PMIC Support"
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
>  	depends on I2C
>  	help
> -	  Say yes here for support for the Dialog Semiconductor DA9062 PMIC.
> +	  Say yes here for support for the Dialog Semiconductor DA9061 and
> +	  DA9062 PMICs.
>  	  This includes the I2C driver and core APIs.
>  	  Additional drivers must be enabled in order to use the functionalit=
y
>  	  of the device.
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index 8f873866..78ab3f4 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c

[...]

> @@ -475,7 +855,25 @@ static int da9062_i2c_probe(struct i2c_client *i2c=
,
>  		return -EINVAL;
>  	}
> =20
> -	chip->regmap =3D devm_regmap_init_i2c(i2c, &da9062_regmap_config);
> +	switch (chip->chip_type) {
> +	case(COMPAT_TYPE_DA9061):

Brackets around the case value?

That's a new one on me.

> +		cell =3D da9061_devs;
> +		cell_num =3D ARRAY_SIZE(da9061_devs);
> +		irq_chip =3D &da9061_irq_chip;
> +		config =3D &da9061_regmap_config;
> +		break;
> +	case(COMPAT_TYPE_DA9062):
> +		cell =3D da9062_devs;
> +		cell_num =3D ARRAY_SIZE(da9062_devs);
> +		irq_chip =3D &da9062_irq_chip;
> +		config =3D &da9062_regmap_config;
> +		break;
> +	default:
> +		dev_err(chip->dev, "Unrecognised chip type\n");
> +		return -ENODEV;
> +	}
> +

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
