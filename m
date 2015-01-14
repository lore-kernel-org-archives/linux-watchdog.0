Return-path: <timo.kokkonen@offcode.fi>
Message-ID: <54B6082A.9040405@offcode.fi>
Date: Wed, 14 Jan 2015 08:09:46 +0200
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Subject: Re: [PATCH] at91sam9_wdt: Allow watchdog to reset device at early
 boot
References: <5465C00E.4030808@offcode.fi> <1416572610-1770-1-git-send-email-timo.kokkonen@offcode.fi> <20141127200036.2c65df62@bbrezillon> <5481ABA1.9030408@offcode.fi> <20141205151221.0ee1e814@bbrezillon> <5481FC7F.3000105@offcode.fi> <20141205190247.GA25455@roeck-us.net> <54821670.9030602@offcode.fi> <20141205213946.GA2802@roeck-us.net> <5482D655.8000700@offcode.fi> <54B53160.6060309@roeck-us.net>
In-Reply-To: <54B53160.6060309@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 13.01.2015 16:53, Guenter Roeck wrote:
> On 12/06/2014 02:11 AM, Timo Kokkonen wrote:
>> On 05.12.2014 23:39, Guenter Roeck wrote:
>>> On Fri, Dec 05, 2014 at 10:32:48PM +0200, Timo Kokkonen wrote:
>>>> On 05.12.2014 21:02, Guenter Roeck wrote:
>>
>>>>> Not sure about how to name enable-early-reset. I'd prefer to have
>>>>> something
>>>>> generic, even if only implemented in a single driver for now, but I
>>>>> don't
>>>>> really know right now what that might/should look like. Maybe just
>>>>> "enable-early" to indicate that the watchdog should be enabled
>>>>> during init ?
>>>>
>>>> Do we need the enable-early or such property at all? Just leave
>>>> early-timeout-sec to zero and then let it behave just like
>>>> enable-early would do?
>>>>
>>>
>>> Problem is that the possible conditions are all over the place
>>> for "early" watchdog handling.
>>>
>>> - Disable watchdog
>>> - Enable watchdog (or keep it enabled), and keep it alive
>>>    until user space kicks in (ie possibly forever)
>>> - Enable watchdog or keep it enabled, and keep it alive
>>>    for a specified period of time.
>>> - Keep watchdog enabled if it is already enabled, otherwise
>>>    keep it disabled.
>>>
>>> There are probably more conditions which I don't recall right now.
>>> Which of those conditions would you address with "early-timeout =
>>> <0>;" ?
>>> "enable watchdog early and keep it alive until user space kicks in",
>>> or "keep watchdog enabled if already running, and set specified early
>>> timeout" ? One could argue either way which one of the two meanings
>>> it should be.
>>
>> Okay, let me elaborate my point of view a bit.
>>
>> The use case we are concerned about is that we have a device that we
>> rather not let freeze up at any point. This is what we use the
>> watchdog for. The only missing corner case right now is the point
>> where kernel driver initializes the watchdog hardware and pings it on
>> behalf of user space until a watchdog daemon opens it and starts
>> kicking. This is kind of bad as kernel might lock up or user space
>> might crash before we get to the point where the daemon starts taking
>> care of petting the watchdog. So this is what we are trying to fix.
>>
>> Right. Some other hardware behave differently to the one in Atmel.
>> They might have watchdog stopped by bootloader or it might not be
>> running at all until someone starts it. What do do with such case? If
>> we are still concerned about the same use case I described above, I
>> would say the reasonable thing to do is to make sure the watchdog is
>> started as early as possible and not stopped at any point at all, if
>> possible. If it needs to be explicitly enabled, bootloader should do
>> it. If it didn't do it, then kernel should do it.
>>
>> Now that I think of it, what we really are interested in is to defer
>> starting of the watchdog to give user space more time to start up. In
>> Atmel HW it's more tricky as the driver can't be stopped. And in other
>> hardware we could simply disable it altogether until we enable it
>> after specific timeout, but we might crash before the timeout expires,
>> in which case we would not get a chance to enable it. So the right
>> thing to do is to enable the watchdog as early as possible, kick it on
>> behalf of the user space until the timeout expires. Special case would
>> be when the timeout is zero, when we just ensure watchdog is running
>> but we don't do anything to prolong the first expiration.
>>
>> I can't think of any other use case someone would be interested in,
>> but I'm positive that there are plenty of products on the market right
>> now that have the requirement for race free guarantee that watchdog
>> never stops.
>>
>> So given the conditions you listed, what I think is really important
>> to fix is "Enable watchdog or keep it enabled, and keep it alive for a
>> specified period of time". The only other choice we have right now is
>> "Disable watchdog and let user space enabled it later, if ever". Yeah,
>> maybe we could cover those other use cases too. Maybe someone is using
>> bootloader to decide what to do with watchdog and kernel should
>> somehow respect that. I don't know if that makes sense or if it would
>> be reasonable assumption..
>>
>> Any more thoughts?
>>
> To make progress, can you update the patch using early-timeout-sec as
> discussed ?
>

Sorry, I have been heavily distracted with other work recently and I 
haven't been able to make any progress with this. Thanks for reminding 
me, I'll try to allocate some time for this in near future.

-Timo
