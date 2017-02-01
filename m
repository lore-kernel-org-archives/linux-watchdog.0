Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57503 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753127AbdBAQ4s (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 1 Feb 2017 11:56:48 -0500
Date: Wed, 1 Feb 2017 17:56:33 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: sama5d4: Cache MR instead of a partial
 config
Message-ID: <20170201165633.lof3ddfvd4je35my@piout.net>
References: <20170130171848.31598-1-alexandre.belloni@free-electrons.com>
 <20170130175813.GA23087@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170130175813.GA23087@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 30/01/2017 at 09:58:13 -0800, Guenter Roeck wrote:
> On Mon, Jan 30, 2017 at 06:18:47PM +0100, Alexandre Belloni wrote:
> > .config is used to cache a part of WDT_MR at probe time and is not used
> > afterwards. Instead of doing that, actually cache MR and avoid reading it
> > every time it is modified.
> > 
> The semantic change here is that the old code leaves "other" bits in the
> mr register alone. I assume you have verified that clearing those bits
> does not have negative impact.
> 

It doesn't have any impact unless you expect to restart a watchdog
exactly were you stopped it.

> Also, I am not really sure if replacing a read from a register is more
> costly than a read from memory. Is that change really worth it ?
> I mean, sure, the way the 'config' variable is used is a bit odd,
> but I don't really see the improvement in its replacement either.
> 

It is difficult to say performance wise (I doubt the sama5d4_wdt
structure stays long enough in the cache). But it allows to avoid
reading mr in the suspend function in 2/2.

> > @@ -132,19 +126,19 @@ static int of_sama5d4_wdt_init(struct device_node *np, struct sama5d4_wdt *wdt)
> >  {
> >  	const char *tmp;
> >  
> > -	wdt->config = AT91_WDT_WDDIS;
> > +	wdt->mr = AT91_WDT_WDDIS;
> >  
> >  	if (!of_property_read_string(np, "atmel,watchdog-type", &tmp) &&
> >  	    !strcmp(tmp, "software"))
> > -		wdt->config |= AT91_WDT_WDFIEN;
> > +		wdt->mr |= AT91_WDT_WDFIEN;
> >  	else
> > -		wdt->config |= AT91_WDT_WDRSTEN;
> > +		wdt->mr |= AT91_WDT_WDRSTEN;
> >  
> >  	if (of_property_read_bool(np, "atmel,idle-halt"))
> > -		wdt->config |= AT91_WDT_WDIDLEHLT;
> > +		wdt->mr |= AT91_WDT_WDIDLEHLT;
> >  
> >  	if (of_property_read_bool(np, "atmel,dbg-halt"))
> > -		wdt->config |= AT91_WDT_WDDBGHLT;
> > +		wdt->mr |= AT91_WDT_WDDBGHLT;
> >  
> >  	return 0;
> >  }
> > @@ -163,11 +157,10 @@ static int sama5d4_wdt_init(struct sama5d4_wdt *wdt)
> >  	reg &= ~AT91_WDT_WDDIS;
> >  	wdt_write(wdt, AT91_WDT_MR, reg);
> >  
> There is (at least) one read of the mr register left above this code.
> It is not entirely obvious to me why it would make sense to retain
> this single read instead of just clearing the AT91_WDT_WDDIS bit
> from the cached value and writing the rest. Maybe this is to make
> sure that WDV or WDD isn't changed with the bit set, but ....
> the explanation associated with clearing the bit is a bit odd either
> case. It states that AT91_WDT_WDDIS must not be set (meaning the watchdog
> must be running ? Shouldn't it be the opposite ?) when changing WDV or WDD,
> then violates this rule when updating the timeout (which can happen with
> the watchdog running or not).

The datasheet states:
Note: When setting the WDDIS bit, and while it is set, the fields WDV
and WDD must not be modified.

And indeed, this may be an issue in sama5d4_wdt_set_timeout(). That is
something I needed to clarify and forgot about but I think that can be
solved in a separate patch.

If you prefer I can simply remove the weird wdt->config usage, keeping
the register accesses and then rework 2/2 in consequence.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
