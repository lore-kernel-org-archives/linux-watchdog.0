Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Fu, Borun" <borun.fu@intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>, "Li, Aubrey" <aubrey.li@intel.com>
Subject: RE: [PATCH] PM / watchdog: iTCO: stop watchdog during system suspend
Date: Thu, 2 Apr 2015 02:13:56 +0000
Message-ID: <48A8D21F3057FE4DB59C829EB7A1638A10EA3311@SHSMSX104.ccr.corp.intel.com>
References: <2017660.nPaHVT8bW3@vostro.rjw.lan>
 <48A8D21F3057FE4DB59C829EB7A1638A10EA3254@SHSMSX104.ccr.corp.intel.com>
 <551C973C.3080902@roeck-us.net>
In-Reply-To: <551C973C.3080902@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8bit
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Sorry, my fault. It should work as well. 

-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net] 
Sent: Thursday, April 02, 2015 9:11
To: Fu, Borun; Rafael J. Wysocki; linux-watchdog@vger.kernel.org
Cc: Linux Kernel Mailing List; Linux PM list; Wim Van Sebroeck; Li, Aubrey; Wang, Frank
Subject: Re: [PATCH] PM / watchdog: iTCO: stop watchdog during system suspend

On 04/01/2015 05:52 PM, Fu, Borun wrote:
> Hi Rafael,
> watchdog_active() function is not implemented in your patch. Pls. add it.
>

Please explain why using the standard watchdog_active() would not work here.

Guenter

> static int watchdog_active(struct device *dev) {
>         unsigned int val;
>
>         spin_lock(&iTCO_wdt_private.io_lock);
>         val = inw(TCO1_CNT);
>         spin_unlock(&iTCO_wdt_private.io_lock);
>
>         /* Bit 11: TCO Timer Halt */
>         if (val & 0x0800)
>                 return 0;
>         else
>                 return 1;
> }
>
> Regards,
> Borun
> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Thursday, April 02, 2015 8:31
> To: linux-watchdog@vger.kernel.org
> Cc: Linux Kernel Mailing List; Linux PM list; Wim Van Sebroeck; Li, 
> Aubrey; Fu, Borun
> Subject: [PATCH] PM / watchdog: iTCO: stop watchdog during system 
> suspend
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If the target sleep state of the system is not an ACPI sleep state (S1, S2 or S3), the TCO watchdog needs to be stopped during system suspend, because it may not be possible to ping it any more after timekeeping has been suspended (suspend-to-idle does that for one example).
>
> For this reason, provide ->suspend_noirq and ->resume_noirq callbacks for the iTCO watchdog driver and use them to stop and restart the watchdog during system suspend and resume, respectively, if the system is not going to enter an ACPI sleep state (in which case the watchdog will be stopped by the platform firmware before the state is entered).
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
> + * Suspend-to-idle requires this, because it stops the ticks and 
> +timekeeping, so
> + * the watchdog cannot be pinged while in that state.  In ACPI sleep 
> +states the
> + * watchdog is stopped by the platform firmware.
> + */
> +
> +#ifdef CONFIG_ACPI
> +static inline bool need_suspend(void) {
> +	return acpi_target_system_state() == ACPI_STATE_S0; } #else static 
> +inline bool need_suspend(void) { return true; } #endif
> +
> +static int iTCO_wdt_suspend_noirq(struct device *dev) {
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
> +static int iTCO_wdt_resume_noirq(struct device *dev) {
> +	if (iTCO_wdt_private.suspended)
> +		iTCO_wdt_start(&iTCO_wdt_watchdog_dev);
> +
> +	return 0;
> +}
> +
> +struct dev_pm_ops iTCO_wdt_pm = {
> +	.suspend_noirq = iTCO_wdt_suspend_noirq,
> +	.resume_noirq = iTCO_wdt_resume_noirq, };
> +
> +#define ITCO_WDT_PM_OPS	&iTCO_wdt_pm
> +#else
> +#define ITCO_WDT_PM_OPS	NULL
> +#endif /* CONFIG_PM_SLEEP */
> +
>   static struct platform_driver iTCO_wdt_driver = {
>   	.probe          = iTCO_wdt_probe,
>   	.remove         = iTCO_wdt_remove,
>   	.shutdown       = iTCO_wdt_shutdown,
>   	.driver         = {
>   		.name   = DRV_NAME,
> +		.pm     = ITCO_WDT_PM_OPS,
>   	},
>   };
>
>
> N     r  y   b X  Ç§v ^ )Şº{.n +    {   \    {ay 
Ê‡Ú™ ,j 
>   f   h   z 
 w   
   j:+v   w j m         zZ+     İ¢j"  !tml=
>

ÿôèº{.nÇ+‰·Ÿ®‰­†+%ŠËÿ±éİ¶¥Šwÿº{.nÇ+‰·¥Š{±şG«éÿŠ{ayº
Ê‡Ú™ë,j­¢f£¢·hšïêÿ‘êçz_è®(­éšŠİ¢j"ú¶m§ÿÿ¾«şG«éÿ¢¸?™¨è­Ú&£ø§~á¶iO•æ¬z·švØ^¶m§ÿÿÃ
ÿ¶ìÿ¢¸?–I¥
