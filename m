Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36906 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeIJVHw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Sep 2018 17:07:52 -0400
Date: Mon, 10 Sep 2018 09:13:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH v3 1/2] watchdog: rza_wdt: Support longer timeouts
Message-ID: <20180910161300.GA19858@roeck-us.net>
References: <20180907012243.86603-1-chris.brandt@renesas.com>
 <20180907012243.86603-2-chris.brandt@renesas.com>
 <314e2981-8fbd-43ed-2f2d-c080a2961055@roeck-us.net>
 <TY1PR01MB156229CF6EA73FD0B083B0A18A050@TY1PR01MB1562.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB156229CF6EA73FD0B083B0A18A050@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 10, 2018 at 01:53:28PM +0000, Chris Brandt wrote:
> On Saturday, September 08, 2018 1, Guenter Roeck wrote:
> > > +#define CKS_3BIT		0x7
> > > +#define CKS_4BIT		0xF
> >
> > Any special reason for the value of those defines ? They are just used as
> > flags,
> > or am I missing something ? Why not just use 0 / 1 or an enum ?
> 
> Geert's suggestion was:
> 
>   >> I suggest storing cks in rza_wdt_of_match[].data, and
>   >> retrieving it with of_device_get_match_data() in your
>   >> probe function...
> 
> So now I just literally read in the value I want to write into CKS 
> register in the probe function.
> 
>     priv->cks = (unsigned int)of_device_get_match_data(&pdev->dev);
> 
> And since I want to slowest clock source (CKS) possible, that's '0x7' if
> CKS is only 3 bits, and '0xF' if CKS is 4 bits.
> I can add a comment above the #define to explain my reasoning.
> 
Yes, that would help.

> 
> > >   struct rza_wdt {
> > >   	struct watchdog_device wdev;
> > >   	void __iomem *base;
> > >   	struct clk *clk;
> > > +	u8 count;
> > > +	u8 cks;
> > > +	u8 timeout;
> > 
> > Hmm ... this limits the effective timeout to 255 seconds. That seems odd.
> > Maybe it is true in practice, if the clock is always guaranteed to be
> > above 4194304 Hz, but it is an odd assumption that isn't really reflected
> > in the code.
> 
> I can change that to something else like u16.
> 
Sorry, I see no point ion 1) keeping this a separate variable and not using
the one in the watchdog data structure.

> In reality, there are 2 variations of HW:
> 
> #1. If the CKS is only 3-bits, the max HW timeout is 200ms, so I'm 
> setting 'max_hw_heartbeat_ms' and then the use can set a timeout as long as 
> they want (but it's not really a true HW watchdog).
> 
> #2. If the CKS is only 4-bits, the max HW timeout is 32 seconds. (so 
> 'timeout' can never be more that a u8).
> 
That is not the point. The point is that there is no need to keep two
'timeout' variables.

> 
> > > +	if (priv->cks == CKS_4BIT) {
> > > +		ticks = DIV_ROUND_UP((timeout * rate), 4194304);
> > 
> > The ( ) around timeout * rate is unnecessary.
> 
> Yes, you're right.
> 
> 
> > Also, it would be nice
> > to have a define and explanation for 4194304 (and 0x400000 would probably
> > be a better value to use).
> 
> The number "4194304" is exactly how it is documented in the hardware 
> manual, that is why I'm using it that way. Yes, 0x400000 makes more 
> sense, but I like matching the device documenting as much as possible to 
> help the next person that comes along and has to debug this code.
> 
Use at least a define.

> 
> > > +		if (ticks > 256)
> > > +			ticks = 256;
> > 
> > If you keep this, you should as well recalculate timeout since it won't
> > match the expected value.
> > 
> > 		if (ticks > 256) {
> > 			ticks = 256;
> > 			timeout = ticks * 4194304 / rate;
> > 		}
> 
> That's a good point!
> 
> 
> > Not that it can ever happen, since max_timeout limits the value.
> > Personally I would rather see this dropped with a comment stating that
> > ticks <= 256 is guaranteed by max_timeout; I am not a friend of dead code
> > in the kernel.
> 
> I agree. I will drop this code and put a comment.
> 
> 
> > > @@ -75,7 +103,12 @@ static int rza_wdt_ping(struct watchdog_device
> > *wdev)
> > >   {
> > >   	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
> > >
> > > -	writew(WTCNT_MAGIC | 0, priv->base + WTCNT);
> > > +	if (priv->timeout != wdev->timeout)
> > > +		rza_wdt_calc_timeout(priv, wdev->timeout);
> > > +
> > FWIW, odd way of updating the timeout. Why not do it in the set_timeout()
> > function where it belongs. Which makes me wonder why priv->timeout is
> > needed
> > in the first place (and why it is u8 - as mentioned above).
> 
> Because when I was doing all my testing, I found cases where '.ping' was
> called from the upper layer without '.start' being called first. So, I 
> changed the code as you see it now. This guaranteed I would also get the
> timeout the user was requesting.
> 
That would only happen if the watchdog is considered to be running. 
Also, we are talking about the set_timeout function which is the one which
should set the timeout and update the HW if needed, ie if the watchdog is
already running.

> 
> > > +	writew(WTCNT_MAGIC | priv->count, priv->base + WTCNT);
> > > +
> > > +	pr_debug("%s: timeout = %u\n", __func__, wdev->timeout);
> > >
> > 
> > Do you really want this displayed with each ping, even as debug message ?
> > Just wondering.
> 
> This is how you can see that sometimes '.ping' is called without '.start'
> being called first.
> 
If that happens and the watchdog was not already started, it would be
a bug that would affect all watchdog drivers. If that is the case,
working around it in a driver is most definitely the wrong solution.

Guenter
