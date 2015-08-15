Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40438 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbbHOXRQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Aug 2015 19:17:16 -0400
Message-ID: <55CFC870.8060003@roeck-us.net>
Date: Sat, 15 Aug 2015 16:17:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 2/8] watchdog: Introduce hardware maximum timeout in
 watchdog core
References: <1439010167-13818-1-git-send-email-linux@roeck-us.net> <1439010167-13818-3-git-send-email-linux@roeck-us.net> <20150813211345.GN9999@pengutronix.de>
In-Reply-To: <20150813211345.GN9999@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 08/13/2015 02:13 PM, Uwe Kleine-König wrote:
> Hello Guenter,
>
> On Fri, Aug 07, 2015 at 10:02:41PM -0700, Guenter Roeck wrote:
>> Introduce an optional hardware maximum timeout in the watchdog core.
>> The hardware maximum timeout can be lower than the maximum timeout.
>>
>> Drivers can set the maximum hardware timeout value in the watchdog data
>> structure. If the configured timeout exceeds the maximum hardware timeout,
>> the watchdog core enables a timer function to assist sending keepalive
>> requests to the watchdog driver.
>>
>> Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>
>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2:
>> - Improved and hopefully clarified documentation.
>> - Rearranged variables in struct watchdog_device such that internal variables
>>    come last.
>> - The code now ensures that the watchdog times out <timeout> seconds after
>>    the most recent keepalive sent from user space.
>> - The internal keepalive now stops silently and no longer generates a
>>    warning message. Reason is that it will now stop early, while there
>>    may still be a substantial amount of time for keepalives from user space
>>    to arrive. If such keepalives arrive late (for example if user space
>>    is configured to send keepalives just a few seconds before the watchdog
>>    times out), the message would just be noise and not provide any value.
>> ---
>>   Documentation/watchdog/watchdog-kernel-api.txt |  23 +++-
>>   drivers/watchdog/watchdog_dev.c                | 140 ++++++++++++++++++++++---
>>   include/linux/watchdog.h                       |  26 +++--
>>   3 files changed, 163 insertions(+), 26 deletions(-)
>>
>> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
>> index d8b0d3367706..25b00b878a7b 100644
>> --- a/Documentation/watchdog/watchdog-kernel-api.txt
>> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
>> @@ -53,9 +53,12 @@ struct watchdog_device {
>>   	unsigned int timeout;
>>   	unsigned int min_timeout;
>>   	unsigned int max_timeout;
>> +	unsigned int max_hw_timeout_ms;
>>   	void *driver_data;
>> -	struct mutex lock;
>>   	unsigned long status;
>> +	struct mutex lock;
>> +	unsigned long last_keepalive;
>> +	struct delayed_work work;
>>   	struct list_head deferred;
>>   };
>>
>> @@ -73,18 +76,28 @@ It contains following fields:
>>     additional information about the watchdog timer itself. (Like it's unique name)
>>   * ops: a pointer to the list of watchdog operations that the watchdog supports.
>>   * timeout: the watchdog timer's timeout value (in seconds).
>> +  This is the time after which the system will reboot if user space does
>> +  not send a heartbeat request if WDOG_ACTIVE is set.
>>   * min_timeout: the watchdog timer's minimum timeout value (in seconds).
>>   * max_timeout: the watchdog timer's maximum timeout value (in seconds).
>> +* max_hw_timeout_ms: Maximum hardware timeout, in milli-seconds. May differ
>> +  from max_timeout. If set to a value larger than max_timeout, the
>> +  infrastructure will send a heartbeat to the watchdog driver if 'timeout'
>> +  is larger than 'max_hw_timeout / 2', unless WDOG_ACTIVE is set and user
>> +  space failed to send a heartbeat for at least 'timeout' seconds.
> To properly understand this it would be necessary to know what
> max_timeout is. Maybe clearify that, too?
>

I think I found a better solution: Declare that max_timeout won't be used
if max_hw_timeout_ms is provided. This also simplifies the code a lot.

>>   * bootstatus: status of the device after booting (reported with watchdog
>>     WDIOF_* status bits).
>>   * driver_data: a pointer to the drivers private data of a watchdog device.
>>     This data should only be accessed via the watchdog_set_drvdata and
>>     watchdog_get_drvdata routines.
>> -* lock: Mutex for WatchDog Timer Driver Core internal use only.
>>   * status: this field contains a number of status bits that give extra
>>     information about the status of the device (Like: is the watchdog timer
>>     running/active, is the nowayout bit set, is the device opened via
>>     the /dev/watchdog interface or not, ...).
>> +* lock: Mutex for WatchDog Timer Driver Core internal use only.
>> +* last_keepalive: Time of most recent keepalive triggered from user space,
>> +  in jiffies.
>> +* work: Worker data structure for WatchDog Timer Driver Core internal use only.
>>   * deferred: entry in wtd_deferred_reg_list which is used to
>>     register early initialized watchdogs.
>>
>> @@ -160,7 +173,11 @@ they are supported. These optional routines/operations are:
>>     and -EIO for "could not write value to the watchdog". On success this
>>     routine should set the timeout value of the watchdog_device to the
>>     achieved timeout value (which may be different from the requested one
>> -  because the watchdog does not necessarily has a 1 second resolution).
>> +  because the watchdog does not necessarily have a 1 second resolution).
>> +  Drivers implementing hw_max_timeout_ms set the hardware watchdog timeout
>> +  to the minimum of timeout and hw_max_timeout_ms. Those drivers set the
>> +  timeout value of the watchdog_device either to the requested timeout value
>> +  (if it is larger than hw_max_timeout_ms), or to the achieved timeout value.
>>     (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
>>     watchdog's info structure).
>>   * get_timeleft: this routines returns the time that's left before a reset.
>> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
>> index 06171c73daf5..c04ba1a98cc8 100644
>> --- a/drivers/watchdog/watchdog_dev.c
>> +++ b/drivers/watchdog/watchdog_dev.c
>> @@ -37,7 +37,9 @@
>>   #include <linux/errno.h>	/* For the -ENODEV/... values */
>>   #include <linux/kernel.h>	/* For printk/panic/... */
>>   #include <linux/fs.h>		/* For file operations */
>> +#include <linux/jiffies.h>	/* For timeout functions */
>>   #include <linux/watchdog.h>	/* For watchdog specific items */
>> +#include <linux/workqueue.h>	/* For workqueue */
>>   #include <linux/miscdevice.h>	/* For handling misc devices */
>>   #include <linux/init.h>		/* For __init/__exit/... */
>>   #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
>> @@ -49,6 +51,78 @@ static dev_t watchdog_devt;
>>   /* the watchdog device behind /dev/watchdog */
>>   static struct watchdog_device *old_wdd;
>>
>> +static struct workqueue_struct *watchdog_wq;
>> +
>> +static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>> +{
>
> Maybe add:
> 	/* all variables in milli seconds */
>
Done.

>> +	unsigned int hm = wdd->max_hw_timeout_ms;
>> +	unsigned int m = wdd->max_timeout * 1000;
>> +	unsigned int t = wdd->timeout * 1000;
>> +
>> +	return watchdog_active(wdd) && hm && (!m || hm < m) && t > hm;
>
> ok, this means:
>
> 	watchdog_active(wdd): Userspace thinks the hardware is running
> 	hm: the driver is aware of framework pinging
> 	!m: no artificial limit
> 	hm < m: some artificial limit (does this make sense to have
> 		max_timeout > DIV_ROUND_UP(max_hw_timeout_ms, 1000), or
> 		should we better enforce max_timeout = 0 for "good"
> 		drivers?)
> 	t > hm: userspace requests longer timeout than hardware can
> 		handle.

I added this to the comments, with a slight modification. Specifically,
I don't check max_timeout anymore if max_hw_timeout_ms is specified.

>
> looks good.
>
>> +}
>> +
>> +static unsigned long watchdog_next_keepalive(struct watchdog_device *wdd)
>> +{
>> +	unsigned int t = wdd->timeout * 1000;
>> +	unsigned long to = wdd->last_keepalive + msecs_to_jiffies(t);
>> +	unsigned long last, max_t, tj;
>> +
>> +	if (wdd->max_hw_timeout_ms && t > wdd->max_hw_timeout_ms)
>> +		t = wdd->max_hw_timeout_ms;
>
> watchdog_next_keepalive is only called after watchdog_need_worker
> returned true, so there shouldn't be a need to repeat this test, right?
>

Yes, the check if wdd->max_hw_timeout_ms != 0 can be dropped.

>> +	tj = msecs_to_jiffies(t / 2);
>> +
>> +	/*
>> +	 * Ensure that the watchdog times out wdd->timeout seconds
>> +	 * after the most recent keepalive sent from user space.
>> +	 */
>> +	last = to - msecs_to_jiffies(t);
>> +	if (time_is_after_jiffies(last))
>> +		max_t = last - jiffies;
>> +	else
>> +		max_t = 0;
>> +
>> +	if (max_t < tj)
>> +		tj = max_t;
>> +
>> +	return tj;
> I find this hard to understand. Maybe the variable names could be
> improved, something like:
>
> 	t -> hw_timeout_ms
> 	tj -> keep_alive_interval
> 	to -> virt_timeout
> 	last -> last_hw_ping
>
> And I'd do:
>
> 	/*
> 	 * To ensure that the watchdog times out wdd->timeout seconds
> 	 * after the most recent ping from userspace, the last
> 	 * worker ping has to come in hw_timeout_ms before this timeout.
> 	 */
> 	last_hw_ping = virt_timeout - msecs_to_jiffies(hw_timeout_ms);
>
> 	/*
> 	 * Worker pings usually come at intervals of
> 	 * max_hw_timeout_ms / 2. This interval is shortend if
> 	 * virt_timeout is near (or already over).
> 	 */
> 	return min_t(long, last_hw_ping - jiffies, keep_alive_interval);
>
> then you have to change the return type to long and ...
>
>> +}
>> +
>> +static inline void watchdog_update_worker(struct watchdog_device *wdd,
>> +					  bool cancel, bool sync)
>> +{
>> +	if (watchdog_need_worker(wdd)) {
>> +		unsigned long t = watchdog_next_keepalive(wdd);
>> +
>> +		if (t)
>
> ... test for t > 0 here.
>
Makes sense, done.

>> +			mod_delayed_work(watchdog_wq, &wdd->work, t);
>> +	} else if (cancel) {
>> +		if (sync)
>
> Up to now sync is always false. Does this change later? Should this
> parameter be introduced only later, too?
>
>> +			cancel_delayed_work_sync(&wdd->work);
>> +		else
>> +			cancel_delayed_work(&wdd->work);
>> +	}
>> +}
>
> This function looks artificial, i.e. I don't understand why you would
> want to modify the timer or stop it. Probably that is because the timer
> does more than increasing the virtual timeout later?
>

I dropped the sync part. This will be needed with the next patch of the series
(if I recall correctly) so I'll introduce it there.

cancel is needed because the timer does not have to be canceled if called
from the timer function itself.

>> +static int _watchdog_ping(struct watchdog_device *wdd)
>> +{
>> +	int err;
>> +
>> +	if (test_bit(WDOG_UNREGISTERED, &wdd->status))
>> +		return -ENODEV;
>> +
>> +	if (!watchdog_active(wdd))
>> +		return 0;
>> +
>> +	if (wdd->ops->ping)
>> +		err = wdd->ops->ping(wdd);  /* ping the watchdog */
>> +	else
>> +		err = wdd->ops->start(wdd); /* restart watchdog */
>> +
>> +	return err;
>> +}
>> +
>>   /*
>>    *	watchdog_ping: ping the watchdog.
>>    *	@wdd: the watchdog device to ping
>> @@ -61,26 +135,27 @@ static struct watchdog_device *old_wdd;
>>
>>   static int watchdog_ping(struct watchdog_device *wdd)
>>   {
>> -	int err = 0;
>> +	int err;
>>
>>   	mutex_lock(&wdd->lock);
>> +	err = _watchdog_ping(wdd);
>> +	wdd->last_keepalive = jiffies;
> I'd switch these two lines. Consider wdd->ops->ping takes some time then
> the next ping should timed relative to before the ping, not after it.
>
Ok.

>> +	watchdog_update_worker(wdd, false, false);
>> +	mutex_unlock(&wdd->lock);
>>
>> -	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
>> -		err = -ENODEV;
>> -		goto out_ping;
>> -	}
>> +	return err;
>> +}
>>
>> -	if (!watchdog_active(wdd))
>> -		goto out_ping;
>> +static void watchdog_ping_work(struct work_struct *work)
>> +{
>> +	struct watchdog_device *wdd;
>>
>> -	if (wdd->ops->ping)
>> -		err = wdd->ops->ping(wdd);	/* ping the watchdog */
>> -	else
>> -		err = wdd->ops->start(wdd);	/* restart watchdog */
>> +	wdd = container_of(to_delayed_work(work), struct watchdog_device, work);
>>
>> -out_ping:
>> +	mutex_lock(&wdd->lock);
>> +	_watchdog_ping(wdd);
>> +	watchdog_update_worker(wdd, false, false);
>>   	mutex_unlock(&wdd->lock);
>> -	return err;
>>   }
>>
>>   /*
>> @@ -107,8 +182,11 @@ static int watchdog_start(struct watchdog_device *wdd)
>>   		goto out_start;
>>
>>   	err = wdd->ops->start(wdd);
>> -	if (err == 0)
>> +	if (err == 0) {
>>   		set_bit(WDOG_ACTIVE, &wdd->status);
>> +		wdd->last_keepalive = jiffies;
>> +		watchdog_update_worker(wdd, false, false);
>> +	}
>>
>>   out_start:
>>   	mutex_unlock(&wdd->lock);
>> @@ -146,8 +224,10 @@ static int watchdog_stop(struct watchdog_device *wdd)
>>   	}
>>
>>   	err = wdd->ops->stop(wdd);
>> -	if (err == 0)
>> +	if (err == 0) {
>>   		clear_bit(WDOG_ACTIVE, &wdd->status);
>> +		watchdog_update_worker(wdd, true, false);
>
> Regarding my concern about watchdog_update_worker above: After
> clear_bit(WDOG_ACTIVE, ...) it's an unconditional cancel_delayed_work
> and I'd prefer to not have that disguised. Maybe it would be easier to
> understand if there were two different functions, one with the semantic
> of watchdog_update_worker(cancel=true) and one with
> watchdog_update_worker(cancel=false)?
>
I replaced it with cancel_delayed_work() in this patch. It needs to be
the update function after the next patch, but I'll introduce it there.

Reason for doing it here was to reduce the number of changes needed
in the next patch, but I now think that is just adding confusion.

> It's to late here now to review the rest of your patch. Will follow-up
> after sleeping.
>
Thanks!

Guenter

