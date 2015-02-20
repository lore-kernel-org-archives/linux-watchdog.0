Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53063 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771AbbBTUFQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 15:05:16 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YOtp5-003UIq-5I
	for linux-watchdog@vger.kernel.org; Fri, 20 Feb 2015 20:05:15 +0000
Date: Fri, 20 Feb 2015 12:04:57 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Rob Herring <robherring2@gmail.com>,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-watchdog@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at
 early boot
Message-ID: <20150220200457.GB29730@roeck-us.net>
References: <6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi>
 <54E49AA5.40008@roeck-us.net>
 <20150218151713.7a718311@bbrezillon>
 <54E4A6C4.4070706@roeck-us.net>
 <20150218160033.GK11529@piout.net>
 <CAL_JsqLj=bGTWr1aUMRNMjC+xmftMLjUHnGu5M337jNdDDOsZA@mail.gmail.com>
 <54E57F4F.5040300@offcode.fi>
 <CAL_Jsq+p=dEE0hz3B+nMG_Y1zNeZiJhfQXzDQ6b8xyKcc2VBJg@mail.gmail.com>
 <20150220162855.GB22752@roeck-us.net>
 <20150220204358.775a9967@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150220204358.775a9967@bbrezillon>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 20, 2015 at 08:43:58PM +0100, Boris Brezillon wrote:
> On Fri, 20 Feb 2015 08:28:55 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Fri, Feb 20, 2015 at 08:06:23AM -0600, Rob Herring wrote:
> > > On Thu, Feb 19, 2015 at 12:14 AM, Timo Kokkonen
> > > <timo.kokkonen@offcode.fi> wrote:
> > > > Hi,
> > > >
> 
> [...]
> 
> > > > What I am proposing here is a way to solve this without hacking. I was told
> > > > to think also a way to defer starting the watchdog for a given timeout so
> > > > that user space would have more time to wake up, which sounded like a good
> > > > idea. And this obviously needs to be implemented so that the watchdog is
> > > > guaranteed to reset the device should there be a crash of any kind that
> > > > prevents the watchdog daemon from starting up. There are a lot of details
> > > > that need to be taken care of properly and therefore watchdog core can't do
> > > > much about it, which is why I thought there is no much point trying to do it
> > > > in watchdog core.
> > > 
> > > Deferring would assume that the watchdog is not already enabled.
> > > 
> > > Putting in how long the kernel should service the watchdog in DT is
> > > like putting soft or hard lockup detection times into DT. These are
> > > kernel settings. If you need to change this, you should update your
> > > kernel or kernel settings, not the DT.
> > > 
> > The time to userspace handover may differ from HW variant to HW variant.
> > Some may load faster, some may load slower.
> > 
> > Similar, the runtime watchdog timeout may be different from system
> > to system.  On a system with faster CPU, and/or one with faster io,
> > one may want (or need) a faster watchdog timeout. I assumed that
> > was accepted and understood when the timeout-sec property was
> > introduced a long time ago, but maybe not.
> > 
> > Yes, the problem should be resolved in a generic way. This has been
> > on my mind for a long time, including the problem if a watchdog should
> > or should not stay or become enabled during early boot. All those are
> > system properties which should be addressed generically, and there
> > should be a means to express those properties in devicetree.
> > 
> > Problem goes back into the old back-and-forth of what can be in devicetree
> > or not. Sorting that out always takes a long time and a substantial amount
> > of effort. Unfortunately, I don't have that time (writing the code would
> > probably be trivial in comparison).
> 
> I once promised myself to propose this stupid idea, so here it is:
> How about creating a new concept called CT (for Config Tree), that
> would reuse the DT syntax and tree representation and add system config
> information to the appropriate devices (something like an overlay
> you'll put on top of your DT).
> 

We actually use that approach at work - essentially a system configuration
using dt syntax. It even uses the dt compiler to create dtb files,
only the dtb files are kept as part of the application software.

Problem here though is that we are not talking about configuration,
but about system properties. Secondary problem is that those system
properties can be abused, and "it can be abused, let's reject it"
is always easy. This is made more complicated by the fact that very
few people are willing or even able to go through the exercise of
clearly distinguishing system configuration vs. system properties
when proposing new dt properties, especially since this can be a very
tricky slope and may require 90% communication skills and 10% engineering
skills (use the term 'configuration' once and you are out). Not really
sure how to solve that problem, or if it is even possible to solve it.

> Joke apart, I've had the same kind of discussion quite often lately.
> While I understand DT guys concern to control which property should go
> into the DT which ones should not, some system config are better
> described next to the device they are attached to rather than in the
> cmdline.
> 
I think we are very much in agreement here.

Thanks,
Guenter
