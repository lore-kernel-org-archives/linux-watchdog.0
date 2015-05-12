Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45004 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbbELB3B (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 May 2015 21:29:01 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1Yrz0G-000xt3-SF
	for linux-watchdog@vger.kernel.org; Tue, 12 May 2015 01:29:01 +0000
Date: Mon, 11 May 2015 18:28:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Muller, Francois-nicolas" <francois-nicolas.muller@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
	"'platform-driver-x86@vger.kernel.org'"
	<platform-driver-x86@vger.kernel.org>,
	Darren Hart <dvhart@infradead.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: TCO Watchdog warning interrupt driver creation
Message-ID: <20150512012822.GA10791@roeck-us.net>
References: <B9C02DB17496AC4197F41A146D371B9B07625D40@hasmsx107.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B9C02DB17496AC4197F41A146D371B9B07625D40@hasmsx107.ger.corp.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 30, 2015 at 01:45:08PM +0000, Muller, Francois-nicolas wrote:
> Thanks Rafael for your comments.
> Please find my answers embedded below and a new version of the patch.

This makes it quite difficult to find your patch.
Please follow the guidelines in Documentation/SubmittingPatches
when (re)submitting kernel patches.

[ ... ]
> 
> I need to be able to enable the panic or not after the warning interrupt.
> I could also use module parameters instead of Kconfig, I don't know which one
> is preferred in this case. Any advice ?
> 
There should be one and only one option, and that should trigger a panic.
Pretty much follow the "pretimeout" semantics in
Documentation/watchdog/watchdog-api.txt.

> 
> ##################################################################
> 
> >From 255184705e94f2983d965ad711f30281a1eed816 Mon Sep 17 00:00:00 2001
> From: Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
> Date: Mon, 30 Mar 2015 14:56:39 +0200
> Subject: [PATCH] Adding TCO watchdog warning interrupt handling.
> 
> This feature is useful to root cause watchdog expiration.
> It is activated by boot parameter 'warn_irq' (disabled by default).
> 
> Upon first expiration of the TCO watchdog, a warning interrupt is fired,
> then the interrupt handler dumps registers and call stack of all available
> cpus.
> TCO watchdog reloads with 2.4 seconds timeout for second expiration.
> 
> If CONFIG_ITCO_WARN_PANIC is set, the warning interrupt also calls panic()
> which notifies the panic handlers then reboots the platform, depending on
> CONFIG_PANIC_TIMEOUT value :
> 
> - If CONFIG_PANIC_TIMEOUT is zero or greater than 3 seconds, TCO watchdog will
> reset the platform if second expiration happens before TCO has been kicked again.
> 
> - If CONFIG_PANIC_TIMEOUT is < 0, platform will reboot immediately (emergency
> restart procedure).
> 
> - If CONFIG_PANIC_TIMEOUT is 1 or 2 seconds, platform will reboot after 1 or 2
> seconds delay (emergency restart procedure).
> 
> See Documentation/watchdog/tco-wdt-warning-interrupt.txt for more details.
> 
> Signed-off-by: Francois-Nicolas Muller <francois-nicolas.muller@intel.com>
> ---
>  drivers/watchdog/Kconfig    | 13 ++++++++++++
>  drivers/watchdog/iTCO_wdt.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> -- 
> 1.9.1
> 
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

This option should go away.

>  config IT8712F_WDT
>  	tristate "IT8712F (Smart Guardian) Watchdog Timer"
>  	depends on X86
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index e802a54..8cfa5e7 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -68,6 +68,8 @@
>  #include <linux/pm.h>			/* For suspend/resume */
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/lpc_ich.h>
> +#include <linux/nmi.h>
> +#include <linux/acpi.h>
>  
>  #include "iTCO_vendor.h"
>  
> @@ -126,6 +128,11 @@ module_param(turn_SMI_watchdog_clear_off, int, 0);
>  MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
>  	"Turn off SMI clearing watchdog (depends on TCO-version)(default=1)");
>  
> +static bool warn_irq;
> +module_param(warn_irq, bool, 0);
> +MODULE_PARM_DESC(warn_irq,
> +	"Dump all cpus backtraces at first watchdog timer expiration (default=0)");
> +
This option (possibly with a better name) should be the only one
needed to trigger the new functionality.

>  /*
>   * Some TCO specific functions
>   */
> @@ -200,6 +207,41 @@ static int iTCO_wdt_unset_NO_REBOOT_bit(void)
>  	return ret; /* returns: 0 = OK, -EIO = Error */
>  }
>  
> +#ifdef CONFIG_ACPI

Question is if this ifdef is needed. Most if not all ACPI functions
are provided as dummies if ACPI is disabled.

> +static unsigned char *tco_hid = "8086229C";
> +static bool warn_irq_panic = CONFIG_ITCO_WARNING_PANIC;
> +
> +static u32 iTCO_wdt_wirq(acpi_handle gpe_device, u32 gpe, void *context)
> +{
> +	trigger_all_cpu_backtrace();
> +	if (warn_irq_panic)
> +		panic("Kernel Watchdog");

panic already implies a backtrace, doesn't it ?

> +
> +	return ACPI_INTERRUPT_HANDLED;
> +}
> +
> +static acpi_status __init iTCO_wdt_register_gpe(acpi_handle handle,
> +					u32 lvl, void *context, void **rv)
> +{
> +	unsigned long long gpe;
> +	acpi_status status;
> +
> +	status = acpi_evaluate_integer(handle, "_GPE", NULL, &gpe);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	status = acpi_install_gpe_handler(NULL, gpe, ACPI_GPE_EDGE_TRIGGERED,
> +					  iTCO_wdt_wirq, NULL);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	acpi_enable_gpe(NULL, gpe);
> +
> +	pr_debug("interrupt=SCI GPE=0x%02llx", gpe);

Is this message really useful ?

> +	return AE_OK;
> +}
> +#endif
> +
>  static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>  {
>  	unsigned int val;
> @@ -638,9 +680,15 @@ static int __init iTCO_wdt_init_module(void)
>  	if (err)
>  		return err;
>  
> +#ifdef CONFIG_ACPI
> +	if (warn_irq)
> +		acpi_get_devices(tco_hid, iTCO_wdt_register_gpe, NULL, NULL);

acpi_get_devices provides a dummy function if ACPI is not configured,
so the #ifdef above is not needed.

> +#endif
> +
>  	return 0;
>  }
>  
> +

Please no whitespace changes (much less whitespace changes introducing
checkpatch problems).

>  static void __exit iTCO_wdt_cleanup_module(void)
>  {
>  	platform_driver_unregister(&iTCO_wdt_driver);
