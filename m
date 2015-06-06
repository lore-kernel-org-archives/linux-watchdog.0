Return-path: <valentinrothberg@gmail.com>
Date: Sat, 6 Jun 2015 14:56:11 +0200
From: Valentin Rothberg <valentinrothberg@gmail.com>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] gpio_wdt: Add option for early registration
Message-ID: <20150606125611.GA16930@nebuchadnezzar>
References: <1433576786-14947-1-git-send-email-jtheou@adeneo-embedded.us>
 <1433576786-14947-2-git-send-email-jtheou@adeneo-embedded.us>
 <1433584986.10861.46.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433584986.10861.46.camel@x220>
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, Jun 06, 2015 at 12:03:06PM +0200, Paul Bolle wrote:
> On Sat, 2015-06-06 at 00:46 -0700, Jean-Baptiste Theou wrote:
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> 
> > +config GPIO_WATCHDOG_ARCH_INITCALL
> > +	bool "Register the watchdog as early as possible"
> > +	depends on GPIO_WATCHDOG=y
> > +	help
> > +	  In some situations, the default initcall level (module_init)
> > +	  in not early enough in the boot process to avoid the watchdog
> > +	  to be triggered.
> > +	  If you say yes here, the initcall level would be raised to
> > +	  arch_initcall.
> > +	  If in doubt, say N.
> 
> > --- a/drivers/watchdog/gpio_wdt.c
> > +++ b/drivers/watchdog/gpio_wdt.c
> 
> > +#ifdef GPIO_WATCHDOG_ARCH_INITCALL
> 
> You meant
>     #ifdef CONFIG_GPIO_WATCHDOG_ARCH_INITCALL
> 
> Please use scripts/checkkconfigsymbols.py.

checkkconfigsymbols.py only checks CONFIG_ prefix symbols.  Since this
prefix is missing here, the script would not complain.  But that's
an interesting case and worth checking for.

Kind regards,
 Valentin

> 
> > +static int __init gpio_wdt_init(void)
> > +{
> > +	return platform_driver_register(&gpio_wdt_driver);
> > +}
> > +arch_initcall(gpio_wdt_init);
> > +#else
> >  module_platform_driver(gpio_wdt_driver);
> > +#endif
> 
> The entire patch is basically an elaborate NOP. How did this pass your
> testing?
> 
> 
> Paul Bolle
