Return-path: <prvs=997fd3939=Rasmus.Villemoes@prevas.dk>
Subject: Re: [RFC 3/3] watchdog: introduce CONFIG_WATCHDOG_OPEN_DEADLINE
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
References: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1468487788-22457-4-git-send-email-rasmus.villemoes@prevas.dk>
 <5787A4E9.30905@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <578891AB.3070501@prevas.dk>
Date: Fri, 15 Jul 2016 09:32:59 +0200
MIME-Version: 1.0
In-Reply-To: <5787A4E9.30905@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 2016-07-14 16:42, Guenter Roeck wrote:
> On 07/14/2016 02:16 AM, Rasmus Villemoes wrote:
>>
>> +config WATCHDOG_OPEN_DEADLINE
>> +    bool "Allow deadline for opening watchdog device"
>> +    help
>> +      If a watchdog driver indicates that to the framework that
>> +      the hardware watchdog is running, the framework takes care
>> +      of pinging the watchdog until userspace opens
>> +      /dev/watchdogN. By selecting this option, you can set a
>> +      maximum time for which the kernel will do this after the
>> +      device has been registered.
>> +
>> +config WATCHDOG_OPEN_TIMEOUT
>> +    int "Timeout value for opening watchdog device"
>> +    depends on WATCHDOG_OPEN_DEADLINE
>> +    default 120000
>> +    help
>> +      The maximum time, in milliseconds, for which the watchdog
>> +      framework takes care of pinging a watchdog device. A value
>> +      of 0 means infinite. The value set here can be overridden by
>> +      the commandline parameter "watchdog.open_timeout" or through
>> +      sysfs.
>> +
>
> I like the basic idea, and we always thought about implementing it,
> though as "initial timeout" (I personally preferred that term).

I also used WATCHDOG_INIT_TIMEOUT in my first few drafts, and my helper 
watchdog_set_open_deadline was called watchdog_set_init_timeout. But 
then I stumbled on watchdog_init_timeout in watchdog_core.c, and thought 
that might end up being quite confusing. I think having 'open' part of 
the name is quite natural, but I don't really have strong feelings about 
the naming of this thing.

> However, implementing it as configuration option diminishes its
> value substantially, since it means that using it in multi-platform
> images (such as multi_v7_defconfig) becomes impossible.

If one wants to allow this feature in an existing _defconfig, one can 
set OPEN_DEADLINE=y and OPEN_TIMEOUT=0; we could change the default for 
the latter to that. (I thought about just having that single config 
option with a default of 0, but it wasn't much more code to allow this 
thing to be compiled out completely.) Platforms without a running 
watchdog won't be affected, and for those with, having a non-zero 
deadline requires opt-in anyway.

> The initial timeout should be specified as module option or as
> devicetree parameter, and there should be no additional configuration
> option.

I was under the impression that device tree was exclusively for 
describing hardware, and this certainly is not that. I also wanted to 
avoid having to modify each driver, which would seem to be necessary if 
it was module parameter/DT - the only thing required of a driver now is 
that it correctly reports WDOG_HW_RUNNING.

Regardless of implementation, it's not something that any "distro" 
kernel is going to enable (with non-zero deadline), so to use it will 
require some customization - which could be a .config tweak, passing a 
command line parameter, a custom dtb, and probably other options. ISTM 
that the first two are the most generic and require the least repeated 
work across platforms.

> Where does the module parameter in watchdog_dev.c end up ?

# cat /sys/module/watchdog/parameters/open_timeout
120000

Rasmus
