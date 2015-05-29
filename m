Return-path: <timo.kokkonen@offcode.fi>
Message-ID: <55685F09.8070200@offcode.fi>
Date: Fri, 29 May 2015 15:43:53 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 boris.brezillon@free-electrons.com, nicolas.ferre@atmel.com,
 alexandre.belloni@free-electrons.com
Subject: Re: [PATCHv8 01/10] watchdog: Rename watchdog_active to watchdog_hw_active
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi> <1432023969-20736-2-git-send-email-timo.kokkonen@offcode.fi> <555BDF22.2090208@roeck-us.net> <555C1D9F.4060600@offcode.fi> <555C9020.6060908@roeck-us.net>
In-Reply-To: <555C9020.6060908@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

Other work has begun piling on my desk, sorry I haven't had time to take 
this any forward.

On 20.05.2015 16:46, Guenter Roeck wrote:
> On 05/19/2015 10:37 PM, Timo Kokkonen wrote:
>> On 20.05.2015 04:10, Guenter Roeck wrote:
>>> On 05/19/2015 01:26 AM, Timo Kokkonen wrote:
>>>> Before extending the watchdog core midlayer, it is useful to rename
>>>> the watchdog_active function so that it states explicitly what it
>>>> really does. That is, "active" watchdog means really that the watchdog
>>>> hardware is running and needs pinging to prevent a watchdog reset
>>>> taking place in near future.
>>>>
>>>> This is different to "watchdog open" state, which simply states that
>>>> kernel is expecting the user space to keep the watchdog alive. These
>>>> states might become different mainly because some hardware have
>>>> limitations that prevent them from being stopped at will.
>>>>
>>>
>>> I don't see why this is needed. If you need another state, per your
>>> description, it would be "open" in addition to "active".
>>
>> Yes, the watchdog_is_open() is introduced on patch number two. The
>> original watchdog_is_active() is really confusing. It doesn't really
>> state what it means. Most of the drivers are using it to test whether
>> the watchdog HW is active when going to suspend, but at least atmel
>> watchdog was testing it to see whether the watchdog device is open
>> from user space. The HW itself is always active in that driver.
>>
>> If we are about to distinguish between "device open from user space"
>> and "hardware timer running", we better be clear about the naming.
>> "watchdog_is_active" doesn't really tell what it does.
>>
>> This was originally suggested by Uwe Kleine-König. He also recommended
>> changing the timeout parameter so that is would state more clearly
>> that it is the SW timeout and not HW timeout. But I felt that it would
>> have been too invasive to change the timeout parameter as well. The
>> watchdog_is_active was not used very much so the change was easy.
>>
>> -Timo
>>
> You could just clarify what it means.
>
> Anyway, I think I'll have to step back from this for a while.
> As I mentioned, I think it is getting too invasive, which clouds
> my judgment. I think I'll leave this patch set up to Wim to handle.

Let me try to elaborate my self a little more, maybe it helps taking the 
discussion forward.

The early-timeout-sec feature I am trying to get merged is something 
that is not tied into any hardware at all. It is a new policy that is 
needed. The current policy, explicitly stopping the watchdog, is not a 
very good policy if your intention is to keep it running at all times. 
The early-timeout-sec would allow to choose a policy where the watchdog 
is not stopped at all. Also optionally the watchdog core could extend 
the initial expiration of the watchdog in case userspace is slow in 
starting up for any reason.

As this is not a hardware related feature but a policy feature, clearly 
it should be implemented in the core instead of the drivers.

Unfortunately this feature comes with a hard requirement that the 
watchdog should not be stopped by the driver. Currently all drivers 
implement explicitly the policy to stop the hardware. There is no way 
early-timeout-sec can be implemented in watchdog core without taking the 
decision over the policy from the drivers to the core.

Fortunately this change alone is really straightforward to implement in 
most of the drivers. As can be seen in my patch to omap_wdt.c, there are 
just a few lines of code that really need to change. Also as can be seen 
from at91sam9_wdt.c and imx2_wdt.c patches, the change can also remove 
quite a lot of code in case the driver is already implementing things 
that early-timeout-sec would need anyway in watchdog core.

The thing that really needs to be thought well is what exactly should be 
changed in the watchdog core API in order to allow the core to do its 
things correctly. The way I thought is that the API should be simple, 
not complex. Drivers should be simple and only implement necessary code 
to implement functions that the hardware actually supports. Obviously 
the changes to the drivers should be also kept minimal to reduce the 
conversion work, so this puts quite a deal of limits what changes are 
reasonable.

The core needs to know at least the actual HW maximum timeout value and 
heartbeat period. Otherwise it can't make any reasonable assumptions 
about how to do pinging right. The old second based max_timeout handling 
is too limited to be useful for all hardware, which is why I proposed 
deprecating it in favour of the millisecond based hw_max_timeout. The 
current pretimeout patches in review are unfortunately adding more code 
for handling max_timeout, which is colliding with my goals of making the 
variables be more useful with describing the actual HW features. Maybe 
we don't need to remove the max_timeout, but the logic becomes quite 
complex if there are too many different kind of timeouts, especially if 
some of them are logically overlapping. This is why I think it would be 
better to streamline the timeout handling a bit.

I want to take this work forward, but I see no point in starting to work 
with patches until there is at least some sort of agreement of the 
correct direction where to take it at. I am hoping to get more 
discussion ongoing over this.

Thanks,
-Timo
