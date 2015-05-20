Return-path: <timo.kokkonen@offcode.fi>
Message-ID: <555C2742.2080408@offcode.fi>
Date: Wed, 20 May 2015 09:18:42 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 boris.brezillon@free-electrons.com, nicolas.ferre@atmel.com,
 alexandre.belloni@free-electrons.com
CC: Wenyou.Yang@atmel.com
Subject: Re: [PATCHv8 02/10] watchdog: core: Ping watchdog on behalf of user
 space when needed
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi> <1432023969-20736-3-git-send-email-timo.kokkonen@offcode.fi> <555BE1CB.10605@roeck-us.net>
In-Reply-To: <555BE1CB.10605@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 20.05.2015 04:22, Guenter Roeck wrote:
> On 05/19/2015 01:26 AM, Timo Kokkonen wrote:
>> Many watchdogs are not stoppable on the hardware level at all. Some
>> others have a very short maximum timeout value. Both of these limits
>> are problematic to the userspace and watchdog drivers have been
>> traditionally implementing workarounds of their own in order to
>> overcome the limitations. This obviously results in duplicate code in
>> the driver level and makes it harder to implement generic hardware
>> independent features.
>>
>> Extend the watchdog core by allowing it do the most common tasks on
>> behalf of the driver. For this to work the watchdog core needs two new
>> values from the driver, hw_max_timeout and hw_heartbeat. The first one
>> tells the core what is the maximum supported timeout value in the
>> hardware and the second one tells the preferred heartbeat value for
>> the hardware. Both values are in milliseconds.
>>
>> The driver needs to also call watchdog_init_params() in order to let
>> watchdog core fill in default watchdog paramters and let the core
>> check the validity of the values.
>>
>> The watchdog core api changes slightly because of this change. Most
>> importantly, the watchdog core now stands out as a clear midlayer
>> between the driver and the user space. That is, the hw_max_timeout and
>> hw_heartbeat values are meant to be filled in by the driver for the
>> core. They will not be visible to user space any way. The timeout
>> variable however is part of user space API. The comments in watchdog.h
>> are changed also to reflect more clearly the difference. The
>> max_timeout also becomes obsolete as the worker can support arbitrary
>> timeout values.
>>
>> As long as we have still old drivers that don't tell the core about
>> their hw capabilities, we need to support the old driver handling
>> too. Add watchdog_needs_legacy_handling() function to watchdog.h so we
>> can implement easily the old driver behavior and it becomes clear from
>> the code which parts can be removed once all existing drivers supply
>> the new parameters to watchdog core.
>>
>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>> ---
>>   drivers/watchdog/watchdog_core.c | 124
>> ++++++++++++++++++++++++++++++++++++++-
>>   drivers/watchdog/watchdog_dev.c  | 105
>> ++++++++++++++++++++++++++-------
>>   include/linux/watchdog.h         |  64 ++++++++++++++++++--
>>   3 files changed, 265 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/watchdog/watchdog_core.c
>> b/drivers/watchdog/watchdog_core.c
>> index cec9b55..16e10e0 100644
>> --- a/drivers/watchdog/watchdog_core.c
>> +++ b/drivers/watchdog/watchdog_core.c
>> @@ -45,6 +45,9 @@ static struct class *watchdog_class;
>>
>>   static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
>>   {
>> +    /* Newer drivers don't need this check any more */
>> +    if (!watchdog_needs_legacy_handling(wdd))
>> +        return;
>
> Something is conceptually wrong here.
>

The max timeout concept becomes obsolete once the watchdog core starts 
intermediating between the driver and the user space and extend the 
watchdog period as needed. Once you remove the max timeout from the 
check, it becomes so trivial that I don't see point factoring it out as 
a separate check. If you had something else on your mind, please elaborate.

>>       /*
>>        * Check that we have valid min and max timeout values, if
>>        * not reset them both to 0 (=not used or unknown)
>> @@ -98,6 +101,110 @@ int watchdog_init_timeout(struct watchdog_device
>> *wdd,
>>   }
>>   EXPORT_SYMBOL_GPL(watchdog_init_timeout);
>>
>> +static void watchdog_set_default_timeout(struct watchdog_device *wdd,
>> +                     struct device *dev)
>> +{
>> +    int ret;
>> +    /*
>> +     * If driver has already set up a timeout, eg. from a module
>> +     * parameter, no need to do anything here
>> +     */
>> +    if (!watchdog_timeout_invalid(wdd, wdd->timeout))
>> +        return;
>> +
>> +    /* Query device tree */
>> +    if (dev && dev->of_node) {
>> +        ret = of_property_read_u32(dev->of_node, "timeout-sec",
>> +                       &wdd->timeout);
>> +        if (!ret && !watchdog_timeout_invalid(wdd, wdd->timeout))
>> +            return;
>> +    }
>> +
>> +    /*
>> +     * If no other preference is given, use 60 seconds as the
>> +     * default timeout value
>> +     */
>> +    wdd->timeout = 60;
>> +}
>> +
>> +/**
>> + * watchdog_init_parms() - initialize generic watchdog parameters
>> + * @wdd: Watchdog device to operate
>> + * @dev: Device that stores the device tree properties
>> + *
>> + * Initialize the generic watchdog parameters. At least hw_max_timeout
>> + * must be set prior calling this function. Other unset parameters are
>> + * set based on information gathered from different sources (kernel
>> + * config, device tree, ...) or set up with a reasonable defaults.
>> + *
>> + * A zero is returned on success and -EINVAL for failure.
>> + */
>> +int watchdog_init_params(struct watchdog_device *wdd, struct device
>> *dev)
>> +{
>> +    int ret = 0;
>> +
>> +    watchdog_set_default_timeout(wdd, dev);
>> +
>> +    if (wdd->max_timeout)
>> +        dev_err(dev, "Driver setting deprecated max_timeout, please
>> fix\n");
>> +
>> +    if (!wdd->hw_max_timeout)
>> +        return -EINVAL;
>> +
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(watchdog_init_params);
>> +
>
> I really think things are going into the wrong direction. I prefer the
> approach
> that is taken with the pretimeout introduction code, where we try to change
> as little as possible. Specifically I dislike here that this function takes
> parameters from wdd, instead of having function arguments. Again, the
> approach
> used by the pretimeout code, where we introduce watchdog_init_timeouts()
> with
> an additional parameter (while keeping the original
> watchdog_init_timeout API)
> makes much more sense to me.

The reason why I replaced the watchdog_init_timeout() call with a new 
one was that I give a chance to the watchdog core to do generic 
initialization for the driver. The core would parse timeout and 
early-timeout-sec parameters from device tree and possible do something 
else that the driver does not need to know about. We could keep the 
watchdog_init_timeout and add another call for parsing the 
early-timeout-sec, but the timeout handling changes a bit too as the 
concept of max timeout disappears.

And if we are going to change the drivers calling watchdog_init_timeout 
anyway, why not think something that initializes all parameters in one 
call? That's what I thought. We can do it on some other way, but now is 
a chance to think about a bit how it should be done right. I'm open to 
suggestions.

> Overall I really think we should keep the changes minimalistic. This
> patch set
> is growing larger and larger, and I see less and less benefit and more and
> more changes.

I have got feedback about what I should do and I have learned more about 
the problems the current watchdog api has. My goal is to keep changes to 
most of the drivers minimal, simply let core know about hw_max_timeout 
and hw_heartbeat values. Some drivers can also remove a lot of timer 
handling code that they no longer need to duplicate. The end result is 
that watchdogs appear to userspace more as a unified subsystem instead 
of a collection of separate drivers that all behave different to each 
others. This is something that I think makes things better.

I hope you can give clear directions on where to go with the patches. I 
have spent a lot of time with these now and I probably don't have that 
luxury much longer any more, so I am all open in keeping the changes 
minimalistic.

Thanks,
-Timo
