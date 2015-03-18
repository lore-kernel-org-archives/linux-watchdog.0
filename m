Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52174 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750822AbbCRWgl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Mar 2015 18:36:41 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Muller, Francois-nicolas" <francois-nicolas.muller@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Darren Hart <dvhart@infradead.org>,
	"'platform-driver-x86@vger.kernel.org'"
	<platform-driver-x86@vger.kernel.org>,
	Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] TCO Watchdog warning interrupt driver creation
Date: Thu, 19 Mar 2015 00:00:35 +0100
Message-ID: <1473938.paZdQ2uybb@vostro.rjw.lan>
In-Reply-To: <B9C02DB17496AC4197F41A146D371B9B075F2E43@hasmsx107.ger.corp.intel.com>
References: <B9C02DB17496AC4197F41A146D371B9B075AF9DE@hasmsx107.ger.corp.intel.com> <23699971.dg9GkUQYoK@vostro.rjw.lan> <B9C02DB17496AC4197F41A146D371B9B075F2E43@hasmsx107.ger.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thursday, February 12, 2015 10:13:43 AM Muller, Francois-nicolas wrote:
> Please find hereafter a new version of the patch with a documentation file and that builds with CONFIG_ACPI unset.

First of all, if I'm supposed to apply this, please note that I'm not the
maintainer of drivers/watchdog/iTCO_wdt.c (or anything under drivers/watchdog/
for that matter).

> From a7135e6b4bc7c91d6ac72a4f38157f7f2308615b Mon Sep 17 00:00:00 2001
> From: Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
> Date: Tue, 20 Jan 2015 14:55:42 +0100
> Subject: [PATCH] Adding TCO watchdog warning interrupt handling.
> 
> This feature is useful to root cause watchdog expiration.
> It is activated by boot parameter 'warn_irq' (disabled by default).
> 
> Upon first expiration of the TCO watchdog, a warning interrupt is fired, then
> the interrupt handler dumps registers and call stack of all available cpus.
> TCO watchdog reloads with 2.4 seconds timeout for second expiration.
> 
> If CONFIG_ITCO_WARN_PANIC is set, the warning interrupt also calls panic()
> which notifies the panic handlers then reboots the platform, depending on
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
> See Documentation/watchdog/tco-wdt-warning-interrupt.txt for more details.
> 
> Change-Id: I7314a50812529423b117cf28e4a195a356da2f57
> Signed-off-by: Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
> ---
>  .../watchdog/tco-wdt-warning-interrupt.txt         |   85 ++++++++++++++++++++
>  drivers/watchdog/Kconfig                           |   13 +++
>  drivers/watchdog/iTCO_wdt.c                        |   80 ++++++++++++++++++
>  3 files changed, 178 insertions(+)
>  create mode 100644 Documentation/watchdog/tco-wdt-warning-interrupt.txt
> 
> diff --git a/Documentation/watchdog/tco-wdt-warning-interrupt.txt b/Documentation/watchdog/tco-wdt-warning-interrupt.txt
> new file mode 100644
> index 0000000..2e4eebf
> --- /dev/null
> +++ b/Documentation/watchdog/tco-wdt-warning-interrupt.txt
> @@ -0,0 +1,85 @@
> +Last reviewed: 02/12/2015
> +
> +                     TCO watchdog warning interrupt
> +                 handled by drivers/watchdog/iTCO_wdt.c
> +                      Documentation and code by
> +       Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
> +
> +
> +Introduction
> +------------
> +Intel TCO watchdog is intended to detect and recover from locks up of the
> +platform. It contains a countdown timer, that should be reloaded on-time by
> +software before reaching zero.
> +
> +If the platform locks up and is not able to reload the timer, then when it
> +reaches zero:
> +- the timer is automatically reloaded with 04h and starts decrementing again,
> +- timeout bit is set in TCO1_STS register,
> +- SMI or SCI interrupt is generated (optional).

Is the timeout configurable?  If not, what's the hard-coded  value?

Is there any documentation of that feature you can point people to?

> +
> +If it reaches zero a second time while timeout bit is set,
> +- second_to_sts bit is set,
> +- reset of the platform is initiated.
> +
> +At first timeout, the SMI (or SCI) can be used to provide debug information
> +about the system state and help on fixing the cause of the hang. This is the
> +"warning interrupt".

I'm not sure how SMI would help here.

> +
> +Warning interrupt
> +-----------------
> +Warning interrupt handler is called when system is hung, so it is useful to
> +gather maximum information about system state at this point for root-causing the
> +issue.
> +
> +When the interrupt occurs,
> +- call stacks of all running cpus are dumped,
> +- panic() is called (optional)

What is the panic() useful for given that the second timeout will reset the
system anyway?

> +
> +Enabling the warning interrupt
> +------------------------------
> +Boot parameter "warn_irq" (boolean) enables warning interrupt generation at
> +first timer expiration (disabled by default).

Why is it disabled by default?

> +
> +As this is a command line option, configuration can be changed easily without
> +building again the code.
> +
> +Enabling panic upon warning interrupt
> +-------------------------------------
> +Warning interrupt handler can call panic() when Kconfig option
> +CONFIG_ITCO_WARNING_PANIC is set.

This isn't helpful.  Distribution ship binary kernel images, so they can't realy
on Kconfig options to disable/enable things.  They have to decide whether or not
to include the feature upfront.

> +
> +panic() call is useful in case of some panic handlers have been registered and
> +need to be run at this time.
> +
> +When CONFIG_ITCO_WARN_PANIC is set,
> +- If CONFIG_PANIC_TIMEOUT is zero or greater than 3 seconds, TCO watchdog will
> +  reset the platform if second expiration happens before TCO has been kicked
> +  again.

OK, so the timeout is configurable.  Why isn't the timeout configurable via
command line or sysfs?

> +- If CONFIG_PANIC_TIMEOUT is < 0, platform will reboot immediately (emergency
> +  restart procedure).
> +- If CONFIG_PANIC_TIMEOUT is 1 or 2 seconds, platform will reboot after 1 or 2
> +  seconds delay (emergency restart procedure).
> +
> +SCI vs SMI
> +----------
> +For the moment, the TCO watchdog warning interrupt feature is only available for
> +platforms that are able to trigger a SCI upon first expiration of TCO watchdog.
> +
> +There is no support of the SMI option yet.

So what's the reason to mention SMI at all?

> +
> +ACPI configuration
> +------------------
> +Bios is configuring the GPE associated to the warning interrupt. The driver uses
> +acpi tables to get the GPE number.

What documentation is describing how it is supposed to do that?

> +
> +This change is intended for Intel Cherrytrail platform. As TCO watchdog is part
> +of lpc_ich module, its _HID is used in the driver to retrieve GPE configuration
> +from Bios.
> +
> +If no GPE information is provided by the Bios, the interrupt is not handled and
> +appears in the dmesg log as a warning. Second timeout is still able to trigger a
> +reset.
> +
> +-- Francois-Nicolas Muller
> +   (francois-nicolas.muller@intel.com)
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 79d2589..41f3647 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -674,6 +674,19 @@ config ITCO_VENDOR_SUPPORT
>  	  devices. At this moment we only have additional support for some
>  	  SuperMicro Inc. motherboards.
>  
> +config ITCO_WARNING_PANIC
> +	bool "Intel TCO Timer/Watchdog panic on warning interrupt"
> +	depends on ITCO_WDT && ACPI

Do we really need a new Kconfig option for that?

> +	default y
> +	---help---
> +	  Force a call to panic() when TCO warning interrupt occurs.
> +
> +	  Warning interrupt happens if warn_irq module parameter is set and
> +	  TCO timer first expires.
> +
> +	  If not set, only cpu backtraces are dumped, no call to panic() and
> +	  no notification of panic are done.
> +
>  config IT8712F_WDT
>  	tristate "IT8712F (Smart Guardian) Watchdog Timer"
>  	depends on X86
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index e802a54..a25794c 100644
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
> @@ -68,6 +70,11 @@
>  #include <linux/pm.h>			/* For suspend/resume */
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/lpc_ich.h>
> +#include <linux/nmi.h>
> +#ifdef CONFIG_ACPI
> +#include <linux/acpi.h>
> +#include <acpi/actypes.h>
> +#endif

No, this isn't how you're supposed to do it.  Please include <linux/acpi.h>
only, it contains the necessary CONFIG_ACPI checks.

>  
>  #include "iTCO_vendor.h"
>  
> @@ -107,6 +114,14 @@ static struct {		/* this is private data for the iTCO_wdt device */
>  	bool started;
>  } iTCO_wdt_private;
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id iTCO_wdt_ids[] = {
> +	{"8086229C", 0},
> +	{"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, iTCO_wdt_ids);
> +#endif

This is for module auto-loading, right?

You seem to have too many #ifdef CONFIG_ACPI blocks in this code.  Any chance
to combine them all into one?

> +
>  /* module parameters */
>  #define WATCHDOG_TIMEOUT 30	/* 30 sec default heartbeat */
>  static int heartbeat = WATCHDOG_TIMEOUT;  /* in seconds */
> @@ -126,6 +141,15 @@ module_param(turn_SMI_watchdog_clear_off, int, 0);
>  MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
>  	"Turn off SMI clearing watchdog (depends on TCO-version)(default=1)");
>  
> +static bool warn_irq;
> +module_param(warn_irq, bool, 0);
> +MODULE_PARM_DESC(warn_irq,
> +	"Dump all cpus backtraces at first watchdog timer expiration (default=0)");
> +
> +#ifdef CONFIG_ACPI
> +static bool warn_irq_panic = CONFIG_ITCO_WARNING_PANIC;
> +#endif
> +
>  /*
>   * Some TCO specific functions
>   */
> @@ -200,6 +224,37 @@ static int iTCO_wdt_unset_NO_REBOOT_bit(void)
>  	return ret; /* returns: 0 = OK, -EIO = Error */
>  }
>  
> +#ifdef CONFIG_ACPI
> +static u32 iTCO_wdt_wirq(acpi_handle gpe_device, u32 gpe, void *context)
> +{
> +	trigger_all_cpu_backtrace();
> +	if (warn_irq_panic)
> +		panic("Kernel Watchdog");

Is the panic() useful at all?

> +
> +	return IRQ_HANDLED;

That should return ACPI_INTERRUPT_HANDLED or
ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE depending on what you want to
achieve here.

> +}
> +
> +static int iTCO_wdt_acpi_add(struct acpi_device *device)
> +{
> +	unsigned long long gpe;
> +	acpi_status status;
> +
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
> +#endif
> +
>  static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>  {
>  	unsigned int val;
> @@ -628,6 +683,17 @@ static struct platform_driver iTCO_wdt_driver = {
>  	},
>  };
>  
> +#ifdef CONFIG_ACPI
> +static struct acpi_driver iTCO_wdt_acpi_driver = {
> +	.name = DRV_NAME_ACPI,
> +	.class = TCO_CLASS,
> +	.ids = iTCO_wdt_ids,
> +	.ops = {
> +		.add = iTCO_wdt_acpi_add,
> +	},
> +};
> +#endif
> +
>  static int __init iTCO_wdt_init_module(void)
>  {
>  	int err;
> @@ -638,12 +704,26 @@ static int __init iTCO_wdt_init_module(void)
>  	if (err)
>  		return err;
>  
> +#ifdef CONFIG_ACPI
> +	if (warn_irq) {
> +		err = acpi_bus_register_driver(&iTCO_wdt_acpi_driver);

OK, so what's the guarantee that the ACPI core won't create a platform
device for _HID "8086229C" and if it does, why is it correct to register
an ACPI driver for that device object?

Can you possibly use acpi_get_devices() instead and install the GPE
handler if _HID == "8086229C" is found?

> +		if (err) {
> +			platform_driver_unregister(&iTCO_wdt_driver);
> +			return err;
> +		}
> +	}
> +#endif
> +
>  	return 0;
>  }
>  
>  static void __exit iTCO_wdt_cleanup_module(void)
>  {
>  	platform_driver_unregister(&iTCO_wdt_driver);
> +#ifdef CONFIG_ACPI
> +	if (warn_irq)
> +		acpi_bus_unregister_driver(&iTCO_wdt_acpi_driver);
> +#endif
>  	pr_info("Watchdog Module Unloaded\n");
>  }
>  
> -- 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
