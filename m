Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <556DD5E1.9000104@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1433217907-928-1-git-send-email-fu.wei@linaro.org>
	<1433217907-928-5-git-send-email-fu.wei@linaro.org>
	<556DD5E1.9000104@roeck-us.net>
Date: Tue, 9 Jun 2015 00:44:58 +0800
Message-ID: <CADyBb7sfAMhcPe2QL3pmwshduW9TC_v0VyBnoZ7xhtY3y3k9vQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] Watchdog: introdouce "pretimeout" into framework
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>, Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

Great thanks for your review,


On 3 June 2015 at 00:12, Guenter Roeck <linux@roeck-us.net> wrote:
> On 06/01/2015 09:05 PM, fu.wei@linaro.org wrote:
>>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> Also update Documentation/watchdog/watchdog-kernel-api.txt to
>> introduce:
>> (1)the new elements in the watchdog_device and watchdog_ops struct;
>> (2)the new API "watchdog_init_timeouts"
>>
>> Reasons:
>> (1)kernel already has two watchdog drivers are using "pretimeout":
>>         drivers/char/ipmi/ipmi_watchdog.c
>>         drivers/watchdog/kempld_wdt.c(but the definition is different)
>> (2)some other drivers are going to use this: ARM SBSA Generic Watchdog
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>   Documentation/watchdog/watchdog-kernel-api.txt |  47 ++++++++--
>>   drivers/watchdog/watchdog_core.c               | 115
>> +++++++++++++++++++------
>>   drivers/watchdog/watchdog_dev.c                |  53 ++++++++++++
>>   include/linux/watchdog.h                       |  33 ++++++-
>>   4 files changed, 212 insertions(+), 36 deletions(-)
>>
>> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt
>> b/Documentation/watchdog/watchdog-kernel-api.txt
>> index a0438f3..95b355d 100644
>> --- a/Documentation/watchdog/watchdog-kernel-api.txt
>> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
>> @@ -49,6 +49,9 @@ struct watchdog_device {
>>         unsigned int timeout;
>>         unsigned int min_timeout;
>>         unsigned int max_timeout;
>> +       unsigned int pretimeout;
>> +       unsigned int min_pretimeout;
>> +       unsigned int max_pretimeout;
>>         void *driver_data;
>>         struct mutex lock;
>>         unsigned long status;
>> @@ -70,6 +73,9 @@ It contains following fields:
>>   * timeout: the watchdog timer's timeout value (in seconds).
>>   * min_timeout: the watchdog timer's minimum timeout value (in seconds).
>>   * max_timeout: the watchdog timer's maximum timeout value (in seconds).
>> +* pretimeout: the watchdog timer's pretimeout value (in seconds).
>> +* min_pretimeout: the watchdog timer's minimum pretimeout value (in
>> seconds).
>> +* max_pretimeout: the watchdog timer's maximum pretimeout value (in
>> seconds).
>>   * bootstatus: status of the device after booting (reported with watchdog
>>     WDIOF_* status bits).
>>   * driver_data: a pointer to the drivers private data of a watchdog
>> device.
>> @@ -92,6 +98,7 @@ struct watchdog_ops {
>>         int (*ping)(struct watchdog_device *);
>>         unsigned int (*status)(struct watchdog_device *);
>>         int (*set_timeout)(struct watchdog_device *, unsigned int);
>> +       int (*set_pretimeout)(struct watchdog_device *, unsigned int);
>>         unsigned int (*get_timeleft)(struct watchdog_device *);
>>         void (*ref)(struct watchdog_device *);
>>         void (*unref)(struct watchdog_device *);
>> @@ -153,9 +160,19 @@ they are supported. These optional
>> routines/operations are:
>>     and -EIO for "could not write value to the watchdog". On success this
>>     routine should set the timeout value of the watchdog_device to the
>>     achieved timeout value (which may be different from the requested one
>> -  because the watchdog does not necessarily has a 1 second resolution).
>> +  because the watchdog does not necessarily has a 1 second resolution;
>> +  If the driver supports pretimeout, then the timeout value must be
>> greater
>> +  than that).
>>     (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of
>> the
>>     watchdog's info structure).
>> +* set_pretimeout: this routine checks and changes the pretimeout of the
>> +  watchdog timer device. It returns 0 on success, -EINVAL for "parameter
>> out of
>> +  range" and -EIO for "could not write value to the watchdog". On success
>> this
>> +  routine should set the pretimeout value of the watchdog_device to the
>> +  achieved pretimeout value (which may be different from the requested
>> one
>> +  because the watchdog does not necessarily has a 1 second resolution).
>> +  (Note: the WDIOF_PRETIMEOUT needs to be set in the options field of the
>> +  watchdog's info structure).
>>   * get_timeleft: this routines returns the time that's left before a
>> reset.
>>   * ref: the operation that calls kref_get on the kref of a dynamically
>>     allocated watchdog_device struct.
>> @@ -219,8 +236,28 @@ extern int watchdog_init_timeout(struct
>> watchdog_device *wdd,
>>                                     unsigned int timeout_parm, struct
>> device *dev);
>>
>>   The watchdog_init_timeout function allows you to initialize the timeout
>> field
>> -using the module timeout parameter or by retrieving the timeout-sec
>> property from
>> -the device tree (if the module timeout parameter is invalid). Best
>> practice is
>> -to set the default timeout value as timeout value in the watchdog_device
>> and
>> -then use this function to set the user "preferred" timeout value.
>> +using the module timeout parameter or by retrieving the first element of
>> +the timeout-sec property from the device tree (if the module timeout
>> parameter
>> +is invalid). Best practice is to set the default timeout value as timeout
>> value
>> +in the watchdog_device and then use this function to set the user
>> "preferred"
>> +timeout value.
>> +This routine returns zero on success and a negative errno code for
>> failure.
>> +
>> +Some watchdog timers have two stage of timeouts(timeout and pretimeout),
>> +to initialize the timeout and pretimeout fields at the same time, the
>> following
>> +function can be used:
>> +
>> +extern int watchdog_init_timeouts(struct watchdog_device *wdd,
>> +                                  unsigned int pretimeout_parm,
>> +                                  unsigned int timeout_parm,
>> +                                  struct device *dev);
>> +
>> +The watchdog_init_timeouts function allows you to initialize the
>> pretimeout and
>> +timeout fields using the module pretimeout and timeout parameter or by
>> +retrieving the elements in the timeout-sec property(the first element is
>> for
>> +timeout, the second one is for pretimeout) from the device tree(if the
>> module
>> +pretimeout and timeout parameter are invalid).
>> +Best practice is to set the default pretimeout and timeout value as
>> pretimeout
>> +and timeout value in the watchdog_device and then use this function to
>> set the
>> +user "preferred" pretimeout value.
>>   This routine returns zero on success and a negative errno code for
>> failure.
>> diff --git a/drivers/watchdog/watchdog_core.c
>> b/drivers/watchdog/watchdog_core.c
>> index cec9b55..ff18db3 100644
>> --- a/drivers/watchdog/watchdog_core.c
>> +++ b/drivers/watchdog/watchdog_core.c
>> @@ -43,60 +43,119 @@
>>   static DEFINE_IDA(watchdog_ida);
>>   static struct class *watchdog_class;
>>
>> -static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
>> +static void watchdog_check_min_max_timeouts(struct watchdog_device *wdd)
>>   {
>>         /*
>> -        * Check that we have valid min and max timeout values, if
>> -        * not reset them both to 0 (=not used or unknown)
>> +        * Check that we have valid min and max pretimeout and timeout
>> values,
>> +        * if not reset them both to 0 (=not used or unknown)
>>          */
>> +       if (wdd->min_pretimeout > wdd->max_pretimeout) {
>> +               pr_info("Invalid min and max pretimeout, resetting to
>> 0\n");
>> +               wdd->min_pretimeout = 0;
>> +               wdd->max_pretimeout = 0;
>> +       }
>>         if (wdd->min_timeout > wdd->max_timeout) {
>>                 pr_info("Invalid min and max timeout values, resetting to
>> 0!\n");
>>                 wdd->min_timeout = 0;
>>                 wdd->max_timeout = 0;
>>         }
>> +       /*
>> +        * Check that we have valid min timeout and max pretimeout values,
>> +        * if not reset them.
>> +        */
>> +       if (wdd->min_pretimeout && wdd->min_timeout < wdd->min_pretimeout)
>> {
>> +               pr_info("Invalid min_timeout, resetting to
>> min_pretimeout+1\n");
>> +               wdd->min_timeout = wdd->min_pretimeout + 1;
>> +       }
>
>
> min_timeout = 10
> max_timeout = 20
> min_pretimeout = 30
> max_pretimeout = 40
>
> will result in min_timeout set to 31.
>
>> +       if (wdd->max_pretimeout && wdd->max_timeout < wdd->max_pretimeout)
>> {
>> +               pr_info("Invalid max_pretimeout, resetting to
>> max_timeout-1\n");
>> +               wdd->max_pretimeout = wdd->max_timeout - 1;
>
>
> and then you set max_pretimeout to 19.
>
> So we'll end up with
>
> min_timeout = 31
> max_timeout = 20
> min_pretimeout = 30
> max_pretimeout = 19
>
> Another example: max_pretimeout = 10, max_timeout = 0 -> max_pretimeout =
> -1.
>
>> +       }
>
>
> You'll need to determine valid ranges and then enforce those.
> Maybe something like
>         min_pretimeout < min_timeout < max_timeout
> and
>         min_pretimeout < max_pretimeout < max_timeout
>
> Not sure if we should adjust anything to a value different to 0.
> Seems to me this is just asking for trouble.

yes, this is a new problem, but let me fix this in my new patchset:
(1)these values is set by driver in the initialization procedure,
according to hardware info.
(2) I thinks there is not any driver should call this function after
initialization.
 So if we find any incorrect value, I think the hardware info we got
is wrong , maybe we can just give up

any suggestion ?

>
>>   }
>>
>>   /**
>> - * watchdog_init_timeout() - initialize the timeout field
>> + * watchdog_init_timeouts() - initialize the pretimeout and timeout field
>> + * @pretimeout_parm: pretimeout module parameter
>>    * @timeout_parm: timeout module parameter
>>    * @dev: Device that stores the timeout-sec property
>>    *
>> - * Initialize the timeout field of the watchdog_device struct with either
>> the
>> - * timeout module parameter (if it is valid value) or the timeout-sec
>> property
>> - * (only if it is a valid value and the timeout_parm is out of bounds).
>> - * If none of them are valid then we keep the old value (which should
>> normally
>> - * be the default timeout value.
>> + * Initialize the pretimeout and timeout field of the watchdog_device
>> struct
>> + * with either the pretimeout and timeout module parameter (if it is
>> valid
>> + * value) or the timeout-sec property (only if it is a valid value and
>> the
>
>
> just 'if it is valid', or 'if it is a valid value' in both cases.

OK. np,. Thanks

>
>> + * pretimeout_parm and timeout_parm is out of bounds). If none of them
>> are
>
>
> s/and/or/

Thanks , fixed

>
>
>> + * valid, then we keep the old value (which should normally be the
>> default
>> + * timeout value).
>>    *
>>    * A zero is returned on success and -EINVAL for failure.
>>    */
>> -int watchdog_init_timeout(struct watchdog_device *wdd,
>> -                               unsigned int timeout_parm, struct device
>> *dev)
>> +int watchdog_init_timeouts(struct watchdog_device *wdd,
>> +                          unsigned int pretimeout_parm,
>> +                          unsigned int timeout_parm,
>> +                          struct device *dev)
>>   {
>> -       unsigned int t = 0;
>> -       int ret = 0;
>> +       int ret = 0, length = 0;
>> +       u32 timeouts[2] = {0};
>>
>> -       watchdog_check_min_max_timeout(wdd);
>> +       watchdog_check_min_max_timeouts(wdd);
>>
>> -       /* try to get the timeout module parameter first */
>> -       if (!watchdog_timeout_invalid(wdd, timeout_parm) && timeout_parm)
>> {
>> -               wdd->timeout = timeout_parm;
>> -               return ret;
>> +       /*
>> +        * Try to get the pretimeout module parameter first,
>> +        * but it can be "0", that means we don't use pretimeout.
>> +        */
>> +       if (pretimeout_parm) {
>> +               if (!watchdog_pretimeout_invalid(wdd, pretimeout_parm))
>> +                       timeouts[1] = pretimeout_parm;
>> +               ret = -EINVAL; /* pretimeout_parm is not "0", and invalid
>> */
>
>
> pretimeout_parm is always invalid ? Why ?

Sorry, I lost a "else" , this is a bug/typo

>
>>         }
>> -       if (timeout_parm)
>> +
>> +       /*
>> +        * Try to get the timeout module parameter,
>> +        * if it's valid and pretimeout is ont invalid(ret == 0),
>
>
> s/ont/not/

Thanks , fixed

>
>> +        * assignment and return zero. Otherwise, try dtb.
>> +        */
>> +       if (timeout_parm) {
>> +               if (!watchdog_timeout_invalid(wdd, timeout_parm) && !ret)
>> {
>
>
> Unless I am missing something, you'll never get here if the pretimeout
> module
> parameter is set.

yes, because of the bug above.
Will fix it in my next patchset , thanks :-)

>
>> +                       wdd->timeout = timeout_parm;
>> +                       wdd->pretimeout = timeouts[1];
>> +                       return 0;
>> +               }
>>                 ret = -EINVAL;
>> +       }
>>
>> -       /* try to get the timeout_sec property */
>> +       /*
>> +        * We get here, the situation is one of them:
>> +        * (1)at least one of parameters is invalid(ret = -EINVAL);
>> +        * (2)both of them are 0.(ret = 0)
>> +        * So give up the module parameter(at least drop the invalid one),
>> +        * try to get the timeout_sec property from dtb.
>
>
> Please simplify the comment.
>
>         Either at least one of the module parameters is invalid,
>         or both of them are 0. Try to get the timeout_sec property.

Thanks , will do.

>
>> +        */
>>         if (dev == NULL || dev->of_node == NULL)
>>                 return ret;
>> -       of_property_read_u32(dev->of_node, "timeout-sec", &t);
>> -       if (!watchdog_timeout_invalid(wdd, t) && t)
>> -               wdd->timeout = t;
>> -       else
>> -               ret = -EINVAL;
>>
>> -       return ret;
>> +       /*
>> +        * We get here, that means maybe we can get timeouts from dtb,
>> +        * if "timeout-sec" is available and the data is valid.
>> +        */
>
>
> That comment is not needed; it is obvious.

OK, will remove it

>
>> +       of_find_property(dev->of_node, "timeout-sec", &length);
>> +       if (length > 0 && length <= sizeof(u32) * 2) {
>
>
> You need to check the return value of of_find_property() instead of assuming
> that length will be 0 if it is not found.

you are right, will do, thanks

>
>> +               of_property_read_u32_array(dev->of_node,
>> +                                          "timeout-sec", timeouts,
>> +                                          length / sizeof(u32));
>> +               if (length == sizeof(u32) * 2 && timeouts[1] &&
>> +                   watchdog_pretimeout_invalid(wdd, timeouts[1]))
>> +                               return -EINVAL; /* pretimeout is invalid
>> */
>
>
> Obvious comment.

OK, will remove it

>
>
>> +
>> +               if (!watchdog_timeout_invalid(wdd, timeouts[0]) &&
>> +                   timeouts[0]) {
>> +                       wdd->timeout = timeouts[0];
>> +                       wdd->pretimeout = timeouts[1];
>> +                       return 0;
>> +               }
>> +       }
>> +
>> +       return -EINVAL;
>>   }
>> -EXPORT_SYMBOL_GPL(watchdog_init_timeout);
>> +EXPORT_SYMBOL_GPL(watchdog_init_timeouts);
>>
>>   /**
>>    * watchdog_register_device() - register a watchdog device
>> @@ -119,7 +178,7 @@ int watchdog_register_device(struct watchdog_device
>> *wdd)
>>         if (wdd->ops->start == NULL || wdd->ops->stop == NULL)
>>                 return -EINVAL;
>>
>> -       watchdog_check_min_max_timeout(wdd);
>> +       watchdog_check_min_max_timeouts(wdd);
>>
>>         /*
>>          * Note: now that all watchdog_device data has been verified, we
>> diff --git a/drivers/watchdog/watchdog_dev.c
>> b/drivers/watchdog/watchdog_dev.c
>> index 6aaefba..af0777e 100644
>> --- a/drivers/watchdog/watchdog_dev.c
>> +++ b/drivers/watchdog/watchdog_dev.c
>> @@ -218,6 +218,38 @@ out_timeout:
>>   }
>>
>>   /*
>> + *     watchdog_set_pretimeout: set the watchdog timer pretimeout
>> + *     @wddev: the watchdog device to set the timeout for
>> + *     @pretimeout: pretimeout to set in seconds
>> + */
>> +
>> +static int watchdog_set_pretimeout(struct watchdog_device *wddev,
>> +                                  unsigned int pretimeout)
>> +{
>> +       int err;
>> +
>> +       if (!wddev->ops->set_pretimeout ||
>> +           !(wddev->info->options & WDIOF_PRETIMEOUT))
>> +               return -EOPNOTSUPP;
>> +
>> +       if (watchdog_pretimeout_invalid(wddev, pretimeout))
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&wddev->lock);
>> +
>> +       if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
>> +               err = -ENODEV;
>> +               goto out_pretimeout;
>> +       }
>> +
>> +       err = wddev->ops->set_pretimeout(wddev, pretimeout);
>> +
>> +out_pretimeout:
>> +       mutex_unlock(&wddev->lock);
>> +       return err;
>> +}
>> +
>> +/*
>>    *    watchdog_get_timeleft: wrapper to get the time left before a
>> reboot
>>    *    @wddev: the watchdog device to get the remaining time from
>>    *    @timeleft: the time that's left
>> @@ -388,6 +420,27 @@ static long watchdog_ioctl(struct file *file,
>> unsigned int cmd,
>>                 if (wdd->timeout == 0)
>>                         return -EOPNOTSUPP;
>>                 return put_user(wdd->timeout, p);
>> +       case WDIOC_SETPRETIMEOUT:
>> +               /* check if we support the pretimeout */
>> +               if (!(wdd->info->options & WDIOF_PRETIMEOUT))
>> +                       return -EOPNOTSUPP;
>> +               if (get_user(val, p))
>> +                       return -EFAULT;
>> +               err = watchdog_set_pretimeout(wdd, val);
>> +               if (err < 0)
>> +                       return err;
>> +               /*
>> +                * If the watchdog is active then we send a keepalive ping
>> +                * to make sure that the watchdog keeps running (and if
>> +                * possible that it takes the new pretimeout)
>> +                */
>> +               watchdog_ping(wdd);
>> +               /* Fall */
>> +       case WDIOC_GETPRETIMEOUT:
>> +               /* check if we support the pretimeout */
>> +               if (wdd->info->options & WDIOF_PRETIMEOUT)
>> +                       return put_user(wdd->pretimeout, p);
>> +               return -EOPNOTSUPP;
>>         case WDIOC_GETTIMELEFT:
>>                 err = watchdog_get_timeleft(wdd, &val);
>>                 if (err)
>> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
>> index a746bf5..b1e325d 100644
>> --- a/include/linux/watchdog.h
>> +++ b/include/linux/watchdog.h
>> @@ -25,6 +25,7 @@ struct watchdog_device;
>>    * @ping:     The routine that sends a keepalive ping to the watchdog
>> device.
>>    * @status:   The routine that shows the status of the watchdog device.
>>    * @set_timeout:The routine for setting the watchdog devices timeout
>> value.
>> + * @set_pretimeout:The routine for setting the watchdog devices
>> pretimeout value
>>    * @get_timeleft:The routine that get's the time that's left before a
>> reset.
>>    * @ref:      The ref operation for dyn. allocated watchdog_device
>> structs
>>    * @unref:    The unref operation for dyn. allocated watchdog_device
>> structs
>> @@ -44,6 +45,7 @@ struct watchdog_ops {
>>         int (*ping)(struct watchdog_device *);
>>         unsigned int (*status)(struct watchdog_device *);
>>         int (*set_timeout)(struct watchdog_device *, unsigned int);
>> +       int (*set_pretimeout)(struct watchdog_device *, unsigned int);
>>         unsigned int (*get_timeleft)(struct watchdog_device *);
>>         void (*ref)(struct watchdog_device *);
>>         void (*unref)(struct watchdog_device *);
>> @@ -62,6 +64,9 @@ struct watchdog_ops {
>>    * @timeout:  The watchdog devices timeout value.
>>    * @min_timeout:The watchdog devices minimum timeout value.
>>    * @max_timeout:The watchdog devices maximum timeout value.
>> + * @pretimeout:        The watchdog devices pretimeout value.
>> + * @min_pretimeout:The watchdog devices minimum pretimeout value.
>> + * @max_pretimeout:The watchdog devices maximum pretimeout value.
>>    * @driver-data:Pointer to the drivers private data.
>>    * @lock:     Lock for watchdog core internal use only.
>>    * @status:   Field that contains the devices internal status bits.
>> @@ -86,6 +91,9 @@ struct watchdog_device {
>>         unsigned int timeout;
>>         unsigned int min_timeout;
>>         unsigned int max_timeout;
>> +       unsigned int pretimeout;
>> +       unsigned int min_pretimeout;
>> +       unsigned int max_pretimeout;
>>         void *driver_data;
>>         struct mutex lock;
>>         unsigned long status;
>> @@ -117,7 +125,17 @@ static inline void watchdog_set_nowayout(struct
>> watchdog_device *wdd, bool noway
>>   static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd,
>> unsigned int t)
>>   {
>>         return ((wdd->max_timeout != 0) &&
>> -               (t < wdd->min_timeout || t > wdd->max_timeout));
>> +               (t < wdd->min_timeout || t > wdd->max_timeout ||
>> +                       t <= wdd->pretimeout));
>> +}
>> +
>> +/* Use the following function to check if a pretimeout value is invalid
>> */
>> +static inline bool watchdog_pretimeout_invalid(struct watchdog_device
>> *wdd,
>> +                                              unsigned int t)
>> +{
>> +       return (wdd->max_pretimeout != 0 &&
>> +               (t < wdd->min_pretimeout || t > wdd->max_pretimeout ||
>> +                       (wdd->timeout != 0 && t >= wdd->timeout)));
>
>
> This validates a pretimeout as valid if max_pretimeout == 0,
> no matter what timeout is set to.
>
> Do we really need to check if timeout == 0 ? Can that ever happen ?

(wdd->timeout != 0 && t >= wdd->timeout)

if we have set timeout(wdd->timeout != 0), and t(pretimeout) >
wdd->timeout, t is a invalid value.
Am I correct?

the reason of adding "wdd->timeout != 0": if driver calls this
function before setting up  wdd->timeout.


>
>>   }
>>
>>   /* Use the following functions to manipulate watchdog driver specific
>> data */
>> @@ -132,11 +150,20 @@ static inline void *watchdog_get_drvdata(struct
>> watchdog_device *wdd)
>>   }
>>
>>   /* drivers/watchdog/watchdog_core.c */
>> -extern int watchdog_init_timeout(struct watchdog_device *wdd,
>> -                                 unsigned int timeout_parm, struct device
>> *dev);
>> +extern int watchdog_init_timeouts(struct watchdog_device *wdd,
>> +                                 unsigned int pretimeout_parm,
>> +                                 unsigned int timeout_parm,
>> +                                 struct device *dev);
>
>
> No 'extern' here, please. Yes, we'll need to fix that for the other
> function declarations, but that is not a reason to introduce new ones.

OK, I do agree with you on this, have fixed it in my next patchset.

>
> Thanks,
> Guenter
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
