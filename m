Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50083 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbbLVBLC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Dec 2015 20:11:02 -0500
Subject: Re: [PATCH 2/5] watchdog: Separate and maintain variables based on
 variable lifetime
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Pratyush Anand <panand@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
References: <1450645503-16661-1-git-send-email-linux@roeck-us.net>
 <1450645503-16661-3-git-send-email-linux@roeck-us.net>
 <20151221172815.GC12696@localhost>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5678A322.2010109@roeck-us.net>
Date: Mon, 21 Dec 2015 17:10:58 -0800
MIME-Version: 1.0
In-Reply-To: <20151221172815.GC12696@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/21/2015 09:28 AM, Damien Riegel wrote:
> On Sun, Dec 20, 2015 at 01:05:00PM -0800, Guenter Roeck wrote:
>> All variables required by the watchdog core to manage a watchdog are
>> currently stored in struct watchdog_device. The lifetime of those
>> variables is determined by the watchdog driver. However, the lifetime
>> of variables used by the watchdog core differs from the lifetime of
>> struct watchdog_device. To remedy this situation, watchdog drivers
>> can implement ref and unref callbacks, to be used by the watchdog
>> core to lock struct watchdog_device in memory.
>>
>> While this solves the immediate problem, it depends on watchdog drivers
>> to actually implement the ref/unref callbacks. This is error prone,
>> often not implemented in the first place, or not implemented correctly.
>>
>> To solve the problem without requiring driver support, split the variables
>> in struct watchdog_device into two data structures - one for variables
>> associated with the watchdog driver, one for variables associated with
>> the watchdog core. With this approach, the watchdog core can keep track
>> of its variable lifetime and no longer depends on ref/unref callbacks
>> in the driver. As a side effect, some of the variables originally in
>> struct watchdog_driver are now private to the watchdog core and no longer
>> visible in watchdog drivers.
>>
>> The 'ref' and 'unref' callbacks in struct watchdog_driver are no longer
>> used and marked as deprecated.
>
> Two comments below. It's great to see that unbinding a driver no longer
> triggers a kernel panic.
>
It should not have caused a panic to start with, but the ref/unref functions
for the most part were either not or wrongly implemented. Not really
surprising - it took me a while to understand the problem.

[ ... ]

>>
>>   /*
>> + * struct _watchdog_device - watchdog core internal data
>
> Think it should be /**. Anyway, I find it confusing to have both
> _watchdog_device and watchdog_device, but I can't think of a better
> name right now.

I renamed the data structure to watchdog_data and moved it into watchdog_dev.c
since it is only used there. No '**', though, because it is not a published
API, but just an internal data structure.

I also renamed the matching variable name to 'wd_data' (from '_wdd').

>>
>>   static void watchdog_cdev_unregister(struct watchdog_device *wdd)
>>   {
>> -	mutex_lock(&wdd->lock);
>> -	set_bit(WDOG_UNREGISTERED, &wdd->status);
>> -	mutex_unlock(&wdd->lock);
>> +	struct _watchdog_device *_wdd = wdd->wdd_data;
>>
>> -	cdev_del(&wdd->cdev);
>> +	cdev_del(&_wdd->cdev);
>>   	if (wdd->id == 0) {
>>   		misc_deregister(&watchdog_miscdev);
>> -		old_wdd = NULL;
>> +		_old_wdd = NULL;
>>   	}
>> +
>> +	if (watchdog_active(wdd))
>> +		pr_crit("watchdog%d: watchdog still running!\n", wdd->id);
>
> As it is now safe to unbind and rebind a driver, it means that a
> watchdog driver probe function can now be called with a running
> watchdog. Some drivers handle this situation, but I think that most of
> them expect the watchdog to be off at this point.
>
No semantics change, though, and no change in behavior. Drivers _should_
handle that situation today. Sure, many don't, but that is a different issue.

I'll address handling an already-running watchdog by the watchdog core until
the character device is opened in a separate patch set, but we'll have to have
this series accepted before I re-introduce that. Even with that, it will still
be the driver's responsibility to detect and report that/if a watchdog is
already running.

Thanks,
Guenter

