Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:60034 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599Ab3IVDH0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 21 Sep 2013 23:07:26 -0400
Received: by mail-qa0-f43.google.com with SMTP id k15so682801qaq.16
        for <linux-watchdog@vger.kernel.org>; Sat, 21 Sep 2013 20:07:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <l0sp1v$5tp$1@ger.gmane.org>
References: <1378953828-374-1-git-send-email-Baohua.Song@csr.com>
 <l0rusk$789$1@ger.gmane.org> <CAGsJ_4zxCzmvYvB8NnuPWW3gr3ht3_qexWR4PLN7i1rMrrNf4g@mail.gmail.com>
 <l0sp1v$5tp$1@ger.gmane.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 22 Sep 2013 11:07:05 +0800
Message-ID: <CAGsJ_4wYwAHUPHCD-PTUbJdjzXixYyo79nGcf52zKNJ4PLRuuw@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: sirf: add watchdog driver of CSR SiRFprimaII
 and SiRFatlasVI
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>,
	Xianglong Du <xianglong.du@csr.com>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

2013/9/13 Romain Izard <romain.izard.pro@gmail.com>:
> On 2013-09-12, Barry Song <21cnbao@gmail.com> wrote:
>> 2013/9/12 Romain Izard <romain.izard.pro@gmail.com>:
>>>
>>> Does this really mean that both drivers will be loaded?  From what I
>>> understand of device tree, this means to use the "sirf,prima2-tick"
>>> driver, and then if not available, the "sirf-prima2-wdt" driver.
>>> It would be necessary to either add the watchdog support in the
>>> clocksource driver, or create a separate node in the device tree
>>> (with the same address?) to respect the compatible rules.
>>
>> that means both. the 6th timer can act as a watchdog timer when the
>> Watchdog mode is enabled. all 6 timers have been controlled by timer
>> driver, here it is a more-functionality for timer6.
>>
>
> First, from my reading the device tree specification says that the
> compatible property describes an ordered list from which a single driver
> is used.
>
> After checking with the platform code, I understand why this is possible,
> but I think the current syntax is not good.
>
> The general case for device tree is the following one:
> - Linux parses the device tree on startup with of_platform_populate, and
>   creates a struct platform_device per node in the tree with a
>   compatible string.
> - Creating each device calls device_attach, trying to match and bind the
>   new device with already existing drivers, until one of them succeeds
>   or no driver is left.
> - Registering a new device driver ilater calls driver_attach, trying to
>   match and bind each unbound device with the new driver.
>
> As each device can only be bound to a single driver, the normal case
> is that only one compatible driver can be bound to a device. As noted
> in http://xillybus.com/tutorials/device-tree-zynq-3, what happens when
> multiple drivers are compatible with a node is dependent on the
> initialization order.
>
> But in our specific case, "sirf,prima2-tick" does not describe a normal
> device from the kernel point of view, it describes a clocksource node.
> It is used earlier during the startup sequence to avoid cyclic
> dependency issues between the timers and the driver framework. When the
> node is created later on, there is no driver to match with the node from
> the device tree. This is why in this case, and for all clocksource
> nodes, it will be possible to have a second matching compatible string.
>
> So, since this behaviour is specific for clocksource nodes, and does not
> describe the hardware as device tree should, I believe it would be
> appropriate to use "sirf,prima2-tick" as the compatible string for the
> watchdog driver, binding the device left by the clocksource with it.

ok. make sense. i guess the best name for "sirf,prima2-tick" should be
"sirf,prima2-timer" as tick is a software concept but timer is a
hardware concept.

but i will use prima2-tick for both watchdog and clocksource for the
moment as i don't want to touch two tasks in a patch.

>
>
>>>> diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
>>>> index 002a1ce..eec56e8 100644
>>>> --- a/arch/arm/configs/prima2_defconfig
>>>> +++ b/arch/arm/configs/prima2_defconfig
>>>> @@ -1,4 +1,3 @@
>>>> -CONFIG_EXPERIMENTAL=y
>>>
>>> CONFIG_EXPERIMENTAL is not related to this change.
>>
>> i think it is just due to kernel upgrade. here just make menuconfig
>> with enabling watchdog and save defconfig, then there are some minor
>> differences here.
>>
> Perhaps would it be better to put it in a different patch?

ok.

>
>>>> +
>>>> +     if (match >= counter)
>>>> +             time_left = match-counter;
>>>> +     else
>>>> +             /* rollover */
>>>> +             time_left = (0xffffffffUL - counter) + match;
>>>
>>> As u32 is a modulo 2^32 type, those values are almost the same (off by one).
>>> time_left = match - counter; will be valid in all cases.
>>>
>
> On one side, we have:
>         time_left = match - counter (mod 2^32)
> On the other side we have:
>         time_left = (0xffffffffUL - counter) + match (mod 2^32)
> <=>     time_left = match - counter + 0xFFFFFFFF (mod 2^32)
> As we are in the modulo 2^32 space, adding or substracting 2^32 does not
> change the result
> <=>     time_left = match - counter + 0xFFFFFFFF - 2^32 (mod 2^32)
> And since 0xFFFFFFFF = 2^32 - 1
>         time_left = match - counter - 1; (mod 2^32)
>
>>>> +
>>>> +     if ((0xffffffffUL - counter) >= timeout_ticks)
>>>> +             counter += timeout_ticks;
>>>> +     else
>>>> +             /* Rollover */
>>>> +             counter = timeout_ticks - (0xffffffffUL - counter);
>>>
>>> modulo 2^32 arithmetic, no need for two cases.
>>
>> you mean just "counter += timeout_ticks" is ok?
>
> Yes, with the same reasoning as previously. Adding or substracting
> 0xffffffff for 32 bit unsigned values is the same as substracting
> or adding 1. But we do not even want this 1, we just want to
> rollover like the timer itself does, because it counts on 32 bit
> unsigned values.
>

well. good.

> --
> Romain Izard
>

-barry
