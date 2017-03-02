Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36478 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbdCBUD4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Mar 2017 15:03:56 -0500
Date: Thu, 2 Mar 2017 09:48:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] watchdog: add rza_wdt driver
Message-ID: <20170302174855.GD28554@roeck-us.net>
References: <20170302135746.30550-1-chris.brandt@renesas.com>
 <20170302135746.30550-2-chris.brandt@renesas.com>
 <bf76e106-9272-622c-8d4e-c270a6b51d16@roeck-us.net>
 <SG2PR06MB11656FE3E3CF8BAA1B8A86688A280@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20170302171148.GA28554@roeck-us.net>
 <SG2PR06MB11656393CB487F8413DAD58C8A280@SG2PR06MB1165.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR06MB11656393CB487F8413DAD58C8A280@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Mar 02, 2017 at 05:31:18PM +0000, Chris Brandt wrote:
> On Thursday, March 02, 2017, Guenter Roeck worte:
> > > > The above two lines are unnecessary.
> > >
> > > OK.
> > >
> > > #I'll assume you mean take out just the last sentence (2 lines), not
> > > both sentences (all 3 lines).
> > >
> > The two empty lines.
> 
> Ooops! That makes more sense.
> 
> 
> > > > > +	rate = clk_get_rate(priv->clk);
> > > > > +	if (!rate)
> > > > > +		return -ENOENT;
> > > > > +
> > > > > +	/* Assume slowest clock rate possible (CKS=7) */
> > > > > +	rate /= 16384;
> > > > > +
> > > >
> > > > The rate check should probably be here to avoid situations where
> > > > rate < 16384.
> > >
> > > Do I need that if it's technically not possible to have a 'rate' less
> > than 25MHz?
> > >
> > > These watchdogs HW are always feed directly from the peripheral clock
> > > and there is no such thing as a 16kHz peripheral block an any Renesas
> > SoC.
> > >
> > Following that line of argument, can clk_get_rate() ever return 0 ?
> 
> In the DT binding, it says that a clock source is required to be present.
> 
> If the user leaves out the "clocks =", then devm_clk_get will fail.
> 
> If the user puts in some crazy value for "clocks = ", then maybe you could get
> 0 (assuming there is a valid clock node they made by themselves somewhere that
> runs at 0Hz).
> But in that extreme case, I think they deserve to have it crash and burn because
> who knows what they are doing.
> 

But then there could also be a clock source with a rate of less than 16 kHz, as
wrong as it may be ?

Anyway, I disagree about the crash and burn. It isn't as if this would be really
fatal except for the watchdog driver. Bad data in devicetree should not result
in a system crash.

> 
> > > > > +	priv->wdev.max_hw_heartbeat_ms = (1000 * U8_MAX)/rate;
> > > >
> > > > space before and after /
> > >
> > > OK.
> > > #Funny because checkpatch.pl said it didn't like a space on one side
> > > but  not the other, so I choose no spaces and it was happy. I'm way
> > > below 80  characters for that line so it doesn't matter to me.
> > >
> > 
> > That would be a bug in checkpatch. coding style, chapter 3.1, still
> > applies.
> > Or at least I hope so.
> 
> OK. Thank you for the clarification.
> 
> 
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > > +
> > > > > +	return 0;
> > 
> > Also just
> > 	return ret;
> 
> OK.
> 
> 
> > > > > +static int rza_wdt_remove(struct platform_device *pdev) {
> > > > > +	struct rza_wdt *priv = platform_get_drvdata(pdev);
> > > > > +
> > > > > +	watchdog_unregister_device(&priv->wdev);
> > > > > +	iounmap(priv->base);
> > > >
> > > > iounmap is unnecessary (and wrong).
> > >
> > > Anything mapped with devm_ioremap_resource() automatically gets
> > > unmapped when the drive gets unloaded?
> > 
> > That is the point of devm_ functions. It also means that you won't need a
> > remove function if you also use devm_watchdog_register_device().
> 
> OK.
> I see that only 1 driver is using devm_watchdog_register_device (wdat_wdt.c), so
> maybe that is a new method.
> 
Yes, it is quite new. Still, you are a bit behind. I count 19 users
in the mainline kernel.

Guenter
