Return-path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Muller, Francois-nicolas" <francois-nicolas.muller@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, "'platform-driver-x86@vger.kernel.org'" <platform-driver-x86@vger.kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] TCO Watchdog warning interrupt driver creation
Date: Tue, 20 Jan 2015 16:00:22 +0100
Message-ID: <23699971.dg9GkUQYoK@vostro.rjw.lan>
In-Reply-To: <B9C02DB17496AC4197F41A146D371B9B075CCA21@hasmsx107.ger.corp.intel.com>
References: <B9C02DB17496AC4197F41A146D371B9B075AF9DE@hasmsx107.ger.corp.intel.com> <54AF6288.6040305@roeck-us.net> <B9C02DB17496AC4197F41A146D371B9B075CCA21@hasmsx107.ger.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Wednesday, January 14, 2015 04:38:49 PM Muller, Francois-nicolas wrote:
> From 54d2ff5e13c1b35d5019b82376dabb903ebe30d6 Mon Sep 17 00:00:00 2001
> From: Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
> Date: Wed, 14 Jan 2015 14:27:43 +0100
> Subject: [PATCH] Adding TCO watchdog warning interrupt handling.
> 
> This feature is useful to root cause watchdog expiration.
> It is activated by boot parameter 'warn_irq' (disabled by default).
> 
> Upon first expiration of the TCO watchdog, a warning interrupt is fired then the
> interrupt handler dumps registers and call stack of all available cores.
> 
> Finally panic() is called and notifies the panic handlers if any. At the same
> time, the TCO watchdog reloads with 2.4 seconds timeout value.
> 
> When warning interrupt is enabled, platform reboot depends on
> CONFIG_PANIC_TIMEOUT value :
> 
> - If CONFIG_PANIC_TIMEOUT is zero or greater than 3 seconds, TCO watchdog will
> reset the platform if second expiration happens before TCO has been kicked
> again.
> 
> - If CONFIG_PANIC_TIMEOUT is < 0, platform will reboot immediately (emergency
> restart procedure).
> 
> - If CONFIG_PANIC_TIMEOUT is 1 or 2 seconds, platform will reboot after 1 or 2
> seconds delay (emergency restart procedure).
> 
> Change-Id: I009c41f2f3dc3bd091b4d2a45b4ea0be85c8ce27
> Signed-off-by: Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
> ---
>  drivers/watchdog/iTCO_wdt.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index e802a54..a8c16d2 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -49,6 +49,8 @@
>  /* Module and version information */
>  #define DRV_NAME	"iTCO_wdt"
>  #define DRV_VERSION	"1.11"
> +#define DRV_NAME_ACPI	"iTCO_wdt_wirq"
> +#define TCO_CLASS	DRV_NAME
>  
>  /* Includes */
>  #include <linux/module.h>		/* For module specific items */
> @@ -68,6 +70,9 @@
>  #include <linux/pm.h>			/* For suspend/resume */
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/lpc_ich.h>
> +#include <linux/nmi.h>
> +#include <linux/acpi.h>
> +#include <acpi/actypes.h>
>  
>  #include "iTCO_vendor.h"
>  
> @@ -107,6 +112,12 @@ static struct {		/* this is private data for the iTCO_wdt device */
>  	bool started;
>  } iTCO_wdt_private;
>  
> +static const struct acpi_device_id iTCO_wdt_ids[] = {
> +	{"8086229C", 0},

This is not a proper ACPI or PNP device name as far as I can say.

What is it?

> +	{"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, iTCO_wdt_ids);
> +
>  /* module parameters */
>  #define WATCHDOG_TIMEOUT 30	/* 30 sec default heartbeat */
>  static int heartbeat = WATCHDOG_TIMEOUT;  /* in seconds */
> @@ -126,6 +137,11 @@ module_param(turn_SMI_watchdog_clear_off, int, 0);
>  MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
>  	"Turn off SMI clearing watchdog (depends on TCO-version)(default=1)");
>  
> +static bool warn_irq;
> +module_param(warn_irq, bool, 0);
> +MODULE_PARM_DESC(warn_irq,
> +	"Watchdog trigs a panic at first expiration (default=0)");
> +
>  /*
>   * Some TCO specific functions
>   */
> @@ -200,6 +216,35 @@ static int iTCO_wdt_unset_NO_REBOOT_bit(void)
>  	return ret; /* returns: 0 = OK, -EIO = Error */
>  }
>  
> +static u32 iTCO_wdt_wirq(acpi_handle gpe_device, u32 gpe, void *context)
> +{
> +	trigger_all_cpu_backtrace();
> +	panic("Kernel Watchdog");
> +
> +	/* This code should not be reached */
> +	return IRQ_HANDLED;
> +}
> +
> +static int iTCO_wdt_acpi_add(struct acpi_device *device)
> +{
> +	unsigned long long gpe;
> +	acpi_status status;
> +

The code below seems to mean: "If the device _HID returns '8086229C', there
should be a _GPE object under it which then returns the number of the GPE
to bind to within the FADT GPE blocks."

Where is this documented?

> +	status = acpi_evaluate_integer(device->handle, "_GPE", NULL, &gpe);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +
> +	status = acpi_install_gpe_handler(NULL, gpe, ACPI_GPE_EDGE_TRIGGERED,
> +					  iTCO_wdt_wirq, NULL);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	acpi_enable_gpe(NULL, gpe);
> +
> +	pr_debug("interrupt=SCI GPE=0x%02llx", gpe);
> +	return 0;
> +}
> +
>  static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>  {
>  	unsigned int val;
> @@ -628,6 +673,15 @@ static struct platform_driver iTCO_wdt_driver = {
>  	},
>  };
>  
> +static struct acpi_driver iTCO_wdt_acpi_driver = {
> +	.name = DRV_NAME_ACPI,
> +	.class = TCO_CLASS,
> +	.ids = iTCO_wdt_ids,
> +	.ops = {
> +		.add = iTCO_wdt_acpi_add,
> +	},
> +};
> +
>  static int __init iTCO_wdt_init_module(void)
>  {
>  	int err;
> @@ -638,12 +692,22 @@ static int __init iTCO_wdt_init_module(void)
>  	if (err)
>  		return err;
>  
> +	if (warn_irq) {
> +		err = acpi_bus_register_driver(&iTCO_wdt_acpi_driver);
> +		if (err) {
> +			platform_driver_unregister(&iTCO_wdt_driver);
> +			return err;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
>  static void __exit iTCO_wdt_cleanup_module(void)
>  {
>  	platform_driver_unregister(&iTCO_wdt_driver);
> +	if (warn_irq)
> +		acpi_bus_unregister_driver(&iTCO_wdt_acpi_driver);
>  	pr_info("Watchdog Module Unloaded\n");
>  }
>  
> -- 
> 1.9.1

And does it build for CONFIG_ACPI unset?
