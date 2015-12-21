Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57310 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbbLUNV0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Dec 2015 08:21:26 -0500
Subject: Re: [PATCH 5/5] hwmon: (sch56xx) Drop watchdog driver data reference
 count callbacks
To: Hans de Goede <hdegoede@redhat.com>, linux-watchdog@vger.kernel.org
References: <1450645503-16661-1-git-send-email-linux@roeck-us.net>
 <1450645503-16661-6-git-send-email-linux@roeck-us.net>
 <5677D66C.6090906@redhat.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Pratyush Anand <panand@redhat.com>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5677FCD1.8020807@roeck-us.net>
Date: Mon, 21 Dec 2015 05:21:21 -0800
MIME-Version: 1.0
In-Reply-To: <5677D66C.6090906@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Hans,

On 12/21/2015 02:37 AM, Hans de Goede wrote:
> Hi,
>
> On 20-12-15 22:05, Guenter Roeck wrote:
>> Reference counting is now implemented in the watchdog core and no longer
>> required in watchdog drivers.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/sch56xx-common.c | 30 ------------------------------
>>   1 file changed, 30 deletions(-)
>>
>> diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
>> index 738681983284..88dba68a9abb 100644
>> --- a/drivers/hwmon/sch56xx-common.c
>> +++ b/drivers/hwmon/sch56xx-common.c
>> @@ -30,7 +30,6 @@
>>   #include <linux/watchdog.h>
>>   #include <linux/miscdevice.h>
>>   #include <linux/uaccess.h>
>> -#include <linux/kref.h>
>>   #include <linux/slab.h>
>>   #include "sch56xx-common.h"
>>
>> @@ -67,7 +66,6 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>>   struct sch56xx_watchdog_data {
>>       u16 addr;
>>       struct mutex *io_lock;
>> -    struct kref kref;
>>       struct watchdog_info wdinfo;
>>       struct watchdog_device wddev;
>>       u8 watchdog_preset;
>> @@ -258,15 +256,6 @@ EXPORT_SYMBOL(sch56xx_read_virtual_reg12);
>>    * Watchdog routines
>>    */
>>
>> -/* Release our data struct when we're unregistered *and*
>> -   all references to our watchdog device are released */
>> -static void watchdog_release_resources(struct kref *r)
>> -{
>> -    struct sch56xx_watchdog_data *data =
>> -        container_of(r, struct sch56xx_watchdog_data, kref);
>> -    kfree(data);
>
> You're not replacing this kfree() anywhere, so now the data
> allocated by sch56xx_watchdog_register() never gets free-ed
> after a sch56xx_watchdog_unregister(). If I read this patch
> set correctly then after this patch-set it is safe to
> immediately free the memory containing the struct watchdog_device
> (and also the struct wdinfo ?) after calling
> watchdog_unregister_device(), even if userspace still has the
> watchdog cdev open, correct ?
>
Yes, this is correct for both struct watchdog_device and struct wdinfo.

> In that case (continue reading below) ...
>
>> -}
>> -
>>   static int watchdog_set_timeout(struct watchdog_device *wddev,
>>                   unsigned int timeout)
>>   {
>> @@ -395,28 +384,12 @@ static int watchdog_stop(struct watchdog_device *wddev)
>>       return 0;
>>   }
>>
>> -static void watchdog_ref(struct watchdog_device *wddev)
>> -{
>> -    struct sch56xx_watchdog_data *data = watchdog_get_drvdata(wddev);
>> -
>> -    kref_get(&data->kref);
>> -}
>> -
>> -static void watchdog_unref(struct watchdog_device *wddev)
>> -{
>> -    struct sch56xx_watchdog_data *data = watchdog_get_drvdata(wddev);
>> -
>> -    kref_put(&data->kref, watchdog_release_resources);
>> -}
>> -
>>   static const struct watchdog_ops watchdog_ops = {
>>       .owner        = THIS_MODULE,
>>       .start        = watchdog_start,
>>       .stop        = watchdog_stop,
>>       .ping        = watchdog_trigger,
>>       .set_timeout    = watchdog_set_timeout,
>> -    .ref        = watchdog_ref,
>> -    .unref        = watchdog_unref,
>>   };
>>
>>   struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
>> @@ -448,7 +421,6 @@ struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
>>
>>       data->addr = addr;
>>       data->io_lock = io_lock;
>> -    kref_init(&data->kref);
>>
>>       strlcpy(data->wdinfo.identity, "sch56xx watchdog",
>>           sizeof(data->wdinfo.identity));
>> @@ -494,8 +466,6 @@ EXPORT_SYMBOL(sch56xx_watchdog_register);
>>   void sch56xx_watchdog_unregister(struct sch56xx_watchdog_data *data)
>>   {
>>       watchdog_unregister_device(&data->wddev);
>> -    kref_put(&data->kref, watchdog_release_resources);
>> -    /* Don't touch data after this it may have been free-ed! */
>
> These 2 lines need to be replaced by a "kfree(data);" rather then being
> removed.
>
Good catch. Fixed.

>>   }
>>   EXPORT_SYMBOL(sch56xx_watchdog_unregister);
>>
>>
>
> Regards,
>
> Hans
>
>
> p.s.
>
> The patches for da9052_wdt and da9055_wdt are also interesting,
> their da905#_wdt_release_resources() functions are nops,
> making the entire refcounting exercise a nop.
>
> For da9052_wdt is the case since this commit:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/watchdog/da9052_wdt.c?id=0360dffedd7bad92f174b2ce5e69e960451d2b59

And for da9055 with commit ee8c94adff9b ("watchdog: da9055: Fix invalid free
of devm_ allocated data").

>
> Which fixes the bug it tries to fix in the wrong way, the right
> way would have been to change the devm_kzalloc to a regular kzalloc,
> since devm_*alloc cannot be used together with refcounting to keep
> memory alive after device unregister time.
>
> What this means is that these drivers actually have a bug wrt
> freeing in use memory on driver unbind while userspace has
> the watchdog cdev open, and this gets fixed by this patch-set,
> it would be very good to mention this in the commit messages.

Good point. I updated the commit log.

Thanks,
Guenter

