Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:10607 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2KPO4S (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 16 Nov 2012 09:56:18 -0500
Message-ID: <50A6540F.9070308@atmel.com>
Date: Fri, 16 Nov 2012 15:56:15 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Fabio Porcedda <fabio.porcedda@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	<devicetree-discuss@lists.ozlabs.org>,
	"Yang, Wenyou" <Wenyou.Yang@atmel.com>,
	LIN Junmin <JM.Lin@atmel.com>,
	"Jean-Christophe PLAGNIOL-VILLARD" <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v9 RESEND 1/3] watchdog: at91sam9_wdt: add device tree
 support
References: <1352709447-8306-1-git-send-email-fabio.porcedda@gmail.com> <1352709447-8306-2-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1352709447-8306-2-git-send-email-fabio.porcedda@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/12/2012 09:37 AM, Fabio Porcedda :
> Tested on an at91sam9260 board (evk-pro3)
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
(and to the whole patch series actually)

Wim, can you tell me if it is possible to merge this part through
arm-soc git tree with the rest of material for AT91? If yes, I would
need your Acked-by...

Thanks, best regards,

> ---
>  Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 15 +++++++++++++++
>  drivers/watchdog/at91sam9_wdt.c                          | 11 +++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> new file mode 100644
> index 0000000..2957ebb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> @@ -0,0 +1,15 @@
> +* Atmel Watchdog Timers
> +
> +** at91sam9-wdt
> +
> +Required properties:
> +- compatible: must be "atmel,at91sam9260-wdt".
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +Example:
> +
> +	watchdog@fffffd40 {
> +		compatible = "atmel,at91sam9260-wdt";
> +		reg = <0xfffffd40 0x10>;
> +	};
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 05e1be8..dc42e44 100644
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
> @@ -302,11 +303,21 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
>  	return res;
>  }
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id at91_wdt_dt_ids[] __initconst = {
> +	{ .compatible = "atmel,at91sam9260-wdt" },
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


-- 
Nicolas Ferre
