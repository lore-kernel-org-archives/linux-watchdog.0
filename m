Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45814 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbbLTSQm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 20 Dec 2015 13:16:42 -0500
Subject: Re: [char-misc-next v2 6/7] watchdog: mei_wdt: register wd device
 only if required
To: "Winkler, Tomas" <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
 <1450363780-30008-7-git-send-email-tomas.winkler@intel.com>
 <56743B3B.4080502@roeck-us.net>
 <5B8DA87D05A7694D9FA63FD143655C1B540EEA99@hasmsx108.ger.corp.intel.com>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5676F085.9040204@roeck-us.net>
Date: Sun, 20 Dec 2015 10:16:37 -0800
MIME-Version: 1.0
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B540EEA99@hasmsx108.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/20/2015 04:23 AM, Winkler, Tomas wrote:
>>
>> On 12/17/2015 06:49 AM, Tomas Winkler wrote:
>>> From: Alexander Usyskin <alexander.usyskin@intel.com>
>>>
>>> For Intel Broadwell and newer platforms, the ME device can inform
>>> the host whether the watchdog functionality is activated or not.
>>> If the watchdog functionality is not activated then the watchdog interface
>>> can be not registered and eliminate unnecessary pings and hence lower the
>>> power consumption by avoiding waking up the device.
>>>
>>> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
>>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>>> ---
>>> V2: rework unregistration
>>>
>>>    drivers/watchdog/mei_wdt.c | 180
>> +++++++++++++++++++++++++++++++++++++++++----
>>>    1 file changed, 167 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
>>> index a3f1c1613c32..00d1b8e630b7 100644
>>> --- a/drivers/watchdog/mei_wdt.c
>>> +++ b/drivers/watchdog/mei_wdt.c
>>> @@ -16,6 +16,7 @@
>>>    #include <linux/slab.h>
>>>    #include <linux/interrupt.h>
>>>    #include <linux/watchdog.h>
>>> +#include <linux/completion.h>
>>>    #include <linux/debugfs.h>
>>>
>>>    #include <linux/uuid.h>
>>> @@ -38,43 +39,54 @@
>>>
>>>    /* Sub Commands */
>>>    #define MEI_MC_START_WD_TIMER_REQ  0x13
>>> +#define MEI_MC_START_WD_TIMER_RES  0x83
>>> +#define   MEI_WDT_STATUS_SUCCESS 0
>>> +#define   MEI_WDT_WDSTATE_NOT_REQUIRED 0x1
>>>    #define MEI_MC_STOP_WD_TIMER_REQ   0x14
>>>
>>>    /**
>>>     * enum mei_wdt_state - internal watchdog state
>>>     *
>>> + * @MEI_WDT_PROBE: wd in probing stage
>>>     * @MEI_WDT_IDLE: wd is idle and not opened
>>>     * @MEI_WDT_START: wd was opened, start was called
>>>     * @MEI_WDT_RUNNING: wd is expecting keep alive pings
>>>     * @MEI_WDT_STOPPING: wd is stopping and will move to IDLE
>>> + * @MEI_WDT_NOT_REQUIRED: wd device is not required
>>>     */
>>>    enum mei_wdt_state {
>>> +	MEI_WDT_PROBE,
>>>    	MEI_WDT_IDLE,
>>>    	MEI_WDT_START,
>>>    	MEI_WDT_RUNNING,
>>>    	MEI_WDT_STOPPING,
>>> +	MEI_WDT_NOT_REQUIRED,
>>>    };
>>>
>>> -#if IS_ENABLED(CONFIG_DEBUG_FS)
>>>    static const char *mei_wdt_state_str(enum mei_wdt_state state)
>>>    {
>>>    	switch (state) {
>>> +	case MEI_WDT_PROBE: return "PROBE";
>>>    	case MEI_WDT_IDLE: return "IDLE";
>>>    	case MEI_WDT_START: return "START";
>>>    	case MEI_WDT_RUNNING: return "RUNNING";
>>>    	case MEI_WDT_STOPPING: return "STOPPING";
>>> +	case MEI_WDT_NOT_REQUIRED: return "NOT_REQUIRED";
>>>    	default: return "unknown";
>>>    	}
>>>    }
>>> -#endif /* CONFIG_DEBUG_FS */
>>>
>>>    /**
>>>     * struct mei_wdt - mei watchdog driver
>>>     * @wdd: watchdog device
>>>     * @refcnt: watchdog device reference counter
>>> + * @reg_lock: watchdog device registration lock
>>> + * @is_registered: is watchdog device registered
>>>     *
>>> - * @state: watchdog internal state
>>>     * @cldev: mei watchdog client device
>>> + * @state: watchdog internal state
>>> + * @resp_required: ping required response
>>> + * @response: ping response
>>>     * @timeout: watchdog current timeout
>>>     *
>>>     * @dbgfs_dir: debugfs dir entry
>>> @@ -82,9 +94,13 @@ static const char *mei_wdt_state_str(enum
>> mei_wdt_state state)
>>>    struct mei_wdt {
>>>    	struct watchdog_device wdd;
>>>    	struct kref refcnt;
>>> +	struct mutex reg_lock;
>>> +	bool   is_registered;
>>>
>>>    	struct mei_cl_device *cldev;
>>>    	enum mei_wdt_state state;
>>> +	bool resp_required;
>>> +	struct completion response;
>>>    	u16 timeout;
>>>
>>>    #if IS_ENABLED(CONFIG_DEBUG_FS)
>>> @@ -121,6 +137,19 @@ struct mei_wdt_start_request {
>>>    } __packed;
>>>
>>>    /**
>>> + * struct mei_wdt_start_response watchdog start/ping response
>>> + *
>>> + * @hdr: Management Control Command Header
>>> + * @status: operation status
>>> + * @wdstate: watchdog status bit mask
>>> + */
>>> +struct mei_wdt_start_response {
>>> +	struct mei_mc_hdr hdr;
>>> +	u8 status;
>>> +	u8 wdstate;
>>> +} __packed;
>>> +
>>> +/**
>>>     * struct mei_wdt_stop_request - watchdog stop
>>>     *
>>>     * @hdr: Management Control Command Header
>>> @@ -192,6 +221,23 @@ static void mei_wdt_release(struct kref *ref)
>>>    }
>>>
>>>    /**
>>> + * mei_wdt_unregister - unregister from the watchdog subsystem
>>> + *
>>> + * @wdt: mei watchdog device
>>> + */
>>> +static void mei_wdt_unregister(struct mei_wdt *wdt)
>>> +{
>>> +
>>> +	mutex_lock(&wdt->reg_lock);
>>> +	if (wdt->is_registered) {
>>> +		clear_bit(WDOG_ACTIVE, &wdt->wdd.status);
>>
>> WDOG_ACTIVE is commonly handled by the core. Why does it have to be
>> touched here ?
>
> This have to be cleaned otherwise we ops->start is won't be called on new open()
>
>> I am a bit concerned about the entire sequence.
>>
>> If the following happens
>>
>> - watchdog character device is opened
>> - watchdog goes away
>> - watchdog reappears
>> - watchdog character device is accessed
>
>
>> the code may access the driver through an old instance of the watchdog
>> character device. The behavior in this situation is pretty much undefined.
>> It may work, but only by luck, not by design.
>
> You won't get through as the file descriptor is stale, you have to open the device again.
> This should work by design, you have pluggable devices.

It can definitely happen today without the third step, ie

- watchdog is unregistered
- watchdog character device is accessed

is possible, making the ref/unref operations necessary, and the reason for
introducing WDOG_UNREGISTERED in the first place. See commit e907df327252.

I actually tested that condition. It _can_ happen.

>
>>
>>> +		watchdog_unregister_device(&wdt->wdd);
>>> +		wdt->is_registered = false;
>>> +	}
>>> +	mutex_unlock(&wdt->reg_lock);
>>> +}
>>> +
>>> +/**
>>>     * mei_wdt_register - register with the watchdog subsystem
>>>     *
>>>     * @wdt: mei watchdog device
>>> @@ -205,15 +251,20 @@ static int mei_wdt_register(struct mei_wdt *wdt)
>>>
>>>    	dev = &wdt->cldev->dev;
>>>
>>> -	watchdog_set_drvdata(&wdt->wdd, wdt);
>>> +	wdt->state = MEI_WDT_IDLE;
>>>
>>> +	mutex_lock(&wdt->reg_lock);
>>> +	clear_bit(WDOG_UNREGISTERED, &wdt->wdd.status);
>>
>> Please don't touch watchdog core internal states
>
> No choice here. This is a bit tricky bit. This is not cleared, by the core as fresh watchdog device upon registering
> I think in the overall design it would be cleaner if this flag would have positive logic. i.e.  WDOG_REGISTERED.
> The code would be simpler if I would be able just toggle this bit, but there is no event propagated to the user space on this change, so
> I prefer to remove the whole device as this is something already supported..
>
> - this flag will likely
>> go away soon
>
> We will have to deal with that when this happens.

Consider the case where the watchdog was removed, but the character device
(or misc device) file descriptor is still open. Now you clear this flag.
User space accesses the "stale" file descriptor right after your "clear" operation.
Since the flag is no longer set, the watchdog core doesn't know anymore that the
watchdog device is unregistered, and calls the driver functions, even though
the watchdog is still unregistered.

I don't know what happens if the watchdog is re-registered using the same character
device data structure, ie after cdev_init() is called on it again. Maybe a file access
using the "old" file descriptor is then rejected by the kernel, and it doesn't find
its way into the driver. Maybe I am missing it, but I don't immediately see where
the kernel would detect that situation. Instead, it seems to me that the kernel
holds a reference to the file operations until the device is closed/released.
And how would that close operation happen unless the kernel actually calls the fops
release function ? After all, the close operation _does_ have to call the watchdog
core, since the watchdog core calls module_put() as well as kref_put(), and clears
WDOG_DEV_OPEN.

Did you actually test that case ? That would actually be interesting to know for sure.

Another interesting case occurs after you unregistered the watchdog device, but
the character device is still open. Your code clears WATCHDOG_ACTIVE, meaning
the watchdog core will believe that the watchdog isn't running and won't even check
for other flags such as WDOG_ALLOW_RELEASE, or call the stop function, but will
just close the watchdog device unconditionally. That may well work with your driver,
but again relies on internal functionality and may have unexpected side effects
(such as that the WDOG_ALLOW_RELEASE flag won't be cleared).

Yet another interesting case occurs if the character device is still open after
the watchdog was unregistererd and re-registered. In that case, WDOG_DEV_OPEN
will still be set, so it will be impossible to open the watchdog device until
the old instance is closed. How would that close actually happen ? Do you rely
on the kernel detecting that the fd is stale when user space tries to use it,
and on calling the release function at that time ?

Either case, with the current watchdog core, there is no guarantee that 'struct
watchdog_device' is no longer in use by the watchdog core until the unref function
has been called. Until then, the watchdog core still "owns" the structure, and
you can not re-use it.

I am working on a set of patches to remedy that situation. With those patches,
the watchdog core will no longer use struct watchdog_device after the call to
watchdog_unregister_device, and you will be able to re-use it immediately.
But we are not there yet.

Overall, it may be better to allocate a new instance of struct watchdog_device
whenever you re-register the watchdog, to avoid all those problems. Sorry that
I didn't realize that earlier.

Guenter

