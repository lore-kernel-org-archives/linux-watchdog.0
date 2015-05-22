Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:36913 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756396AbbEVMOR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 May 2015 08:14:17 -0400
Message-ID: <555F1D91.3020506@offcode.fi>
Date: Fri, 22 May 2015 15:14:09 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>
CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/7] Watchdog: introduce "pretimeout" into framework
References: <=fu.wei@linaro.org>	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>	<1432197156-16947-6-git-send-email-fu.wei@linaro.org>	<555ECD04.6000404@offcode.fi>	<CADyBb7sZWgNnEoTfaYm6=YcbWgEYRMcaNAdX9Y7B6W9pg+gOmg@mail.gmail.com>	<555EEFDB.2030907@offcode.fi> <CADyBb7uh-6=ihfrKHBVXDzAKAE-_GqLXTPJa5_7Gw2R71pyeUg@mail.gmail.com>
In-Reply-To: <CADyBb7uh-6=ihfrKHBVXDzAKAE-_GqLXTPJa5_7Gw2R71pyeUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 22.05.2015 13:46, Fu Wei wrote:
> Hi Timo,
>
> On 22 May 2015 at 16:59, Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
>> On 22.05.2015 11:23, Fu Wei wrote:
>>>
>>> Hi Timo,
>>>
>>>
>>> On 22 May 2015 at 14:30, Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
>>>>
>>>> On 21.05.2015 11:32, fu.wei@linaro.org wrote:
>>>>>
>>>>>
>>>>> From: Fu Wei <fu.wei@linaro.org>
>>>>>
>>>>> Also update Documentation/watchdog/watchdog-kernel-api.txt to
>>>>> introduce:
>>>>> (1)the new elements in the watchdog_device and watchdog_ops struct;
>>>>> (2)the new API "watchdog_init_timeouts".
>>>>>
>>>>> Reasons:
>>>>> (1)kernel already has two watchdog drivers are using "pretimeout":
>>>>>           drivers/char/ipmi/ipmi_watchdog.c
>>>>>           drivers/watchdog/kempld_wdt.c(but the definition is different)
>>>>> (2)some other dirvers are going to use this: ARM SBSA Generic Watchdog
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> As I was proposing some other API changes with my early-timeout-sec work,
>>>> I
>>>> can see my work is going to collide with your API change proposal a bit.
>>>> So
>>>> maybe I should ask your opinion as well..
>>>
>>>
>>> Thank you for reminding me of that, I saw "early-timeout-sec", but
>>> because I don't get it in kernel API or watchdog_core.c, so I did not
>>> pay attention to it.
>>> Sorry.
>>>
>>>>
>>>> Could this pretimeout feature be something that other drivers could
>>>> benefit
>>>> too?
>>>
>>>
>>> yes , as you may know, I am making a patch for pretimeout support in
>>> watchdog framework
>>>
>>>> I can see that it does not do anything else except call panic() before
>>>> letting the watchdog expire. This is something that could be emulated
>>>> easily
>>>> by the watchdog core for drivers that don't know anything about
>>>> pretimeouts
>>>> at all.
>>>
>>>
>>> For SBSA watchdog, there are two stage timeout, and according to kernel
>>> doc:
>>> ----------------------
>>> Pretimeouts:
>>>
>>> Some watchdog timers can be set to have a trigger go off before the
>>> actual time they will reset the system.  This can be done with an NMI,
>>> interrupt, or other mechanism.  This allows Linux to record useful
>>> information (like panic information and kernel coredumps) before it
>>> resets.
>>> ----------------------
>>>
>>> I think panic() is the right way to do now.  but people may also need
>>> to config :
>>> PANIC_TIMEOUT [!=0]
>>> KEXEC
>>> KDUMP
>>> for debug reason
>>>
>>
>> Yes, so basically if we hit pretimeout, we probably have already crashed.
>
> yes,  for now , I only  use panic(), but at the beginning, I offer
> user some options:
>
> https://lists.linaro.org/pipermail/linaro-acpi/2015-April/004350.html
>
>> The only difference is that we now have some seconds time to dump out useful
>> data and then either reboot or let the actual watchdog reset take care of
>> resetting the device. panic() sounds like a good thing to do. Maybe you
>> could also dump registers on other CPUs too or try to get out some other
>> useful information about the kernel in case it has crashed or something. But
>> I'm just guessing.
>
> yes, that is my thought.
> because there is the kdump support in panic(), so that can give use a
> chance to figure out why the watchdog wasn't fed.
>

Yes indeed, sounds good!

>>
>>>>
>>>> The way I was planning the API change there would need to be a small
>>>> change
>>>> with each watchdog driver in order to let the watchdog core take over
>>>> generic behaviour on behalf of the driver. My goal was to make the change
>>>> so
>>>> that each driver that gets converted to the new API extensions gets a
>>>> support for early-timeout-sec for free, without needing to enable support
>>>> for it any way. If the API was designed properly, also pretimeouts could
>>>> be
>>>> handled easily and maybe even so that other drivers could have that
>>>> feature
>>>> even though their hardware does not explicitly give any support for it.
>>>
>>>
>>> could you please point out your patch , then I can learn your idea :-)
>>> For now , I am working on a common "Pretimeouts" following the concept
>>> in kernel doc.
>>>
>>>>
>>>> Any thoughts?
>>>
>>>
>>> my thoughts is in  my pretimeout patch , would you provide some suggestion
>>> ?
>>>
>>
>> Here is an archive link to my patch set:
>>
>> http://www.spinics.net/lists/linux-watchdog/msg06473.html
>
> Ah , cool, I can see some common in your patch. Thanks :-)
> See if I can learn something from your patches
>
>>
>> Your patch set is adding a new call to the core for adjusting the
>> pretimoeut, which is probably a good thing in case the driver needs special
>> handling for it anyway. But if the core had capability to emulate pretimeout
>> for drivers that can't support it in hardware, it would be good if there was
>> a way for the core to support it even though the driver had zero code for
>> it. The core also has watchdog_init_timeout() right now but even that is not
>> called from that many drivers. I would like to fix that too so that drivers
>> would not need to bother so much about it but let core take care of it more.
>> This is why I proposed the watchdog_init_params() call that could dig all
>> the generic parameters from device tree on behalf of the driver. This is
>> where I though timeout and early-timeout-sec parameters would be parsed from
>> device tree, but it could also parse pretimeout parameter as well.
>> Apparently Guenter did not like my approach so we might need some other way
>> to do it.
>
> I am using pretimeout, because SBSA watchdog hardware support two
> stages timeout,
> I am reusing the existing kernel concept, but your early_timeout_sec
> is a new concept.

Yes, the early-timeout-sec concept itself is new in mainline but there 
are a lot of production devices out there that start up with watchdog 
running and the watchdog must not be stopped ever. Those devices 
typically hack the watchdog policy somehow into the drivers so that they 
don't just freeze even if kernel or early userspace happens to crash for 
some reason. So I thought it would be about time to get support for this 
in mainline. I don't want to hack this feature any more into drivers :)

> If you check my previous patchset , you will see : at the beginning,
> pretimeout support is not a  generic features in my patchset.
> Then  Arnd suggest that I can try to make pretimeout into watchdog
> framework, and Guenter said :"Makes sense."

Yeah, the same story as mine. Early-timeout-sec was first atmel driver 
specific but I was told to think something more generic. At first I 
objected as I felt I would need to implement a lot of stuff into the 
core before I could make it generic. Then I was given chance to spend 
some time with this and I actually wrote a generic implementation in the 
core in a way that allows all drivers to use it with minimal 
modifications. It also lets core deal with unstoppable watchdogs and 
watchdogs with very short maximum timeout so that driver don't need 
special handling for it.

> So I am still trying to improve pretimeout support :-)
> If I can make pretimeout merged, may be you can try pretimeout to
> implement early_timeout_sec function?
> It is up to the maintainers, I will try my best.

Yes, which brings us to the actual implementation details. Right now we 
only have watchdog_init_timeout() that some drivers are using. Your 
proposal is going into direction where we would also have 
init_watchdog_pretimeout() or init_watchdog_timeouts() call. Drivers 
providing pretimeout support would call these functions to set up 
pretimeout values.

My patch set is taking the timeout concept into completely different 
direction where we have hardware timeout properties and then we have 
userspace timeout requests. Watchdog core is in the middle and checks 
whether userspace timeout requested by user is something small enough 
that the hardware can actually support. If not, a worker pings the 
watchdog core on behalf of userspace so that user daemon can have longer 
timeout. The same works with unstoppable watchdogs and the new 
early-timeout-sec property. Right now drivers with restricted hardware 
are just implementing this on their own.

Also the parameter parsing is different on my patch set. I was trying to 
make it so that all generic parameters were parsed by the core and 
driver would not need to bother about then, unless user had specified 
eg. module parameter that it fills in the watchdog_device structure and 
the core would not then override it. This way new parameters could be 
introduced in a way that the driver does not explicitly need to 
implement support for it if core knows how to handle it. There was 
someone making windowed watchdogs, maybe we could implement support for 
that in core and let the watchdog core emulate windowed watchdog support 
for all drivers even if the actual hardware implementation was not there.

This is the direction we could go eventually. Of course not all features 
are in interest for everyone and it may not make sense to try implement 
everything in the core. But we have a lot of drivers that implement all 
sorts of timers in them and my patch set could eliminate a lot of code 
from them. We also have couple of drivers that have pretimeout support 
and there seems to be a desire make that generic as well. Obviously I 
think it makes sense to combine this effort in order to avoid conflicts.

So I am too hoping more guidelines on what is the acceptable direction 
where to aim at. For example we could make this parameter handling more 
generic and future proof if we allow an API change that require small 
change to all drivers. I don't know exactly where the line is drawn.

Thanks,
-Timo
