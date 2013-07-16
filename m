Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61351 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932381Ab3GPO3p (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Jul 2013 10:29:45 -0400
Date: Tue, 16 Jul 2013 10:29:30 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	devicetree-discuss@lists.ozlabs.org, wim@iguana.be,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 00/10] Orion Watchdog fixes
Message-ID: <20130716142930.GF12062@titan.lakedaemon.net>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716065952.GA25043@lunn.ch>
 <20130716092059.237ea729@skate>
 <20130716073101.GB25043@lunn.ch>
 <20130716121432.GA2317@localhost>
 <20130716134422.GE12062@titan.lakedaemon.net>
 <20130716140435.GA23904@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130716140435.GA23904@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jul 16, 2013 at 11:04:36AM -0300, Ezequiel Garcia wrote:
> On Tue, Jul 16, 2013 at 09:44:22AM -0400, Jason Cooper wrote:
> > On Tue, Jul 16, 2013 at 09:14:33AM -0300, Ezequiel Garcia wrote:
> > > On the other side, I'm much interested in knowing if you are OK with
> > > breaking the watchdog DT compatibility. If you NACK this, then I'll
> > > start preparing a different watchdog driver for 370/XP, since I don't
> > > want to extend a driver that is a bit dirty.
> > 
> > Apparently there is some agreement that the bindings are still in flux
> > and that they need to be for a bit longer in order to hammer out
> > problems such as this.
> > 
> > Arnd and Olof both mentioned that something (a doc, and email?) is
> > forthcoming about marking some bindings as stable.  Whatever form that
> > takes, this one wouldn't get the stable marking yet. ;-)
> > 
> 
> Yup, that's my understanding as well. But on the other side, I don't
> want to break possible users out there.

I agree, but living with a sub-standard binding is worse imho.

> So, just to check, you say it's early enough to safely do such change?

Well, it's not *safe*.  But most consumers on mainline kernels are
currently developer/hackers/distro maintainers.  eg, folks who can
handle it.  It's better to do it now.

> In that case, I'll extend this patchset to include Armada 370/XP support
> and post it as soon as Sebastian's clocksource stuff gets in.

Cool.

thx,

Jason.
