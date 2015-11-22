Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33626 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbbKVCcb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 21 Nov 2015 21:32:31 -0500
Subject: Re: [PATCH 4/4] MIPS: bmips: Convert bcm63xx_wdt to use WATCHDOG_CORE
To: Simon Arlott <simon@fire.lp0.eu>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Miguel Gaio <miguel.gaio@efixo.com>,
	Maxime Bizon <mbizon@freebox.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56512937.6030903@roeck-us.net>
Date: Sat, 21 Nov 2015 18:32:23 -0800
MIME-Version: 1.0
In-Reply-To: <5650E5BB.6020404@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/21/2015 01:44 PM, Simon Arlott wrote:
> On 21/11/15 21:32, Guenter Roeck wrote:
>> On 11/21/2015 11:05 AM, Simon Arlott wrote:
>>> Convert bcm63xx_wdt to use WATCHDOG_CORE and add a device tree binding.
>>>
>>> Adds support for the time left value and provides a more effective
>>> interrupt handler based on the watchdog warning interrupt behaviour.
>>>
>>> This removes the unnecessary software countdown timer and replaces the
>>> use of bcm63xx_timer with a normal interrupt when not using mach-bcm63xx.
>>>
>>
>> Hi Simon,
>>
>> this is really doing a bit too much in a single patch.
>> Conversion to the watchdog infrastructure should probably be
>> the first step, followed by further optimizations and improvements.
>
> I'll split it into two patches, but that won't remove the need for #ifdefs.
>
>> In general, it would be great if we can avoid #ifdef in the code.
>> Maybe there is some other means to determine if one code path
>> needs to be taken or another. The driver may be part of a
>> multi-platform image, and #ifdefs in the code make that all
>> but impossible. Besides, it makes the code really hard to read
>> and understand.
>
> It's impossible to avoid the #ifdefs because the driver needs to support
> mach-bmips while still supporting mach-bcm63xx. I don't think they make
> it too difficult to understand. Until there are device tree supporting
> drivers for everything mach-bcm63xx needs, it can't be removed.
>

Even if ifdefs are needed, they don't need to be as extensive as they are.
#ifdef around function names can be handled with shim functions, different
clock names can be handled by defining the clock name per platform.
The interrupt handler registration may not require an #ifdef if it is
just made optional. Conditional include files are typically not needed
at all.

>> We have some infrastructure changes in the works which will move
>> the need for soft-timers from individual drivers into the watchdog core.
>> Would this possibly be helpful here ? The timer-driven watchdog ping
>> seems to accomplish pretty much the same.
>
> There is no need for a software timer. This is not a timer-driven
> watchdog ping, there is an unmaskable timer interrupt when the watchdog
> timer has less than 50% remaining.
>
Ok. Maybe I got confused by the interrupt-triggered watchdog ping.
I'll have to look into that much more closely; it is quite unusual
and complex. The explanation is also not easy to understand.
What does "The only way to stop this interrupt" mean ? Repeatedly
triggering the interrupt in 1/2, 1/4, 1/8 of the remaining time is
really odd.

On side note, the subject tag should be "watchdog:", not "MIPS:".

Thanks,
Guenter

