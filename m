Return-path: <timo.kokkonen@offcode.fi>
Message-ID: <55486294.708@offcode.fi>
Date: Tue, 05 May 2015 09:26:28 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 boris.brezillon@free-electrons.com, nicolas.ferre@atmel.com,
 alexandre.belloni@free-electrons.com, Wenyou.Yang@atmel.com
Subject: Re: [PATCHv7 1/8] watchdog: Extend kernel API to know about HW limitations
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi> <1429701102-22320-2-git-send-email-timo.kokkonen@offcode.fi> <20150504154321.GB9602@roeck-us.net>
In-Reply-To: <20150504154321.GB9602@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

On 04.05.2015 18:43, Guenter Roeck wrote:
> On Wed, Apr 22, 2015 at 02:11:35PM +0300, Timo Kokkonen wrote:
>> There is a great deal of diversity in the watchdog hardware found on
>> different devices. Differen hardware have different contstraints on
>> them, many of the constraints that are excessively difficult for the
>> user space to satisfy.
>>
>> One such constraint is the length of the timeout value, which in many
>> cases can be just a few seconds. Drivers are creating ad hoc solutions
>> with timers and workqueues to extend the timeout in order to give user
>> space more time between updates. Looking at the drivers it is clear
>> that this has resulted to a lot of duplicate code.
>>
>> Add an extension to the watchdog kernel API that allows the driver to
>> describe tis HW constraints to the watchdog code. A kernel worker in
>> the core is then used to extend the watchdog timeout on behalf of the
>> user space. This allows the drivers to be simplified as core takes
>> over the timer extending.
>>
>> Tested-by: Wenyou Yang <wenyou.yang@atmel.com>
>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>
> Hi Timo,
>
> Time to add my thoughts before you create the next version.
> It isn't complete, so I won't try a line by line review.
>
> The init_params function isn't the best choice for a name. Ultimately
> we have other concepts to add - such as generic pretimeout support -
> which makes this more and more difficult to handle. A separate function to
> initialize the early timeout separately might make more sense. Either case,
> any new API must not provide less functionality than the old one.

Did you have something specific on your mind, something else besides of 
the early-timeout-sec parameter I'm adding with this series? I would 
like to learn more about it so that I can ensure the core API is as 
generic as possible.

> The current semantics of timeout and max_timeout is that those _are_ the
> hardware limits. We can not just change that. Also, the new functionality
> should, as much as possible, be automatic and should not require changes in
> existing drivers to be useful for them.
>
> I understand we need something line hw_timeout and hw_max_timeout, but that
> doesn't mean that those _have_ to be specified to be used. For a generic use
> case, it is sufficient to assume that timeout == hw_timeout and max_timeout ==
> hw_max_timeout, and the hw_ values can be set automatically if not specified.
> The code should be more permissive to not bail out if , for example,
> hw_max_timeout is not specified (then hw_max_timeout == max_timeout).

There are two requirements here that made me add the new hw_timeout 
variables:

1) Some of the hardware need higher precision in the timeout parameters 
as their limits are very short
2) There are too many watchdog drivers for me to change all at once, so 
old drivers need to remain functional while they are converted to the 
new core API

Also once the drivers are using the new API, there are actually two 
timeout values, one that is limited by the HW and one that is requested 
by the user space. The core code then intermediates between these two so 
that user space doesn't need to know about the HW limitations.

The max_timeout actually becomes irrelevant from user space perspective 
as the core code is capable of extending the timeout indefinitely, if 
that is what user space wants. We could add some logical maximum here, 
such as one day, what is already used by some of the drivers..

> Similar, it should not be necessary to have to specify hw_timeout and
> hw_max_timeout in the first place for those to be useful. We can instead do
> something like
>
> 	#define MIN_TIMEOUT	(60 * 10)	/* in seconds */
>
> 	if (!hw_max_timeout && max_timeout < MIN_TIMEOUT) {
> 		hw_max_timeout = max_timeout;
> 		max_timeout = MIN_TIMEOUT;
> 	}
>
> with similar adjustments for hw_timeout and timeout. I am not sure if we should
> keep the current meaning of timeout and max_timeout (ie it means hw limits) and
> introduce sw_max_timeout and sw_timeout, or extend the meaning of max_timeout
> and timeout to mean both and introduce the hw_variables. The latter would let us
> specify more granularity for the hw_ values, so maybe the latter approach is
> better.

I would like to be clear with the variable naming that others are for SW 
and the other for HW, but as we can't change all drivers at once, I'm 
trying to make it obvious that the new set of limits are purely for 
hardware. Once all drivers using the core API are filling the hw limits, 
the core is the only place that is taking care of the sw limits.

> Limits should not be in jiffies unless only used internally by the watchdog
> subsystem. If more granularity is needed, use milliseconds and convert to
> jiffies where needed.

I can change the limits in milliseconds.

> Consider adding helper functions such as _watchdog_ping as inline in
> watchdog_core.h.

I was wondering whether it should be in there instead of in 
watchdog_dev.c, so I'll move it there in the next version.

> hw_heartbeat should be set from the watchdog core; I don't think it needs to
> be provided by the driver. It can be calculated from hw_max_timeout and timeout
> as needed (to something like min(hw_max_timeout, timeout) / 2).

The HW might have limitations on what is the proper or ideal heartbeat 
value, which is why I thought driver should probably decide about how it 
should be set. But we could let core make a guess of its own if 
hw_heartbeat is left zero. Now I'm assuming the driver is changing the 
hw_heartbeat when timeout is changed.

> You don't need boot_kepalive and active_keepalive as separate flags in
> watchdog_worker.

You are right, I'll fix it.

> hw_features is unfortunate, and I am not sure that it is needed. That the
> watchdog is running at boot time is not really a hardware feature, but a state.
> Either add a bit to 'status' in watchdog_device, or add a callback function.
> WDOG_HW_IS_STOPPABLE can be added to 'status' as well. It should probably be
> reversed, though, to something like WDOG_NOT_STOPPABLE, so that it does not have
> to be set to existing drivers.

We can avoid WDOG_HW_IS_STOPPABLE entirely by mandating that driver 
stop() returns failure if hardware can't be stopped. This way core can 
start the worker whenever the HW can't be stopped.

Then we only have the boot time status of the watchdog left. For some HW 
that's a feature (eg. at91sam9_wdt) and some other it's a state (eg. 
omap_wdt). But I can add a new status bit for it, that's a better 
approach than having an entirely new set of HW flags.

Thanks for your review.

-Timo
