Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f195.google.com ([209.85.192.195]:61808 "EHLO
	mail-pd0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbaBGQzY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Feb 2014 11:55:24 -0500
Date: Fri, 7 Feb 2014 08:55:22 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 05/19] watchdog: orion: Make sure the watchdog is
 initially stopped
Message-ID: <20140207165522.GA9158@roeck-us.net>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1391707226-18258-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <52F43ED0.4050808@roeck-us.net>
 <20140207104044.GA11063@localhost>
 <52F4E1C1.4010805@roeck-us.net>
 <20140207151727.GB8218@localhost>
 <20140207154453.GA8533@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140207154453.GA8533@titan.lakedaemon.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 07, 2014 at 10:44:53AM -0500, Jason Cooper wrote:
> On Fri, Feb 07, 2014 at 12:17:28PM -0300, Ezequiel Garcia wrote:
> > On Fri, Feb 07, 2014 at 05:38:09AM -0800, Guenter Roeck wrote:
> > > On 02/07/2014 02:40 AM, Ezequiel Garcia wrote:
> > > > On Thu, Feb 06, 2014 at 06:02:56PM -0800, Guenter Roeck wrote:
> > > >> On 02/06/2014 09:20 AM, Ezequiel Garcia wrote:
> > > >>> Having the watchdog initially fully stopped is important to avoid
> > > >>> any spurious watchdog triggers, in case the registers are not in
> > > >>> its reset state.
> > > >>>
> > > >>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > >>> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > > >>> Tested-by: Willy Tarreau <w@1wt.eu>
> > > >>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > >>> ---
> > > >>>    drivers/watchdog/orion_wdt.c | 3 +++
> > > >>>    1 file changed, 3 insertions(+)
> > > >>>
> > > >>> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> > > >>> index 6746033..2dbeee9 100644
> > > >>> --- a/drivers/watchdog/orion_wdt.c
> > > >>> +++ b/drivers/watchdog/orion_wdt.c
> > > >>> @@ -142,6 +142,9 @@ static int orion_wdt_probe(struct platform_device *pdev)
> > > >>>    	orion_wdt.max_timeout = wdt_max_duration;
> > > >>>    	watchdog_init_timeout(&orion_wdt, heartbeat, &pdev->dev);
> > > >>>
> > > >>> +	/* Let's make sure the watchdog is fully stopped */
> > > >>> +	orion_wdt_stop(&orion_wdt);
> > > >>> +
> > > >>
> > > >> Actually we just had that in another driver, and I stumbled over it there.
> > > >>
> > > >> Problem with stopping the watchdog in probe unconditionally is that you can
> > > >> use it to defeat nowayout: unload the module, then load it again,
> > > >> and the watchdog is stopped even if nowayout is true.
> > > >>
> 
> How often would a user legitimately want to unload/load the watchdog
> module?
> 
Not sure what you are saying here. If you don't think the nowayout option
should be supported, drop it. Don't claim it is supported when it isn't.

> > > >
> > > > Hm... I see.
> > > >
> > > >> Is this really what you want ? Or, in other words, what is the problem
> > > >> you are trying to solve ?
> > > >>
> > > >
> > > > Well, this is related to the discussion about the bootloader not
> > > > reseting the watchdog properly, provoking spurious watchdog triggering.
> > > >
> > > > Jason Gunthorpe explained [1] that we needed a particular sequence:
> > > >
> > > >   1. Disable WDT
> > > >   2. Clear bridge
> > > >   3. Enable WDT
> > > >
> > > > We added the irq handling to satisfy (2), and the watchdog stop for (1).
> > > >
> > > > The watchdog stop was agreed specifically [2].
> > > >
> > > > Ideas?
> > > >
> > > 
> > > Other drivers assume that if the watchdog is running, it is supposed
> > > to be running. The more common approach in such cases is to ping the
> > > watchdog once to give userspace more time to get ready, but leave
> > > it enabled. So you could check if the watchdog is enabled, and if
> > > it was enabled re-enable it after initialization is complete
> > > (and maybe log a message stating that the watchdog is enabled).
> > > 
> > > If you don't want to do that, and if you are defeating nowayout
> > > on purpose to fix a problem with a broken bootloader,
> > > you should at least put in comment describing the problem you are
> > > trying to solve, and that you accept breaking nowayout with your fix.
> 
> Yes, this should be commented.
> 
> > I'm not fond of not having "nowayout" option on our driver, given I'm sure
> > it's a watchdog feature for a good reason.
> > 
> > On the other side, I can't see how can we distinguish a previously
> > and explicitly enabled watchdog, from a spurious enable by broken bootloader.
> 
> How about we just don't define module_exit() and leave a comment as
> such?  It's not unprecedented, a couple of the atm drivers are
> explicitly setup like this (uPD98402.c, zatm.c, eni.c).
> 
Or don't support tristate in the first place. There was some argument from
others earlier that a watchdog should never be optional. Or drop the nowayout
option from the driver.

There is one problem, though, if you don't support a pre-enabled watchdog:
If the system dies before the watchdog application starts running, it will
hang. This is the reason why the watchdog is enabled on purpose by some
boot loaders.

Guenter
