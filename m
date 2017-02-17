Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42554 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934159AbdBQPQw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Feb 2017 10:16:52 -0500
Date: Fri, 17 Feb 2017 16:16:50 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] watchdog: sama5d4: Fix setting timeout when
 watchdog is disabled
Message-ID: <20170217151625.hv2vn5imx2kyeftt@piout.net>
References: <20170216193053.5546-1-alexandre.belloni@free-electrons.com>
 <20170216193053.5546-2-alexandre.belloni@free-electrons.com>
 <968ef53e-c3c4-5322-020a-8382ce367931@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <968ef53e-c3c4-5322-020a-8382ce367931@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 17/02/2017 at 06:40:33 -0800, Guenter Roeck wrote:
> On 02/16/2017 11:30 AM, Alexandre Belloni wrote:
> > The datasheet states: "When setting the WDDIS bit, and while it is set, the
> > fields WDV and WDD must not be modified."
> > 
> > Ensure WDDIS is not set when changing the timeout and set it afterwards if
> > the watchdog was disabled.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> > Changes in v2:
> >  - new patch
> >  drivers/watchdog/sama5d4_wdt.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> > index 2c6f5a70ae67..2a60251806d2 100644
> > --- a/drivers/watchdog/sama5d4_wdt.c
> > +++ b/drivers/watchdog/sama5d4_wdt.c
> > @@ -90,11 +90,18 @@ static int sama5d4_wdt_set_timeout(struct watchdog_device *wdd,
> >  	u32 reg;
> > 
> >  	reg = wdt_read(wdt, AT91_WDT_MR);
> > +
> > +	if (reg & AT91_WDT_WDDIS)
> > +		wdt_write(wdt, AT91_WDT_MR, reg & ~AT91_WDT_WDDIS);
> > +
> >  	reg &= ~AT91_WDT_WDV;
> >  	reg &= ~AT91_WDT_WDD;
> >  	reg |= AT91_WDT_SET_WDV(value);
> >  	reg |= AT91_WDT_SET_WDD(value);
> > -	wdt_write(wdt, AT91_WDT_MR, reg);
> > +	wdt_write(wdt, AT91_WDT_MR, reg & ~AT91_WDT_WDDIS);
> > +
> > +	if (reg & AT91_WDT_WDDIS)
> > +		wdt_write(wdt, AT91_WDT_MR, reg);
> > 
> That means if the watchdog is running, the timeout would not be updated.
> It should be updated no matter if it is running or not.
> 

No, it is enabling the watchdog, then changing WDV and WDD and finally
disabling the watchdog if necessary. So, WDV and WDD are always changed.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
