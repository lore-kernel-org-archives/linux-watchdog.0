Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:54960 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754384AbaAULEl (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 06:04:41 -0500
Date: Tue, 21 Jan 2014 12:02:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 02/15] clocksource: orion: Use atomic access for
 shared registers
Message-ID: <20140121110255.GD13396@lunn.ch>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <5118193.GjKusj569J@wuerfel>
 <52DE44B9.70308@gmail.com>
 <4103670.WQZpL6dQdj@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4103670.WQZpL6dQdj@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > The real problem with this is that it resides in orion-time.c which
> > is fine for Orion SoCs. Armada 370/XP use a different timer and
> > therefore the _common_ watchdog driver cannot call this function.
> 
> Right, I had missed this part.
> 
> > Moreover, Dove (out of Orion) and Armada 370/XP will happily live in
> > one V7 kernel with both time-orion and time-armada-370-xp compiled in.
> 
> It still wouldn't be too hard to do: both clock drivers could export
> functions with different identifiers, and the wdt driver can use
> conditional compilation (#ifdef or if(IS_ENABLED())) to only call
> those functions when the respective clocksource drivers are enabled.

Hi Arnd.

The plan is to make dove part of MULTI_V7. At that point, you have
both dove and armada-370-xp in the same kernel. Conditional
compilation does not work, the watchdog driver would need to know at
runtime which timer is in use, and call the right timer function.

I'm working on making DT Kirkwood part of MULTI_V5. The changes needed
are mostly trivial. I expect making Dove part of MULTI_V7 is also
trivial, so could happen during the next cycle. So this mix of Dove
and Armada 370 XP is not a theoretical problem, it is something which
needs to be solved ready for merging during the next window.

	Andrew
