Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.246]:53600 "EHLO
	DVREDG02.corp.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754914AbbDNCjR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 13 Apr 2015 22:39:17 -0400
Message-ID: <552C7DCA.9020907@atmel.com>
Date: Tue, 14 Apr 2015 10:39:06 +0800
From: "Yang, Wenyou" <wenyou.yang@atmel.com>
MIME-Version: 1.0
To: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>,
	<boris.brezillon@free-electrons.com>, <nicolas.ferre@atmel.com>,
	<alexandre.belloni@free-electrons.com>
Subject: Re: [PATCHv5 1/4] watchdog: Extend kernel API to know about HW limitations
References: <1428671199-5562-1-git-send-email-timo.kokkonen@offcode.fi> <1428671199-5562-2-git-send-email-timo.kokkonen@offcode.fi> <552B8C7F.5070003@atmel.com> <552BA1BC.2070006@offcode.fi>
In-Reply-To: <552BA1BC.2070006@offcode.fi>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 2015/4/13 19:00, Timo Kokkonen wrote:
> On 13.04.2015 12:29, Yang, Wenyou wrote:
>> Hi Timo,
>>
>> If the /dev/watchdog device file doesn't open by the user space
>> application, the system will reboot by the watchdog.
>>
>
> Thank you for pointing out the bug. When the struct watchdog_device is 
> initialized, the expires variable is zero. Jiffies however is negative 
> on boot up, so time_after() comparison with zero returns false and the 
> worker keeps the watchdog alive for some minutes, until jiffies become 
> positive. Then it will stop updating the HW as the expires value has 
> become expired.
>
>> I think it is missing update of  the wdd->expires value. added it as
>> following.
>
> Actually, the expires value stores the user space expiration value. It 
> should only be updated when user space pings the watchdog. If we 
> increment the expires value in the worker thread, the watchdog will 
> never expire even if user space stops pinging it and keep it open.
>
> So the proper fix is to have it like this (in watchdog_worker function):
>
>     if (time_after(jiffies, wdd->expires) && watchdog_active(wdd)) {
>         pr_crit("I will reset your machine !\n");
>         return;
>     }
I have a little doubt, if the watchdog is not opened by the user space, 
the watchdog will not reset the system in any case.

it doesn't work in the same way as before in the at91sam9_wdt.c.
>
> Also we need this change to re-start the worker when watchdog is 
> properly stopped (in watchdog_dev.c):
>
> @@ -157,9 +159,15 @@ static int watchdog_stop(struct watchdog_device 
> *wddev)
>                 goto out_stop;
>         }
>
> -       err = wddev->ops->stop(wddev);
> -       if (err == 0)
> +       if (!wddev->hw_max_timeout || watchdog_is_stoppable(wddev)) {
> +               err = wddev->ops->stop(wddev);
> +               if (err == 0)
> +                       clear_bit(WDOG_ACTIVE, &wddev->status);
> +       } else {
> +               /* Unstoppable watchdogs need the worker to keep them 
> alive */
>                 clear_bit(WDOG_ACTIVE, &wddev->status);
> +               schedule_delayed_work(&wddev->work, wddev->hw_heartbeat);
> +       }
Tested it, there is a issue.
After open the watchdog device file, and feed the watchdog, then close 
the watchdog device file, the system reset by the watchdog.
It didn't reach here, the watchdog_worker didn't run.

>
>  out_stop:
>         mutex_unlock(&wddev->lock);
>
>
> After these two modifications the watchdog is being pinged 
> indefinitely until the user space opens the device and the worker is 
> re-started if watchdog daemon exits after writing the magic character. 
> I will update these change to the next version of the patch.
>
> Thanks again!
>
> -Timo
>
>> On 2015/4/10 21:06, Timo Kokkonen wrote:
>>> There is a great deal of diversity in the watchdog hardware found on
>>> different devices. Differen hardware have different contstraints on
>>> them, many of the constraints that are excessively difficult for the
>>> user space to satisfy.
>>>
>>> One such constraint is the length of the timeout value, which in many
>>> cases can be just a few seconds. Drivers are creating ad hoc solutions
>>> with timers and workqueues to extend the timeout in order to give user
>>> space more time between updates. Looking at the drivers it is clear
>>> that this has resulted to a lot of duplicate code.
>>>
>>> Add an extension to the watchdog kernel API that allows the driver to
>>> describe tis HW constraints to the watchdog code. A kernel worker in
>>> the core is then used to extend the watchdog timeout on behalf of the
>>> user space. This allows the drivers to be simplified as core takes
>>> over the timer extending.
>>>
>>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>>> ---
>>>   drivers/watchdog/watchdog_core.c | 87
>>> ++++++++++++++++++++++++++++++++++++++--
>>>   drivers/watchdog/watchdog_dev.c  | 12 ++++++
>>>   include/linux/watchdog.h         | 23 +++++++++++
>>>   3 files changed, 119 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/watchdog_core.c
>>> b/drivers/watchdog/watchdog_core.c
>>> index cec9b55..8e7d08d 100644
>>> --- a/drivers/watchdog/watchdog_core.c
>>> +++ b/drivers/watchdog/watchdog_core.c
>>> @@ -99,6 +99,75 @@ int watchdog_init_timeout(struct watchdog_device 
>>> *wdd,
>>>   EXPORT_SYMBOL_GPL(watchdog_init_timeout);
>>>   /**
>>> + * watchdog_init_timeout() - initialize generic watchdog parameters
>>> + * @wdd: Watchdog device to operate
>>> + * @dev: Device that stores the device tree properties
>>> + *
>>> + * Initialize the generic timeout parameters. The driver needs to set
>>> + * hw_features bitmask from @wdd prior calling this function in order
>>> + * to ensure the core knows how to handle the HW.
>>> + *
>>> + * A zero is returned on success and -EINVAL for failure.
>>> + */
>>> +int watchdog_init_params(struct watchdog_device *wdd, struct device
>>> *dev)
>>> +{
>>> +    int ret = 0;
>>> +
>>> +    ret = watchdog_init_timeout(wdd, wdd->timeout, dev);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    /*
>>> +     * Max HW timeout needs to be set so that core knows when to
>>> +     * use a kernel worker to support longer watchdog timeouts
>>> +     */
>>> +    if (!wdd->hw_max_timeout)
>>> +        return -EINVAL;
>>> +
>>> +    return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(watchdog_init_params);
>>> +
>>> +static void watchdog_worker(struct work_struct *work)
>>> +{
>>> +    struct watchdog_device *wdd = container_of(to_delayed_work(work),
>>> +                        struct watchdog_device, work);
>>> +
>>> +    if (time_after(jiffies, wdd->expires)) {
>>> +        pr_crit("I will reset your machine !\n");
>>> +        return;
>>> +    }
>>> +
>>> +    if ((!watchdog_active(wdd) && !watchdog_is_stoppable(wdd)) ||
>>> +        (watchdog_active(wdd) &&
>>> +            wdd->hw_max_timeout < wdd->timeout * HZ)) {
>>> +        if (wdd->ops->ping)
>>> +            wdd->ops->ping(wdd);
>>> +        else
>>> +            wdd->ops->start(wdd);
>>> +
>>> +        schedule_delayed_work(&wdd->work, wdd->hw_heartbeat);
>>     I think you missed the update of wdd->expires, as following.
>>                                     wdd->expires = jiffies +
>> wdd->timeout * HZ;
>>> +    }
>>> +}
>>> +
>>> +static int prepare_watchdog(struct watchdog_device *wdd)
>>> +{
>>> +    /* Stop the watchdog now before user space opens the device */
>>> +    if (wdd->hw_features & WDOG_HW_IS_STOPPABLE &&
>>> +        wdd->hw_features & WDOG_HW_RUNNING_AT_BOOT) {
>>> +        wdd->ops->stop(wdd);
>>> +
>>> +    } else if (!(wdd->hw_features & WDOG_HW_IS_STOPPABLE)) {
>>> +        /*
>>> +         * Can't stop it, use a kernel timer to tick
>>> +         * it until it's open by user space
>>> +         */
>>> +        schedule_delayed_work(&wdd->work, wdd->hw_heartbeat);
>>> +    }
>>       ditto
>>                      wdd->expires = jiffies + wdd->timeout * HZ;
>>
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>>>    * watchdog_register_device() - register a watchdog device
>>>    * @wdd: watchdog device
>>>    *
>>> @@ -156,13 +225,24 @@ int watchdog_register_device(struct
>>> watchdog_device *wdd)
>>>       wdd->dev = device_create(watchdog_class, wdd->parent, devno,
>>>                       NULL, "watchdog%d", wdd->id);
>>>       if (IS_ERR(wdd->dev)) {
>>> -        watchdog_dev_unregister(wdd);
>>> -        ida_simple_remove(&watchdog_ida, id);
>>>           ret = PTR_ERR(wdd->dev);
>>> -        return ret;
>>> +        goto dev_create_fail;
>>> +    }
>>> +
>>> +    INIT_DELAYED_WORK(&wdd->work, watchdog_worker);
>>> +
>>> +    if (wdd->hw_max_timeout) {
>>> +        ret = prepare_watchdog(wdd);
>>> +        if (ret)
>>> +            goto dev_create_fail;
>>>       }
>>>       return 0;
>>> +
>>> +dev_create_fail:
>>> +    watchdog_dev_unregister(wdd);
>>> +    ida_simple_remove(&watchdog_ida, id);
>>> +    return ret;
>>>   }
>>>   EXPORT_SYMBOL_GPL(watchdog_register_device);
>>> @@ -181,6 +261,7 @@ void watchdog_unregister_device(struct
>>> watchdog_device *wdd)
>>>       if (wdd == NULL)
>>>           return;
>>> +    cancel_delayed_work_sync(&wdd->work);
>>>       devno = wdd->cdev.dev;
>>>       ret = watchdog_dev_unregister(wdd);
>>>       if (ret)
>>> diff --git a/drivers/watchdog/watchdog_dev.c
>>> b/drivers/watchdog/watchdog_dev.c
>>> index 6aaefba..99eb363 100644
>>> --- a/drivers/watchdog/watchdog_dev.c
>>> +++ b/drivers/watchdog/watchdog_dev.c
>>> @@ -78,6 +78,12 @@ static int watchdog_ping(struct watchdog_device
>>> *wddev)
>>>       else
>>>           err = wddev->ops->start(wddev); /* restart watchdog */
>>> +    if (wddev->hw_max_timeout &&
>>> +        wddev->timeout * HZ > wddev->hw_max_timeout) {
>>> +        wddev->expires = jiffies + wddev->timeout * HZ;
>>> +        schedule_delayed_work(&wddev->work, wddev->hw_heartbeat);
>>> +    }
>>> +
>>>   out_ping:
>>>       mutex_unlock(&wddev->lock);
>>>       return err;
>>> @@ -110,6 +116,12 @@ static int watchdog_start(struct watchdog_device
>>> *wddev)
>>>       if (err == 0)
>>>           set_bit(WDOG_ACTIVE, &wddev->status);
>>> +    if (wddev->hw_max_timeout &&
>>> +        wddev->timeout * HZ > wddev->hw_max_timeout) {
>>> +        wddev->expires = jiffies + wddev->timeout * HZ;
>>> +        schedule_delayed_work(&wddev->work, wddev->hw_heartbeat);
>>> +    }
>>> +
>>>   out_start:
>>>       mutex_unlock(&wddev->lock);
>>>       return err;
>>> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
>>> index 395b70e..c16c921 100644
>>> --- a/include/linux/watchdog.h
>>> +++ b/include/linux/watchdog.h
>>> @@ -12,6 +12,7 @@
>>>   #include <linux/bitops.h>
>>>   #include <linux/device.h>
>>>   #include <linux/cdev.h>
>>> +#include <linux/workqueue.h>
>>>   #include <uapi/linux/watchdog.h>
>>>   struct watchdog_ops;
>>> @@ -62,9 +63,13 @@ struct watchdog_ops {
>>>    * @timeout:    The watchdog devices timeout value.
>>>    * @min_timeout:The watchdog devices minimum timeout value.
>>>    * @max_timeout:The watchdog devices maximum timeout value.
>>> + * @hw_max_timeout:The watchdog hardware maximum timeout value.
>>> + * @hw_margin:    Time interval between timer pings.
>>>    * @driver-data:Pointer to the drivers private data.
>>>    * @lock:    Lock for watchdog core internal use only.
>>> + * @work:    Worker used to provide longer timeouts than hardware
>>> supports.
>>>    * @status:    Field that contains the devices internal status bits.
>>> + * @hw_features:Feature bits describing how the watchdog HW works.
>>>    *
>>>    * The watchdog_device structure contains all information about a
>>>    * watchdog timer device.
>>> @@ -86,8 +91,12 @@ struct watchdog_device {
>>>       unsigned int timeout;
>>>       unsigned int min_timeout;
>>>       unsigned int max_timeout;
>>> +    unsigned int hw_max_timeout; /* in jiffies */
>>> +    unsigned int hw_heartbeat; /* in jiffies */
>>> +    unsigned long int expires; /* for soft timer */
>>>       void *driver_data;
>>>       struct mutex lock;
>>> +    struct delayed_work work;
>>>       unsigned long status;
>>>   /* Bit numbers for status flags */
>>>   #define WDOG_ACTIVE        0    /* Is the watchdog running/active */
>>> @@ -95,6 +104,14 @@ struct watchdog_device {
>>>   #define WDOG_ALLOW_RELEASE    2    /* Did we receive the magic char
>>> ? */
>>>   #define WDOG_NO_WAY_OUT        3    /* Is 'nowayout' feature set ? */
>>>   #define WDOG_UNREGISTERED    4    /* Has the device been
>>> unregistered */
>>> +
>>> +/* Bits describing features supported by the HW */
>>> +    unsigned long hw_features;
>>> +
>>> +/* Can the watchdog be stopped and started */
>>> +#define WDOG_HW_IS_STOPPABLE        BIT(0)
>>> +/* Is the watchdog already running when the driver starts up */
>>> +#define WDOG_HW_RUNNING_AT_BOOT        BIT(1)
>>>   };
>>>   #define WATCHDOG_NOWAYOUT IS_BUILTIN(CONFIG_WATCHDOG_NOWAYOUT)
>>> @@ -120,6 +137,11 @@ static inline bool
>>> watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
>>>           (t < wdd->min_timeout || t > wdd->max_timeout));
>>>   }
>>> +static inline bool watchdog_is_stoppable(struct watchdog_device *wdd)
>>> +{
>>> +    return wdd->hw_features & WDOG_HW_IS_STOPPABLE;
>>> +}
>>> +
>>>   /* Use the following functions to manipulate watchdog driver
>>> specific data */
>>>   static inline void watchdog_set_drvdata(struct watchdog_device *wdd,
>>> void *data)
>>>   {
>>> @@ -134,6 +156,7 @@ static inline void *watchdog_get_drvdata(struct
>>> watchdog_device *wdd)
>>>   /* drivers/watchdog/watchdog_core.c */
>>>   extern int watchdog_init_timeout(struct watchdog_device *wdd,
>>>                     unsigned int timeout_parm, struct device *dev);
>>> +int watchdog_init_params(struct watchdog_device *wdd, struct device
>>> *dev);
>>>   extern int watchdog_register_device(struct watchdog_device *);
>>>   extern void watchdog_unregister_device(struct watchdog_device *);
>> Best Regards,
>> Wenyou Yang
>
Best Regards,
Wenyou Yang

