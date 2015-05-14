Return-path: <andy@wernerandy.de>
Date: Thu, 14 May 2015 16:09:08 +0200
From: Andreas Werner <andy@wernerandy.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Window watchdog driver design
Message-ID: <20150514140908.GA21645@wernerandy.de>
References: <20150514115626.GA13621@wernerandy.de>
 <5554A35D.5040702@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5554A35D.5040702@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, May 14, 2015 at 06:30:05AM -0700, Guenter Roeck wrote:
> On 05/14/2015 04:56 AM, Andreas Werner wrote:
> >Hi,
> >in the next few weeks I need to write a driver for a window wachtdog
> >implemented in a CPLD. I have some questions about the design
> >of the driver and the best way to write this driver to also be able
> >to submit it.
> >
> >The triggering and configuration of the Watchdog is done by several GPIOs which
> >are connected to the CPLD watchdog device. The correct GPIOs are configurable
> >using the Device Tree.
> >
> >1. Timeout
> >	The timeout values are defined in ms and start from 20ms to 2560ms.
> >	The timout is set by 3 GPIOs this means we have only 8 different
> >	timout values. It is also possible that a future Watchdog CPLD device
> >	does have different timeout values.
> >
> >	Is it possible to set ms timeouts? It seems that the WDT API does
> >	only support a resolution of 1sec.
> >
> >	One idea would be to use the API timeout as something like a timeout
> >	index to set the different values. Of course this needs to be documented.
> >
> >	e.g.
> >	timeout	(API)	timeout in device
> >	1 		20ms
> >	2		100ms
> >	3		500ms
> >	...		...		
> >
> >2. Upper/Lower Window
> >	There is currently no support for a windowed watchdog in the wdt core.
> >	The lower window can be activated by a gpio and its timeout is defined
> >	as "upper windows timeout/4"	
> >
> >	What is the best way to implement those additional settings? Adding additional
> >	ioctl or export these in sysfs?
> >--
> 
> Sorry for the maybe dumb question, but what is a window watchdog,
> and what is the lower window timeout for (assuming the upper window
> timeout causes the watchdog to expire) ?
> 
> Guenter
> 

Oh sorry forgot to describe it in more detail.

If you have a watchdog window you do not have just one timeout where the watchdog can expire.
You have a so called "window" to trigger it within.

		|<----trig---->|
---lower timeout----------------upper timeout

This means you have to trigger the watchdog not to late and not to early.
This kind of watchdog is often used in embedded applications or more often
in safety cases to fullfil requirements given e.g. by SIL1-SIL4 certifications.

The lower timeout is set by a dedicated GPIO and the value will then "Upper timeout / 4". The
upper timeout is set by 3 GPIOs to get different timeout values.

If you have any further questions, to not hesitate to ask me.

Regards
Andy 
