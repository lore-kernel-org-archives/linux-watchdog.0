Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34320 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbDBBVv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Apr 2015 21:21:51 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YdTpO-000ayY-KD
	for linux-watchdog@vger.kernel.org; Thu, 02 Apr 2015 01:21:50 +0000
Message-ID: <551C99A4.40608@roeck-us.net>
Date: Wed, 01 Apr 2015 18:21:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-watchdog@vger.kernel.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Aubrey Li <aubrey.li@intel.com>, Borun Fu <borun.fu@intel.com>
Subject: Re: [PATCH] PM / watchdog: iTCO: stop watchdog during system suspend
References: <2017660.nPaHVT8bW3@vostro.rjw.lan>
In-Reply-To: <2017660.nPaHVT8bW3@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/01/2015 05:31 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If the target sleep state of the system is not an ACPI sleep state
> (S1, S2 or S3), the TCO watchdog needs to be stopped during system
> suspend, because it may not be possible to ping it any more after
> timekeeping has been suspended (suspend-to-idle does that for
> one example).
>
> For this reason, provide ->suspend_noirq and ->resume_noirq
> callbacks for the iTCO watchdog driver and use them to stop
> and restart the watchdog during system suspend and resume,
> respectively, if the system is not going to enter an ACPI
> sleep state (in which case the watchdog will be stopped
> by the platform firmware before the state is entered).
>
> Reported-by: Borun Fu <borun.fu@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/watchdog/iTCO_wdt.c |   51 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
>
> Index: linux-pm/drivers/watchdog/iTCO_wdt.c
> ===================================================================
> --- linux-pm.orig/drivers/watchdog/iTCO_wdt.c
> +++ linux-pm/drivers/watchdog/iTCO_wdt.c
> @@ -51,6 +51,7 @@
>   #define DRV_VERSION	"1.11"
>
>   /* Includes */
> +#include <linux/acpi.h>			/* For ACPI support */
>   #include <linux/module.h>		/* For module specific items */
>   #include <linux/moduleparam.h>		/* For new moduleparam's */
>   #include <linux/types.h>		/* For standard types (like size_t) */
> @@ -103,6 +104,8 @@ static struct {		/* this is private data
>   	struct platform_device *dev;
>   	/* the PCI-device */
>   	struct pci_dev *pdev;
> +	/* whether or not the watchdog has been suspended */
> +	bool suspended;
>   } iTCO_wdt_private;
>
>   /* module parameters */
> @@ -571,12 +574,60 @@ static void iTCO_wdt_shutdown(struct pla
>   	iTCO_wdt_stop(NULL);
>   }
>
> +#ifdef CONFIG_PM_SLEEP
> +/*
> + * Suspend-to-idle requires this, because it stops the ticks and timekeeping, so
> + * the watchdog cannot be pinged while in that state.  In ACPI sleep states the
> + * watchdog is stopped by the platform firmware.
> + */
> +
> +#ifdef CONFIG_ACPI
> +static inline bool need_suspend(void)
> +{
> +	return acpi_target_system_state() == ACPI_STATE_S0;
> +}
> +#else
> +static inline bool need_suspend(void) { return true; }
> +#endif
> +
> +static int iTCO_wdt_suspend_noirq(struct device *dev)
> +{
> +	int ret = 0;
> +
> +	iTCO_wdt_private.suspended = false;
> +	if (watchdog_active(&iTCO_wdt_watchdog_dev) && need_suspend()) {
> +		ret = iTCO_wdt_stop(&iTCO_wdt_watchdog_dev);
> +		if (!ret)
> +			iTCO_wdt_private.suspended = true;
> +	}
> +	return ret;
> +}
> +
> +static int iTCO_wdt_resume_noirq(struct device *dev)
> +{
> +	if (iTCO_wdt_private.suspended)
> +		iTCO_wdt_start(&iTCO_wdt_watchdog_dev);
> +
> +	return 0;
> +}
> +
> +struct dev_pm_ops iTCO_wdt_pm = {
> +	.suspend_noirq = iTCO_wdt_suspend_noirq,
> +	.resume_noirq = iTCO_wdt_resume_noirq,

Hi Rafael,

This only covers suspend and resume, but not any of the other
sleep operations (like SIMPLE_DEV_PM_OPS would do).
Is that intentional ?

> +};
> +
> +#define ITCO_WDT_PM_OPS	&iTCO_wdt_pm

Checkpatch wants to see (&iTCO_wdt_pm).

ERROR: Macros with complex values should be enclosed in parentheses

Thanks,
Guenter

