Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46254 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbdCBSkS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Mar 2017 13:40:18 -0500
Date: Thu, 2 Mar 2017 10:39:49 -0800
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
Message-ID: <20170302183949.GA2047@roeck-us.net>
References: <20170302135746.30550-1-chris.brandt@renesas.com>
 <20170302135746.30550-2-chris.brandt@renesas.com>
 <bf76e106-9272-622c-8d4e-c270a6b51d16@roeck-us.net>
 <SG2PR06MB11656FE3E3CF8BAA1B8A86688A280@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20170302171148.GA28554@roeck-us.net>
 <SG2PR06MB11656393CB487F8413DAD58C8A280@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20170302174855.GD28554@roeck-us.net>
 <SG2PR06MB1165F37B234CE0353B4E86B98A280@SG2PR06MB1165.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR06MB1165F37B234CE0353B4E86B98A280@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Mar 02, 2017 at 06:22:17PM +0000, Chris Brandt wrote:
> On Thursday, March 02, 2017, Guenter Roeck wrote:
> > > > > > The rate check should probably be here to avoid situations where
> > > > > > rate < 16384.
> > > > >
> > > > > Do I need that if it's technically not possible to have a 'rate'
> > > > > less
> > > > than 25MHz?
> > > > >
> > > > > These watchdogs HW are always feed directly from the peripheral
> > > > > clock and there is no such thing as a 16kHz peripheral block an
> > > > > any Renesas
> > > > SoC.
> > > > >
> > > > Following that line of argument, can clk_get_rate() ever return 0 ?
> > >
> > > In the DT binding, it says that a clock source is required to be present.
> > >
> > > If the user leaves out the "clocks =", then devm_clk_get will fail.
> > >
> > > If the user puts in some crazy value for "clocks = ", then maybe you
> > > could get
> > > 0 (assuming there is a valid clock node they made by themselves
> > > somewhere that runs at 0Hz).
> > > But in that extreme case, I think they deserve to have it crash and
> > > burn because who knows what they are doing.
> > >
> > 
> > But then there could also be a clock source with a rate of less than 16
> > kHz, as wrong as it may be ?
> > 
> > Anyway, I disagree about the crash and burn. It isn't as if this would be
> > really fatal except for the watchdog driver. Bad data in devicetree should
> > not result in a system crash.
> 
> OK. I will put the check in. Something like:
> 
> 	rate = clk_get_rate(priv->clk); 
> 	if (rate < 16384) {
> 		dev_err(&pdev->dev, "invalid clock specified\n");
> 		return -ENOENT;
> 	}
> 
> 
Sounds good. Maybe display the wrong rate as well ?
Not a strong opinion though.

Thanks,
Guenter

> > > > That is the point of devm_ functions. It also means that you won't
> > > > need a remove function if you also use devm_watchdog_register_device().
> > >
> > > OK.
> > > I see that only 1 driver is using devm_watchdog_register_device
> > > (wdat_wdt.c), so maybe that is a new method.
> > >
> > Yes, it is quite new. Still, you are a bit behind. I count 19 users in the
> > mainline kernel.
> 
> OK, I see now.
> 
> 
> Thank you,
> Chris
