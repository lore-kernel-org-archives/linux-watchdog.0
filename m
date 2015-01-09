Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47829 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbAIFJe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 9 Jan 2015 00:09:34 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Y9RpG-0038oN-CJ
	for linux-watchdog@vger.kernel.org; Fri, 09 Jan 2015 05:09:35 +0000
Message-ID: <54AF6288.6040305@roeck-us.net>
Date: Thu, 08 Jan 2015 21:09:28 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: "Muller, Francois-nicolas" <francois-nicolas.muller@intel.com>,
	Darren Hart <dvhart@infradead.org>
CC: "'platform-driver-x86@vger.kernel.org'"
	<platform-driver-x86@vger.kernel.org>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] TCO Watchdog warning interrupt driver creation
References: <B9C02DB17496AC4197F41A146D371B9B075AF9DE@hasmsx107.ger.corp.intel.com> <20141211040404.GA28797@vmdeb7> <5489AA6B.9080802@roeck-us.net> <B9C02DB17496AC4197F41A146D371B9B075C5FE3@hasmsx107.ger.corp.intel.com> <E73BFCB9-87CB-447D-839C-9ED4031FC6E2@infradead.org> <B9C02DB17496AC4197F41A146D371B9B075C6189@hasmsx107.ger.corp.intel.com>
In-Reply-To: <B9C02DB17496AC4197F41A146D371B9B075C6189@hasmsx107.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/22/2014 08:07 AM, Muller, Francois-nicolas wrote:
> Subject: [PATCH] TCO watchdog warning interrupt handler
>
> Adding TCO watchdog warning interrupt handling.
>
> This feature is useful to root cause watchdog expiration.
> It is activated by boot parameter 'warn_irq' (disabled by default).
>
> Upon first expiration of the TCO watchdog, a warning interrupt is
> fired and the driver calls panic() to dump debug information (registe=
rs and
> call stacks).
>
> At the same time, the TCO watchdog reloads with 2.4 seconds timeout
> value and runs until the second expiration.
>
> Signed-off-by: Francois-Nicolas Muller <francois-nicolas.muller@intel=
=2Ecom>
> ---
>   drivers/watchdog/iTCO_wdt.c |   66 ++++++++++++++++++++++++++++++++=
+++++++++++
>   1 file changed, 66 insertions(+)
>
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.=
c index e802a54..1ce9ad8 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -49,6 +49,8 @@
>   /* Module and version information */
>   #define DRV_NAME	"iTCO_wdt"
>   #define DRV_VERSION	"1.11"
> +#define DRV_NAME_ACPI	"iTCO_wdt_wirq"
> +#define TCO_CLASS	DRV_NAME
>
>   /* Includes */
>   #include <linux/module.h>		/* For module specific items */
> @@ -68,6 +70,9 @@
>   #include <linux/pm.h>			/* For suspend/resume */
>   #include <linux/mfd/core.h>
>   #include <linux/mfd/lpc_ich.h>
> +#include <linux/nmi.h>
> +#include <linux/acpi.h>
> +#include <acpi/actypes.h>
>
>   #include "iTCO_vendor.h"
>
> @@ -107,6 +112,12 @@ static struct {		/* this is private data for the=
 iTCO_wdt device */
>   	bool started;
>   } iTCO_wdt_private;
>
> +static const struct acpi_device_id iTCO_wdt_ids[] =3D {
> +	{"8086229C", 0},
> +	{"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, iTCO_wdt_ids);
> +

Doesn't that result in auto-loading the driver ?

If so, if that is really desirable, it should be a separate patch.

>   /* module parameters */
>   #define WATCHDOG_TIMEOUT 30	/* 30 sec default heartbeat */
>   static int heartbeat =3D WATCHDOG_TIMEOUT;  /* in seconds */ @@ -12=
6,6 +137,11 @@ module_param(turn_SMI_watchdog_clear_off, int, 0);  MODU=
LE_PARM_DESC(turn_SMI_watchdog_clear_off,
>   	"Turn off SMI clearing watchdog (depends on TCO-version)(default=3D=
1)");
>

Really looks like the patch is corrupted, with lines merged.

> +static bool warn_irq;
> +module_param(warn_irq, bool, 0);
> +MODULE_PARM_DESC(warn_irq,
> +	"Watchdog trigs a panic at first expiration (default=3D0)");
> +
>   /*
>    * Some TCO specific functions
>    */
> @@ -200,6 +216,37 @@ static int iTCO_wdt_unset_NO_REBOOT_bit(void)
>   	return ret; /* returns: 0 =3D OK, -EIO =3D Error */  }
>
> +static u32 iTCO_wdt_wirq(acpi_handle gpe_device, u32 gpe, void
> +*context) {

Either the patch is corrupted, or you need to look into kernel
coding style rules.

> +	pr_warn("[SHTDWN] %s, WATCHDOG TIMEOUT HANDLER!\n", __func__);
> +
That is kind of redundant with the following panic.

> +	trigger_all_cpu_backtrace();
> +	panic("Kernel Watchdog");
> +

Quite frankly, I don't see the point of this patch. Sure, this will
dump the stack. Ok, but so what ? What value would it have for the
user to see the interrupt call stack that is seen if the watchdog
times out ?

Guess I must be missing something.

> +	/* This code should not be reached */
> +	return IRQ_HANDLED;
> +}
> +
> +static int iTCO_wdt_acpi_add(struct acpi_device *device) {
> +	unsigned long long gpe;
> +	acpi_status status;
> +
> +	status =3D acpi_evaluate_integer(device->handle, "_GPE", NULL, &gpe=
);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +
> +	status =3D acpi_install_gpe_handler(NULL, gpe, ACPI_GPE_EDGE_TRIGGE=
RED,
> +					  iTCO_wdt_wirq, NULL);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	acpi_enable_gpe(NULL, gpe);
> +
> +	pr_info("interrupt=3DSCI GPE=3D0x%02llx", gpe);

I fail to see the value of this log message.

> +	return 0;
> +}
> +
>   static int iTCO_wdt_start(struct watchdog_device *wd_dev)  {
>   	unsigned int val;
> @@ -628,6 +675,15 @@ static struct platform_driver iTCO_wdt_driver =3D=
 {
>   	},
>   };
>
> +static struct acpi_driver iTCO_wdt_acpi_driver =3D {
> +	.name =3D DRV_NAME_ACPI,
> +	.class =3D TCO_CLASS,
> +	.ids =3D iTCO_wdt_ids,
> +	.ops =3D {
> +		.add =3D iTCO_wdt_acpi_add,
> +	},
> +};
> +
>   static int __init iTCO_wdt_init_module(void)  {
>   	int err;
> @@ -638,12 +694,22 @@ static int __init iTCO_wdt_init_module(void)
>   	if (err)
>   		return err;
>
> +	if (warn_irq) {
> +		err =3D acpi_bus_register_driver(&iTCO_wdt_acpi_driver);
> +		if (err) {
> +			platform_driver_unregister(&iTCO_wdt_driver);
> +			return err;
> +		}
> +	}
> +
>   	return 0;
>   }
>
>   static void __exit iTCO_wdt_cleanup_module(void)  {

The original code is not formatted like this.

>   	platform_driver_unregister(&iTCO_wdt_driver);
> +	if (warn_irq)
> +		acpi_bus_unregister_driver(&iTCO_wdt_acpi_driver);
>   	pr_info("Watchdog Module Unloaded\n");  }
>
> --
> 1.7.9.5
>
>
> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Monday, December 22, 2014 4:41 PM
> To: Muller, Francois-nicolas; Guenter Roeck
> Cc: 'platform-driver-x86@vger.kernel.org'; Rafael Wysocki; Linux ACPI=
 Mailing List; linux-watchdog@vger.kernel.org; Wim Van Sebroeck
> Subject: RE: [PATCH] TCO Watchdog warning interrupt driver creation
>
>
>
> On December 22, 2014 5:18:33 AM PST, "Muller, Francois-nicolas" <fran=
cois-nicolas.muller@intel.com> wrote:
>> Thanks Darren and Guenter for your review.
>> Here is a new patchset, including the feature in the watchdog driver
>> and using a boot parameter to be enabled.
>> Fran=C3=A7ois-Nicolas
>>
>> Subject: [PATCH] TCO watchdog warning interrupt handler
>>
>
> Please provide a complete commit message.
>
>> Signed-off-by: Francois-Nicolas Muller
>> <francois-nicolas.muller@intel.com>
>
> --
> Darren Hart
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
>

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
