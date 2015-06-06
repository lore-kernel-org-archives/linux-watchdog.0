Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39035 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbbFFRAy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 6 Jun 2015 13:00:54 -0400
Message-ID: <55732744.10303@roeck-us.net>
Date: Sat, 06 Jun 2015 10:00:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] gpio_wdt: Add option for early registration
References: <1433576786-14947-1-git-send-email-jtheou@adeneo-embedded.us> <1433576786-14947-2-git-send-email-jtheou@adeneo-embedded.us>
In-Reply-To: <1433576786-14947-2-git-send-email-jtheou@adeneo-embedded.us>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/06/2015 12:46 AM, Jean-Baptiste Theou wrote:
> In some situation, mainly when it's not possible to disable a
> watchdog, you may want the watchdog driver to be started as soon
> as possible.
>
> Adding GPIO_WATCHDOG_ARCH_INITCALL to raise initcall from
> module_init to arch_initcall.
>
> This patch require watchdog registration deferral mechanism
>
> Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
> ---
> Changes in v3:
>   - Simplify changes, since the modification is for built-in only
>
>   drivers/watchdog/Kconfig    | 12 ++++++++++++
>   drivers/watchdog/gpio_wdt.c |  8 ++++++++
>   2 files changed, 20 insertions(+)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index e5e7c55..7a5c912 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1,3 +1,4 @@
> +
>   #
>   # Watchdog device configuration
>   #
> @@ -104,6 +105,17 @@ config GPIO_WATCHDOG
>   	  If you say yes here you get support for watchdog device
>   	  controlled through GPIO-line.
>
> +config GPIO_WATCHDOG_ARCH_INITCALL
> +	bool "Register the watchdog as early as possible"
> +	depends on GPIO_WATCHDOG=y
> +	help
> +	  In some situations, the default initcall level (module_init)
> +	  in not early enough in the boot process to avoid the watchdog
> +	  to be triggered.
> +	  If you say yes here, the initcall level would be raised to
> +	  arch_initcall.
> +	  If in doubt, say N.
> +
>   config MENF21BMC_WATCHDOG
>   	tristate "MEN 14F021P00 BMC Watchdog"
>   	depends on MFD_MENF21BMC
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index cbc313d..f9149a2 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -267,7 +267,15 @@ static struct platform_driver gpio_wdt_driver = {
>   	.probe	= gpio_wdt_probe,
>   	.remove	= gpio_wdt_remove,
>   };

Please add an empty line here.

Thanks,
Guenter

> +#ifdef GPIO_WATCHDOG_ARCH_INITCALL
> +static int __init gpio_wdt_init(void)
> +{
> +	return platform_driver_register(&gpio_wdt_driver);
> +}
> +arch_initcall(gpio_wdt_init);
> +#else
>   module_platform_driver(gpio_wdt_driver);
> +#endif
>
>   MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
>   MODULE_DESCRIPTION("GPIO Watchdog");
>

