Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35141 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585AbbLGQrf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 7 Dec 2015 11:47:35 -0500
Subject: Re: [RFC/RFT PATCH] watchdog: Move watchdog device creation to
 watchdog_dev.c
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1449431501-15843-1-git-send-email-linux@roeck-us.net>
 <20151207161549.GA6030@localhost>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5665B821.7070803@roeck-us.net>
Date: Mon, 7 Dec 2015 08:47:29 -0800
MIME-Version: 1.0
In-Reply-To: <20151207161549.GA6030@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Damien,

On 12/07/2015 08:15 AM, Damien Riegel wrote:
> On Sun, Dec 06, 2015 at 11:51:41AM -0800, Guenter Roeck wrote:
>> The watchdog character device s currently created in watchdog_dev.c,
>> and the watchdog device in watchdog_core.c. This results in
>> cross-dependencies, as the device creation needs to know the watchdog
>> character device number.
>>
>> On top of that, the watchdog character device is created before the
>> watchdog device is created. This can result in race conditions if the
>> watchdog device node is accessed before the watchdog device has been
>> created.
>>
>> To solve the problem, move watchdog device creation into watchdog_dev.c,
>> and create the watchdog device prior to creating its device node.
>> Also move device class creation into watchdog_dev.c, since this is now
>> the only place where the watchdog class is needed.
>>
>> Inspired by an earlier patch set from Damien Riegel.
>>
>> Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Hi Damien,
>>
>> I think this approach would be a bit better. The watchdog device isn't
>> really used in the watchdog core code, so it is better created in
>> watchdog_dev.c. That also fits well with other pending changes, such as
>> sysfs attribute support, and my attempts to move the ref/unref functions
>> completely into the watchdog core. As a side effect, it also cleans up
>> the error path in __watchdog_register_device().
>>
>> What do you think ?
>
> Hi Guenter,
>
> Like the idea, but I don't really get the separation. For instance, you
> move watchdog_class in watchdog_dev.c but you keep watchdog_ida in
> watchdog_core.c whereas it is only used for device creation/deletion.
>
The class is watchdog driver internal, and it is device related, so I think
it made sense to move it to watchdog_dev.c. On top of that, it will be needed
there if/when we introduce sysfs attributes.

The watchdog id can be determined by obtaining an id using ida, or it can
be provided through the watchdog alias. The operation to get it is not
device related, and it is not straightforward to obtain it, so I thought
it makes sense to keep the code in watchdog_core.c.

Of course a lot of it is personal preference.

> Also a few minor comments below.
>
>> The code has been compile tested only so far. I'll try to test it later
>> today, but I wanted to get it out for discussion.
>
> I'll give it a try but I have only one board to test it.
>
I'll definitely test it myself as well.

>>
>> Thanks,
>> Guenter
>>
>>   drivers/watchdog/watchdog_core.c | 37 ++----------------------
>>   drivers/watchdog/watchdog_core.h |  2 +-
>>   drivers/watchdog/watchdog_dev.c  | 61 ++++++++++++++++++++++++++++++++--------
>>   3 files changed, 54 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
>> index 873f13972cf4..089e930fce19 100644
>> --- a/drivers/watchdog/watchdog_core.c
>> +++ b/drivers/watchdog/watchdog_core.c
>> @@ -41,7 +41,6 @@
>>   #include "watchdog_core.h"	/* For watchdog_dev_register/... */
>>
>>   static DEFINE_IDA(watchdog_ida);
>> -static struct class *watchdog_class;
>>
>>   /*
>>    * Deferred Registration infrastructure.
>> @@ -139,7 +138,7 @@ EXPORT_SYMBOL_GPL(watchdog_init_timeout);
>>
>>   static int __watchdog_register_device(struct watchdog_device *wdd)
>>   {
>> -	int ret, id = -1, devno;
>> +	int ret, id = -1;
>>
>>   	if (wdd == NULL || wdd->info == NULL || wdd->ops == NULL)
>>   		return -EINVAL;
>> @@ -192,16 +191,6 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>>   		}
>>   	}
>>
>> -	devno = wdd->cdev.dev;
>> -	wdd->dev = device_create(watchdog_class, wdd->parent, devno,
>> -					NULL, "watchdog%d", wdd->id);
>> -	if (IS_ERR(wdd->dev)) {
>> -		watchdog_dev_unregister(wdd);
>> -		ida_simple_remove(&watchdog_ida, id);
>> -		ret = PTR_ERR(wdd->dev);
>> -		return ret;
>> -	}
>> -
>>   	return 0;
>>   }
>>
>> @@ -232,19 +221,8 @@ EXPORT_SYMBOL_GPL(watchdog_register_device);
>>
>>   static void __watchdog_unregister_device(struct watchdog_device *wdd)
>>   {
>> -	int ret;
>> -	int devno;
>> -
>> -	if (wdd == NULL)
>> -		return;
>> -
>> -	devno = wdd->cdev.dev;
>> -	ret = watchdog_dev_unregister(wdd);
>> -	if (ret)
>> -		pr_err("error unregistering /dev/watchdog (err=%d)\n", ret);
>> -	device_destroy(watchdog_class, devno);
>> +	watchdog_dev_unregister(wdd);
>>   	ida_simple_remove(&watchdog_ida, wdd->id);
>> -	wdd->dev = NULL;
>>   }
>>
>>   /**
>> @@ -287,17 +265,9 @@ static int __init watchdog_init(void)
>>   {
>>   	int err;
>>
>> -	watchdog_class = class_create(THIS_MODULE, "watchdog");
>> -	if (IS_ERR(watchdog_class)) {
>> -		pr_err("couldn't create class\n");
>> -		return PTR_ERR(watchdog_class);
>> -	}
>> -
>>   	err = watchdog_dev_init();
>> -	if (err < 0) {
>> -		class_destroy(watchdog_class);
>> +	if (err < 0)
>>   		return err;
>> -	}
>>
>>   	watchdog_deferred_registration();
>>   	return 0;
>> @@ -306,7 +276,6 @@ static int __init watchdog_init(void)
>>   static void __exit watchdog_exit(void)
>>   {
>>   	watchdog_dev_exit();
>> -	class_destroy(watchdog_class);
>>   	ida_destroy(&watchdog_ida);
>>   }
>>
>> diff --git a/drivers/watchdog/watchdog_core.h b/drivers/watchdog/watchdog_core.h
>> index 6c951418fca7..86ff962d1e15 100644
>> --- a/drivers/watchdog/watchdog_core.h
>> +++ b/drivers/watchdog/watchdog_core.h
>> @@ -32,6 +32,6 @@
>>    *	Functions/procedures to be called by the core
>>    */
>>   extern int watchdog_dev_register(struct watchdog_device *);
>> -extern int watchdog_dev_unregister(struct watchdog_device *);
>> +extern void watchdog_dev_unregister(struct watchdog_device *);
>>   extern int __init watchdog_dev_init(void);
>>   extern void __exit watchdog_dev_exit(void);
>> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
>> index 56a649e66eb2..07abe8c9e58c 100644
>> --- a/drivers/watchdog/watchdog_dev.c
>> +++ b/drivers/watchdog/watchdog_dev.c
>> @@ -49,6 +49,9 @@ static dev_t watchdog_devt;
>>   /* the watchdog device behind /dev/watchdog */
>>   static struct watchdog_device *old_wdd;
>>
>> +/* the watchdog device class */
>> +static struct class *watchdog_class;
>> +
>>   /*
>>    *	watchdog_ping: ping the watchdog.
>>    *	@wdd: the watchdog device to ping
>> @@ -523,7 +526,7 @@ static struct miscdevice watchdog_miscdev = {
>>    *	thus we set it up like that.
>>    */
>>
>> -int watchdog_dev_register(struct watchdog_device *wdd)
>> +int _watchdog_dev_register(struct watchdog_device *wdd)
>
> Doc not updated and still refers to watchdog_dev_register.
>
Yes, that is still the API function that is called from watchdog_register_device().
It should be static, though.

>>   {
>>   	int err, devno;
>>
>> @@ -532,11 +535,12 @@ int watchdog_dev_register(struct watchdog_device *wdd)
>>   		watchdog_miscdev.parent = wdd->parent;
>>   		err = misc_register(&watchdog_miscdev);
>>   		if (err != 0) {
>> -			pr_err("%s: cannot register miscdev on minor=%d (err=%d).\n",
>> -				wdd->info->identity, WATCHDOG_MINOR, err);
>> +			dev_err(wdd->dev,
>> +				"Cannot register miscdev on minor=%d (err=%d).\n",
>> +				WATCHDOG_MINOR, err);
>>   			if (err == -EBUSY)
>> -				pr_err("%s: a legacy watchdog module is probably present.\n",
>> -					wdd->info->identity);
>> +				dev_err(wdd->dev,
>> +					"A legacy watchdog module is probably present.\n");
>>   			old_wdd = NULL;
>>   			return err;
>>   		}
>> @@ -550,8 +554,8 @@ int watchdog_dev_register(struct watchdog_device *wdd)
>>   	/* Add the device */
>>   	err  = cdev_add(&wdd->cdev, devno, 1);
>>   	if (err) {
>> -		pr_err("watchdog%d unable to add device %d:%d\n",
>> -			wdd->id,  MAJOR(watchdog_devt), wdd->id);
>> +		dev_err(wdd->dev, "Unable to add device %d:%d\n",
>> +			MAJOR(watchdog_devt), wdd->id);
>>   		if (wdd->id == 0) {
>>   			misc_deregister(&watchdog_miscdev);
>>   			old_wdd = NULL;
>> @@ -567,7 +571,7 @@ int watchdog_dev_register(struct watchdog_device *wdd)
>>    *	Unregister the watchdog and if needed the legacy /dev/watchdog device.
>>    */
>>
>> -int watchdog_dev_unregister(struct watchdog_device *wdd)
>> +void _watchdog_dev_unregister(struct watchdog_device *wdd)
>
> Doc not updated.
>
Same as above.

>>   {
>>   	mutex_lock(&wdd->lock);
>>   	set_bit(WDOG_UNREGISTERED, &wdd->status);
>> @@ -578,7 +582,31 @@ int watchdog_dev_unregister(struct watchdog_device *wdd)
>>   		misc_deregister(&watchdog_miscdev);
>>   		old_wdd = NULL;
>>   	}
>> -	return 0;
>> +}
>> +
>> +int watchdog_dev_register(struct watchdog_device *wdd)
>> +{
>> +	dev_t devno;
>> +	int ret;
>> +
>> +	devno = MKDEV(MAJOR(watchdog_devt), wdd->id);
>
> This is now done twice, here and in _watchdog_dev_register. Maybe
> _watchdog_dev_register should be updated to read:
>
>    devno = wdd->dev.devt
>
> The end result is the same but the link between the two devices is more
> explicit (like it is now).
>
You are right, that makes sense. I dropped the variable and now use
wdd->dev.devt directly.

>> +	wdd->dev = device_create(watchdog_class, wdd->parent, devno,
>> +				 wdd, "watchdog%d", wdd->id);
>> +	if (IS_ERR(wdd->dev))
>> +		return PTR_ERR(wdd->dev);
>> +
>> +	ret = _watchdog_dev_register(wdd);
>> +	if (ret)
>> +		device_destroy(watchdog_class, devno);
>> +
>> +	return ret;
>> +}
>> +
>> +void watchdog_dev_unregister(struct watchdog_device *wdd)
>> +{
>> +	_watchdog_dev_unregister(wdd);
>> +	device_destroy(watchdog_class, wdd->dev->devt);
>> +	wdd->dev = NULL;
>>   }
>>
>>   /*
>> @@ -589,9 +617,19 @@ int watchdog_dev_unregister(struct watchdog_device *wdd)
>>
>>   int __init watchdog_dev_init(void)
>>   {
>> -	int err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
>> -	if (err < 0)
>> +	int err;
>> +
>> +	watchdog_class = class_create(THIS_MODULE, "watchdog");
>> +	if (IS_ERR(watchdog_class)) {
>> +		pr_err("couldn't create watchdog class\n");
>> +		return PTR_ERR(watchdog_class);
>> +	}
>> +
>> +	err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
>> +	if (err < 0) {
>>   		pr_err("watchdog: unable to allocate char dev region\n");
>> +		class_destroy(watchdog_class);
>> +	}
>
> Newline here ? checkpatch does not complain and this file style is not
> consistent on new line before return. Don't know which style is
> preferred.
>

The file actually does use a specific style, though it is maybe not easy to see.

	func();
	return err;

or
	if (expr) {
		func();
	}
	return err;

or
	if (expr)
		func();

	return err;

No idea if that is on purpose, but it does make some sense to me for readability.

Thanks,
Guenter

