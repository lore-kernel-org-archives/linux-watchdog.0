Return-path: <tomasw@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5678AA13.8040708@roeck-us.net>
References: <1450645503-16661-1-git-send-email-linux@roeck-us.net>
	<1450645503-16661-3-git-send-email-linux@roeck-us.net>
	<20151221172815.GC12696@localhost>
	<CA+i0qc4-DZvFpOEyJBhMzi=HOc-KowNTf8tebTOh5oinav1S8A@mail.gmail.com>
	<5678AA13.8040708@roeck-us.net>
Date: Wed, 23 Dec 2015 00:05:04 +0200
Message-ID: <CA+i0qc6O9BJaJd-RrZhoTRUkkCohTjZxVccS=NC6JEUKYwvGPQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] watchdog: Separate and maintain variables based on
 variable lifetime
From: Tomas Winkler <tomasw@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Wim Van Sebroeck <wim@iguana.be>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>, Pratyush Anand <panand@redhat.com>
Content-Type: multipart/alternative; boundary=047d7ba97e503c1181052783cc82
List-ID: <linux-watchdog@vger.kernel.org>

--047d7ba97e503c1181052783cc82
Content-Type: text/plain; charset=UTF-8

On Dec 22, 2015 03:40, "Guenter Roeck" <linux@roeck-us.net> wrote:
>
> On 12/21/2015 03:36 PM, Tomas Winkler wrote:
>>
>> On Mon, Dec 21, 2015 at 7:28 PM, Damien Riegel
>> <damien.riegel@savoirfairelinux.com> wrote:
>>>
>>>
>>> On Sun, Dec 20, 2015 at 01:05:00PM -0800, Guenter Roeck wrote:
>>>>
>>>> All variables required by the watchdog core to manage a watchdog are
>>>> currently stored in struct watchdog_device. The lifetime of those
>>>> variables is determined by the watchdog driver. However, the lifetime
>>>> of variables used by the watchdog core differs from the lifetime of
>>>> struct watchdog_device. To remedy this situation, watchdog drivers
>>>> can implement ref and unref callbacks, to be used by the watchdog
>>>> core to lock struct watchdog_device in memory.
>>>>
>>>> While this solves the immediate problem, it depends on watchdog drivers
>>>> to actually implement the ref/unref callbacks. This is error prone,
>>>> often not implemented in the first place, or not implemented correctly.
>>>>
>>>> To solve the problem without requiring driver support, split the
variables
>>>> in struct watchdog_device into two data structures - one for variables
>>>> associated with the watchdog driver, one for variables associated with
>>>> the watchdog core. With this approach, the watchdog core can keep track
>>>> of its variable lifetime and no longer depends on ref/unref callbacks
>>>> in the driver. As a side effect, some of the variables originally in
>>>> struct watchdog_driver are now private to the watchdog core and no
longer
>>>> visible in watchdog drivers.
>>>>
>>>> The 'ref' and 'unref' callbacks in struct watchdog_driver are no longer
>>>> used and marked as deprecated.
>>>
>>>
>>> Two comments below. It's great to see that unbinding a driver no longer
>>> triggers a kernel panic.
>>>
>>>>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>>   Documentation/watchdog/watchdog-kernel-api.txt |  45 +--
>>>>   drivers/watchdog/watchdog_core.c               |   2 -
>>>>   drivers/watchdog/watchdog_core.h               |  23 ++
>>>>   drivers/watchdog/watchdog_dev.c                | 377
+++++++++++++------------
>>>>   include/linux/watchdog.h                       |  21 +-
>>>>   5 files changed, 239 insertions(+), 229 deletions(-)
>>>>
>>>> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt
b/Documentation/watchdog/watchdog-kernel-api.txt
>>>> index 0a37da76acef..3db5092924e5 100644
>>>> --- a/Documentation/watchdog/watchdog-kernel-api.txt
>>>> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
>>>> @@ -44,7 +44,6 @@ The watchdog device structure looks like this:
>>>>
>>>>   struct watchdog_device {
>>>>        int id;
>>>> -     struct cdev cdev;
>>>>        struct device *dev;
>>>>        struct device *parent;
>>>>        const struct watchdog_info *info;
>>>> @@ -56,7 +55,7 @@ struct watchdog_device {
>>>>        struct notifier_block reboot_nb;
>>>>        struct notifier_block restart_nb;
>>>>        void *driver_data;
>>>> -     struct mutex lock;
>>>> +     void *wdd_data;
>>>>        unsigned long status;
>>>>        struct list_head deferred;
>>>>   };
>>>> @@ -66,8 +65,6 @@ It contains following fields:
>>>>     /dev/watchdog0 cdev (dynamic major, minor 0) as well as the old
>>>>     /dev/watchdog miscdev. The id is set automatically when calling
>>>>     watchdog_register_device.
>>>> -* cdev: cdev for the dynamic /dev/watchdog<id> device nodes. This
>>>> -  field is also populated by watchdog_register_device.
>>>>   * dev: device under the watchdog class (created by
watchdog_register_device).
>>>>   * parent: set this to the parent device (or NULL) before calling
>>>>     watchdog_register_device.
>>>> @@ -89,11 +86,10 @@ It contains following fields:
>>>>   * driver_data: a pointer to the drivers private data of a watchdog
device.
>>>>     This data should only be accessed via the watchdog_set_drvdata and
>>>>     watchdog_get_drvdata routines.
>>>> -* lock: Mutex for WatchDog Timer Driver Core internal use only.
>>>> +* wdd_data: a pointer to watchdog core internal data.
>>>>   * status: this field contains a number of status bits that give extra
>>>>     information about the status of the device (Like: is the watchdog
timer
>>>> -  running/active, is the nowayout bit set, is the device opened via
>>>> -  the /dev/watchdog interface or not, ...).
>>>> +  running/active, or is the nowayout bit set).
>>>>   * deferred: entry in wtd_deferred_reg_list which is used to
>>>>     register early initialized watchdogs.
>>>>
>>>> @@ -110,8 +106,8 @@ struct watchdog_ops {
>>>>        int (*set_timeout)(struct watchdog_device *, unsigned int);
>>>>        unsigned int (*get_timeleft)(struct watchdog_device *);
>>>>        int (*restart)(struct watchdog_device *);
>>>> -     void (*ref)(struct watchdog_device *);
>>>> -     void (*unref)(struct watchdog_device *);
>>>> +     void (*ref)(struct watchdog_device *) __deprecated;
>>>> +     void (*unref)(struct watchdog_device *) __deprecated;
>>>>        long (*ioctl)(struct watchdog_device *, unsigned int, unsigned
long);
>>>>   };
>>>>
>>>> @@ -120,20 +116,6 @@ driver's operations. This module owner will be
used to lock the module when
>>>>   the watchdog is active. (This to avoid a system crash when you
unload the
>>>>   module and /dev/watchdog is still open).
>>>>
>>>> -If the watchdog_device struct is dynamically allocated, just locking
the module
>>>> -is not enough and a driver also needs to define the ref and unref
operations to
>>>> -ensure the structure holding the watchdog_device does not go away.
>>>> -
>>>> -The simplest (and usually sufficient) implementation of this is to:
>>>> -1) Add a kref struct to the same structure which is holding the
watchdog_device
>>>> -2) Define a release callback for the kref which frees the struct
holding both
>>>> -3) Call kref_init on this kref *before* calling
watchdog_register_device()
>>>> -4) Define a ref operation calling kref_get on this kref
>>>> -5) Define a unref operation calling kref_put on this kref
>>>> -6) When it is time to cleanup:
>>>> - * Do not kfree() the struct holding both, the last kref_put will do
this!
>>>> - * *After* calling watchdog_unregister_device() call kref_put on the
kref
>>>> -
>>>>   Some operations are mandatory and some are optional. The mandatory
operations
>>>>   are:
>>>>   * start: this is a pointer to the routine that starts the watchdog
timer
>>>> @@ -176,34 +158,21 @@ they are supported. These optional
routines/operations are:
>>>>   * get_timeleft: this routines returns the time that's left before a
reset.
>>>>   * restart: this routine restarts the machine. It returns 0 on
success or a
>>>>     negative errno code for failure.
>>>> -* ref: the operation that calls kref_get on the kref of a dynamically
>>>> -  allocated watchdog_device struct.
>>>> -* unref: the operation that calls kref_put on the kref of a
dynamically
>>>> -  allocated watchdog_device struct.
>>>>   * ioctl: if this routine is present then it will be called first
before we do
>>>>     our own internal ioctl call handling. This routine should return
-ENOIOCTLCMD
>>>>     if a command is not supported. The parameters that are passed to
the ioctl
>>>>     call are: watchdog_device, cmd and arg.
>>>>
>>>> +The 'ref' and 'unref' operations are no longer used and deprecated.
>>>> +
>>>>   The status bits should (preferably) be set with the set_bit and
clear_bit alike
>>>>   bit-operations. The status bits that are defined are:
>>>>   * WDOG_ACTIVE: this status bit indicates whether or not a watchdog
timer device
>>>>     is active or not. When the watchdog is active after booting, then
you should
>>>>     set this status bit (Note: when you register the watchdog timer
device with
>>>>     this bit set, then opening /dev/watchdog will skip the start
operation)
>>>> -* WDOG_DEV_OPEN: this status bit shows whether or not the watchdog
device
>>>> -  was opened via /dev/watchdog.
>>>> -  (This bit should only be used by the WatchDog Timer Driver Core).
>>>> -* WDOG_ALLOW_RELEASE: this bit stores whether or not the magic close
character
>>>> -  has been sent (so that we can support the magic close feature).
>>>> -  (This bit should only be used by the WatchDog Timer Driver Core).
>>>>   * WDOG_NO_WAY_OUT: this bit stores the nowayout setting for the
watchdog.
>>>>     If this bit is set then the watchdog timer will not be able to
stop.
>>>> -* WDOG_UNREGISTERED: this bit gets set by the WatchDog Timer Driver
Core
>>>> -  after calling watchdog_unregister_device, and then checked before
calling
>>>> -  any watchdog_ops, so that you can be sure that no operations (other
then
>>>> -  unref) will get called after unregister, even if userspace still
holds a
>>>> -  reference to /dev/watchdog
>>>>
>>>>     To set the WDOG_NO_WAY_OUT status bit (before registering your
watchdog
>>>>     timer device) you can either:
>>>> diff --git a/drivers/watchdog/watchdog_core.c
b/drivers/watchdog/watchdog_core.c
>>>> index f0293f7d2b80..ec1ab6c1a80b 100644
>>>> --- a/drivers/watchdog/watchdog_core.c
>>>> +++ b/drivers/watchdog/watchdog_core.c
>>>> @@ -210,8 +210,6 @@ static int __watchdog_register_device(struct
watchdog_device *wdd)
>>>>         * corrupted in a later stage then we expect a kernel panic!
>>>>         */
>>>>
>>>> -     mutex_init(&wdd->lock);
>>>> -
>>>>        /* Use alias for watchdog id if possible */
>>>>        if (wdd->parent) {
>>>>                ret = of_alias_get_id(wdd->parent->of_node, "watchdog");
>>>> diff --git a/drivers/watchdog/watchdog_core.h
b/drivers/watchdog/watchdog_core.h
>>>> index 86ff962d1e15..c9b0656284de 100644
>>>> --- a/drivers/watchdog/watchdog_core.h
>>>> +++ b/drivers/watchdog/watchdog_core.h
>>>> @@ -26,9 +26,32 @@
>>>>    *   This material is provided "AS-IS" and at no charge.
>>>>    */
>>>>
>>>> +#include <linux/cdev.h>
>>>> +#include <linux/kref.h>
>>>> +#include <linux/mutex.h>
>>>> +#include <linux/watchdog.h>
>>>> +
>>>>   #define MAX_DOGS     32      /* Maximum number of watchdog devices */
>>>>
>>>>   /*
>>>> + * struct _watchdog_device - watchdog core internal data
>>>
>>>
>>> Think it should be /**. Anyway, I find it confusing to have both
>>> _watchdog_device and watchdog_device, but I can't think of a better
>>> name right now.
>>>
>>>> + * @kref:    Reference count.
>>>> + * @cdev:    The watchdog's Character device.
>>>> + * @wdd:     Pointer to watchdog device.
>>>> + * @lock:    Lock for watchdog core.
>>>> + * @status:  Watchdog core internal status bits.
>>>> + */
>>>> +struct _watchdog_device {
>>
>> We should probably find a better name for this structure... watchdog
>> _adapter, _descriptor, or even _data
>> Also this style is quite confusing when __func() is wrapping func(),
>> usually this would be otherway around
>>
>
> I ended up using watchdog_data. I also moved the data structure into
> watchdog_dev.c, as it is only used there.
>
>
>>>> +     struct kref kref;
>>>> +     struct cdev cdev;
>>>> +     struct watchdog_device *wdd;
>>>> +     struct mutex lock;
>>>> +     unsigned long status;           /* Internal status bits */
>>>> +#define _WDOG_DEV_OPEN               0       /* Opened ? */
>>>> +#define _WDOG_ALLOW_RELEASE  1       /* Did we receive the magic char
? */
>>>> +};
>>>> +
>>>> +/*
>>>>    *   Functions/procedures to be called by the core
>>>>    */
>>>>   extern int watchdog_dev_register(struct watchdog_device *);
>>>> diff --git a/drivers/watchdog/watchdog_dev.c
b/drivers/watchdog/watchdog_dev.c
>>>> index c24392623e98..e8416bdc7037 100644
>>>> --- a/drivers/watchdog/watchdog_dev.c
>>>> +++ b/drivers/watchdog/watchdog_dev.c
>>>> @@ -37,6 +37,7 @@
>>>>   #include <linux/errno.h>     /* For the -ENODEV/... values */
>>>>   #include <linux/kernel.h>    /* For printk/panic/... */
>>>>   #include <linux/fs.h>                /* For file operations */
>>>> +#include <linux/slab.h>              /* For memory functions */
>>>>   #include <linux/watchdog.h>  /* For watchdog specific items */
>>>>   #include <linux/miscdevice.h>        /* For handling misc devices */
>>>>   #include <linux/init.h>              /* For __init/__exit/... */
>>>> @@ -47,12 +48,14 @@
>>>>   /* the dev_t structure to store the dynamically allocated watchdog
devices */
>>>>   static dev_t watchdog_devt;
>>>>   /* the watchdog device behind /dev/watchdog */
>>>> -static struct watchdog_device *old_wdd;
>>>> +static struct _watchdog_device *_old_wdd;
>>>>
>>>>   /*
>>>>    *   watchdog_ping: ping the watchdog.
>>>>    *   @wdd: the watchdog device to ping
>>>>    *
>>>> + *   The caller must hold _wdd->lock.
>>>> + *
>>>>    *   If the watchdog has no own ping operation then it needs to be
>>>>    *   restarted via the start operation. This wrapper function does
>>>>    *   exactly that.
>>>> @@ -61,25 +64,37 @@ static struct watchdog_device *old_wdd;
>>>>
>>>>   static int watchdog_ping(struct watchdog_device *wdd)
>>>>   {
>>
>> Not sure this lockless wrappers are really needed.
>
>
> I dropped _watchdog_ping() and handle locking from the calling code.
>
>
>>>> -     int err = 0;
>>>> -
>>>> -     mutex_lock(&wdd->lock);
>>>> -
>>>> -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
>>>> -             err = -ENODEV;
>>>> -             goto out_ping;
>>>> -     }
>>>> +     int err;
>>>>
>>>>        if (!watchdog_active(wdd))
>>>> -             goto out_ping;
>>>> +             return 0;
>>>>
>>>>        if (wdd->ops->ping)
>>>>                err = wdd->ops->ping(wdd);      /* ping the watchdog */
>>>>        else
>>>>                err = wdd->ops->start(wdd);     /* restart watchdog */
>>>>
>>>> -out_ping:
>>>> -     mutex_unlock(&wdd->lock);
>>>> +     return err;
>>>> +}
>>>> +
>>>> +/*
>>>> + *   _watchdog_ping: ping the watchdog.
>>>> + *   @_wdd: Watchdog core device data
>>>> + *
>>>> + *   Acquire _wdd->lock and call watchdog_ping() unless the watchdog
>>>> + *   driver has been unregistered.
>>>> + */
>>>> +static int _watchdog_ping(struct _watchdog_device *_wdd)
>>
>> Use of double underscore __ is more comon .
>
>
> As mentioned above, I ended up dropping the function entirely.
>
>
>>>> +{
>>>> +     struct watchdog_device *wdd;
>>>> +     int err = -ENODEV;
>>>> +
>>>> +     mutex_lock(&_wdd->lock);
>>>> +     wdd = _wdd->wdd;
>>>> +     if (wdd)
>>>> +             err = watchdog_ping(wdd);
>>>> +     mutex_unlock(&_wdd->lock);
>>>> +
>>>>        return err;
>>>>   }
>>>>
>>>> @@ -87,6 +102,8 @@ out_ping:
>>>>    *   watchdog_start: wrapper to start the watchdog.
>>>>    *   @wdd: the watchdog device to start
>>>>    *
>>>> + *   The caller must hold _wdd->lock.
>>>> + *
>>>>    *   Start the watchdog if it is not active and mark it active.
>>>>    *   This function returns zero on success or a negative errno code
for
>>>>    *   failure.
>>>> @@ -94,24 +111,15 @@ out_ping:
>>>>
>>>>   static int watchdog_start(struct watchdog_device *wdd)
>>>>   {
>>>> -     int err = 0;
>>>> -
>>>> -     mutex_lock(&wdd->lock);
>>>> -
>>>> -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
>>>> -             err = -ENODEV;
>>>> -             goto out_start;
>>>> -     }
>>>> +     int err;
>>>>
>>>>        if (watchdog_active(wdd))
>>>> -             goto out_start;
>>>> +             return 0;
>>>>
>>>>        err = wdd->ops->start(wdd);
>>>>        if (err == 0)
>>>>                set_bit(WDOG_ACTIVE, &wdd->status);
>>>>
>>>> -out_start:
>>>> -     mutex_unlock(&wdd->lock);
>>>>        return err;
>>>>   }
>>>>
>>>> @@ -119,6 +127,8 @@ out_start:
>>>>    *   watchdog_stop: wrapper to stop the watchdog.
>>>>    *   @wdd: the watchdog device to stop
>>>>    *
>>>> + *   The caller must hold _wdd->lock.
>>>> + *
>>>>    *   Stop the watchdog if it is still active and unmark it active.
>>>>    *   This function returns zero on success or a negative errno code
for
>>>>    *   failure.
>>>> @@ -127,93 +137,58 @@ out_start:
>>>>
>>>>   static int watchdog_stop(struct watchdog_device *wdd)
>>>>   {
>>>> -     int err = 0;
>>>> -
>>>> -     mutex_lock(&wdd->lock);
>>>> -
>>>> -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
>>>> -             err = -ENODEV;
>>>> -             goto out_stop;
>>>> -     }
>>>> +     int err;
>>>>
>>>>        if (!watchdog_active(wdd))
>>>> -             goto out_stop;
>>>> +             return 0;
>>>>
>>>>        if (test_bit(WDOG_NO_WAY_OUT, &wdd->status)) {
>>>>                dev_info(wdd->dev, "nowayout prevents watchdog being
stopped!\n");
>>>> -             err = -EBUSY;
>>>> -             goto out_stop;
>>>> +             return -EBUSY;
>>>>        }
>>>>
>>>>        err = wdd->ops->stop(wdd);
>>>>        if (err == 0)
>>>>                clear_bit(WDOG_ACTIVE, &wdd->status);
>>>>
>>>> -out_stop:
>>>> -     mutex_unlock(&wdd->lock);
>>>>        return err;
>>>>   }
>>>>
>>>>   /*
>>>>    *   watchdog_get_status: wrapper to get the watchdog status
>>>>    *   @wdd: the watchdog device to get the status from
>>>> - *   @status: the status of the watchdog device
>>>> + *
>>>> + *   The caller must hold _wdd->lock.
>>>>    *
>>>>    *   Get the watchdog's status flags.
>>>>    */
>>>>
>>>> -static int watchdog_get_status(struct watchdog_device *wdd,
>>>> -                                                     unsigned int
*status)
>>>> +static unsigned int watchdog_get_status(struct watchdog_device *wdd)
>>>>   {
>>>> -     int err = 0;
>>>> -
>>>> -     *status = 0;
>>>>        if (!wdd->ops->status)
>>>> -             return -EOPNOTSUPP;
>>>> -
>>>> -     mutex_lock(&wdd->lock);
>>>> -
>>>> -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
>>>> -             err = -ENODEV;
>>>> -             goto out_status;
>>>> -     }
>>>> -
>>>> -     *status = wdd->ops->status(wdd);
>>>> +             return 0;
>>>>
>>>> -out_status:
>>>> -     mutex_unlock(&wdd->lock);
>>>> -     return err;
>>>> +     return wdd->ops->status(wdd);
>>>>   }
>>>>
>>>>   /*
>>>>    *   watchdog_set_timeout: set the watchdog timer timeout
>>>>    *   @wdd: the watchdog device to set the timeout for
>>>>    *   @timeout: timeout to set in seconds
>>>> + *
>>>> + *   The caller must hold _wdd->lock.
>>>>    */
>>>>
>>>>   static int watchdog_set_timeout(struct watchdog_device *wdd,
>>>>                                                        unsigned int
timeout)
>>>>   {
>>>> -     int err;
>>>> -
>>>>        if (!wdd->ops->set_timeout || !(wdd->info->options &
WDIOF_SETTIMEOUT))
>>>>                return -EOPNOTSUPP;
>>>>
>>>>        if (watchdog_timeout_invalid(wdd, timeout))
>>>>                return -EINVAL;
>>>>
>>>> -     mutex_lock(&wdd->lock);
>>>> -
>>>> -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
>>>> -             err = -ENODEV;
>>>> -             goto out_timeout;
>>>> -     }
>>>> -
>>>> -     err = wdd->ops->set_timeout(wdd, timeout);
>>>> -
>>>> -out_timeout:
>>>> -     mutex_unlock(&wdd->lock);
>>>> -     return err;
>>>> +     return wdd->ops->set_timeout(wdd, timeout);
>>>>   }
>>>>
>>>>   /*
>>>> @@ -221,30 +196,22 @@ out_timeout:
>>>>    *   @wdd: the watchdog device to get the remaining time from
>>>>    *   @timeleft: the time that's left
>>>>    *
>>>> + *   The caller must hold _wdd->lock.
>>>> + *
>>>>    *   Get the time before a watchdog will reboot (if not pinged).
>>>>    */
>>>>
>>>>   static int watchdog_get_timeleft(struct watchdog_device *wdd,
>>>>                                                        unsigned int
*timeleft)
>>>>   {
>>>> -     int err = 0;
>>>> -
>>>>        *timeleft = 0;
>>>> +
>>>>        if (!wdd->ops->get_timeleft)
>>>>                return -EOPNOTSUPP;
>>>>
>>>> -     mutex_lock(&wdd->lock);
>>>> -
>>>> -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
>>>> -             err = -ENODEV;
>>>> -             goto out_timeleft;
>>>> -     }
>>>> -
>>>>        *timeleft = wdd->ops->get_timeleft(wdd);
>>>>
>>>> -out_timeleft:
>>>> -     mutex_unlock(&wdd->lock);
>>>> -     return err;
>>>> +     return 0;
>>>>   }
>>>>
>>>>   #ifdef CONFIG_WATCHDOG_SYSFS
>>>> @@ -261,14 +228,14 @@ static ssize_t status_show(struct device *dev,
struct device_attribute *attr,
>>>>                                char *buf)
>>>>   {
>>>>        struct watchdog_device *wdd = dev_get_drvdata(dev);
>>>> -     ssize_t status;
>>>> -     unsigned int val;
>>>> +     struct _watchdog_device *_wdd = wdd->wdd_data;
>>>> +     unsigned int status;
>>>>
>>>> -     status = watchdog_get_status(wdd, &val);
>>>> -     if (!status)
>>>> -             status = sprintf(buf, "%u\n", val);
>>>> +     mutex_lock(&_wdd->lock);
>>>> +     status = watchdog_get_status(wdd);
>>>> +     mutex_unlock(&_wdd->lock);
>>>>
>>>> -     return status;
>>>> +     return sprintf(buf, "%u\n", status);
>>>>   }
>>>>   static DEVICE_ATTR_RO(status);
>>>>
>>>> @@ -285,10 +252,13 @@ static ssize_t timeleft_show(struct device *dev,
struct device_attribute *attr,
>>>>                                char *buf)
>>>>   {
>>>>        struct watchdog_device *wdd = dev_get_drvdata(dev);
>>>> +     struct _watchdog_device *_wdd = wdd->wdd_data;
>>>>        ssize_t status;
>>>>        unsigned int val;
>>>>
>>>> +     mutex_lock(&_wdd->lock);
>>>>        status = watchdog_get_timeleft(wdd, &val);
>>>> +     mutex_unlock(&_wdd->lock);
>>>>        if (!status)
>>>>                status = sprintf(buf, "%u\n", val);
>>>>
>>>> @@ -363,28 +333,17 @@ __ATTRIBUTE_GROUPS(wdt);
>>>>    *   @wdd: the watchdog device to do the ioctl on
>>>>    *   @cmd: watchdog command
>>>>    *   @arg: argument pointer
>>>> + *
>>>> + *   The caller must hold _wdd->lock.
>>>>    */
>>>>
>>>>   static int watchdog_ioctl_op(struct watchdog_device *wdd, unsigned
int cmd,
>>>>                                                        unsigned long
arg)
>>>>   {
>>>> -     int err;
>>>> -
>>>>        if (!wdd->ops->ioctl)
>>>>                return -ENOIOCTLCMD;
>>>>
>>>> -     mutex_lock(&wdd->lock);
>>>> -
>>>> -     if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
>>>> -             err = -ENODEV;
>>>> -             goto out_ioctl;
>>>> -     }
>>>> -
>>>> -     err = wdd->ops->ioctl(wdd, cmd, arg);
>>>> -
>>>> -out_ioctl:
>>>> -     mutex_unlock(&wdd->lock);
>>>> -     return err;
>>>> +     return wdd->ops->ioctl(wdd, cmd, arg);
>>>>   }
>>>>
>>>>   /*
>>>> @@ -402,7 +361,7 @@ out_ioctl:
>>>>   static ssize_t watchdog_write(struct file *file, const char __user
*data,
>>>>                                                size_t len, loff_t
*ppos)
>>>>   {
>>>> -     struct watchdog_device *wdd = file->private_data;
>>>> +     struct _watchdog_device *_wdd = file->private_data;
>>>>        size_t i;
>>>>        char c;
>>>>        int err;
>>>> @@ -414,18 +373,18 @@ static ssize_t watchdog_write(struct file *file,
const char __user *data,
>>>>         * Note: just in case someone wrote the magic character
>>>>         * five months ago...
>>>>         */
>>>> -     clear_bit(WDOG_ALLOW_RELEASE, &wdd->status);
>>>> +     clear_bit(_WDOG_ALLOW_RELEASE, &_wdd->status);
>>>>
>>>>        /* scan to see whether or not we got the magic character */
>>>>        for (i = 0; i != len; i++) {
>>>>                if (get_user(c, data + i))
>>>>                        return -EFAULT;
>>>>                if (c == 'V')
>>>> -                     set_bit(WDOG_ALLOW_RELEASE, &wdd->status);
>>>> +                     set_bit(_WDOG_ALLOW_RELEASE, &_wdd->status);
>>>>        }
>>>>
>>>>        /* someone wrote to us, so we send the watchdog a keepalive
ping */
>>>> -     err = watchdog_ping(wdd);
>>>> +     err = _watchdog_ping(_wdd);
>>>>        if (err < 0)
>>>>                return err;
>>>>
>>>> @@ -445,71 +404,94 @@ static ssize_t watchdog_write(struct file *file,
const char __user *data,
>>>>   static long watchdog_ioctl(struct file *file, unsigned int cmd,
>>>>                                                        unsigned long
arg)
>>>>   {
>>>> -     struct watchdog_device *wdd = file->private_data;
>>>> +     struct _watchdog_device *_wdd = file->private_data;
>>>>        void __user *argp = (void __user *)arg;
>>>> +     struct watchdog_device *wdd;
>>>>        int __user *p = argp;
>>>>        unsigned int val;
>>>> -     int err;
>>>> +     int err = 0;
>>>> +
>>>> +     mutex_lock(&_wdd->lock);
>>>> +
>>>> +     wdd = _wdd->wdd;
>>>> +     if (!wdd) {
>>>> +             err = -ENODEV;
>>>> +             goto out_ioctl;
>>>> +     }
>>>>
>>>>        err = watchdog_ioctl_op(wdd, cmd, arg);
>>>>        if (err != -ENOIOCTLCMD)
>>>> -             return err;
>>>> +             goto out_ioctl;
>>>>
>>>>        switch (cmd) {
>>>>        case WDIOC_GETSUPPORT:
>>>> -             return copy_to_user(argp, wdd->info,
>>>> +             err = copy_to_user(argp, wdd->info,
>>>>                        sizeof(struct watchdog_info)) ? -EFAULT : 0;
>>>> +             break;
>>>>        case WDIOC_GETSTATUS:
>>>> -             err = watchdog_get_status(wdd, &val);
>>>> -             if (err == -ENODEV)
>>>> -                     return err;
>>>> -             return put_user(val, p);
>>>> +             val = watchdog_get_status(wdd);
>>>> +             err = put_user(val, p);
>>>> +             break;
>>>>        case WDIOC_GETBOOTSTATUS:
>>>> -             return put_user(wdd->bootstatus, p);
>>>> +             err = put_user(wdd->bootstatus, p);
>>>> +             break;
>>>>        case WDIOC_SETOPTIONS:
>>>> -             if (get_user(val, p))
>>>> -                     return -EFAULT;
>>>> +             if (get_user(val, p)) {
>>>> +                     err = -EFAULT;
>>>> +                     break;
>>>> +             }
>>>>                if (val & WDIOS_DISABLECARD) {
>>>>                        err = watchdog_stop(wdd);
>>>>                        if (err < 0)
>>>> -                             return err;
>>>> +                             break;
>>>>                }
>>>> -             if (val & WDIOS_ENABLECARD) {
>>>> +             if (val & WDIOS_ENABLECARD)
>>>>                        err = watchdog_start(wdd);
>>>> -                     if (err < 0)
>>>> -                             return err;
>>>> -             }
>>>> -             return 0;
>>>> +             break;
>>>>        case WDIOC_KEEPALIVE:
>>>> -             if (!(wdd->info->options & WDIOF_KEEPALIVEPING))
>>>> -                     return -EOPNOTSUPP;
>>>> -             return watchdog_ping(wdd);
>>>> +             if (!(wdd->info->options & WDIOF_KEEPALIVEPING)) {
>>>> +                     err = -EOPNOTSUPP;
>>>> +                     break;
>>>> +             }
>>>> +             err = watchdog_ping(wdd);
>>>> +             break;
>>>>        case WDIOC_SETTIMEOUT:
>>>> -             if (get_user(val, p))
>>>> -                     return -EFAULT;
>>>> +             if (get_user(val, p)) {
>>>> +                     err = -EFAULT;
>>>> +                     break;
>>>> +             }
>>>>                err = watchdog_set_timeout(wdd, val);
>>>>                if (err < 0)
>>>> -                     return err;
>>>> +                     break;
>>>>                /* If the watchdog is active then we send a keepalive
ping
>>>>                 * to make sure that the watchdog keep's running (and if
>>>>                 * possible that it takes the new timeout) */
>>>>                err = watchdog_ping(wdd);
>>>>                if (err < 0)
>>>> -                     return err;
>>>> +                     break;
>>
>> You are changing behaviour for the driver here as you are keeping lock
>> over two driver op calls.
>
>
> Yes, but the alternative (unlock, lock again, and check again if the
> watchdog was unregistered) would be awkward, and I don't see where
> this can be a problem.
Maybe there is not but this is something to mention in the commit message.

> Do you see a situation where holding the lock between calls into the
driver
> might be a problem ?

I don't think u are holding the lock now in watchdog_unregister when
WDOG_UNREGISTERED was dropped.
>
>
>>>>                /* Fall */
>>>>        case WDIOC_GETTIMEOUT:
>>>>                /* timeout == 0 means that we don't know the timeout */
>>>> -             if (wdd->timeout == 0)
>>>> -                     return -EOPNOTSUPP;
>>>> -             return put_user(wdd->timeout, p);
>>>> +             if (wdd->timeout == 0) {
>>>> +                     err = -EOPNOTSUPP;
>>>> +                     break;
>>>> +             }
>>>> +             err = put_user(wdd->timeout, p);
>
>
> This is another semantics change - the old code would succeed here if
> the watchdog device was unregistered, unless the driver implements an
> ioctl command. Now it fails with -ENODEV. This is also true for some
> of the other ioctls above. I'll mention that in the commit log.
>
> The alternative would be to keep the locking in the wrapper functions,
> but I think the code is cleaner and more consistent this way.
>
> Thanks,
> Guenter
>

--047d7ba97e503c1181052783cc82
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Dec 22, 2015 03:40, &quot;Guenter Roeck&quot; &lt;<a href=3D"mailto:linu=
x@roeck-us.net">linux@roeck-us.net</a>&gt; wrote:<br>
&gt;<br>
&gt; On 12/21/2015 03:36 PM, Tomas Winkler wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Dec 21, 2015 at 7:28 PM, Damien Riegel<br>
&gt;&gt; &lt;<a href=3D"mailto:damien.riegel@savoirfairelinux.com">damien.r=
iegel@savoirfairelinux.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Sun, Dec 20, 2015 at 01:05:00PM -0800, Guenter Roeck wrote:=
<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; All variables required by the watchdog core to manage a wa=
tchdog are<br>
&gt;&gt;&gt;&gt; currently stored in struct watchdog_device. The lifetime o=
f those<br>
&gt;&gt;&gt;&gt; variables is determined by the watchdog driver. However, t=
he lifetime<br>
&gt;&gt;&gt;&gt; of variables used by the watchdog core differs from the li=
fetime of<br>
&gt;&gt;&gt;&gt; struct watchdog_device. To remedy this situation, watchdog=
 drivers<br>
&gt;&gt;&gt;&gt; can implement ref and unref callbacks, to be used by the w=
atchdog<br>
&gt;&gt;&gt;&gt; core to lock struct watchdog_device in memory.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; While this solves the immediate problem, it depends on wat=
chdog drivers<br>
&gt;&gt;&gt;&gt; to actually implement the ref/unref callbacks. This is err=
or prone,<br>
&gt;&gt;&gt;&gt; often not implemented in the first place, or not implement=
ed correctly.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; To solve the problem without requiring driver support, spl=
it the variables<br>
&gt;&gt;&gt;&gt; in struct watchdog_device into two data structures - one f=
or variables<br>
&gt;&gt;&gt;&gt; associated with the watchdog driver, one for variables ass=
ociated with<br>
&gt;&gt;&gt;&gt; the watchdog core. With this approach, the watchdog core c=
an keep track<br>
&gt;&gt;&gt;&gt; of its variable lifetime and no longer depends on ref/unre=
f callbacks<br>
&gt;&gt;&gt;&gt; in the driver. As a side effect, some of the variables ori=
ginally in<br>
&gt;&gt;&gt;&gt; struct watchdog_driver are now private to the watchdog cor=
e and no longer<br>
&gt;&gt;&gt;&gt; visible in watchdog drivers.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; The &#39;ref&#39; and &#39;unref&#39; callbacks in struct =
watchdog_driver are no longer<br>
&gt;&gt;&gt;&gt; used and marked as deprecated.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Two comments below. It&#39;s great to see that unbinding a dri=
ver no longer<br>
&gt;&gt;&gt; triggers a kernel panic.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Guenter Roeck &lt;<a href=3D"mailto:linux@r=
oeck-us.net">linux@roeck-us.net</a>&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt; =C2=A0 Documentation/watchdog/watchdog-kernel-api.txt |=C2=
=A0 45 +--<br>
&gt;&gt;&gt;&gt; =C2=A0 drivers/watchdog/watchdog_core.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 -<br>
&gt;&gt;&gt;&gt; =C2=A0 drivers/watchdog/watchdog_core.h=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 23 ++<br>
&gt;&gt;&gt;&gt; =C2=A0 drivers/watchdog/watchdog_dev.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 377 +++++++++++++------------<br>
&gt;&gt;&gt;&gt; =C2=A0 include/linux/watchdog.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 21 +-<br>
&gt;&gt;&gt;&gt; =C2=A0 5 files changed, 239 insertions(+), 229 deletions(-=
)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/Documentation/watchdog/watchdog-kernel-api.tx=
t b/Documentation/watchdog/watchdog-kernel-api.txt<br>
&gt;&gt;&gt;&gt; index 0a37da76acef..3db5092924e5 100644<br>
&gt;&gt;&gt;&gt; --- a/Documentation/watchdog/watchdog-kernel-api.txt<br>
&gt;&gt;&gt;&gt; +++ b/Documentation/watchdog/watchdog-kernel-api.txt<br>
&gt;&gt;&gt;&gt; @@ -44,7 +44,6 @@ The watchdog device structure looks like=
 this:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 struct watchdog_device {<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0int id;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0struct cdev cdev;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *parent;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct watchdog_info *inf=
o;<br>
&gt;&gt;&gt;&gt; @@ -56,7 +55,7 @@ struct watchdog_device {<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0struct notifier_block reboot_nb=
;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0struct notifier_block restart_n=
b;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0void *driver_data;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0struct mutex lock;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0void *wdd_data;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long status;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head deferred;<br>
&gt;&gt;&gt;&gt; =C2=A0 };<br>
&gt;&gt;&gt;&gt; @@ -66,8 +65,6 @@ It contains following fields:<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 /dev/watchdog0 cdev (dynamic major, minor 0)=
 as well as the old<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 /dev/watchdog miscdev. The id is set automat=
ically when calling<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 watchdog_register_device.<br>
&gt;&gt;&gt;&gt; -* cdev: cdev for the dynamic /dev/watchdog&lt;id&gt; devi=
ce nodes. This<br>
&gt;&gt;&gt;&gt; -=C2=A0 field is also populated by watchdog_register_devic=
e.<br>
&gt;&gt;&gt;&gt; =C2=A0 * dev: device under the watchdog class (created by =
watchdog_register_device).<br>
&gt;&gt;&gt;&gt; =C2=A0 * parent: set this to the parent device (or NULL) b=
efore calling<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 watchdog_register_device.<br>
&gt;&gt;&gt;&gt; @@ -89,11 +86,10 @@ It contains following fields:<br>
&gt;&gt;&gt;&gt; =C2=A0 * driver_data: a pointer to the drivers private dat=
a of a watchdog device.<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 This data should only be accessed via the wa=
tchdog_set_drvdata and<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 watchdog_get_drvdata routines.<br>
&gt;&gt;&gt;&gt; -* lock: Mutex for WatchDog Timer Driver Core internal use=
 only.<br>
&gt;&gt;&gt;&gt; +* wdd_data: a pointer to watchdog core internal data.<br>
&gt;&gt;&gt;&gt; =C2=A0 * status: this field contains a number of status bi=
ts that give extra<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 information about the status of the device (=
Like: is the watchdog timer<br>
&gt;&gt;&gt;&gt; -=C2=A0 running/active, is the nowayout bit set, is the de=
vice opened via<br>
&gt;&gt;&gt;&gt; -=C2=A0 the /dev/watchdog interface or not, ...).<br>
&gt;&gt;&gt;&gt; +=C2=A0 running/active, or is the nowayout bit set).<br>
&gt;&gt;&gt;&gt; =C2=A0 * deferred: entry in wtd_deferred_reg_list which is=
 used to<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 register early initialized watchdogs.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; @@ -110,8 +106,8 @@ struct watchdog_ops {<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*set_timeout)(struct watch=
dog_device *, unsigned int);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int (*get_timeleft)(st=
ruct watchdog_device *);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*restart)(struct watchdog_=
device *);<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0void (*ref)(struct watchdog_device *)=
;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0void (*unref)(struct watchdog_device =
*);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0void (*ref)(struct watchdog_device *)=
 __deprecated;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0void (*unref)(struct watchdog_device =
*) __deprecated;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0long (*ioctl)(struct watchdog_d=
evice *, unsigned int, unsigned long);<br>
&gt;&gt;&gt;&gt; =C2=A0 };<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; @@ -120,20 +116,6 @@ driver&#39;s operations. This module =
owner will be used to lock the module when<br>
&gt;&gt;&gt;&gt; =C2=A0 the watchdog is active. (This to avoid a system cra=
sh when you unload the<br>
&gt;&gt;&gt;&gt; =C2=A0 module and /dev/watchdog is still open).<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -If the watchdog_device struct is dynamically allocated, j=
ust locking the module<br>
&gt;&gt;&gt;&gt; -is not enough and a driver also needs to define the ref a=
nd unref operations to<br>
&gt;&gt;&gt;&gt; -ensure the structure holding the watchdog_device does not=
 go away.<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -The simplest (and usually sufficient) implementation of t=
his is to:<br>
&gt;&gt;&gt;&gt; -1) Add a kref struct to the same structure which is holdi=
ng the watchdog_device<br>
&gt;&gt;&gt;&gt; -2) Define a release callback for the kref which frees the=
 struct holding both<br>
&gt;&gt;&gt;&gt; -3) Call kref_init on this kref *before* calling watchdog_=
register_device()<br>
&gt;&gt;&gt;&gt; -4) Define a ref operation calling kref_get on this kref<b=
r>
&gt;&gt;&gt;&gt; -5) Define a unref operation calling kref_put on this kref=
<br>
&gt;&gt;&gt;&gt; -6) When it is time to cleanup:<br>
&gt;&gt;&gt;&gt; - * Do not kfree() the struct holding both, the last kref_=
put will do this!<br>
&gt;&gt;&gt;&gt; - * *After* calling watchdog_unregister_device() call kref=
_put on the kref<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; =C2=A0 Some operations are mandatory and some are optional=
. The mandatory operations<br>
&gt;&gt;&gt;&gt; =C2=A0 are:<br>
&gt;&gt;&gt;&gt; =C2=A0 * start: this is a pointer to the routine that star=
ts the watchdog timer<br>
&gt;&gt;&gt;&gt; @@ -176,34 +158,21 @@ they are supported. These optional r=
outines/operations are:<br>
&gt;&gt;&gt;&gt; =C2=A0 * get_timeleft: this routines returns the time that=
&#39;s left before a reset.<br>
&gt;&gt;&gt;&gt; =C2=A0 * restart: this routine restarts the machine. It re=
turns 0 on success or a<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 negative errno code for failure.<br>
&gt;&gt;&gt;&gt; -* ref: the operation that calls kref_get on the kref of a=
 dynamically<br>
&gt;&gt;&gt;&gt; -=C2=A0 allocated watchdog_device struct.<br>
&gt;&gt;&gt;&gt; -* unref: the operation that calls kref_put on the kref of=
 a dynamically<br>
&gt;&gt;&gt;&gt; -=C2=A0 allocated watchdog_device struct.<br>
&gt;&gt;&gt;&gt; =C2=A0 * ioctl: if this routine is present then it will be=
 called first before we do<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 our own internal ioctl call handling. This r=
outine should return -ENOIOCTLCMD<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 if a command is not supported. The parameter=
s that are passed to the ioctl<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 call are: watchdog_device, cmd and arg.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; +The &#39;ref&#39; and &#39;unref&#39; operations are no l=
onger used and deprecated.<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; =C2=A0 The status bits should (preferably) be set with the=
 set_bit and clear_bit alike<br>
&gt;&gt;&gt;&gt; =C2=A0 bit-operations. The status bits that are defined ar=
e:<br>
&gt;&gt;&gt;&gt; =C2=A0 * WDOG_ACTIVE: this status bit indicates whether or=
 not a watchdog timer device<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 is active or not. When the watchdog is activ=
e after booting, then you should<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 set this status bit (Note: when you register=
 the watchdog timer device with<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 this bit set, then opening /dev/watchdog wil=
l skip the start operation)<br>
&gt;&gt;&gt;&gt; -* WDOG_DEV_OPEN: this status bit shows whether or not the=
 watchdog device<br>
&gt;&gt;&gt;&gt; -=C2=A0 was opened via /dev/watchdog.<br>
&gt;&gt;&gt;&gt; -=C2=A0 (This bit should only be used by the WatchDog Time=
r Driver Core).<br>
&gt;&gt;&gt;&gt; -* WDOG_ALLOW_RELEASE: this bit stores whether or not the =
magic close character<br>
&gt;&gt;&gt;&gt; -=C2=A0 has been sent (so that we can support the magic cl=
ose feature).<br>
&gt;&gt;&gt;&gt; -=C2=A0 (This bit should only be used by the WatchDog Time=
r Driver Core).<br>
&gt;&gt;&gt;&gt; =C2=A0 * WDOG_NO_WAY_OUT: this bit stores the nowayout set=
ting for the watchdog.<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 If this bit is set then the watchdog timer w=
ill not be able to stop.<br>
&gt;&gt;&gt;&gt; -* WDOG_UNREGISTERED: this bit gets set by the WatchDog Ti=
mer Driver Core<br>
&gt;&gt;&gt;&gt; -=C2=A0 after calling watchdog_unregister_device, and then=
 checked before calling<br>
&gt;&gt;&gt;&gt; -=C2=A0 any watchdog_ops, so that you can be sure that no =
operations (other then<br>
&gt;&gt;&gt;&gt; -=C2=A0 unref) will get called after unregister, even if u=
serspace still holds a<br>
&gt;&gt;&gt;&gt; -=C2=A0 reference to /dev/watchdog<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 To set the WDOG_NO_WAY_OUT status bit (befor=
e registering your watchdog<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 timer device) you can either:<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/watchdog/watchdog_core.c b/drivers/wa=
tchdog/watchdog_core.c<br>
&gt;&gt;&gt;&gt; index f0293f7d2b80..ec1ab6c1a80b 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/watchdog/watchdog_core.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/watchdog/watchdog_core.c<br>
&gt;&gt;&gt;&gt; @@ -210,8 +210,6 @@ static int __watchdog_register_device(=
struct watchdog_device *wdd)<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 * corrupted in a later stage t=
hen we expect a kernel panic!<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_init(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Use alias for watchdog id if=
 possible */<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (wdd-&gt;parent) {<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=
 =3D of_alias_get_id(wdd-&gt;parent-&gt;of_node, &quot;watchdog&quot;);<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/watchdog/watchdog_core.h b/drivers/wa=
tchdog/watchdog_core.h<br>
&gt;&gt;&gt;&gt; index 86ff962d1e15..c9b0656284de 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/watchdog/watchdog_core.h<br>
&gt;&gt;&gt;&gt; +++ b/drivers/watchdog/watchdog_core.h<br>
&gt;&gt;&gt;&gt; @@ -26,9 +26,32 @@<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0This material is provided &quot=
;AS-IS&quot; and at no charge.<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*/<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; +#include &lt;linux/cdev.h&gt;<br>
&gt;&gt;&gt;&gt; +#include &lt;linux/kref.h&gt;<br>
&gt;&gt;&gt;&gt; +#include &lt;linux/mutex.h&gt;<br>
&gt;&gt;&gt;&gt; +#include &lt;linux/watchdog.h&gt;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; =C2=A0 #define MAX_DOGS=C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0=
 =C2=A0 /* Maximum number of watchdog devices */<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 /*<br>
&gt;&gt;&gt;&gt; + * struct _watchdog_device - watchdog core internal data<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Think it should be /**. Anyway, I find it confusing to have bo=
th<br>
&gt;&gt;&gt; _watchdog_device and watchdog_device, but I can&#39;t think of=
 a better<br>
&gt;&gt;&gt; name right now.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; + * @kref:=C2=A0 =C2=A0 Reference count.<br>
&gt;&gt;&gt;&gt; + * @cdev:=C2=A0 =C2=A0 The watchdog&#39;s Character devic=
e.<br>
&gt;&gt;&gt;&gt; + * @wdd:=C2=A0 =C2=A0 =C2=A0Pointer to watchdog device.<b=
r>
&gt;&gt;&gt;&gt; + * @lock:=C2=A0 =C2=A0 Lock for watchdog core.<br>
&gt;&gt;&gt;&gt; + * @status:=C2=A0 Watchdog core internal status bits.<br>
&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt; +struct _watchdog_device {<br>
&gt;&gt;<br>
&gt;&gt; We should probably find a better name for this structure... watchd=
og<br>
&gt;&gt; _adapter, _descriptor, or even _data<br>
&gt;&gt; Also this style is quite confusing when __func() is wrapping func(=
),<br>
&gt;&gt; usually this would be otherway around<br>
&gt;&gt;<br>
&gt;<br>
&gt; I ended up using watchdog_data. I also moved the data structure into<b=
r>
&gt; watchdog_dev.c, as it is only used there.<br>
&gt;<br>
&gt;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct kref kref;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct cdev cdev;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct mutex lock;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0unsigned long status;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Internal status bits */<br>
&gt;&gt;&gt;&gt; +#define _WDOG_DEV_OPEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Opened ? */<br>
&gt;&gt;&gt;&gt; +#define _WDOG_ALLOW_RELEASE=C2=A0 1=C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* Did we receive the magic char ? */<br>
&gt;&gt;&gt;&gt; +};<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0Functions/procedures to be call=
ed by the core<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*/<br>
&gt;&gt;&gt;&gt; =C2=A0 extern int watchdog_dev_register(struct watchdog_de=
vice *);<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/wat=
chdog/watchdog_dev.c<br>
&gt;&gt;&gt;&gt; index c24392623e98..e8416bdc7037 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/watchdog/watchdog_dev.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/watchdog/watchdog_dev.c<br>
&gt;&gt;&gt;&gt; @@ -37,6 +37,7 @@<br>
&gt;&gt;&gt;&gt; =C2=A0 #include &lt;linux/errno.h&gt;=C2=A0 =C2=A0 =C2=A0/=
* For the -ENODEV/... values */<br>
&gt;&gt;&gt;&gt; =C2=A0 #include &lt;linux/kernel.h&gt;=C2=A0 =C2=A0 /* For=
 printk/panic/... */<br>
&gt;&gt;&gt;&gt; =C2=A0 #include &lt;linux/fs.h&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* For file operations */<br>
&gt;&gt;&gt;&gt; +#include &lt;linux/slab.h&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* For memory functions */<br>
&gt;&gt;&gt;&gt; =C2=A0 #include &lt;linux/watchdog.h&gt;=C2=A0 /* For watc=
hdog specific items */<br>
&gt;&gt;&gt;&gt; =C2=A0 #include &lt;linux/miscdevice.h&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* For handling misc devices */<br>
&gt;&gt;&gt;&gt; =C2=A0 #include &lt;linux/init.h&gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* For __init/__exit/... */<br>
&gt;&gt;&gt;&gt; @@ -47,12 +48,14 @@<br>
&gt;&gt;&gt;&gt; =C2=A0 /* the dev_t structure to store the dynamically all=
ocated watchdog devices */<br>
&gt;&gt;&gt;&gt; =C2=A0 static dev_t watchdog_devt;<br>
&gt;&gt;&gt;&gt; =C2=A0 /* the watchdog device behind /dev/watchdog */<br>
&gt;&gt;&gt;&gt; -static struct watchdog_device *old_wdd;<br>
&gt;&gt;&gt;&gt; +static struct _watchdog_device *_old_wdd;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 /*<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0watchdog_ping: ping the watchdo=
g.<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to pi=
ng<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*<br>
&gt;&gt;&gt;&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0If the watchdog has no own ping=
 operation then it needs to be<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0restarted via the start operati=
on. This wrapper function does<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0exactly that.<br>
&gt;&gt;&gt;&gt; @@ -61,25 +64,37 @@ static struct watchdog_device *old_wdd=
;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 static int watchdog_ping(struct watchdog_device *wd=
d)<br>
&gt;&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;<br>
&gt;&gt; Not sure this lockless wrappers are really needed.<br>
&gt;<br>
&gt;<br>
&gt; I dropped _watchdog_ping() and handle locking from the calling code.<b=
r>
&gt;<br>
&gt;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;=
wdd-&gt;status)) {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -=
ENODEV;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
ping;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!watchdog_active(wdd))<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
ping;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;=
<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (wdd-&gt;ops-&gt;ping)<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err=
 =3D wdd-&gt;ops-&gt;ping(wdd);=C2=A0 =C2=A0 =C2=A0 /* ping the watchdog */=
<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err=
 =3D wdd-&gt;ops-&gt;start(wdd);=C2=A0 =C2=A0 =C2=A0/* restart watchdog */<=
br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -out_ping:<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt; + *=C2=A0 =C2=A0_watchdog_ping: ping the watchdog.<br>
&gt;&gt;&gt;&gt; + *=C2=A0 =C2=A0@_wdd: Watchdog core device data<br>
&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt; + *=C2=A0 =C2=A0Acquire _wdd-&gt;lock and call watchdog_pi=
ng() unless the watchdog<br>
&gt;&gt;&gt;&gt; + *=C2=A0 =C2=A0driver has been unregistered.<br>
&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt; +static int _watchdog_ping(struct _watchdog_device *_wdd)<=
br>
&gt;&gt;<br>
&gt;&gt; Use of double underscore __ is more comon .<br>
&gt;<br>
&gt;<br>
&gt; As mentioned above, I ended up dropping the function entirely.<br>
&gt;<br>
&gt;<br>
&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0int err =3D -ENODEV;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;_wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0wdd =3D _wdd-&gt;wdd;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (wdd)<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D w=
atchdog_ping(wdd);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;_wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt;&gt;&gt; =C2=A0 }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; @@ -87,6 +102,8 @@ out_ping:<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0watchdog_start: wrapper to star=
t the watchdog.<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to st=
art<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*<br>
&gt;&gt;&gt;&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0Start the watchdog if it is not=
 active and mark it active.<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0This function returns zero on s=
uccess or a negative errno code for<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0failure.<br>
&gt;&gt;&gt;&gt; @@ -94,24 +111,15 @@ out_ping:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 static int watchdog_start(struct watchdog_device *w=
dd)<br>
&gt;&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;=
wdd-&gt;status)) {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -=
ENODEV;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
start;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (watchdog_active(wdd))<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
start;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;=
<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D wdd-&gt;ops-&gt;start(w=
dd);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err =3D=3D 0)<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set=
_bit(WDOG_ACTIVE, &amp;wdd-&gt;status);<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -out_start:<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt;&gt;&gt; =C2=A0 }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; @@ -119,6 +127,8 @@ out_start:<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0watchdog_stop: wrapper to stop =
the watchdog.<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to st=
op<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*<br>
&gt;&gt;&gt;&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0Stop the watchdog if it is stil=
l active and unmark it active.<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0This function returns zero on s=
uccess or a negative errno code for<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0failure.<br>
&gt;&gt;&gt;&gt; @@ -127,93 +137,58 @@ out_start:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 static int watchdog_stop(struct watchdog_device *wd=
d)<br>
&gt;&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;=
wdd-&gt;status)) {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -=
ENODEV;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
stop;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!watchdog_active(wdd))<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
stop;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;=
<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_NO_WAY_OUT, &=
amp;wdd-&gt;status)) {<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev=
_info(wdd-&gt;dev, &quot;nowayout prevents watchdog being stopped!\n&quot;)=
;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -=
EBUSY;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
stop;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E=
BUSY;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D wdd-&gt;ops-&gt;stop(wd=
d);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err =3D=3D 0)<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cle=
ar_bit(WDOG_ACTIVE, &amp;wdd-&gt;status);<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -out_stop:<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt;&gt;&gt; =C2=A0 }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 /*<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0watchdog_get_status: wrapper to=
 get the watchdog status<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to ge=
t the status from<br>
&gt;&gt;&gt;&gt; - *=C2=A0 =C2=A0@status: the status of the watchdog device=
<br>
&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0Get the watchdog&#39;s status f=
lags.<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*/<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -static int watchdog_get_status(struct watchdog_device *wd=
d,<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int *st=
atus)<br>
&gt;&gt;&gt;&gt; +static unsigned int watchdog_get_status(struct watchdog_d=
evice *wdd)<br>
&gt;&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0*status =3D 0;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wdd-&gt;ops-&gt;status)<br=
>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E=
OPNOTSUPP;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;=
wdd-&gt;status)) {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -=
ENODEV;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
status;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0*status =3D wdd-&gt;ops-&gt;status(wd=
d);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;=
<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -out_status:<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0return wdd-&gt;ops-&gt;status(wdd);<b=
r>
&gt;&gt;&gt;&gt; =C2=A0 }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 /*<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0watchdog_set_timeout: set the w=
atchdog timer timeout<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to se=
t the timeout for<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0@timeout: timeout to set in sec=
onds<br>
&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*/<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 static int watchdog_set_timeout(struct watchdog_dev=
ice *wdd,<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
int timeout)<br>
&gt;&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wdd-&gt;ops-&gt;set_timeou=
t || !(wdd-&gt;info-&gt;options &amp; WDIOF_SETTIMEOUT))<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=
urn -EOPNOTSUPP;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (watchdog_timeout_invalid(wd=
d, timeout))<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=
urn -EINVAL;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;=
wdd-&gt;status)) {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -=
ENODEV;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
timeout;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0err =3D wdd-&gt;ops-&gt;set_timeout(w=
dd, timeout);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -out_timeout:<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0return wdd-&gt;ops-&gt;set_timeout(wd=
d, timeout);<br>
&gt;&gt;&gt;&gt; =C2=A0 }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 /*<br>
&gt;&gt;&gt;&gt; @@ -221,30 +196,22 @@ out_timeout:<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to ge=
t the remaining time from<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0@timeleft: the time that&#39;s =
left<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*<br>
&gt;&gt;&gt;&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0Get the time before a watchdog =
will reboot (if not pinged).<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*/<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 static int watchdog_get_timeleft(struct watchdog_de=
vice *wdd,<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
int *timeleft)<br>
&gt;&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0*timeleft =3D 0;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wdd-&gt;ops-&gt;get_timele=
ft)<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=
urn -EOPNOTSUPP;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;=
wdd-&gt;status)) {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -=
ENODEV;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
timeleft;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0*timeleft =3D wdd-&gt;ops-&gt;g=
et_timeleft(wdd);<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -out_timeleft:<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;&gt;&gt;&gt; =C2=A0 }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 #ifdef CONFIG_WATCHDOG_SYSFS<br>
&gt;&gt;&gt;&gt; @@ -261,14 +228,14 @@ static ssize_t status_show(struct de=
vice *dev, struct device_attribute *attr,<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf)<br>
&gt;&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd =3D=
 dev_get_drvdata(dev);<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0ssize_t status;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0unsigned int val;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct _watchdog_device *_wdd =3D wdd=
-&gt;wdd_data;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int status;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0status =3D watchdog_get_status(wdd, &=
amp;val);<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (!status)<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =
=3D sprintf(buf, &quot;%u\n&quot;, val);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;_wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0status =3D watchdog_get_status(wdd);<=
br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;_wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0return status;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0return sprintf(buf, &quot;%u\n&quot;,=
 status);<br>
&gt;&gt;&gt;&gt; =C2=A0 }<br>
&gt;&gt;&gt;&gt; =C2=A0 static DEVICE_ATTR_RO(status);<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; @@ -285,10 +252,13 @@ static ssize_t timeleft_show(struct =
device *dev, struct device_attribute *attr,<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf)<br>
&gt;&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd =3D=
 dev_get_drvdata(dev);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct _watchdog_device *_wdd =3D wdd=
-&gt;wdd_data;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t status;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int val;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;_wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D watchdog_get_timelef=
t(wdd, &amp;val);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;_wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!status)<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sta=
tus =3D sprintf(buf, &quot;%u\n&quot;, val);<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; @@ -363,28 +333,17 @@ __ATTRIBUTE_GROUPS(wdt);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0@wdd: the watchdog device to do=
 the ioctl on<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0@cmd: watchdog command<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*=C2=A0 =C2=A0@arg: argument pointer<br>
&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt; + *=C2=A0 =C2=A0The caller must hold _wdd-&gt;lock.<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0*/<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 static int watchdog_ioctl_op(struct watchdog_device=
 *wdd, unsigned int cmd,<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
long arg)<br>
&gt;&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wdd-&gt;ops-&gt;ioctl)<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=
urn -ENOIOCTLCMD;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0if (test_bit(WDOG_UNREGISTERED, &amp;=
wdd-&gt;status)) {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -=
ENODEV;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
ioctl;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0err =3D wdd-&gt;ops-&gt;ioctl(wdd, cm=
d, arg);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -out_ioctl:<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0return wdd-&gt;ops-&gt;ioctl(wdd, cmd=
, arg);<br>
&gt;&gt;&gt;&gt; =C2=A0 }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 /*<br>
&gt;&gt;&gt;&gt; @@ -402,7 +361,7 @@ out_ioctl:<br>
&gt;&gt;&gt;&gt; =C2=A0 static ssize_t watchdog_write(struct file *file, co=
nst char __user *data,<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len, loff_t *ppos)<br>
&gt;&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd =3D file-=
&gt;private_data;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct _watchdog_device *_wdd =3D fil=
e-&gt;private_data;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t i;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0char c;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;&gt;&gt;&gt; @@ -414,18 +373,18 @@ static ssize_t watchdog_write(struct=
 file *file, const char __user *data,<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Note: just in case someone w=
rote the magic character<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 * five months ago...<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0clear_bit(WDOG_ALLOW_RELEASE, &amp;wd=
d-&gt;status);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0clear_bit(_WDOG_ALLOW_RELEASE, &amp;_=
wdd-&gt;status);<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0/* scan to see whether or not w=
e got the magic character */<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i !=3D len; i++) =
{<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(get_user(c, data + i))<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFAULT;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(c =3D=3D &#39;V&#39;)<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0set_bit(WDOG_ALLOW_RELEASE, &amp;wdd-&gt;status);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0set_bit(_WDOG_ALLOW_RELEASE, &amp;_wdd-&gt;status);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0/* someone wrote to us, so we s=
end the watchdog a keepalive ping */<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0err =3D watchdog_ping(wdd);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0err =3D _watchdog_ping(_wdd);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0)<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=
urn err;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; @@ -445,71 +404,94 @@ static ssize_t watchdog_write(struct=
 file *file, const char __user *data,<br>
&gt;&gt;&gt;&gt; =C2=A0 static long watchdog_ioctl(struct file *file, unsig=
ned int cmd,<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
long arg)<br>
&gt;&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd =3D file-=
&gt;private_data;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct _watchdog_device *_wdd =3D fil=
e-&gt;private_data;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0void __user *argp =3D (void __u=
ser *)arg;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct watchdog_device *wdd;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0int __user *p =3D argp;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int val;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;_wdd-&gt;lock);<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0wdd =3D _wdd-&gt;wdd;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (!wdd) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -=
ENODEV;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
ioctl;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D watchdog_ioctl_op(wdd, =
cmd, arg);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err !=3D -ENOIOCTLCMD)<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return er=
r;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
ioctl;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (cmd) {<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_GETSUPPORT:<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return co=
py_to_user(argp, wdd-&gt;info,<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D c=
opy_to_user(argp, wdd-&gt;info,<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct watchdog_info)) ? -EFAULT : 0;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_GETSTATUS:<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D w=
atchdog_get_status(wdd, &amp;val);<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err =
=3D=3D -ENODEV)<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pu=
t_user(val, p);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D w=
atchdog_get_status(wdd);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D p=
ut_user(val, p);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_GETBOOTSTATUS:<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pu=
t_user(wdd-&gt;bootstatus, p);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D p=
ut_user(wdd-&gt;bootstatus, p);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_SETOPTIONS:<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_u=
ser(val, p))<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return -EFAULT;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_u=
ser(val, p)) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0err =3D -EFAULT;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(val &amp; WDIOS_DISABLECARD) {<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D watchdog_stop(wdd);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0)<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<b=
r>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &=
amp; WDIOS_ENABLECARD) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &=
amp; WDIOS_ENABLECARD)<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D watchdog_start(wdd);<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (err &lt; 0)<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;=
<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_KEEPALIVE:<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(wdd=
-&gt;info-&gt;options &amp; WDIOF_KEEPALIVEPING))<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return wa=
tchdog_ping(wdd);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(wdd=
-&gt;info-&gt;options &amp; WDIOF_KEEPALIVEPING)) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0err =3D -EOPNOTSUPP;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D w=
atchdog_ping(wdd);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_SETTIMEOUT:<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_u=
ser(val, p))<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return -EFAULT;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_u=
ser(val, p)) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0err =3D -EFAULT;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err=
 =3D watchdog_set_timeout(wdd, val);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(err &lt; 0)<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
If the watchdog is active then we send a keepalive ping<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =
to make sure that the watchdog keep&#39;s running (and if<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =
possible that it takes the new timeout) */<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err=
 =3D watchdog_ping(wdd);<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(err &lt; 0)<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;<br>
&gt;&gt; You are changing behaviour for the driver here as you are keeping =
lock<br>
&gt;&gt; over two driver op calls.<br>
&gt;<br>
&gt;<br>
&gt; Yes, but the alternative (unlock, lock again, and check again if the<b=
r>
&gt; watchdog was unregistered) would be awkward, and I don&#39;t see where=
<br>
&gt; this can be a problem.<br>
 Maybe there is not but this is something to mention in the commit message.=
</p>
<p dir=3D"ltr">&gt; Do you see a situation where holding the lock between c=
alls into the driver<br>
&gt; might be a problem ?</p>
<p dir=3D"ltr">I don&#39;t think u are holding the lock now in watchdog_unr=
egister when WDOG_UNREGISTERED was dropped. <br>
&gt;<br>
&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
Fall */<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0case WDIOC_GETTIMEOUT:<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
timeout =3D=3D 0 means that we don&#39;t know the timeout */<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (wdd-&=
gt;timeout =3D=3D 0)<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pu=
t_user(wdd-&gt;timeout, p);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (wdd-&=
gt;timeout =3D=3D 0) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0err =3D -EOPNOTSUPP;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D p=
ut_user(wdd-&gt;timeout, p);<br>
&gt;<br>
&gt;<br>
&gt; This is another semantics change - the old code would succeed here if<=
br>
&gt; the watchdog device was unregistered, unless the driver implements an<=
br>
&gt; ioctl command. Now it fails with -ENODEV. This is also true for some<b=
r>
&gt; of the other ioctls above. I&#39;ll mention that in the commit log.<br=
>
&gt;<br>
&gt; The alternative would be to keep the locking in the wrapper functions,=
<br>
&gt; but I think the code is cleaner and more consistent this way.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Guenter<br>
&gt;<br>
</p>

--047d7ba97e503c1181052783cc82--
