Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26002 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887AbaEBPS5 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 May 2014 11:18:57 -0400
Date: Fri, 2 May 2014 11:10:05 -0400
From: Don Zickus <dzickus@redhat.com>
To: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net,
	linux-watchdog@vger.kernel.org
Subject: Re: ipmi watchdog questions
Message-ID: <20140502151005.GG198341@redhat.com>
References: <20140501135832.GE61249@redhat.com>
 <5362E8FA.9050700@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5362E8FA.9050700@acm.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 01, 2014 at 07:38:18PM -0500, Corey Minyard wrote:
> On 05/01/2014 08:58 AM, Don Zickus wrote:
> > Hi Corey,
> >
> > I stumbled upon an issue with a partner of ours, where they booted their
> > machine and tried to load the ipmi_watchdog module by hand and it failed.
> >
> > The reason it failed was that the iTCO watchdog driver was already loaded
> > and it registered the misc device /dev/watchdog first.
> >
> > I looked at the ipmi watchdog driver and realized it was never converted
> > to the new watchdog framework where the watchdog_core module manages the
> > '/dev/watchdog' misc device.
> >
> > So being naive and not knowing much about IPMI, I decided to follow the
> > helpful document Documentation/watchdog/convert_drivers_to_kernel_api.txt
> > and convert the ipmi_watchdog to use the new watchdog framework.
> >
> > I ran into a few issues and then realized the driver itself never really
> > binds to any hardware, so it makes the conversion process a little more
> > challenging.
> >
> > So a few questions to you before I waste my time in this area:
> >
> > - Is there any prior history about why the ipmi_watchdog was never
> >   converted to the new watchdog framework?  Lack of interest? Technical
> > hurdles?
> 
> Mostly lack of interest, but there are some technical hurdles.

Hi Corey,

Thanks for all the responses.

> 
> It would be hard to implement some things.  The watchdog framework has
> no concept of pretimeouts.  And IPMI is message based, you send a
> message to a controller to do anything, and you have to wait for the
> response.  That doesn't work very well with the watchdog interface,
> which assumes you can do everything immediately.

I will defer this conversation to Guenter's expertise.  I am willing to hack
up any suggestions the both of you come up with here to see if everything
works well (same goes for the fasync/poll stuff).

> 
> >
> > - Is there a reason why the ipmi_watchdog is a seperate module as opposed
> >   to being called by ipmi_si?  It seems there shouldn't be an issue with
> > the watchdog always loaded, it just won't do anything until someone opens
> > it (from my understanding).  Also you would gain the ability to use the
> > shutdown/remove routines properly instead of the reboot/panic notifiers.
> 
> I'm not sure I understand this.  Why would you want it as part of
> ipmi_si?  ipmi_msghandler would be a little more logical, but IMHO still
> doesn't make sense.  It uses the IPMI interface, and the interface is
> designed to have multiple users.  Better to keep it separate because
> it's a separate function.
> 
> I also don't understand the comment about shutdown/remove instead of
> reboot/panic.  Can you elaborate on that?

So part of the problem with ipmi_watchdog is that it can't load
automatically (like a normal driver).  The reason is that it doesn't
attach to any device.  My suggestion to roll it into ipmi_si (or
ipmi_msghandler works too), was to help with the autoloading part.

To counter-argue the argument that a customer may not want the watchdog
running, I would argue that it does nothing until someone opens it the
first time.  So autoloading shouldn't have a big downside to it.

The second part I was trying to change is to remove the panic/reboot
notifiers and instead use proper shutdown/remove functions.  This would
make it easier to use the 'struct watchdog_device' pointer as the
pointer could be embedded in the per device struct.  Though on the other
hand, there is only ever one ipmi device per system, so maybe having it
global isn't a big deal.  I was trying to think of scalability issues.

> 
> >   In addition, passing the pointer to the 'struct watchdog_device' would be
> > easier if some of those extra pieces were not there (as opposed to making
> > it a global reference).
> >
> > - What does the fasync and poll calls do for a watchdog?
> 
> The IPMI watchdog has the ability to report a pretimeout at a specific
> amount of time before the final timeout, presumably to take some action
> before the system reboots.  the fasync and poll (and read) calls let
> this be reported to the user.
> 
> >
> > I'll start with that for now.
> >
> > I appreciate any feedback.  Currently we just implemented blacklisting the
> > iTCO watchdog driver to workaround this problem.  I thought we could do
> > better, hence my motivation to do work in this area.
> 
> It would be nice, yes.  I'm afraid to get all the functionality would be
> a lot of hacking on the watchdog framework or removal of function from
> the driver.

We can take it step by step and see how we can get there.  Again my goal
was to help a partner of ours get the ipmi_watchdog to play nice in their
system without resorting to blacklisting other watchdogs.  In addition, I
thought it would help with out of the box configuration if the
ipmi_watchdog could autoload if the ipmi pieces were loaded in the system
too instead of having to add an entry to /etc/modprobe.d.

Thanks for the help so far!

Cheers,
Don
