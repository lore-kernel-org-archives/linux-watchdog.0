Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:54905 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122AbaAUKPV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 05:15:21 -0500
Date: Tue, 21 Jan 2014 11:13:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 03/15] watchdog: orion: Use atomic access for shared
 registers
Message-ID: <20140121101337.GB13396@lunn.ch>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <3381968.dYvuFs4ZXV@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3381968.dYvuFs4ZXV@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 21, 2014 at 10:54:37AM +0100, Arnd Bergmann wrote:
> On Tuesday 21 January 2014 06:12:29 Ezequiel Garcia wrote:
> >         writel(~WDT_INT_REQ, BRIDGE_CAUSE);
> >  
> >         /* Enable watchdog timer */
> > -       reg = readl(wdt_reg + TIMER_CTRL);
> > -       reg |= WDT_EN;
> > -       writel(reg, wdt_reg + TIMER_CTRL);
> > +       atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, WDT_EN);
> 
> As mentioned in my comment for patch 2, it seems that the exported
> orion_timer_ctrl_clrset() function would be more appropriate for this.

Hi Arnd

As Sebastian points out, Armada 370 XP does not have this function. 

> 
> >         /* Enable reset on watchdog */
> > -       reg = readl(RSTOUTn_MASK);
> > -       reg |= WDT_RESET_OUT_EN;
> > -       writel(reg, RSTOUTn_MASK);
> > +       atomic_io_modify(RSTOUTn_MASK, WDT_RESET_OUT_EN, WDT_RESET_OUT_EN);
> 
> And this register already has an abstraction in
> arch/arm/mach-mvebu/system-controller.c. I would prefer to find a way
> to generalize that. I can see multiple ways to do that:

Please be aware that arch/arm/mach-mvebu/system-controller.c is
currently DT only. We need a solution which works for both with DT and
without DT, since orion5x and mv78xx0 none DT boards are not going
away soon.

     Andrew
 
