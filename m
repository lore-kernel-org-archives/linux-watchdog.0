Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:58015 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759688Ab3DJNlt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Apr 2013 09:41:49 -0400
Date: Wed, 10 Apr 2013 06:41:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: wim@iguana.be, manabian@gmail.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH] watchdog: Revert the AT91RM9200_WATCHDOG dependency
Message-ID: <20130410134156.GA15456@roeck-us.net>
References: <20130409202711.GG7867@spo001.leaseweb.com>
 <1365597382-15455-1-git-send-email-nicolas.ferre@atmel.com>
 <20130410133351.GA7295@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130410133351.GA7295@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Apr 10, 2013 at 06:33:51AM -0700, Guenter Roeck wrote:
> On Wed, Apr 10, 2013 at 02:36:22PM +0200, Nicolas Ferre wrote:
> > Compiling the at91rm9200_wdt.c driver without at91rm9200
> > support was leading to several errors:
> > 
> > drivers/built-in.o: In function `at91_wdt_close':
> > at91_adc.c:(.text+0xc9fe4): undefined reference to `at91_st_base'
> > drivers/built-in.o: In function `at91_wdt_write':
> > at91_adc.c:(.text+0xca004): undefined reference to `at91_st_base'
> > drivers/built-in.o: In function `at91wdt_shutdown':
> > at91_adc.c:(.text+0xca01c): undefined reference to `at91_st_base'
> > drivers/built-in.o: In function `at91wdt_suspend':
> > at91_adc.c:(.text+0xca038): undefined reference to `at91_st_base'
> > drivers/built-in.o: In function `at91_wdt_open':
> > at91_adc.c:(.text+0xca0cc): undefined reference to `at91_st_base'
> > drivers/built-in.o:at91_adc.c:(.text+0xca2c8): more undefined references to
> > `at91_st_base' follow
> > 
> > So, reverting the modification of the "depends" Kconfig line
> > introduced by patch a6a1bcd37 (watchdog: at91rm9200: add DT support)
> > seems to be the good solution.
> > 
> Really ? Why ? I mean, this was supposed to be for at91rm9200, wasn't it ?
> And why would want try to compile a watchdog for at91rm9200 without at91rm9200
> support ?
> 
> I understand there is a problem, I just don't see how removing that line would
> solve it.
> 
Me confused, sorry. I somehow thought you were removing the ARCH_AT91RM9200
dependency, not adding it.

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter
