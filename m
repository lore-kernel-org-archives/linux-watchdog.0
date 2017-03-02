Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54684 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdCBUD6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Mar 2017 15:03:58 -0500
Date: Thu, 2 Mar 2017 09:11:48 -0800
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
Message-ID: <20170302171148.GA28554@roeck-us.net>
References: <20170302135746.30550-1-chris.brandt@renesas.com>
 <20170302135746.30550-2-chris.brandt@renesas.com>
 <bf76e106-9272-622c-8d4e-c270a6b51d16@roeck-us.net>
 <SG2PR06MB11656FE3E3CF8BAA1B8A86688A280@SG2PR06MB1165.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR06MB11656FE3E3CF8BAA1B8A86688A280@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Mar 02, 2017 at 03:38:07PM +0000, Chris Brandt wrote:
> Hello Guenter,
> 
> Thank you for your review!
> 
> 
> On Thursday, March 02, 2017, Guenter Roeck wrote:
> > > +/*
> > > + * Renesas RZ/A Series WDT Driver
> > > + *
> > > + * Copyright (C) 2017 Renesas Electronics America, Inc.
> > > + * Copyright (C) 2017 Chris Brandt
> > > + *
> > > + * This file is subject to the terms and conditions of the GNU
> > > +General Public
> > > + * License.  See the file "COPYING" in the main directory of this
> > > +archive
> > > + * for more details.
> > > + *
> > > + *
> > 
> > The above two lines are unnecessary.
> 
> OK.
> 
> #I'll assume you mean take out just the last sentence (2 lines), not both
> sentences (all 3 lines).
> 
The two empty lines.

>  
> > > +/* Watchdog Timer Registers */
> > > +#define WTCSR 0
> > > +#define WTCSR_MAGIC 0xA500
> > > +#define WTSCR_WT (1<<6)
> > > +#define WTSCR_TME (1<<5)
> > 
> > BIT()
> 
> OK.
> 
> > > +#define WTSCR_CKS(i) i
> > 
> > (i)
> 
> OK.
> 
> 
> > > +#define WRCSR_CLEAR_WOVF 0xA500 /* special value */
> > 
> > Please use
> > #define SOMETHING<tab>value
> > throughout and make sure value is aligned.
> 
> OK.
> 
> > > +	rate = clk_get_rate(priv->clk);
> > > +	if (!rate)
> > > +		return -ENOENT;
> > > +
> > > +	/* Assume slowest clock rate possible (CKS=7) */
> > > +	rate /= 16384;
> > > +
> > 
> > The rate check should probably be here to avoid situations where rate <
> > 16384.
> 
> Do I need that if it's technically not possible to have a 'rate' less than 25MHz?
> 
> These watchdogs HW are always feed directly from the peripheral clock and there
> is no such thing as a 16kHz peripheral block an any Renesas SoC.
> 
Following that line of argument, can clk_get_rate() ever return 0 ?

> 
> > > +	priv->wdev.info = &rza_wdt_ident,
> > > +	priv->wdev.ops = &rza_wdt_ops,
> > > +	priv->wdev.parent = &pdev->dev;
> > > +
> > > +	/*
> > > +	 * Since the max possible timeout of our 8-bit count register is
> > less
> > > +	 * than a second, we must use max_hw_heartbeat_ms.
> > > +	 */
> > > +	priv->wdev.max_hw_heartbeat_ms = (1000 * U8_MAX)/rate;
> > 
> > space before and after /
> 
> OK.
> #Funny because checkpatch.pl said it didn't like a space on one side but
>  not the other, so I choose no spaces and it was happy. I'm way below 80
>  characters for that line so it doesn't matter to me.
> 

That would be a bug in checkpatch. coding style, chapter 3.1, still applies.
Or at least I hope so.

> 
> > > +	dev_info(&pdev->dev, "max hw timeout of %dms\n",
> > > +		 priv->wdev.max_hw_heartbeat_ms);
> > 
> > dev_dbg ?
> 
> OK.
> #I guess we don't need to see that info on every boot.
> 
>  
> > > +
> > > +	priv->wdev.min_timeout = 1;
> > > +	priv->wdev.timeout = DEFAULT_TIMEOUT;
> > > +
> > 
> > Add watchdog_init_timeout(&priv->wdev, 0, &pdev->dev); to optionally get
> > the timeout from dt ?
> 
> OK. Good idea.
> 
> > > +	platform_set_drvdata(pdev, priv);
> > > +	watchdog_set_drvdata(&priv->wdev, priv);
> > > +
> > > +	ret = watchdog_register_device(&priv->wdev);
> > 
> > devm_watchdog_register_device()
> 
> OK.
> 
>  
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return 0;

Also just
	return ret;

> > > +}
> > > +
> > > +static int rza_wdt_remove(struct platform_device *pdev) {
> > > +	struct rza_wdt *priv = platform_get_drvdata(pdev);
> > > +
> > > +	watchdog_unregister_device(&priv->wdev);
> > > +	iounmap(priv->base);
> > 
> > iounmap is unnecessary (and wrong).
> 
> Anything mapped with devm_ioremap_resource() automatically gets unmapped
> when the drive gets unloaded?

That is the point of devm_ functions. It also means that you won't need
a remove function if you also use devm_watchdog_register_device().

Guenter
