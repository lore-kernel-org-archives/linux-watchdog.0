Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57731 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbbKYShu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Nov 2015 13:37:50 -0500
Subject: Re: In-reply-to:
 <1448056496-2335-1-git-send-email-damien.riegel@savoirfairelinux.com>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	Harald Geyer <harald@ccbib.org>, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
References: <1448056496-2335-2-git-send-email-damien.riegel@savoirfairelinux.com>
 <E1a0sdo-0000RV-FA@stardust.g4.wien.funkfeuer.at>
 <20151123153747.GA13332@localhost>
 <E1a0vjV-0000O4-QX@stardust.g4.wien.funkfeuer.at>
 <20151123233136.GA18839@localhost>
 <E1a1dUj-0000P7-Ie@stardust.g4.wien.funkfeuer.at>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5655FFF9.8040109@roeck-us.net>
Date: Wed, 25 Nov 2015 10:37:45 -0800
MIME-Version: 1.0
In-Reply-To: <E1a1dUj-0000P7-Ie@stardust.g4.wien.funkfeuer.at>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Harald,

On 11/25/2015 09:04 AM, Harald Geyer wrote:
> Damien Riegel writes:
>> On Mon, Nov 23, 2015 at 07:20:57PM +0100, Harald Geyer wrote:
>>> Damien Riegel writes:
>>>>> +	if (code == SYS_DOWN || code == SYS_HALT) {
>>>>>
>>>>> I think you want this to be (code == SYS_POWER_OFF || code == SYS_HALT)
>>>>> AFAIK SYS_DOWN is the code for a reboot, where the system should come
>>>>> back up immediatly, so probably we shouldn't disable the watchdog in
>>>>> this case, for the system might crash during going down.
>>>>
>>>> Well, most of the drivers (all of them but gpio) that I changed stopped
>>>> on SYS_HALT and SYS_DOWN, so they explicitely wanted to stop the
>>>> watchdog on reboot. I just factorized that in watchdog core.
>>>
>>> If they wanted to do so, or the code just got copied around, is
>>> unclear. SYS_DOWN isn't the most helpful name after all, but ...
>>>
>>>> Maybe they should not stop on reboot in the first place, but this serie
>>>> does not introduce a new behaviour.
>>>
>>> okay. I can always send a follow up patch, if I care enough.
>>>
>>
>> I don't understand why you assume this is not the desired behaviour and
>> that the code was just copied around.
>
> Of course this is only weak evidence: I can't think of a reason why
> this would be the desired behaviour other then working around some
> obscure hardware issue. Yet this code is present in nearly all the
> drivers ... so looks like copy&paste. Also so far nobody has presented

That "looks like" is just an assumption. that you can not think of a reason
doesn't mean there isn't one.

> a reason for this code, so looks like it is not a widely known issue.
>

Should or can we assume that the vast majority of watchdog driver writers
did not know what they were doing ? I do not think so. We have to assume
that they knew what they were doing, and we have to support that behavior.

We can support different functionality, but the starting point is to support
what is there today.

>
>>>>> More importantly however we should stop the watchdog on SYS_POWER_OFF
>>>>> I think.
>>>>>
>>>> My understanding here is that if the system is powered off, the watchdog
>>>> will be powered off too, so there is no need to stop it.
>>>
>>> This is true for many platforms, but I'm pretty sure that not all
>>> platforms have a real power off. So unless you can think of a reason not
>>> to stop the watchdog on power off, I think the core should do it.
>>> Actually if this can't be the default, we probably need to extend
>>> your code so that drivers can select the behaviour they want.
>>> (Of course we would hate to do that, as power management and watchdogs
>>> are pretty orthogonal subsystems and having one depend on the behaviour
>>> of the other is very unfortunate.)
>>
>> We have to assume that power-off means that the system will be powered
>> off (...). If a platform has no real power-off, then it should be
>> halted, and in that case the core would stop the watchdog to prevent a
>> spurious reboot.
>
> If on a platform without real power-off somebody at the shell
> (or maybe some script) issues 'poweroff' - what code will be
> sent to the notifier? Honestly I don't know, but I wouldn't rely
> that it is SYS_HALT ...
>
>> But maybe you're right and we should not make such distinction between
>> power-off and halt, but I don't really want to make changes in drivers I
>> don't know the context in which they are used.
>
> Actually you did make changes in at least one driver: gpio_wdt.c
> And this can't be argued with majority, because we can be quite confident,
> that stopping the watchdog before power-off won't cause problems for any
> driver, but OTOH there is no way to forsee the effect of not
> stopping gpio_wdt.c ...
>
> Actually since the gpio watchdog talks to some external hardware, we
> have no way to tell what the effect of a real power-off will be on the
> external hardware as it might have its own power supply that the kernel
> can't control.
>
> I can offer to prepare a kernel with some printk's and test it on
> some platform where I suspect that there could be issues. But I don't
> see much point in it: Even if it turns out not to be an issue on the
> platform I test, that wouldn't provide much confidence for other platforms.
>

My take is that the infrastructure should support the majority of the
existing use cases. If there are other use cases, there are two options:
Enhance the infrastructure to support more if not all use cases, or
don't use the infrastructure for the non-matching use cases.

For poweroff, one could also argue that the watchdog should _not_ stop.
Reason is that if the poweroff fails, for whatever reason, we don't want
the system to be stuck in some odd state. Keeping the watchdog running
ensures that the system comes back alive. If the poweroff request results
in the system entering the rom monitor, I would expect the rom monitor to
disable or ping the watchdog.

Similar arguments can really be made for all cases. Should the watchdog
be stopped on restart because the restart is known to take too long for
the maximum watchdog interval ? Should it be stopped on device shutdown
(which is also registered by some watchdog drivers, and called when the
system restarts) ?

In other words, one can always find arguments one way or another. Some
may be platform / architecture specific, some may be use case specific.
Maybe the behavior should or could be made configurable.

We can either start somewhere and move common code into the watchdog core,
or we can do nothing. I prefer to start somewhere and improve it as we
go along.

Thanks,
Guenter

