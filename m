Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:36897 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab2IYJkP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 25 Sep 2012 05:40:15 -0400
Message-ID: <50617BFC.1000903@atmel.com>
Date: Tue, 25 Sep 2012 11:40:12 +0200
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Fabio Porcedda <fabio.porcedda@gmail.com>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	<devicetree-discuss@lists.ozlabs.org>
Subject: Re: [PATCH v3 1/2] watchdog: at91sam9_wdt: add device tree support
References: <1348558114-31750-1-git-send-email-fabio.porcedda@gmail.com> <1348558114-31750-2-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1348558114-31750-2-git-send-email-fabio.porcedda@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/25/2012 09:28 AM, Fabio Porcedda :
> Tested on an at91sam9260 board (evk-pro3)
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
>  .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
>  drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> new file mode 100644
> index 0000000..724fad1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> @@ -0,0 +1,19 @@
> +* Atmel Watchdog Timers
> +
> +** at91sam9-wdt
> +
> +Required properties:
> +- compatible: must be "atmel,at91sam9-wdt".

As Jean-Christophe said, you should use the complete name of the fist
SoC that used this WDT version:

So please change all compatibility strings to:

atmel,at91sam9260-wdt


> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +Optional properties:
> +- heartbeat: contains the watchdog heartbeats in seconds.
> +
> +Example:
> +
> +	watchdog@fffffd40 {
> +		compatible = "atmel,at91sam9-wdt";
> +		reg = <0xfffffd40 0x10>;
> +		heartbeat = <10>;
> +	};
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 05e1be8..56b8836 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -32,6 +32,7 @@
>  #include <linux/timer.h>
>  #include <linux/bitops.h>
>  #include <linux/uaccess.h>
> +#include <linux/of.h>
>  
>  #include "at91sam9_wdt.h"
>  
> @@ -254,6 +255,14 @@ static struct miscdevice at91wdt_miscdev = {
>  	.fops		= &at91wdt_fops,
>  };
>  
> +static inline void __init at91wdt_probe_dt(struct device_node *node)
> +{
> +	if (!node)
> +		return;
> +
> +	of_property_read_u32(node, "heartbeat", &heartbeat);
> +}
> +
>  static int __init at91wdt_probe(struct platform_device *pdev)
>  {
>  	struct resource	*r;
> @@ -272,6 +281,8 @@ static int __init at91wdt_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	at91wdt_probe_dt(pdev->dev.of_node);
> +
>  	/* Set watchdog */
>  	res = at91_wdt_settimeout(ms_to_ticks(WDT_HW_TIMEOUT * 1000));
>  	if (res)
> @@ -302,11 +313,21 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
>  	return res;
>  }
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id at91_wdt_dt_ids[] = {
> +	{ .compatible = "atmel,at91sam9-wdt" },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
> +#endif
> +
>  static struct platform_driver at91wdt_driver = {
>  	.remove		= __exit_p(at91wdt_remove),
>  	.driver		= {
>  		.name	= "at91_wdt",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(at91_wdt_dt_ids),
>  	},
>  };
>  
> 

Otherwise, looks ok...

-- 
Nicolas Ferre
