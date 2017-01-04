Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wj0-f170.google.com ([209.85.210.170]:36442 "EHLO
        mail-wj0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757721AbdADMPU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 4 Jan 2017 07:15:20 -0500
Received: by mail-wj0-f170.google.com with SMTP id c11so262731079wjx.3
        for <linux-watchdog@vger.kernel.org>; Wed, 04 Jan 2017 04:15:19 -0800 (PST)
Date: Wed, 4 Jan 2017 12:19:01 +0000
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
Subject: Re: [PATCH V5 4/8] mfd: da9061: MFD core support
Message-ID: <20170104121901.GC24225@dell>
References: <cover.1481828921.git.stwiss.opensource@diasemi.com>
 <ad649a91daa6191f2385dfe79c6ec8ca339f597c.1481828921.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad649a91daa6191f2385dfe79c6ec8ca339f597c.1481828921.git.stwiss.opensource@diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Dec 2016, Steve Twiss wrote:

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
> This patch applies against linux-next and v4.9
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
> Steve Twiss, Dialog Semiconductor Ltd.
>=20
>=20
>  drivers/mfd/Kconfig                  |   5 +-
>  drivers/mfd/da9062-core.c            | 424 +++++++++++++++++++++++++++=
++++++--
>  include/linux/mfd/da9062/core.h      |  27 ++-
>  include/linux/mfd/da9062/registers.h |   2 +
>  4 files changed, 439 insertions(+), 19 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
 =20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index c6df644..a1a780c 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -246,13 +246,14 @@ config MFD_DA9055
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
> index 8f873866..4b5f70f 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -1,5 +1,5 @@
>  /*
> - * Core, IRQ and I2C device driver for DA9062 PMIC
> + * Core, IRQ and I2C device driver for DA9061 and DA9062 PMICs
>   * Copyright (C) 2015  Dialog Semiconductor Ltd.
>   *
>   * This program is free software; you can redistribute it and/or
> @@ -30,6 +30,70 @@
>  #define	DA9062_REG_EVENT_B_OFFSET	1
>  #define	DA9062_REG_EVENT_C_OFFSET	2
> =20
> +static struct regmap_irq da9061_irqs[] =3D {
> +	/* EVENT A */
> +	[DA9061_IRQ_ONKEY] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_A_OFFSET,
> +		.mask =3D DA9062AA_M_NONKEY_MASK,
> +	},
> +	[DA9061_IRQ_WDG_WARN] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_A_OFFSET,
> +		.mask =3D DA9062AA_M_WDG_WARN_MASK,
> +	},
> +	[DA9061_IRQ_SEQ_RDY] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_A_OFFSET,
> +		.mask =3D DA9062AA_M_SEQ_RDY_MASK,
> +	},
> +	/* EVENT B */
> +	[DA9061_IRQ_TEMP] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_B_OFFSET,
> +		.mask =3D DA9062AA_M_TEMP_MASK,
> +	},
> +	[DA9061_IRQ_LDO_LIM] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_B_OFFSET,
> +		.mask =3D DA9062AA_M_LDO_LIM_MASK,
> +	},
> +	[DA9061_IRQ_DVC_RDY] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_B_OFFSET,
> +		.mask =3D DA9062AA_M_DVC_RDY_MASK,
> +	},
> +	[DA9061_IRQ_VDD_WARN] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_B_OFFSET,
> +		.mask =3D DA9062AA_M_VDD_WARN_MASK,
> +	},
> +	/* EVENT C */
> +	[DA9061_IRQ_GPI0] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_C_OFFSET,
> +		.mask =3D DA9062AA_M_GPI0_MASK,
> +	},
> +	[DA9061_IRQ_GPI1] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_C_OFFSET,
> +		.mask =3D DA9062AA_M_GPI1_MASK,
> +	},
> +	[DA9061_IRQ_GPI2] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_C_OFFSET,
> +		.mask =3D DA9062AA_M_GPI2_MASK,
> +	},
> +	[DA9061_IRQ_GPI3] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_C_OFFSET,
> +		.mask =3D DA9062AA_M_GPI3_MASK,
> +	},
> +	[DA9061_IRQ_GPI4] =3D {
> +		.reg_offset =3D DA9062_REG_EVENT_C_OFFSET,
> +		.mask =3D DA9062AA_M_GPI4_MASK,
> +	},
> +};
> +
> +static struct regmap_irq_chip da9061_irq_chip =3D {
> +	.name =3D "da9061-irq",
> +	.irqs =3D da9061_irqs,
> +	.num_irqs =3D DA9061_NUM_IRQ,
> +	.num_regs =3D 3,
> +	.status_base =3D DA9062AA_EVENT_A,
> +	.mask_base =3D DA9062AA_IRQ_MASK_A,
> +	.ack_base =3D DA9062AA_EVENT_A,
> +};
> +
>  static struct regmap_irq da9062_irqs[] =3D {
>  	/* EVENT A */
>  	[DA9062_IRQ_ONKEY] =3D {
> @@ -102,6 +166,57 @@
>  	.ack_base =3D DA9062AA_EVENT_A,
>  };
> =20
> +static struct resource da9061_core_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_VDD_WARN, "VDD_WARN"),
> +};
> +
> +static struct resource da9061_regulators_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_LDO_LIM, "LDO_LIM"),
> +};
> +
> +static struct resource da9061_thermal_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_TEMP, "THERMAL"),
> +};
> +
> +static struct resource da9061_wdt_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_WDG_WARN, "WD_WARN"),
> +};
> +
> +static struct resource da9061_onkey_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_ONKEY, "ONKEY"),
> +};
> +
> +static const struct mfd_cell da9061_devs[] =3D {
> +	{
> +		.name		=3D "da9061-core",
> +		.num_resources	=3D ARRAY_SIZE(da9061_core_resources),
> +		.resources	=3D da9061_core_resources,
> +	},
> +	{
> +		.name		=3D "da9062-regulators",
> +		.num_resources	=3D ARRAY_SIZE(da9061_regulators_resources),
> +		.resources	=3D da9061_regulators_resources,
> +	},
> +	{
> +		.name		=3D "da9061-watchdog",
> +		.num_resources	=3D ARRAY_SIZE(da9061_wdt_resources),
> +		.resources	=3D da9061_wdt_resources,
> +		.of_compatible  =3D "dlg,da9061-watchdog",
> +	},
> +	{
> +		.name		=3D "da9061-thermal",
> +		.num_resources	=3D ARRAY_SIZE(da9061_thermal_resources),
> +		.resources	=3D da9061_thermal_resources,
> +		.of_compatible  =3D "dlg,da9061-thermal",
> +	},
> +	{
> +		.name		=3D "da9061-onkey",
> +		.num_resources	=3D ARRAY_SIZE(da9061_onkey_resources),
> +		.resources	=3D da9061_onkey_resources,
> +		.of_compatible =3D "dlg,da9061-onkey",
> +	},
> +};
> +
>  static struct resource da9062_core_resources[] =3D {
>  	DEFINE_RES_NAMED(DA9062_IRQ_VDD_WARN, 1, "VDD_WARN", IORESOURCE_IRQ),
>  };
> @@ -200,7 +315,8 @@ static int da9062_clear_fault_log(struct da9062 *ch=
ip)
> =20
>  static int da9062_get_device_type(struct da9062 *chip)
>  {
> -	int device_id, variant_id, variant_mrc;
> +	int device_id, variant_id, variant_mrc, variant_vrc;
> +	char *type;
>  	int ret;
> =20
>  	ret =3D regmap_read(chip->regmap, DA9062AA_DEVICE_ID, &device_id);
> @@ -219,9 +335,23 @@ static int da9062_get_device_type(struct da9062 *c=
hip)
>  		return -EIO;
>  	}
> =20
> +	variant_vrc =3D (variant_id & DA9062AA_VRC_MASK) >> DA9062AA_VRC_SHIF=
T;
> +
> +	switch (variant_vrc) {
> +	case DA9062_PMIC_VARIANT_VRC_DA9061:
> +		type =3D "DA9061";
> +		break;
> +	case DA9062_PMIC_VARIANT_VRC_DA9062:
> +		type =3D "DA9062";
> +		break;
> +	default:
> +		type =3D "Unknown";
> +		break;
> +	}
> +
>  	dev_info(chip->dev,
> -		 "Device detected (device-ID: 0x%02X, var-ID: 0x%02X)\n",
> -		 device_id, variant_id);
> +		 "Device detected (device-ID: 0x%02X, var-ID: 0x%02X, %s)\n",
> +		 device_id, variant_id, type);
> =20
>  	variant_mrc =3D (variant_id & DA9062AA_MRC_MASK) >> DA9062AA_MRC_SHIF=
T;
> =20
> @@ -234,6 +364,234 @@ static int da9062_get_device_type(struct da9062 *=
chip)
>  	return ret;
>  }
> =20
> +static const struct regmap_range da9061_aa_readable_ranges[] =3D {
> +	{
> +		.range_min =3D DA9062AA_PAGE_CON,
> +		.range_max =3D DA9062AA_STATUS_B,
> +	}, {
> +		.range_min =3D DA9062AA_STATUS_D,
> +		.range_max =3D DA9062AA_EVENT_C,
> +	}, {
> +		.range_min =3D DA9062AA_IRQ_MASK_A,
> +		.range_max =3D DA9062AA_IRQ_MASK_C,
> +	}, {
> +		.range_min =3D DA9062AA_CONTROL_A,
> +		.range_max =3D DA9062AA_GPIO_4,
> +	}, {
> +		.range_min =3D DA9062AA_GPIO_WKUP_MODE,
> +		.range_max =3D DA9062AA_GPIO_OUT3_4,
> +	}, {
> +		.range_min =3D DA9062AA_BUCK1_CONT,
> +		.range_max =3D DA9062AA_BUCK4_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_BUCK3_CONT,
> +		.range_max =3D DA9062AA_BUCK3_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_LDO1_CONT,
> +		.range_max =3D DA9062AA_LDO4_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_DVC_1,
> +		.range_max =3D DA9062AA_DVC_1,
> +	}, {
> +		.range_min =3D DA9062AA_SEQ,
> +		.range_max =3D DA9062AA_ID_4_3,
> +	}, {
> +		.range_min =3D DA9062AA_ID_12_11,
> +		.range_max =3D DA9062AA_ID_16_15,
> +	}, {
> +		.range_min =3D DA9062AA_ID_22_21,
> +		.range_max =3D DA9062AA_ID_32_31,
> +	}, {
> +		.range_min =3D DA9062AA_SEQ_A,
> +		.range_max =3D DA9062AA_WAIT,
> +	}, {
> +		.range_min =3D DA9062AA_RESET,
> +		.range_max =3D DA9062AA_BUCK_ILIM_C,
> +	}, {
> +		.range_min =3D DA9062AA_BUCK1_CFG,
> +		.range_max =3D DA9062AA_BUCK3_CFG,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK1_A,
> +		.range_max =3D DA9062AA_VBUCK4_A,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK3_A,
> +		.range_max =3D DA9062AA_VBUCK3_A,
> +	}, {
> +		.range_min =3D DA9062AA_VLDO1_A,
> +		.range_max =3D DA9062AA_VLDO4_A,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK1_B,
> +		.range_max =3D DA9062AA_VBUCK4_B,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK3_B,
> +		.range_max =3D DA9062AA_VBUCK3_B,
> +	}, {
> +		.range_min =3D DA9062AA_VLDO1_B,
> +		.range_max =3D DA9062AA_VLDO4_B,
> +	}, {
> +		.range_min =3D DA9062AA_BBAT_CONT,
> +		.range_max =3D DA9062AA_BBAT_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_INTERFACE,
> +		.range_max =3D DA9062AA_CONFIG_E,
> +	}, {
> +		.range_min =3D DA9062AA_CONFIG_G,
> +		.range_max =3D DA9062AA_CONFIG_K,
> +	}, {
> +		.range_min =3D DA9062AA_CONFIG_M,
> +		.range_max =3D DA9062AA_CONFIG_M,
> +	}, {
> +		.range_min =3D DA9062AA_GP_ID_0,
> +		.range_max =3D DA9062AA_GP_ID_19,
> +	}, {
> +		.range_min =3D DA9062AA_DEVICE_ID,
> +		.range_max =3D DA9062AA_CONFIG_ID,
> +	},
> +};
> +
> +static const struct regmap_range da9061_aa_writeable_ranges[] =3D {
> +	{
> +		.range_min =3D DA9062AA_PAGE_CON,
> +		.range_max =3D DA9062AA_PAGE_CON,
> +	}, {
> +		.range_min =3D DA9062AA_FAULT_LOG,
> +		.range_max =3D DA9062AA_EVENT_C,
> +	}, {
> +		.range_min =3D DA9062AA_IRQ_MASK_A,
> +		.range_max =3D DA9062AA_IRQ_MASK_C,
> +	}, {
> +		.range_min =3D DA9062AA_CONTROL_A,
> +		.range_max =3D DA9062AA_GPIO_4,
> +	}, {
> +		.range_min =3D DA9062AA_GPIO_WKUP_MODE,
> +		.range_max =3D DA9062AA_GPIO_OUT3_4,
> +	}, {
> +		.range_min =3D DA9062AA_BUCK1_CONT,
> +		.range_max =3D DA9062AA_BUCK4_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_BUCK3_CONT,
> +		.range_max =3D DA9062AA_BUCK3_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_LDO1_CONT,
> +		.range_max =3D DA9062AA_LDO4_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_DVC_1,
> +		.range_max =3D DA9062AA_DVC_1,
> +	}, {
> +		.range_min =3D DA9062AA_SEQ,
> +		.range_max =3D DA9062AA_ID_4_3,
> +	}, {
> +		.range_min =3D DA9062AA_ID_12_11,
> +		.range_max =3D DA9062AA_ID_16_15,
> +	}, {
> +		.range_min =3D DA9062AA_ID_22_21,
> +		.range_max =3D DA9062AA_ID_32_31,
> +	}, {
> +		.range_min =3D DA9062AA_SEQ_A,
> +		.range_max =3D DA9062AA_WAIT,
> +	}, {
> +		.range_min =3D DA9062AA_RESET,
> +		.range_max =3D DA9062AA_BUCK_ILIM_C,
> +	}, {
> +		.range_min =3D DA9062AA_BUCK1_CFG,
> +		.range_max =3D DA9062AA_BUCK3_CFG,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK1_A,
> +		.range_max =3D DA9062AA_VBUCK4_A,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK3_A,
> +		.range_max =3D DA9062AA_VBUCK3_A,
> +	}, {
> +		.range_min =3D DA9062AA_VLDO1_A,
> +		.range_max =3D DA9062AA_VLDO4_A,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK1_B,
> +		.range_max =3D DA9062AA_VBUCK4_B,
> +	}, {
> +		.range_min =3D DA9062AA_VBUCK3_B,
> +		.range_max =3D DA9062AA_VBUCK3_B,
> +	}, {
> +		.range_min =3D DA9062AA_VLDO1_B,
> +		.range_max =3D DA9062AA_VLDO4_B,
> +	}, {
> +		.range_min =3D DA9062AA_BBAT_CONT,
> +		.range_max =3D DA9062AA_BBAT_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_GP_ID_0,
> +		.range_max =3D DA9062AA_GP_ID_19,
> +	},
> +};
> +
> +static const struct regmap_range da9061_aa_volatile_ranges[] =3D {
> +	{
> +		.range_min =3D DA9062AA_PAGE_CON,
> +		.range_max =3D DA9062AA_STATUS_B,
> +	}, {
> +		.range_min =3D DA9062AA_STATUS_D,
> +		.range_max =3D DA9062AA_EVENT_C,
> +	}, {
> +		.range_min =3D DA9062AA_CONTROL_A,
> +		.range_max =3D DA9062AA_CONTROL_B,
> +	}, {
> +		.range_min =3D DA9062AA_CONTROL_E,
> +		.range_max =3D DA9062AA_CONTROL_F,
> +	}, {
> +		.range_min =3D DA9062AA_BUCK1_CONT,
> +		.range_max =3D DA9062AA_BUCK4_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_BUCK3_CONT,
> +		.range_max =3D DA9062AA_BUCK3_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_LDO1_CONT,
> +		.range_max =3D DA9062AA_LDO4_CONT,
> +	}, {
> +		.range_min =3D DA9062AA_DVC_1,
> +		.range_max =3D DA9062AA_DVC_1,
> +	}, {
> +		.range_min =3D DA9062AA_SEQ,
> +		.range_max =3D DA9062AA_SEQ,
> +	},
> +};
> +
> +static const struct regmap_access_table da9061_aa_readable_table =3D {
> +	.yes_ranges =3D da9061_aa_readable_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(da9061_aa_readable_ranges),
> +};
> +
> +static const struct regmap_access_table da9061_aa_writeable_table =3D =
{
> +	.yes_ranges =3D da9061_aa_writeable_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(da9061_aa_writeable_ranges),
> +};
> +
> +static const struct regmap_access_table da9061_aa_volatile_table =3D {
> +	.yes_ranges =3D da9061_aa_volatile_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(da9061_aa_volatile_ranges),
> +};
> +
> +static const struct regmap_range_cfg da9061_range_cfg[] =3D {
> +	{
> +		.range_min =3D DA9062AA_PAGE_CON,
> +		.range_max =3D DA9062AA_CONFIG_ID,
> +		.selector_reg =3D DA9062AA_PAGE_CON,
> +		.selector_mask =3D 1 << DA9062_I2C_PAGE_SEL_SHIFT,
> +		.selector_shift =3D DA9062_I2C_PAGE_SEL_SHIFT,
> +		.window_start =3D 0,
> +		.window_len =3D 256,
> +	}
> +};
> +
> +static struct regmap_config da9061_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.ranges =3D da9061_range_cfg,
> +	.num_ranges =3D ARRAY_SIZE(da9061_range_cfg),
> +	.max_register =3D DA9062AA_CONFIG_ID,
> +	.cache_type =3D REGCACHE_RBTREE,
> +	.rd_table =3D &da9061_aa_readable_table,
> +	.wr_table =3D &da9061_aa_writeable_table,
> +	.volatile_table =3D &da9061_aa_volatile_table,
> +};
> +
>  static const struct regmap_range da9062_aa_readable_ranges[] =3D {
>  	{
>  		.range_min =3D DA9062AA_PAGE_CON,
> @@ -456,17 +814,38 @@ static int da9062_get_device_type(struct da9062 *=
chip)
>  	.volatile_table =3D &da9062_aa_volatile_table,
>  };
> =20
> +static const struct of_device_id da9062_dt_ids[] =3D {
> +	{ .compatible =3D "dlg,da9061", .data =3D (void *)COMPAT_TYPE_DA9061,=
 },
> +	{ .compatible =3D "dlg,da9062", .data =3D (void *)COMPAT_TYPE_DA9062,=
 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, da9062_dt_ids);
> +
>  static int da9062_i2c_probe(struct i2c_client *i2c,
>  	const struct i2c_device_id *id)
>  {
>  	struct da9062 *chip;
> +	const struct of_device_id *match;
>  	unsigned int irq_base;
> +	const struct mfd_cell *cell;
> +	const struct regmap_irq_chip *irq_chip;
> +	const struct regmap_config *config;
> +	int cell_num;
>  	int ret;
> =20
>  	chip =3D devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
>  	if (!chip)
>  		return -ENOMEM;
> =20
> +	if (i2c->dev.of_node) {
> +		match =3D of_match_node(da9062_dt_ids, i2c->dev.of_node);
> +		if (!match)
> +			return -EINVAL;
> +
> +		chip->chip_type =3D (int)match->data;
> +	} else
> +		chip->chip_type =3D id->driver_data;
> +
>  	i2c_set_clientdata(i2c, chip);
>  	chip->dev =3D &i2c->dev;
> =20
> @@ -475,7 +854,25 @@ static int da9062_i2c_probe(struct i2c_client *i2c=
,
>  		return -EINVAL;
>  	}
> =20
> -	chip->regmap =3D devm_regmap_init_i2c(i2c, &da9062_regmap_config);
> +	switch (chip->chip_type) {
> +	case(COMPAT_TYPE_DA9061):
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
> +	chip->regmap =3D devm_regmap_init_i2c(i2c, config);
>  	if (IS_ERR(chip->regmap)) {
>  		ret =3D PTR_ERR(chip->regmap);
>  		dev_err(chip->dev, "Failed to allocate register map: %d\n",
> @@ -493,7 +890,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
> =20
>  	ret =3D regmap_add_irq_chip(chip->regmap, i2c->irq,
>  			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> -			-1, &da9062_irq_chip,
> +			-1, irq_chip,
>  			&chip->regmap_irq);
>  	if (ret) {
>  		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
> @@ -503,8 +900,8 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
> =20
>  	irq_base =3D regmap_irq_chip_get_base(chip->regmap_irq);
> =20
> -	ret =3D mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE, da9062_devs,
> -			      ARRAY_SIZE(da9062_devs), NULL, irq_base,
> +	ret =3D mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE, cell,
> +			      cell_num, NULL, irq_base,
>  			      NULL);
>  	if (ret) {
>  		dev_err(chip->dev, "Cannot register child devices\n");
> @@ -526,17 +923,12 @@ static int da9062_i2c_remove(struct i2c_client *i=
2c)
>  }
> =20
>  static const struct i2c_device_id da9062_i2c_id[] =3D {
> -	{ "da9062", 0 },
> +	{ "da9061", COMPAT_TYPE_DA9061 },
> +	{ "da9062", COMPAT_TYPE_DA9062 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, da9062_i2c_id);
> =20
> -static const struct of_device_id da9062_dt_ids[] =3D {
> -	{ .compatible =3D "dlg,da9062", },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, da9062_dt_ids);
> -
>  static struct i2c_driver da9062_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D "da9062",
> @@ -549,6 +941,6 @@ static int da9062_i2c_remove(struct i2c_client *i2c=
)
> =20
>  module_i2c_driver(da9062_i2c_driver);
> =20
> -MODULE_DESCRIPTION("Core device driver for Dialog DA9062");
> +MODULE_DESCRIPTION("Core device driver for Dialog DA9061 and DA9062");
>  MODULE_AUTHOR("Steve Twiss <stwiss.opensource@diasemi.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/da9062/core.h b/include/linux/mfd/da9062=
/core.h
> index 376ba84..199c524 100644
> --- a/include/linux/mfd/da9062/core.h
> +++ b/include/linux/mfd/da9062/core.h
> @@ -18,7 +18,31 @@
>  #include <linux/interrupt.h>
>  #include <linux/mfd/da9062/registers.h>
> =20
> -/* Interrupts */
> +enum da9062_compatible_types {
> +	COMPAT_TYPE_DA9061 =3D 1,
> +	COMPAT_TYPE_DA9062,
> +};
> +
> +enum da9061_irqs {
> +	/* IRQ A */
> +	DA9061_IRQ_ONKEY,
> +	DA9061_IRQ_WDG_WARN,
> +	DA9061_IRQ_SEQ_RDY,
> +	/* IRQ B*/
> +	DA9061_IRQ_TEMP,
> +	DA9061_IRQ_LDO_LIM,
> +	DA9061_IRQ_DVC_RDY,
> +	DA9061_IRQ_VDD_WARN,
> +	/* IRQ C */
> +	DA9061_IRQ_GPI0,
> +	DA9061_IRQ_GPI1,
> +	DA9061_IRQ_GPI2,
> +	DA9061_IRQ_GPI3,
> +	DA9061_IRQ_GPI4,
> +
> +	DA9061_NUM_IRQ,
> +};
> +
>  enum da9062_irqs {
>  	/* IRQ A */
>  	DA9062_IRQ_ONKEY,
> @@ -45,6 +69,7 @@ struct da9062 {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct regmap_irq_chip_data *regmap_irq;
> +	enum da9062_compatible_types chip_type;
>  };
> =20
>  #endif /* __MFD_DA9062_CORE_H__ */
> diff --git a/include/linux/mfd/da9062/registers.h b/include/linux/mfd/d=
a9062/registers.h
> index 97790d1..4457fdc 100644
> --- a/include/linux/mfd/da9062/registers.h
> +++ b/include/linux/mfd/da9062/registers.h
> @@ -18,6 +18,8 @@
> =20
>  #define DA9062_PMIC_DEVICE_ID		0x62
>  #define DA9062_PMIC_VARIANT_MRC_AA	0x01
> +#define DA9062_PMIC_VARIANT_VRC_DA9061	0x01
> +#define DA9062_PMIC_VARIANT_VRC_DA9062	0x02
> =20
>  #define DA9062_I2C_PAGE_SEL_SHIFT	1
> =20

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
