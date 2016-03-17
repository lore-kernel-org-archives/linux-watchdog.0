Return-path: <rcochran@linutronix.de>
Date: Thu, 17 Mar 2016 09:08:20 +0100
From: rcochran@linutronix.de
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	rt@linutronix.de
Subject: Re: watchdog: octeon: missing FROZEN hot plug notifier actions
Message-ID: <20160317080820.GA32637@linutronix.de>
References: <20160316205105.GA14847@linutronix.de>
 <56EA21FE.6040009@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56EA21FE.6040009@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Mar 16, 2016 at 08:18:22PM -0700, Guenter Roeck wrote:
> On 03/16/2016 01:51 PM, rcochran@linutronix.de wrote:
> >
> >In drivers/watchdog/octeon-wdt-main.c, the hot plug notifier callback,
> >octeon_wdt_cpu_callback, does not handle events with CPU_TASKS_FROZEN
> >set in the action code.
> >
> >Is this on purpose?  If so, then why is it done that way?
> >
> 
> What do you expect it to do ?

I would expect that the driver handles FROZEN in the same way,
enabling and disabling the watchdog interrupt on the hot plugged CPU.
It looks like an oversight that FROZEN actions are ignored, but I
wanted to be sure.
 
> My understanding is that CPU_TASKS_FROZEN is related to suspend/resume operations,
> which are not really common for typical applications using Octeon CPUs. If they now
> are, it might be worthwhile thinking about adding suspend/resume support to the driver.

Are they merely not common, or is suspend impossible on this machine?
Even if the use case is uncommon, still the driver should be correct.

Thanks,
Richard
