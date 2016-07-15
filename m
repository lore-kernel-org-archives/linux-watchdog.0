Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41723 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbcGOO3m (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Jul 2016 10:29:42 -0400
Subject: Re: [RFC 3/3] watchdog: introduce CONFIG_WATCHDOG_OPEN_DEADLINE
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1468487788-22457-4-git-send-email-rasmus.villemoes@prevas.dk>
 <5787A4E9.30905@roeck-us.net> <578891AB.3070501@prevas.dk>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5788F34E.8060905@roeck-us.net>
Date: Fri, 15 Jul 2016 07:29:34 -0700
MIME-Version: 1.0
In-Reply-To: <578891AB.3070501@prevas.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/15/2016 12:32 AM, Rasmus Villemoes wrote:
> On 2016-07-14 16:42, Guenter Roeck wrote:
>> On 07/14/2016 02:16 AM, Rasmus Villemoes wrote:
>>>
>>> +config WATCHDOG_OPEN_DEADLINE
>>> +    bool "Allow deadline for opening watchdog device"
>>> +    help
>>> +      If a watchdog driver indicates that to the framework that
>>> +      the hardware watchdog is running, the framework takes care
>>> +      of pinging the watchdog until userspace opens
>>> +      /dev/watchdogN. By selecting this option, you can set a
>>> +      maximum time for which the kernel will do this after the
>>> +      device has been registered.
>>> +
>>> +config WATCHDOG_OPEN_TIMEOUT
>>> +    int "Timeout value for opening watchdog device"
>>> +    depends on WATCHDOG_OPEN_DEADLINE
>>> +    default 120000
>>> +    help
>>> +      The maximum time, in milliseconds, for which the watchdog
>>> +      framework takes care of pinging a watchdog device. A value
>>> +      of 0 means infinite. The value set here can be overridden by
>>> +      the commandline parameter "watchdog.open_timeout" or through
>>> +      sysfs.
>>> +
>>
>> I like the basic idea, and we always thought about implementing it,
>> though as "initial timeout" (I personally preferred that term).
>
> I also used WATCHDOG_INIT_TIMEOUT in my first few drafts, and my helper watchdog_set_open_deadline was called watchdog_set_init_timeout. But then I stumbled on watchdog_init_timeout in watchdog_core.c, and thought that might end up being quite confusing. I think having 'open' part of the name is quite natural, but I don't really have strong feelings about the naming of this thing.
>
You could use "INITIAL".

>> However, implementing it as configuration option diminishes its
>> value substantially, since it means that using it in multi-platform
>> images (such as multi_v7_defconfig) becomes impossible.
>
> If one wants to allow this feature in an existing _defconfig, one can set OPEN_DEADLINE=y and OPEN_TIMEOUT=0; we could change the default for the latter to that. (I thought about just having that single config option with a default of 0, but it wasn't much more code to allow this thing to be compiled out completely.) Platforms without a running watchdog won't be affected, and for those with, having a non-zero deadline requires opt-in anyway.
>

Ok, off to Wim to decide then. I don't see the value of WATCHDOG_OPEN_DEADLINE,
and for sure don't like the WATCHDOG_OPEN_TIMEOUT parameter.

>> The initial timeout should be specified as module option or as
>> devicetree parameter, and there should be no additional configuration
>> option.
>
> I was under the impression that device tree was exclusively for describing hardware, and this certainly is not that. I also wanted to avoid having to modify each driver, which would seem to be necessary if it was module parameter/DT - the only thing required of a driver now is that it correctly reports WDOG_HW_RUNNING.

What is "hardware" ? It is supposed to describe the system, isn't it ? Part of that system is its clock rate,
and the means how the OS is loaded, and both have impact on the initial timeout (and the regular timeout).

You might as well argue that clock rates should not be in devicetree either. Clock rates are, after all,
just reflecting the _use_ of the hardware, not the hardware itself.

Devicetree could be handled in the core, with a function to set the initial timeout,
or possibly even with the watchdog registration itself.

>
> Regardless of implementation, it's not something that any "distro" kernel is going to enable (with non-zero deadline), so to use it will require some customization - which could be a .config tweak, passing a command line parameter, a custom dtb, and probably other options. ISTM that the first two are the most generic and require the least repeated work across platforms.
>

Each system running a specific kernel will require its own dtb, so I don't see your point there.

Guenter

