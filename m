Return-path: <pebolle@tiscali.nl>
Message-ID: <1433584986.10861.46.camel@x220>
Subject: Re: [PATCH v3 2/2] gpio_wdt: Add option for early registration
From: Paul Bolle <pebolle@tiscali.nl>
To: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 06 Jun 2015 12:03:06 +0200
In-Reply-To: <1433576786-14947-2-git-send-email-jtheou@adeneo-embedded.us>
References: <1433576786-14947-1-git-send-email-jtheou@adeneo-embedded.us>
	 <1433576786-14947-2-git-send-email-jtheou@adeneo-embedded.us>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, 2015-06-06 at 00:46 -0700, Jean-Baptiste Theou wrote:
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig

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

> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c

> +#ifdef GPIO_WATCHDOG_ARCH_INITCALL

You meant
    #ifdef CONFIG_GPIO_WATCHDOG_ARCH_INITCALL

Please use scripts/checkkconfigsymbols.py.

> +static int __init gpio_wdt_init(void)
> +{
> +	return platform_driver_register(&gpio_wdt_driver);
> +}
> +arch_initcall(gpio_wdt_init);
> +#else
>  module_platform_driver(gpio_wdt_driver);
> +#endif

The entire patch is basically an elaborate NOP. How did this pass your
testing?


Paul Bolle
