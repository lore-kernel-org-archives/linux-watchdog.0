Return-path: <dvhart@infradead.org>
Date: Wed, 5 Aug 2015 13:39:19 -0700
From: Darren Hart <dvhart@infradead.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
	Lee Jones <lee.jones@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Zha Qipeng <qipeng.zha@intel.com>
Subject: Re: [PATCH v3 1/3] iTCO_wdt: Expose watchdog properties using
 platform data
Message-ID: <20150805203919.GA30164@vmdeb7>
References: <1438293541-26131-1-git-send-email-matt@codeblueprint.co.uk>
 <1438293541-26131-2-git-send-email-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438293541-26131-2-git-send-email-matt@codeblueprint.co.uk>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Jul 30, 2015 at 10:58:59PM +0100, Matt Fleming wrote:
> From: Matt Fleming <matt.fleming@intel.com>
> 
> Intel Sunrisepoint (Skylake PCH) has the iTCO watchdog accessible across
> the SMBus, unlike previous generations of PCH/ICH where it was on the
> LPC bus. Because it's on the SMBus, it doesn't make sense to pass around
> a 'struct lpc_ich_info', and leaking the type of bus into the iTCO
> watchdog driver is kind of backwards anyway.
> 
> This change introduces a new 'struct itco_wdt_platform_data' for use
> inside the iTCO watchdog driver and by the upcoming Intel Sunrisepoint
> code, which neatly avoids having to include lpc_ich headers in the i801
> i2c driver.
> 
> This change is overdue because lpc_ich_info has already found its way
> into other TCO watchdog users, notably the intel_pmc_ipc driver where
> the watchdog actually isn't on the LPC bus as far as I can see.
> 
> A simple translation layer is provided for converting from the existing
> 'struct lpc_ich_info' inside the lpc_ich mfd driver.
> 
> Cc: Peter Tyser <ptyser@xes-inc.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Zha Qipeng <qipeng.zha@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>

For platform/drivers/x86:

Simple changes to accomodate refactoring.

Acked-by: Darren Hart <dvhart@linux.intel.com>

> ---
> 
> v3:
>  - Added Lee's ACK
> 
> v2:
>  - Use lowercase "itco" in all new files and data structures.
>  - Use devm_kzalloc() to allocate platform data, fixing a memory leak
>    and saving us from having to free the allocation in error paths
>  - Move stray Kconfig hunk to PATCH 3 that accidentally snuck into v1
>  - Swap strcpy() for the safer strlcpy()
>  - Fix lpc_ich_info user in the intel_pmc_ipc driver that was merged for
>    v4.2.
> 
>  drivers/mfd/lpc_ich.c                  | 32 +++++++++++++++++++++++++++++---
>  drivers/platform/x86/intel_pmc_ipc.c   |  9 ++++-----
>  drivers/watchdog/iTCO_wdt.c            | 11 +++++------
>  include/linux/mfd/lpc_ich.h            |  6 ------
>  include/linux/platform_data/itco_wdt.h | 19 +++++++++++++++++++
>  5 files changed, 57 insertions(+), 20 deletions(-)
>  create mode 100644 include/linux/platform_data/itco_wdt.h
> 
> diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
> index 8de34398abc0..c5a9a08b5dfb 100644
> --- a/drivers/mfd/lpc_ich.c
> +++ b/drivers/mfd/lpc_ich.c
> @@ -66,6 +66,7 @@
>  #include <linux/pci.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/lpc_ich.h>
> +#include <linux/platform_data/itco_wdt.h>
>  
>  #define ACPIBASE		0x40
>  #define ACPIBASE_GPE_OFF	0x28
> @@ -835,9 +836,31 @@ static void lpc_ich_enable_pmc_space(struct pci_dev *dev)
>  	priv->actrl_pbase_save = reg_save;
>  }
>  
> -static void lpc_ich_finalize_cell(struct pci_dev *dev, struct mfd_cell *cell)
> +static int lpc_ich_finalize_wdt_cell(struct pci_dev *dev)
>  {
> +	struct itco_wdt_platform_data *pdata;
>  	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
> +	struct lpc_ich_info *info;
> +	struct mfd_cell *cell = &lpc_ich_cells[LPC_WDT];
> +
> +	pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	info = &lpc_chipset_info[priv->chipset];
> +
> +	pdata->version = info->iTCO_version;
> +	strlcpy(pdata->name, info->name, sizeof(pdata->name));
> +
> +	cell->platform_data = pdata;
> +	cell->pdata_size = sizeof(*pdata);
> +	return 0;
> +}
> +
> +static void lpc_ich_finalize_gpio_cell(struct pci_dev *dev)
> +{
> +	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
> +	struct mfd_cell *cell = &lpc_ich_cells[LPC_GPIO];
>  
>  	cell->platform_data = &lpc_chipset_info[priv->chipset];
>  	cell->pdata_size = sizeof(struct lpc_ich_info);
> @@ -933,7 +956,7 @@ gpe0_done:
>  	lpc_chipset_info[priv->chipset].use_gpio = ret;
>  	lpc_ich_enable_gpio_space(dev);
>  
> -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_GPIO]);
> +	lpc_ich_finalize_gpio_cell(dev);
>  	ret = mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
>  			      &lpc_ich_cells[LPC_GPIO], 1, NULL, 0, NULL);
>  
> @@ -1007,7 +1030,10 @@ static int lpc_ich_init_wdt(struct pci_dev *dev)
>  		res->end = base_addr + ACPIBASE_PMC_END;
>  	}
>  
> -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_WDT]);
> +	ret = lpc_ich_finalize_wdt_cell(dev);
> +	if (ret)
> +		goto wdt_done;
> +
>  	ret = mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
>  			      &lpc_ich_cells[LPC_WDT], 1, NULL, 0, NULL);
>  
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
> index 105cfffe82c6..28b2a12bb26d 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -33,7 +33,7 @@
>  #include <linux/suspend.h>
>  #include <linux/acpi.h>
>  #include <asm/intel_pmc_ipc.h>
> -#include <linux/mfd/lpc_ich.h>
> +#include <linux/platform_data/itco_wdt.h>
>  
>  /*
>   * IPC registers
> @@ -473,9 +473,9 @@ static struct resource tco_res[] = {
>  	},
>  };
>  
> -static struct lpc_ich_info tco_info = {
> +static struct itco_wdt_platform_data tco_info = {
>  	.name = "Apollo Lake SoC",
> -	.iTCO_version = 3,
> +	.version = 3,
>  };
>  
>  static int ipc_create_punit_device(void)
> @@ -552,8 +552,7 @@ static int ipc_create_tco_device(void)
>  		goto err;
>  	}
>  
> -	ret = platform_device_add_data(pdev, &tco_info,
> -				       sizeof(struct lpc_ich_info));
> +	ret = platform_device_add_data(pdev, &tco_info, sizeof(tco_info));
>  	if (ret) {
>  		dev_err(ipcdev.dev, "Failed to add tco platform data\n");
>  		goto err;
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 3c3fd417ddeb..a94401b2deca 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -66,8 +66,7 @@
>  #include <linux/spinlock.h>		/* For spin_lock/spin_unlock/... */
>  #include <linux/uaccess.h>		/* For copy_to_user/put_user/... */
>  #include <linux/io.h>			/* For inb/outb/... */
> -#include <linux/mfd/core.h>
> -#include <linux/mfd/lpc_ich.h>
> +#include <linux/platform_data/itco_wdt.h>
>  
>  #include "iTCO_vendor.h"
>  
> @@ -418,9 +417,9 @@ static int iTCO_wdt_probe(struct platform_device *dev)
>  {
>  	int ret = -ENODEV;
>  	unsigned long val32;
> -	struct lpc_ich_info *ich_info = dev_get_platdata(&dev->dev);
> +	struct itco_wdt_platform_data *pdata = dev_get_platdata(&dev->dev);
>  
> -	if (!ich_info)
> +	if (!pdata)
>  		goto out;
>  
>  	spin_lock_init(&iTCO_wdt_private.io_lock);
> @@ -435,7 +434,7 @@ static int iTCO_wdt_probe(struct platform_device *dev)
>  	if (!iTCO_wdt_private.smi_res)
>  		goto out;
>  
> -	iTCO_wdt_private.iTCO_version = ich_info->iTCO_version;
> +	iTCO_wdt_private.iTCO_version = pdata->version;
>  	iTCO_wdt_private.dev = dev;
>  	iTCO_wdt_private.pdev = to_pci_dev(dev->dev.parent);
>  
> @@ -501,7 +500,7 @@ static int iTCO_wdt_probe(struct platform_device *dev)
>  	}
>  
>  	pr_info("Found a %s TCO device (Version=%d, TCOBASE=0x%04llx)\n",
> -		ich_info->name, ich_info->iTCO_version, (u64)TCOBASE);
> +		pdata->name, pdata->version, (u64)TCOBASE);
>  
>  	/* Clear out the (probably old) status */
>  	if (iTCO_wdt_private.iTCO_version == 3) {
> diff --git a/include/linux/mfd/lpc_ich.h b/include/linux/mfd/lpc_ich.h
> index 8feac782fa83..2b300b44f994 100644
> --- a/include/linux/mfd/lpc_ich.h
> +++ b/include/linux/mfd/lpc_ich.h
> @@ -20,12 +20,6 @@
>  #ifndef LPC_ICH_H
>  #define LPC_ICH_H
>  
> -/* Watchdog resources */
> -#define ICH_RES_IO_TCO		0
> -#define ICH_RES_IO_SMI		1
> -#define ICH_RES_MEM_OFF		2
> -#define ICH_RES_MEM_GCS_PMC	0
> -
>  /* GPIO resources */
>  #define ICH_RES_GPIO	0
>  #define ICH_RES_GPE0	1
> diff --git a/include/linux/platform_data/itco_wdt.h b/include/linux/platform_data/itco_wdt.h
> new file mode 100644
> index 000000000000..f16542c77ff7
> --- /dev/null
> +++ b/include/linux/platform_data/itco_wdt.h
> @@ -0,0 +1,19 @@
> +/*
> + * Platform data for the Intel TCO Watchdog
> + */
> +
> +#ifndef _ITCO_WDT_H_
> +#define _ITCO_WDT_H_
> +
> +/* Watchdog resources */
> +#define ICH_RES_IO_TCO		0
> +#define ICH_RES_IO_SMI		1
> +#define ICH_RES_MEM_OFF		2
> +#define ICH_RES_MEM_GCS_PMC	0
> +
> +struct itco_wdt_platform_data {
> +	char name[32];
> +	unsigned int version;
> +};
> +
> +#endif /* _ITCO_WDT_H_ */
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Darren Hart
Intel Open Source Technology Center
