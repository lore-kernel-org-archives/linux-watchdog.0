Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:56303 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbbEORIg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 May 2015 13:08:36 -0400
Date: Fri, 15 May 2015 19:17:23 +0200
From: Andreas Werner <andy@wernerandy.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Window watchdog driver design
Message-ID: <20150515171723.GA27162@wernerandy.de>
References: <20150514115626.GA13621@wernerandy.de>
 <5554A35D.5040702@roeck-us.net>
 <20150514140908.GA21645@wernerandy.de>
 <55554356.3070700@roeck-us.net>
 <20150515054341.GA26468@wernerandy.de>
 <55558EBB.30502@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55558EBB.30502@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 14, 2015 at 11:14:19PM -0700, Guenter Roeck wrote:
> On 05/14/2015 10:43 PM, Andreas Werner wrote:
> >On Thu, May 14, 2015 at 05:52:38PM -0700, Guenter Roeck wrote:
> >>On 05/14/2015 07:09 AM, Andreas Werner wrote:
> >>>On Thu, May 14, 2015 at 06:30:05AM -0700, Guenter Roeck wrote:
> >>>>On 05/14/2015 04:56 AM, Andreas Werner wrote:
> >>>>>Hi,
> >>>>>in the next few weeks I need to write a driver for a window wachtdog
> >>>>>implemented in a CPLD. I have some questions about the design
> >>>>>of the driver and the best way to write this driver to also be able
> >>>>>to submit it.
> >>>>>
> >>>>>The triggering and configuration of the Watchdog is done by several GPIOs which
> >>>>>are connected to the CPLD watchdog device. The correct GPIOs are configurable
> >>>>>using the Device Tree.
> >>>>>
> >>>>>1. Timeout
> >>>>>	The timeout values are defined in ms and start from 20ms to 2560ms.
> >>>>>	The timout is set by 3 GPIOs this means we have only 8 different
> >>>>>	timout values. It is also possible that a future Watchdog CPLD device
> >>>>>	does have different timeout values.
> >>>>>
> >>>>>	Is it possible to set ms timeouts? It seems that the WDT API does
> >>>>>	only support a resolution of 1sec.
> >>>>>
> >>>>>	One idea would be to use the API timeout as something like a timeout
> >>>>>	index to set the different values. Of course this needs to be documented.
> >>>>>
> >>>>>	e.g.
> >>>>>	timeout	(API)	timeout in device
> >>>>>	1 		20ms
> >>>>>	2		100ms
> >>>>>	3		500ms
> >>>>>	...		...		
> >>>>>
> >>>>>2. Upper/Lower Window
> >>>>>	There is currently no support for a windowed watchdog in the wdt core.
> >>>>>	The lower window can be activated by a gpio and its timeout is defined
> >>>>>	as "upper windows timeout/4"	
> >>>>>
> >>>>>	What is the best way to implement those additional settings? Adding additional
> >>>>>	ioctl or export these in sysfs?
> >>>>>--
> >>>>
> >>>>Sorry for the maybe dumb question, but what is a window watchdog,
> >>>>and what is the lower window timeout for (assuming the upper window
> >>>>timeout causes the watchdog to expire) ?
> >>>>
> >>>>Guenter
> >>>>
> >>>
> >>>Oh sorry forgot to describe it in more detail.
> >>>
> >>>If you have a watchdog window you do not have just one timeout where the watchdog can expire.
> >>>You have a so called "window" to trigger it within.
> >>>
> >>>		|<----trig---->|
> >>>---lower timeout----------------upper timeout
> >>>
> >>>This means you have to trigger the watchdog not to late and not to early.
> >>>This kind of watchdog is often used in embedded applications or more often
> >>>in safety cases to fullfil requirements given e.g. by SIL1-SIL4 certifications.
> >>>
> >>>The lower timeout is set by a dedicated GPIO and the value will then "Upper timeout / 4". The
> >>>upper timeout is set by 3 GPIOs to get different timeout values.
> >>>
> >>
> >>Thanks a lot for the explanation.
> >>
> >>I would suggest to use a module parameter to enable the "lower timeout" functionality.
> >>
> >>Timeouts have to be specified in seconds.
> >>
> >>Hope this helps,
> >>Guenter
> >>
> >
> >Thanks for the answer.
> >
> >The module parameter would be ok for me, but it would be better if i can enable/disable
> >the lower window by the application.
> >
> You could try adding a sysfs attribute.

Yes that would be the best solution for that. Module Parameter
would be also ok because normally you just want to enable the lower timeout
or not but if you can do this in the application this would be the best.

> 
> >I know that the API defines the timout in seconds but what about ms? Is there no
> >watchdog out there which has timout values < seconds?.
> >
> The ABI is the ABI, it has been there for a long time, and it only
> supports second intervals.
> 

Yes of course I'm with you.

> >In my case I can only set 2 timouts (1sec and 2sec) but I need to support all 8 timeout
> >values.
> >
> Kind of strict for a Linux watchdog. Most if not all other timeouts are much higher.
> The drivers for hardware with low maximum timeout values often implement
> a two-stage timeout, one handled in the driver that pings the actual hardware
> timeout, and a soft-timeout to be triggered from user space with a more relaxed
> timing.
> 

Yes I've seen such kind of a watchdog but this is not possible for my design.
The watchdog must be used by the application because the application shall be
monitored and not the whole system/kernel. 

> >The other thing is that my Watchdog can have differen timeout values depending
> >on the CPLD and the customer requirements. I can not read out this values, they are
> >only defined in the specification.
> >
> Normally you'd expect such platform specific details to be configured via devicetree
> or platform data if that is not available (or ACPI, of course).
> 
> The userspace/kernel ABI/API needs to be standardized, so that user space doesn't
> need to know implementation details.
> 
Yes you are right, that should be no problem.

> >This is why i had the idea with the table to only set some "indexes" for the timout
> >to handle all the cases.
> >
> Such an "index" would not be a well defined number. A standard application,
> such as watchdogd or systemd, would not know what to do with it.
> 
> After all, the common use case of a watchdog driver is for it to interface with
> a standard userspace application, so its interface to userspace needs to be well
> defined. We can not permit "wildcards" such as redefining the meaning of a time
> interval from seconds to something driver-specific; that would break all kinds
> of applications.
> 

Yes, i just wanted to discuss about it what possiblity I/we have to design a proper driver.

But it seems that this CPLD/Watchdog design is too specific to be also able to get it upstream.
I think I need to define my own ABI for this special watchdog to get all the requirements full filled.


> Guenter
> 


Thanks a lot for discussing :-)

Regards
Andy
