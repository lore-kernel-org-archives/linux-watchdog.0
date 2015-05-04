Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:53569 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751046AbbEDJkr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 May 2015 05:40:47 -0400
Message-ID: <55473E99.8020006@offcode.fi>
Date: Mon, 04 May 2015 12:40:41 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com,
	Wenyou.Yang@atmel.com
Subject: Re: [PATCHv7 1/8] watchdog: Extend kernel API to know about HW limitations
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi> <1429701102-22320-2-git-send-email-timo.kokkonen@offcode.fi> <20150504075801.GF25193@pengutronix.de>
In-Reply-To: <20150504075801.GF25193@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe

On 04.05.2015 10:58, Uwe Kleine-König wrote:
> Hello Timo,
>
> On Wed, Apr 22, 2015 at 02:11:35PM +0300, Timo Kokkonen wrote:
>> There is a great deal of diversity in the watchdog hardware found on
>> different devices. Differen hardware have different contstraints on
> s/Differen/Different/; s/contstraints/constraints/
>
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
> s/tis/its/
>

I thought that I ran ispell at least on the commit message, but maybe 
not on all commits.. I'll try to collect all these fixes to the next 
version.

>> the core is then used to extend the watchdog timeout on behalf of the
>> user space. This allows the drivers to be simplified as core takes
>> over the timer extending.
> In general a nice idea.
>
>> Tested-by: Wenyou Yang <wenyou.yang@atmel.com>
>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>> ---
>>   drivers/watchdog/watchdog_core.c | 101 +++++++++++++++++++++++++++++++++++++--
>>   drivers/watchdog/watchdog_dev.c  |  75 ++++++++++++++++++++++++++---
>>   include/linux/watchdog.h         |  23 +++++++++
>>   3 files changed, 189 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
>> index cec9b55..fd12489 100644
>> --- a/drivers/watchdog/watchdog_core.c
>> +++ b/drivers/watchdog/watchdog_core.c
>> @@ -99,6 +99,89 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
>>   EXPORT_SYMBOL_GPL(watchdog_init_timeout);
>>
>>   /**
>> + * watchdog_init_parms() - initialize generic watchdog parameters
>> + * @wdd: Watchdog device to operate
>> + * @dev: Device that stores the device tree properties
>> + *
>> + * Initialize the generic timeout parameters. The driver needs to set
>> + * hw_features bitmask from @wdd prior calling this function in order
>> + * to ensure the core knows how to handle the HW.
>> + *
>> + * A zero is returned on success and -EINVAL for failure.
>> + */
>> +int watchdog_init_params(struct watchdog_device *wdd, struct device *dev)
>> +{
>> +	int ret = 0;
>> +
>> +	ret = watchdog_init_timeout(wdd, wdd->timeout, dev);
>> +	if (ret < 0)
>> +		return ret;
> As Guenter pointed out, using wdd->timeout is unfortunate here.
>

Yeah, I'll come up with something better for the next version.

>> +
>> +	/*
>> +	 * Max HW timeout needs to be set so that core knows when to
>> +	 * use a kernel worker to support longer watchdog timeouts
>> +	 */
>> +	if (!wdd->hw_max_timeout)
>> +		return -EINVAL;
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(watchdog_init_params);
>> +
>> +static void watchdog_worker(struct work_struct *work)
>> +{
>> +	struct watchdog_device *wdd = container_of(to_delayed_work(work),
>> +						struct watchdog_device, work);
> please align the follow-up line to the opening (.
>

ok

>> +	bool boot_keepalive;
>> +	bool active_keepalive;
>> +
>> +	mutex_lock(&wdd->lock);
>> +
>> +	boot_keepalive = !watchdog_active(wdd) &&
> I'm not sure about the semantic of watchdog_active here. Would be nice
> to clearify this. Does it mean /dev/watchdog is open, or the watchdog is
> running? Maybe introduce watchdog_running(wdd) and watchdog_opened(wdd)?

watchdog_active() simply means the device is open by user and we expect 
the HW to be running. What is a bit confusing here is that if watchdog 
is closed by the user, according the variable names here, it goes back 
to "boot_keepalive" mode. Maybe it would be better to rename the 
variable as inactive_keepalive instead.

 > Is this related to the topic of this patch? You didn't mention anything
 > in the commit log about the time until userspace comes up.
 >

It's the next patch in this series that introduces the early_timeout_sec 
logic. I deliberately splitted that functionality out from this patch to 
not confuse the new feature with the change of the existing API.

>> +		!watchdog_is_stoppable(wdd);
>> +
>> +	active_keepalive = watchdog_active(wdd) &&
>> +		wdd->hw_max_timeout < wdd->timeout * HZ;
>> +
>> +	if (time_after(jiffies, wdd->expires) && watchdog_active(wdd)) {
>> +		pr_crit("I will reset your machine !\n");
>> +		mutex_unlock(&wdd->lock);
>> +		return;
>> +	}
> I'd replace the pr_crit by a code comment. Also "I will reset your
> machine!" is wrong, the core just stops petting the watchdog.

Yeah, this is something that kept repeating with some of the drivers 
that had custom keepalive code with them. I'm fine with replacing it 
with a commect.

> If userspace comes in in time there is no harm, right?

Yep, indeed.

>
>> +	if (boot_keepalive || active_keepalive) {
>> +		if (wdd->ops->ping)
>> +			wdd->ops->ping(wdd);
>> +		else
>> +			wdd->ops->start(wdd);
> if (boot_keepalive || active_keepalive)
> 	_watchdog_ping(wdd);
>

ack.

>> +
>> +		schedule_delayed_work(&wdd->work,  wdd->hw_heartbeat);
> s/  / /; Would it be sensible to assume hw_heartbeat to be timeout / 2
> always?
>

Timeout variable stores the user space timeout value, which might be 
different to what hardware is capable of. I'd better document that 
change in the headers at least.

>> +	}
>> +
>> +	mutex_unlock(&wdd->lock);
>> +}
>> +
>> +static int prepare_watchdog(struct watchdog_device *wdd)
>> +{
>> +	int err = 0;
>> +
>> +	/* Stop the watchdog now before user space opens the device */
>> +	if (watchdog_is_stoppable(wdd) &&
>> +		wdd->hw_features & WDOG_HW_RUNNING_AT_BOOT) {
>> +		err = wdd->ops->stop(wdd);
>> +
>> +	} else if (!watchdog_is_stoppable(wdd) &&
>> +		wdd->hw_features & WDOG_HW_RUNNING_AT_BOOT) {
>> +		/*
>> +		 * Can't stop it, use a delayed worker to tick it
>> +		 * until it's open by user space
>> +		 */
> I'd add a ping here because if the driver comes up a big part of the
> initial timeout setup by the bootloader might already be over.

Agreed.

> Note that at least for the omap watchdog driver the assignment to
> timeout doesn't relate in any way to the timeout actually setup in
> hardware.

The timeout value should match what is setup in hardware, unless user is 
requesting something beyond hardware limits, in which case we use the 
worker to extend the limit. I'm not sure how that is relevant at here 
though..

>> +		schedule_delayed_work(&wdd->work, wdd->hw_heartbeat);
>> +	}
>> +	return err;
>> +}
>> +
>> +/**
>>    * watchdog_register_device() - register a watchdog device
>>    * @wdd: watchdog device
>>    *
>> @@ -156,13 +239,24 @@ int watchdog_register_device(struct watchdog_device *wdd)
>>   	wdd->dev = device_create(watchdog_class, wdd->parent, devno,
>>   					NULL, "watchdog%d", wdd->id);
>>   	if (IS_ERR(wdd->dev)) {
>> -		watchdog_dev_unregister(wdd);
>> -		ida_simple_remove(&watchdog_ida, id);
>>   		ret = PTR_ERR(wdd->dev);
>> -		return ret;
>> +		goto dev_create_fail;
>> +	}
>> +
>> +	INIT_DELAYED_WORK(&wdd->work, watchdog_worker);
>> +
>> +	if (wdd->hw_max_timeout) {
>> +		ret = prepare_watchdog(wdd);
>> +		if (ret)
>> +			goto dev_create_fail;
> 	} else {
> 		dev_warn("Incomplete watchdog driver implementation, please report or fix\n")

Yes, this would probably speed up the rate drivers are converting to use 
the new API extensions. I'll add it.

>>   	}
>>
>>   	return 0;
>> +
>> +dev_create_fail:
>> +	watchdog_dev_unregister(wdd);
>> +	ida_simple_remove(&watchdog_ida, id);
>> +	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(watchdog_register_device);
>>
>> @@ -181,6 +275,7 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
>>   	if (wdd == NULL)
>>   		return;
>>
>> +	cancel_delayed_work_sync(&wdd->work);
>>   	devno = wdd->cdev.dev;
>>   	ret = watchdog_dev_unregister(wdd);
>>   	if (ret)
>> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
>> index 6aaefba..04ac68c 100644
>> --- a/drivers/watchdog/watchdog_dev.c
>> +++ b/drivers/watchdog/watchdog_dev.c
>> @@ -49,6 +49,14 @@ static dev_t watchdog_devt;
>>   /* the watchdog device behind /dev/watchdog */
>>   static struct watchdog_device *old_wdd;
>>
>> +static int _watchdog_ping(struct watchdog_device *wddev)
>> +{
>> +	if (wddev->ops->ping)
>> +		return wddev->ops->ping(wddev);  /* ping the watchdog */
>> +	else
>> +		return wddev->ops->start(wddev); /* restart watchdog */
>> +}
>> +
>>   /*
>>    *	watchdog_ping: ping the watchdog.
>>    *	@wddev: the watchdog device to ping
>> @@ -73,10 +81,13 @@ static int watchdog_ping(struct watchdog_device *wddev)
>>   	if (!watchdog_active(wddev))
>>   		goto out_ping;
>>
>> -	if (wddev->ops->ping)
>> -		err = wddev->ops->ping(wddev);  /* ping the watchdog */
>> -	else
>> -		err = wddev->ops->start(wddev); /* restart watchdog */
>> +	err = _watchdog_ping(wddev);
>> +
>> +	if (wddev->hw_max_timeout &&
>> +		wddev->timeout * HZ > wddev->hw_max_timeout) {
>> +		wddev->expires = jiffies + wddev->timeout * HZ;
>> +		schedule_delayed_work(&wddev->work, wddev->hw_heartbeat);
>> +	}
>>
>>   out_ping:
>>   	mutex_unlock(&wddev->lock);
>> @@ -110,6 +121,13 @@ static int watchdog_start(struct watchdog_device *wddev)
>>   	if (err == 0)
>>   		set_bit(WDOG_ACTIVE, &wddev->status);
>>
>> +	if (wddev->hw_max_timeout &&
>> +		wddev->timeout * HZ > wddev->hw_max_timeout) {
>> +		wddev->expires = jiffies + wddev->timeout * HZ;
>> +		schedule_delayed_work(&wddev->work, wddev->hw_heartbeat);
>> +	} else
>> +		cancel_delayed_work(&wddev->work);
>> +
>>   out_start:
>>   	mutex_unlock(&wddev->lock);
>>   	return err;
>> @@ -145,9 +163,21 @@ static int watchdog_stop(struct watchdog_device *wddev)
>>   		goto out_stop;
>>   	}
>>
>> -	err = wddev->ops->stop(wddev);
>> -	if (err == 0)
>> +	if (!wddev->hw_max_timeout || watchdog_is_stoppable(wddev)) {
>> +		cancel_delayed_work(&wddev->work);
>> +		err = wddev->ops->stop(wddev);
>> +		if (err == 0)
>> +			clear_bit(WDOG_ACTIVE, &wddev->status);
>> +	} else {
>> +		/* Unstoppable watchdogs need the worker to keep them alive */
>>   		clear_bit(WDOG_ACTIVE, &wddev->status);
>> +		/*
>> +		 * Ping it once as we don't know how much time there
>> +		 * is left in the watchdog timer.
>> +		 */
>> +		err = _watchdog_ping(wddev);
>> +		schedule_delayed_work(&wddev->work, wddev->hw_heartbeat);
>> +	}
> Why not do:
>
> 	err = wddev->ops->stop(wddev);
> 	clear_bit(WDOG_ACTIVE, &wddev->status);
> 	if (err != 0) {
> 		err = _watchdog_ping(wddev);
> 		if (err) {
> 			dev_crit(...);
> 		schedule_delayed_work(...);
> 	}
>
> This way you (maybe?) don't need to expand all drivers to tell you if
> the watchdog timer is stoppable, just assert that the stop callback
> fails which IMHO is easier and more natural.
>

Currently the watchdog API mandates that stop() function must be 
implemented and the drivers that can't stop the actual HW just set up 
their own tricks to emulate stopped hardware. What we could do is to 
require that drivers using the new API return error on their stop 
function in case they can't stop the hardware. I never thought it this 
way. This would indeed reduce 50% of the proposed HW feature bits.

I'll look into this. The idea is good.

>>
>>   out_stop:
>>   	mutex_unlock(&wddev->lock);
>> @@ -194,7 +224,38 @@ out_status:
>>   static int watchdog_set_timeout(struct watchdog_device *wddev,
>>   							unsigned int timeout)
>>   {
>> -	int err;
>> +	int err = 0;
>> +
>> +	if (wddev->hw_max_timeout) {
>> +		int hw_timeout;
>> +		/*
>> +		 * We can't support too short timeout values. There is
>> +		 * really no maximu however, anything longer than HW
> s/maximu/maximum/
>
>> +		 * maximum will be supported by the watchdog core on
>> +		 * behalf of the actual HW.
>> +		 */
>> +		if (timeout < wddev->min_timeout)
>> +			return -EINVAL;
> Is it save to read min_timout without holding the lock?

No, I'd say it is a bug, even though I don't think we are likely to race 
here. I see no reason why this shouldn't be covered with the lock.

>> +
>> +		mutex_lock(&wddev->lock);
>> +		if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
>> +			err = -ENODEV;
>> +			goto out_timeout;
>> +		}
>> +
>> +		if (timeout * HZ > wddev->hw_max_timeout)
>> +			schedule_delayed_work(&wddev->work,
>> +					wddev->hw_heartbeat);
>> +
>> +		hw_timeout = min(timeout, wddev->hw_max_timeout / HZ);
> If you'd keep hw_max_timeout in seconds (i.e. what is used for timeout)
> you wouldn't need to divide here. If my watchdog has hw_max_timeout =
> 0.5s then you do wddev->ops->set_timeout(0) here.
>

If the maximum supported timeout is less than a second, there is no 
really point in having WDIOF_SETTIMEOUT set in the driver at all. There 
is no way user can set up the timeout through the current API. The 
hw_max_timeout needs to be in jiffies in case the HW maximum is less 
than a second.

>> +		if (wddev->info->options & WDIOF_SETTIMEOUT)
>> +			err = wddev->ops->set_timeout(wddev, hw_timeout);
> The case of not having WDIOF_SETTIMEOUT isn't handled here, right? Other
> places check for WDIOF_SETTIMEOUT and wddev->ops->set_timeout?!
>

Good point. I didn't actually test this with any drivers that didn't 
have WDIOF_SETTIMEOUT set. For example with at91sam9_wdt 
WDIOF_SETTIMEOUT is set but only because the driver implemented its own 
fake timeouts as the hardware cannot be set. So I need to remove 
WDIOF_SETTIMEOUT bit from the driver and then handle the timeout 
handling here properly. And in that case, what we can do here is to 
either have a timeout that is exactly same what is supported by the 
hardware or use the worker to extend the timeout. Can't do anything else.

Good catch!

>> +
>> +		if (hw_timeout < timeout)
>> +			wddev->timeout = timeout;
> What is the semantic of wddev->timeout? Does it hold the value
> set by userspace or the value the hardware is set to? You'd need to
> clarify that by adding more comments. Is this if correct?
>

It stores the timeout interval we are expecting from the user space. 
Hardware timeout can be shorter. I'll document this better to the next 
patch version.

>> +
>> +		goto out_timeout;
>> +	}
>>
>>   	if ((wddev->ops->set_timeout == NULL) ||
>>   	    !(wddev->info->options & WDIOF_SETTIMEOUT))
>> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
>> index 395b70e..027c99d 100644
>> --- a/include/linux/watchdog.h
>> +++ b/include/linux/watchdog.h
>> @@ -12,6 +12,7 @@
>>   #include <linux/bitops.h>
>>   #include <linux/device.h>
>>   #include <linux/cdev.h>
>> +#include <linux/workqueue.h>
>>   #include <uapi/linux/watchdog.h>
>>
>>   struct watchdog_ops;
>> @@ -62,9 +63,13 @@ struct watchdog_ops {
>>    * @timeout:	The watchdog devices timeout value.
>>    * @min_timeout:The watchdog devices minimum timeout value.
>>    * @max_timeout:The watchdog devices maximum timeout value.
>> + * @hw_max_timeout:The watchdog hardware maximum timeout value.
>> + * @hw_heartbeat:Time interval in HW between timer pings.
>>    * @driver-data:Pointer to the drivers private data.
>>    * @lock:	Lock for watchdog core internal use only.
>> + * @work:	Worker used to provide longer timeouts than hardware supports.
>>    * @status:	Field that contains the devices internal status bits.
>> + * @hw_features:Feature bits describing how the watchdog HW works.
>>    *
>>    * The watchdog_device structure contains all information about a
>>    * watchdog timer device.
>> @@ -86,8 +91,12 @@ struct watchdog_device {
>>   	unsigned int timeout;
>>   	unsigned int min_timeout;
>>   	unsigned int max_timeout;
>> +	unsigned int hw_max_timeout; /* in jiffies */
>> +	unsigned int hw_heartbeat; /* in jiffies */
>> +	unsigned long int expires; /* for keepalive worker */
>>   	void *driver_data;
>>   	struct mutex lock;
>> +	struct delayed_work work;
> I'd group things together here that belong together.
>

How would you like to have the "belong together" criteria to be defined? 
I now have timeout values together and then other structures in another 
group as I found that logical. I'm fine with other criteria too, if you 
specify one to me.

>>   	unsigned long status;
>>   /* Bit numbers for status flags */
>>   #define WDOG_ACTIVE		0	/* Is the watchdog running/active */
>> @@ -95,6 +104,14 @@ struct watchdog_device {
>>   #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
>>   #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
>>   #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
>> +
>> +/* Bits describing features supported by the HW */
>> +	unsigned long hw_features;
>> +
>> +/* Can the watchdog be stopped and started */
>> +#define WDOG_HW_IS_STOPPABLE		BIT(0)
>> +/* Is the watchdog already running when the driver starts up */
>> +#define WDOG_HW_RUNNING_AT_BOOT		BIT(1)
>>   };
>>
>>   #define WATCHDOG_NOWAYOUT		IS_BUILTIN(CONFIG_WATCHDOG_NOWAYOUT)
>> @@ -120,6 +137,11 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
>>   		(t < wdd->min_timeout || t > wdd->max_timeout));
>>   }
>>
>> +static inline bool watchdog_is_stoppable(struct watchdog_device *wdd)
>> +{
>> +	return wdd->hw_features & WDOG_HW_IS_STOPPABLE;
>> +}
>> +
>>   /* Use the following functions to manipulate watchdog driver specific data */
>>   static inline void watchdog_set_drvdata(struct watchdog_device *wdd, void *data)
>>   {
>> @@ -134,6 +156,7 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
>>   /* drivers/watchdog/watchdog_core.c */
>>   extern int watchdog_init_timeout(struct watchdog_device *wdd,
>>   				  unsigned int timeout_parm, struct device *dev);
>> +int watchdog_init_params(struct watchdog_device *wdd, struct device *dev);
> This needs commenting and probably embrace watchdog_init_timeout
> properly. i.e. remove watchdog_init_timeout.

Yes, the comments are now mostly above the function implementation. I 
can add more there if you feel its inadequate.

watchdog_init_timeout() can be removed once all drivers are converted to 
use init_watchdog_params()


Thank you for your valuable review.

-Timo

>
> Best regards
> Uwe
>

