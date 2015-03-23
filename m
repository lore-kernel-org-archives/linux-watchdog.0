Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:56689 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbbCWFeE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Mar 2015 01:34:04 -0400
Date: Mon, 23 Mar 2015 07:33:56 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] watchdog: digicolor: driver for Conexant Digicolor
 CX92755 SoC
Message-ID: <20150323053355.GJ2825@tarshish>
References: <6bc6e867b500cd3cfc629b96f90442f5c0aced3a.1427028036.git.baruch@tkos.co.il>
 <409ece75204d3911dc526a9bc0c908fc30893b26.1427028036.git.baruch@tkos.co.il>
 <550EF4DA.6040407@roeck-us.net>
 <20150322180857.GI2825@tarshish>
 <550F111F.9060400@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550F111F.9060400@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

On Sun, Mar 22, 2015 at 11:59:43AM -0700, Guenter Roeck wrote:
> On 03/22/2015 11:08 AM, Baruch Siach wrote:
> >On Sun, Mar 22, 2015 at 09:59:06AM -0700, Guenter Roeck wrote:
> >>On 03/22/2015 05:40 AM, Baruch Siach wrote:
> >>>+#define DC_WDT_DEFAULT_TIME	5
> >>
> >>Five seconds is an extremely low default timeout. More common would be
> >>30 or 60 seconds. Any special reason for selecting this default ?
> >
> >I copied this value from an old Conexant provided watchdog driver, so I
> >thought it should be a safe default. In fact, the RTC timer is clocked at
> >200MHz by default, and since the counter is only 32bit wide, we can't set
> >timeout much longer than 20 seconds anyway.
>
> That really depends on the application, user space load, and watchdogd
> application configuration.
> 
> You declare that since someone else is doing it in a different watchdog
> driver, it is safe to do it here. This is not really a good argument.
> 
> Remember we are talking about the default setting here, not about some
> target specific setting. I would have thought that the default setting
> would be on the relaxed side of the timeout (probably actually the
> maximum if the maximum is in the 20 seconds range), not a low limit.
> After all, it is always possible to overwrite a relaxed value with a
> stricter one. Overwriting a strict value with a more relaxed one may
> be more difficult if the application handling the watchdog doesn't
> start in time to prevent the first timeout from happening.
> 
> Anyway, I am fine if you think that 5 seconds is ok; that is really
> your call to make. But I really think your logic should be a bit better
> than "someone else is doing it as well".

My intention was to minimize the surprise for someone migrating from the old 
Conexant provided kernel to mainline. I agree though that this logic does not 
extend to watchdog timeout default. I'll set the default to (U32_MAX / 
clk_rate).

[...]

> >>>+static int dc_wdt_set_timeout(struct watchdog_device *wdog, unsigned int 
> >>>t)
> >>>+{
> >>>+	wdog->timeout = t;
> >>>+
> >>No updating the timer count register ?
> >>
> >>If you increase the timeout significantly, the next ping may come too late.
> >
> >Some other drivers are doing the same (e.g. bcm2835_wdt, orion_wdt). Are they
> >buggy? Will fix, anyway.
> >
> 
> I always like that kind of argument ;-). Others do it, therefore I can do it as well.
> 
> Why don't you give it a try.
> 
> Here is the logic: Say, you increase the timeout from 5 seconds to 20 seconds.
> User space now believes it has to ping the watchdog every 10 seconds or so.
> However, you did not update the HW timeout immediately, meaning the watchdog will
> time out no later than 5 seconds after the timeout change, even thought the timeout
> is now supposed to be 20 seconds. If user space does not ping the watchdog immediately
> after changing the timeout, but starts using the 10-second ping schedule, you may
> have a problem.
> 
> Sure, you can declare that you expect user space to ping the watchdog immediately
> after changing the timeout, but that does not necessarily happen just because
> you expect it to happen.

OK. Will fix.

> >>>+static struct watchdog_ops dc_wdt_ops = {
> >>>+	.owner		= THIS_MODULE,
> >>>+	.start		= dc_wdt_start,
> >>>+	.stop		= dc_wdt_stop,
> >>
> >>Since you don't have a ping function, each ping will stop the watchdog,
> >>update the timer, and restart it. Is this intentional ?
> >
> >No. Just copied other drivers. I guess I can set .ping to dc_wdt_start as
> >well.
> >
> That would be pretty pointless, since the watchdog core calls the start
> function if no ping function is available.
> 
> Other hardware may mandate the sequence (turn off watchdog, set timer,
> turn on watchdog). Other driver developers may have used the sequence
> for convenience. That doesn't mean that this watchdog driver should use
> the same sequence or logic just because others do it.
> 
> Specific problem: Assume your system hangs itself hard just after the
> watchdog is disabled, due to some other CPU core doing something really
> bad. Oops ... no more watchdog, system is dead.
> 
> Sure, this may be the mandated sequence on this architecture. That would be
> bad enough, since it leaves the system unprotected for a couple of instructions
> every few seconds. That doesn't mean it should be the default behavior,
> though, if the sequence is _not_ mandated by the hardware.
> 
> So, if your argument was that the hardware mandates the sequence, fine,
> nothing we can do about it. Yet, your argument is that you do it because
> others do it. Think about it.

Right. Unfortunately in this case the counter can only be programmed when the 
timer is off. The watchdog hardware functionality (a single bit, actually) 
looks like an afterthought addition to the system timer. The fact that timer 
update takes place under spinlock should mitigate the problem somewhat.

[...]

> >>>+	wdt->restart_handler.notifier_call = dc_restart_handler;
> >>>+	wdt->restart_handler.priority = 128;
> >>
> >>Is 128 intentional, ie is this the expected reset method for this platform ?
> >>If not, it may be better to select a lower priority (eg 64). Using a watchdog
> >>to reset a system should in general be a method of last resort.
> >
> >Copied this value from imx2_wdt. grep indicates that almost all other watchdog
> >drivers implementing restart_handler use priority of 128 (except bcm47xx_wdt).
> >What is the policy here?
> 
> The policy is to do what is sensible for the platform. That can only be decided
> on a case-by-case basis. The documentation suggests to use 128 for "Default restart
> handler; use if no other restart handler is expected to be available, and/or if
> restart functionality is sufficient to restart the entire system".
> 
> So if this is the only means expected to be available to reset the system
> for this architecture/platform, and if the watchdog resets the entire system
> (not just the CPU), 128 may be ok to use. If, however, there may be other
> means to reset the system, such as a GPIO pin, maybe not.

This driver is for a SoC hardware block. The restart_handler priority level is 
hard coded in the drivers, and should thus work reasonably well for all its 
users. The fact that the common priority level is 128, is significant in this 
case IMO (as apposed to issues discussed above). Systems designers are likely 
take this priority level into account in their designs. If this does not match 
the documentation, then documentation needs to change to reflect reality.

Thanks for your thorough review, and enlightening comments.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
