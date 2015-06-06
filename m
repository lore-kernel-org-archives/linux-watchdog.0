Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38146 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbbFFEba (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 6 Jun 2015 00:31:30 -0400
Message-ID: <557277A0.4060801@roeck-us.net>
Date: Fri, 05 Jun 2015 21:31:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] gpio_wdt: Add option for early registration
References: <1433555212-4729-1-git-send-email-jtheou@adeneo-embedded.us> <1433555212-4729-3-git-send-email-jtheou@adeneo-embedded.us>
In-Reply-To: <1433555212-4729-3-git-send-email-jtheou@adeneo-embedded.us>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/05/2015 06:46 PM, Jean-Baptiste Theou wrote:
> In some situation, mainly when it's not possible to disable a
> watchdog, you may want the watchdog driver to be started as soon
> as possible.
>
> Adding GPIO_WATCHDOG_ARCH_INITCALL to raise initcall from
> module_init to arch_initcall. This is only for a built-in
> module.
>
> This patch require watchdog registration deferral mechanism
>
> Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
> ---
>   drivers/watchdog/Kconfig    | 14 ++++++++++++++
>   drivers/watchdog/gpio_wdt.c | 13 +++++++++++++
>   2 files changed, 27 insertions(+)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index e5e7c55..a9655a9 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1,3 +1,4 @@
> +
>   #
>   # Watchdog device configuration
>   #
> @@ -114,6 +115,19 @@ config MENF21BMC_WATCHDOG
>   	  This driver can also be built as a module. If so the module
>   	  will be called menf21bmc_wdt.
>
> +config GPIO_WATCHDOG_ARCH_INITCALL
> +	bool "Register the watchdog as early as possible"
> +	depends on GPIO_WATCHDOG

	depends on GPIO_WATCHDOG=y

> +	help
> +	  This option make sense only on a built-in situation.
> +
and then you can drop this sentence.

> +	  In some situation, the default initcall level (module_init)

situations

> +	  in not early enough on the boot process to avoid the watchdog

in the boot process

> +	  to be trigger.

triggered.

> +	  If you say yes here, the initcall level would be raise to

will be raised to ...

> +	  arch_initcall.
> +	  "If in doubt, leave it out" - say N.

If in doubt, say N.

> +
>   config WM831X_WATCHDOG
>   	tristate "WM831x watchdog"
>   	depends on MFD_WM831X
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index cbc313d..07a39cd 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -267,8 +267,21 @@ static struct platform_driver gpio_wdt_driver = {
>   	.probe	= gpio_wdt_probe,
>   	.remove	= gpio_wdt_remove,
>   };
> +#ifndef GPIO_WATCHDOG_ARCH_INITCALL
>   module_platform_driver(gpio_wdt_driver);
> +#else
> +static int __init gpio_wdt_init(void)
> +{
> +	return platform_driver_register(&gpio_wdt_driver);
> +}
> +arch_initcall(gpio_wdt_init);
>
> +static void __exit gpio_wdt_exit(void)
> +{
> +	platform_driver_unregister(&gpio_wdt_driver);
> +}
> +module_exit(gpio_wdt_exit);
> +#endif

If you change the dependency as suggested above, you don't need
the exit function at all, and you can simplify this code to

#ifdef GPIO_WATCHDOG_ARCH_INITCALL
arch_initcall(gpio_wdt_init);
#else
module_platform_driver(gpio_wdt_driver);
#endif

which would look much nicer.

Thanks,
Guenter

>   MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
>   MODULE_DESCRIPTION("GPIO Watchdog");
>   MODULE_LICENSE("GPL");
>

