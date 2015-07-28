Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36307 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266AbbG1Jqs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 05:46:48 -0400
Received: by wicgb10 with SMTP id gb10so148288610wic.1
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 02:46:47 -0700 (PDT)
Date: Tue, 28 Jul 2015 10:46:43 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150728094643.GT14943@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 27 Jul 2015, Matt Fleming wrote:

> From: Matt Fleming <matt.fleming@intel.com>
>=20
> Intel Sunrisepoint (Skylake PCH) has the iTCO watchdog accessible acr=
oss
> the SMBus, unlike previous generations of PCH/ICH where it was on the
> LPC bus. Because it's on the SMBus, it doesn't make sense to pass aro=
und
> a 'struct lpc_ich_info', and leaking the type of bus into the iTCO
> watchdog driver is kind of backwards anyway.
>=20
> This change introduces a new 'struct iTCO_wdt_platform_data' for use
> inside the iTCO watchdog driver and by the upcoming Intel Sunrisepoin=
t
> code, which neatly avoids having to include lpc_ich headers in the i8=
01
> i2c driver.
>=20
> A simple translation layer is provided for converting from the existi=
ng
> 'struct lpc_ich_info' inside the lpc_ich mfd driver.
>=20
> Cc: Peter Tyser <ptyser@xes-inc.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> ---
>  drivers/mfd/lpc_ich.c                  | 32 ++++++++++++++++++++++++=
+++++---
>  drivers/watchdog/Kconfig               |  2 +-
>  drivers/watchdog/iTCO_wdt.c            | 11 +++++------
>  include/linux/mfd/lpc_ich.h            |  6 ------
>  include/linux/platform_data/iTCO_wdt.h | 18 ++++++++++++++++++
>  5 files changed, 53 insertions(+), 16 deletions(-)
>  create mode 100644 include/linux/platform_data/iTCO_wdt.h
>=20
> diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
> index 8de34398abc0..d190b74a6321 100644
> --- a/drivers/mfd/lpc_ich.c
> +++ b/drivers/mfd/lpc_ich.c
> @@ -66,6 +66,7 @@
>  #include <linux/pci.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/lpc_ich.h>
> +#include <linux/platform_data/iTCO_wdt.h>

Lowercase please.

>  #define ACPIBASE		0x40
>  #define ACPIBASE_GPE_OFF	0x28
> @@ -835,9 +836,31 @@ static void lpc_ich_enable_pmc_space(struct pci_=
dev *dev)
>  	priv->actrl_pbase_save =3D reg_save;
>  }
> =20
> -static void lpc_ich_finalize_cell(struct pci_dev *dev, struct mfd_ce=
ll *cell)
> +static int lpc_ich_finalize_wdt_cell(struct pci_dev *dev)
>  {
> +	struct iTCO_wdt_platform_data *pdata;

Lowercase please.

>  	struct lpc_ich_priv *priv =3D pci_get_drvdata(dev);
> +	struct lpc_ich_info *info;
> +	struct mfd_cell *cell =3D &lpc_ich_cells[LPC_WDT];
> +
> +	pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;

Where is this freed?

Better to use devm_*

> +	info =3D &lpc_chipset_info[priv->chipset];
> +
> +	pdata->iTCO_version =3D info->iTCO_version;

Lowercase please.

> +	strcpy(pdata->name, info->name);

strncpy() is safer.

> +	cell->platform_data =3D pdata;
> +	cell->pdata_size =3D sizeof(*pdata);
> +	return 0;
> +}
> +
> +static void lpc_ich_finalize_gpio_cell(struct pci_dev *dev)
> +{
> +	struct lpc_ich_priv *priv =3D pci_get_drvdata(dev);
> +	struct mfd_cell *cell =3D &lpc_ich_cells[LPC_GPIO];
> =20
>  	cell->platform_data =3D &lpc_chipset_info[priv->chipset];
>  	cell->pdata_size =3D sizeof(struct lpc_ich_info);

It's pretty hard to tell from the patch without applying it, but what
are the actual similarities and differences between the two finalise
functions?  They looks like they share enough lines for it to make
sense to have one function call and do different things in say a
switch statement, no?

> @@ -933,7 +956,7 @@ gpe0_done:
>  	lpc_chipset_info[priv->chipset].use_gpio =3D ret;
>  	lpc_ich_enable_gpio_space(dev);
> =20
> -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_GPIO]);
> +	lpc_ich_finalize_gpio_cell(dev);
>  	ret =3D mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
>  			      &lpc_ich_cells[LPC_GPIO], 1, NULL, 0, NULL);
> =20
> @@ -1007,7 +1030,10 @@ static int lpc_ich_init_wdt(struct pci_dev *de=
v)
>  		res->end =3D base_addr + ACPIBASE_PMC_END;
>  	}
> =20
> -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_WDT]);
> +	ret =3D lpc_ich_finalize_wdt_cell(dev);
> +	if (ret)
> +		goto wdt_done;
> +
>  	ret =3D mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
>  			      &lpc_ich_cells[LPC_WDT], 1, NULL, 0, NULL);

Why do you have an mfd_add_devices() call for each device?

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 241fafde42cb..5336fe2ff689 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -797,7 +797,7 @@ config ITCO_WDT
>  	tristate "Intel TCO Timer/Watchdog"
>  	depends on (X86 || IA64) && PCI
>  	select WATCHDOG_CORE
> -	select LPC_ICH
> +	depends on LPC_ICH || I2C_I801
>  	---help---
>  	  Hardware driver for the intel TCO timer based watchdog devices.
>  	  These drivers are included in the Intel 82801 I/O Controller
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.=
c
> index 3c3fd417ddeb..9a6e70976f64 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -66,8 +66,7 @@
>  #include <linux/spinlock.h>		/* For spin_lock/spin_unlock/... */
>  #include <linux/uaccess.h>		/* For copy_to_user/put_user/... */
>  #include <linux/io.h>			/* For inb/outb/... */
> -#include <linux/mfd/core.h>
> -#include <linux/mfd/lpc_ich.h>
> +#include <linux/platform_data/iTCO_wdt.h>
> =20
>  #include "iTCO_vendor.h"
> =20
> @@ -418,9 +417,9 @@ static int iTCO_wdt_probe(struct platform_device =
*dev)
>  {
>  	int ret =3D -ENODEV;
>  	unsigned long val32;
> -	struct lpc_ich_info *ich_info =3D dev_get_platdata(&dev->dev);
> +	struct iTCO_wdt_platform_data *pdata =3D dev_get_platdata(&dev->dev=
);
> =20
> -	if (!ich_info)
> +	if (!pdata)
>  		goto out;
> =20
>  	spin_lock_init(&iTCO_wdt_private.io_lock);
> @@ -435,7 +434,7 @@ static int iTCO_wdt_probe(struct platform_device =
*dev)
>  	if (!iTCO_wdt_private.smi_res)
>  		goto out;
> =20
> -	iTCO_wdt_private.iTCO_version =3D ich_info->iTCO_version;
> +	iTCO_wdt_private.iTCO_version =3D pdata->iTCO_version;
>  	iTCO_wdt_private.dev =3D dev;
>  	iTCO_wdt_private.pdev =3D to_pci_dev(dev->dev.parent);
> =20
> @@ -501,7 +500,7 @@ static int iTCO_wdt_probe(struct platform_device =
*dev)
>  	}
> =20
>  	pr_info("Found a %s TCO device (Version=3D%d, TCOBASE=3D0x%04llx)\n=
",
> -		ich_info->name, ich_info->iTCO_version, (u64)TCOBASE);
> +		pdata->name, pdata->iTCO_version, (u64)TCOBASE);
> =20
>  	/* Clear out the (probably old) status */
>  	if (iTCO_wdt_private.iTCO_version =3D=3D 3) {
> diff --git a/include/linux/mfd/lpc_ich.h b/include/linux/mfd/lpc_ich.=
h
> index 8feac782fa83..2b300b44f994 100644
> --- a/include/linux/mfd/lpc_ich.h
> +++ b/include/linux/mfd/lpc_ich.h
> @@ -20,12 +20,6 @@
>  #ifndef LPC_ICH_H
>  #define LPC_ICH_H
> =20
> -/* Watchdog resources */
> -#define ICH_RES_IO_TCO		0
> -#define ICH_RES_IO_SMI		1
> -#define ICH_RES_MEM_OFF		2
> -#define ICH_RES_MEM_GCS_PMC	0
> -
>  /* GPIO resources */
>  #define ICH_RES_GPIO	0
>  #define ICH_RES_GPE0	1
> diff --git a/include/linux/platform_data/iTCO_wdt.h b/include/linux/p=
latform_data/iTCO_wdt.h
> new file mode 100644
> index 000000000000..ce53c2b01f6d
> --- /dev/null
> +++ b/include/linux/platform_data/iTCO_wdt.h
> @@ -0,0 +1,18 @@
> +/*
> + * Platform data for the Intel TCO Watchdog
> + */
> +
> +#ifndef _ITCO_WDT_H_
> +
> +/* Watchdog resources */
> +#define ICH_RES_IO_TCO		0
> +#define ICH_RES_IO_SMI		1
> +#define ICH_RES_MEM_OFF		2
> +#define ICH_RES_MEM_GCS_PMC	0
> +
> +struct iTCO_wdt_platform_data {
> +	char name[32];
> +	unsigned int iTCO_version;
> +};
> +
> +#endif /* _ITCO_WDT_H_ */

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
