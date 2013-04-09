Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:53251 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932468Ab3DIOEI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Apr 2013 10:04:08 -0400
Message-ID: <51641FD4.9070706@atmel.com>
Date: Tue, 9 Apr 2013 16:04:04 +0200
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Joachim Eastwood <manabian@gmail.com>, <wim@iguana.be>,
	<plagnioj@jcrosoft.com>
CC: <linux-watchdog@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>
Subject: Re: [PATCH] watchdog: at91rm9200: add DT support
References: <1360879349-17369-1-git-send-email-manabian@gmail.com>
In-Reply-To: <1360879349-17369-1-git-send-email-manabian@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Joachim,

On 02/14/2013 11:02 PM, Joachim Eastwood :
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>  .../devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt        | 9 +++++++++
>  drivers/watchdog/Kconfig                                         | 2 +-
>  drivers/watchdog/at91rm9200_wdt.c                                | 9 +++++++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
> new file mode 100644
> index 0000000..d4d86cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
> @@ -0,0 +1,9 @@
> +Atmel AT91RM9200 System Timer Watchdog
> +
> +Required properties:
> +- compatible: must be "atmel,at91sam9260-wdt".
> +
> +Example:
> +	watchdog@fffffd00 {
> +		compatible = "atmel,at91rm9200-wdt";
> +	};
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 7f809fd..82ebff9 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -116,7 +116,7 @@ config ARM_SP805_WATCHDOG
>  
>  config AT91RM9200_WATCHDOG
>  	tristate "AT91RM9200 watchdog"
> -	depends on ARCH_AT91RM9200
> +	depends on ARCH_AT91

This seems to trigger errors when compiling without AT91RM9200 selected:


drivers/built-in.o: In function `at91_wdt_close':
at91_adc.c:(.text+0xc9fe4): undefined reference to `at91_st_base'
drivers/built-in.o: In function `at91_wdt_write':
at91_adc.c:(.text+0xca004): undefined reference to `at91_st_base'
drivers/built-in.o: In function `at91wdt_shutdown':
at91_adc.c:(.text+0xca01c): undefined reference to `at91_st_base'
drivers/built-in.o: In function `at91wdt_suspend':
at91_adc.c:(.text+0xca038): undefined reference to `at91_st_base'
drivers/built-in.o: In function `at91_wdt_open':
at91_adc.c:(.text+0xca0cc): undefined reference to `at91_st_base'
drivers/built-in.o:at91_adc.c:(.text+0xca2c8): more undefined references to `at91_st_base' follow
make[2]: *** [vmlinux] Error 1
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2

It seems thatthis driver is not written for non-rm9200-proof compilation...
So, it can be a good idea to revert this *line* for 3.9-final: Wim, what do you think?

Best regards,

>  	help
>  	  Watchdog timer embedded into AT91RM9200 chips. This will reboot your
>  	  system when the timeout is reached.
> diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
> index 89831ed..1c75260 100644
> --- a/drivers/watchdog/at91rm9200_wdt.c
> +++ b/drivers/watchdog/at91rm9200_wdt.c
> @@ -24,6 +24,8 @@
>  #include <linux/types.h>
>  #include <linux/watchdog.h>
>  #include <linux/uaccess.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <mach/at91_st.h>
>  
>  #define WDT_DEFAULT_TIME	5	/* seconds */
> @@ -252,6 +254,12 @@ static int at91wdt_resume(struct platform_device *pdev)
>  #define at91wdt_resume	NULL
>  #endif
>  
> +static const struct of_device_id at91_wdt_dt_ids[] = {
> +	{ .compatible = "atmel,at91rm9200-wdt" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
> +
>  static struct platform_driver at91wdt_driver = {
>  	.probe		= at91wdt_probe,
>  	.remove		= at91wdt_remove,
> @@ -261,6 +269,7 @@ static struct platform_driver at91wdt_driver = {
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
