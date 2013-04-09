Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:42246 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936183Ab3DIU1O (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Apr 2013 16:27:14 -0400
Date: Tue, 9 Apr 2013 22:27:11 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Joachim Eastwood <manabian@gmail.com>, plagnioj@jcrosoft.com,
	linux-watchdog@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH] watchdog: at91rm9200: add DT support
Message-ID: <20130409202711.GG7867@spo001.leaseweb.com>
References: <1360879349-17369-1-git-send-email-manabian@gmail.com> <51641FD4.9070706@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51641FD4.9070706@atmel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 7f809fd..82ebff9 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -116,7 +116,7 @@ config ARM_SP805_WATCHDOG
> >  
> >  config AT91RM9200_WATCHDOG
> >  	tristate "AT91RM9200 watchdog"
> > -	depends on ARCH_AT91RM9200
> > +	depends on ARCH_AT91
> 
> This seems to trigger errors when compiling without AT91RM9200 selected:
> 
> 
> drivers/built-in.o: In function `at91_wdt_close':
> at91_adc.c:(.text+0xc9fe4): undefined reference to `at91_st_base'
> drivers/built-in.o: In function `at91_wdt_write':
> at91_adc.c:(.text+0xca004): undefined reference to `at91_st_base'
> drivers/built-in.o: In function `at91wdt_shutdown':
> at91_adc.c:(.text+0xca01c): undefined reference to `at91_st_base'
> drivers/built-in.o: In function `at91wdt_suspend':
> at91_adc.c:(.text+0xca038): undefined reference to `at91_st_base'
> drivers/built-in.o: In function `at91_wdt_open':
> at91_adc.c:(.text+0xca0cc): undefined reference to `at91_st_base'
> drivers/built-in.o:at91_adc.c:(.text+0xca2c8): more undefined references to `at91_st_base' follow
> make[2]: *** [vmlinux] Error 1
> make[1]: *** [sub-make] Error 2
> make: *** [all] Error 2
> 
> It seems thatthis driver is not written for non-rm9200-proof compilation...
> So, it can be a good idea to revert this *line* for 3.9-final: Wim, what do you think?

If this triggers compile error, then this indeed needs to get fixed.
I'll do the necessary tomorrow.

Kind regards,
Wim.

