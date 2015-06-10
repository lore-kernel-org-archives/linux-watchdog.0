Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33651 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933871AbbFJQWD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Jun 2015 12:22:03 -0400
Message-ID: <5578641E.1060209@roeck-us.net>
Date: Wed, 10 Jun 2015 09:21:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
	linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, vgandhi@codeaurora.org,
	wim@iguana.be, jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
	mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
	rjw@rjwysocki.net
Subject: Re: [PATCH v5 4/8] Watchdog: introdouce "pretimeout" into framework
References: <=fu.wei@linaro.org> <1433943713-32466-1-git-send-email-fu.wei@linaro.org> <1433943713-32466-5-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1433943713-32466-5-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/10/2015 06:41 AM, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> Also update Documentation/watchdog/watchdog-kernel-api.txt to
> introduce:
> (1)the new elements in the watchdog_device and watchdog_ops struct;
> (2)the new API "watchdog_init_timeouts"
>
> Reasons:
> (1)kernel already has two watchdog drivers are using "pretimeout":
> 	drivers/char/ipmi/ipmi_watchdog.c
> 	drivers/watchdog/kempld_wdt.c(but the definition is different)
> (2)some other drivers are going to use this: ARM SBSA Generic Watchdog
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>   Documentation/watchdog/watchdog-kernel-api.txt |  47 ++++++++++--
>   drivers/watchdog/watchdog_core.c               | 100 +++++++++++++++++--------
>   drivers/watchdog/watchdog_dev.c                |  53 +++++++++++++
>   include/linux/watchdog.h                       |  36 ++++++++-
>   4 files changed, 197 insertions(+), 39 deletions(-)
>
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index a0438f3..95b355d 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -49,6 +49,9 @@ struct watchdog_device {
>   	unsigned int timeout;
>   	unsigned int min_timeout;
>   	unsigned int max_timeout;
> +	unsigned int pretimeout;
> +	unsigned int min_pretimeout;
> +	unsigned int max_pretimeout;
>   	void *driver_data;
>   	struct mutex lock;
>   	unsigned long status;
> @@ -70,6 +73,9 @@ It contains following fields:
>   * timeout: the watchdog timer's timeout value (in seconds).
>   * min_timeout: the watchdog timer's minimum timeout value (in seconds).
>   * max_timeout: the watchdog timer's maximum timeout value (in seconds).
> +* pretimeout: the watchdog timer's pretimeout value (in seconds).
> +* min_pretimeout: the watchdog timer's minimum pretimeout value (in seconds).
> +* max_pretimeout: the watchdog timer's maximum pretimeout value (in seconds).
>   * bootstatus: status of the device after booting (reported with watchdog
>     WDIOF_* status bits).
>   * driver_data: a pointer to the drivers private data of a watchdog device.
> @@ -92,6 +98,7 @@ struct watchdog_ops {
>   	int (*ping)(struct watchdog_device *);
>   	unsigned int (*status)(struct watchdog_device *);
>   	int (*set_timeout)(struct watchdog_device *, unsigned int);
> +	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
>   	unsigned int (*get_timeleft)(struct watchdog_device *);
>   	void (*ref)(struct watchdog_device *);
>   	void (*unref)(struct watchdog_device *);
> @@ -153,9 +160,19 @@ they are supported. These optional routines/operations are:
>     and -EIO for "could not write value to the watchdog". On success this
>     routine should set the timeout value of the watchdog_device to the
>     achieved timeout value (which may be different from the requested one
> -  because the watchdog does not necessarily has a 1 second resolution).
> +  because the watchdog does not necessarily has a 1 second resolution;
> +  If the driver supports pretimeout, then the timeout value must be greater
> +  than that).
>     (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
>     watchdog's info structure).
> +* set_pretimeout: this routine checks and changes the pretimeout of the
> +  watchdog timer device. It returns 0 on success, -EINVAL for "parameter out of
> +  range" and -EIO for "could not write value to the watchdog". On success this
> +  routine should set the pretimeout value of the watchdog_device to the
> +  achieved pretimeout value (which may be different from the requested one
> +  because the watchdog does not necessarily has a 1 second resolution).
> +  (Note: the WDIOF_PRETIMEOUT needs to be set in the options field of the
> +  watchdog's info structure).
>   * get_timeleft: this routines returns the time that's left before a reset.
>   * ref: the operation that calls kref_get on the kref of a dynamically
>     allocated watchdog_device struct.
> @@ -219,8 +236,28 @@ extern int watchdog_init_timeout(struct watchdog_device *wdd,
>                                     unsigned int timeout_parm, struct device *dev);
>
>   The watchdog_init_timeout function allows you to initialize the timeout field
> -using the module timeout parameter or by retrieving the timeout-sec property from
> -the device tree (if the module timeout parameter is invalid). Best practice is
> -to set the default timeout value as timeout value in the watchdog_device and
> -then use this function to set the user "preferred" timeout value.
> +using the module timeout parameter or by retrieving the first element of
> +the timeout-sec property from the device tree (if the module timeout parameter

Missing space before (.

> +is invalid). Best practice is to set the default timeout value as timeout value
> +in the watchdog_device and then use this function to set the user "preferred"
> +timeout value.
> +This routine returns zero on success and a negative errno code for failure.
> +
> +Some watchdog timers have two stage of timeouts(timeout and pretimeout),
> +to initialize the timeout and pretimeout fields at the same time, the following
> +function can be used:
> +
> +extern int watchdog_init_timeouts(struct watchdog_device *wdd,
> +                                  unsigned int pretimeout_parm,
> +                                  unsigned int timeout_parm,
> +                                  struct device *dev);
> +
> +The watchdog_init_timeouts function allows you to initialize the pretimeout and
> +timeout fields using the module pretimeout and timeout parameter or by
> +retrieving the elements in the timeout-sec property(the first element is for
> +timeout, the second one is for pretimeout) from the device tree(if the module
> +pretimeout and timeout parameter are invalid).

Missing spaces before (.

> +Best practice is to set the default pretimeout and timeout value as pretimeout
> +and timeout value in the watchdog_device and then use this function to set the
> +user "preferred" pretimeout value.
>   This routine returns zero on success and a negative errno code for failure.
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index cec9b55..bdd4e43 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -43,60 +43,98 @@
>   static DEFINE_IDA(watchdog_ida);
>   static struct class *watchdog_class;
>
> -static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
> +static void watchdog_check_min_max_timeouts(struct watchdog_device *wdd)

Please don't rename this function. This avoids conflicts with other pending
patches.

>   {
>   	/*
> -	 * Check that we have valid min and max timeout values, if
> -	 * not reset them both to 0 (=not used or unknown)
> +	 * Check that we have valid min and max pretimeout and timeout values,
> +	 * if not, reset them all to 0 (=not used or unknown)
>   	 */
> -	if (wdd->min_timeout > wdd->max_timeout) {
> -		pr_info("Invalid min and max timeout values, resetting to 0!\n");
> +	if (wdd->min_pretimeout > wdd->max_pretimeout ||
> +	    wdd->min_timeout > wdd->max_timeout ||
> +	    wdd->min_timeout < wdd->min_pretimeout ||
> +	    wdd->max_timeout < wdd->max_pretimeout) {
> +		pr_info("Invalid min and max timeouts, resetting to 0\n");

timeouts or pretimeouts.

> +		wdd->min_pretimeout = 0;
> +		wdd->max_pretimeout = 0;
>   		wdd->min_timeout = 0;
>   		wdd->max_timeout = 0;
>   	}
>   }
>
>   /**
> - * watchdog_init_timeout() - initialize the timeout field
> + * watchdog_init_timeouts() - initialize the pretimeout and timeout field
> + * @pretimeout_parm: pretimeout module parameter
>    * @timeout_parm: timeout module parameter
>    * @dev: Device that stores the timeout-sec property
>    *
> - * Initialize the timeout field of the watchdog_device struct with either the
> - * timeout module parameter (if it is valid value) or the timeout-sec property
> - * (only if it is a valid value and the timeout_parm is out of bounds).
> - * If none of them are valid then we keep the old value (which should normally
> - * be the default timeout value.
> + * Initialize the pretimeout and timeout field of the watchdog_device struct
> + * with either the pretimeout and timeout module parameter (if it is valid) or
> + * the timeout-sec property (only if it is valid and the pretimeout_parm or
> + * timeout_parm is out of bounds). If none of them is valid, then we keep
> + * the old value (which should normally be the default timeout value).
>    *
>    * A zero is returned on success and -EINVAL for failure.
>    */
> -int watchdog_init_timeout(struct watchdog_device *wdd,
> -				unsigned int timeout_parm, struct device *dev)
> +int watchdog_init_timeouts(struct watchdog_device *wdd,
> +			   unsigned int pretimeout_parm,
> +			   unsigned int timeout_parm,
> +			   struct device *dev)
>   {
> -	unsigned int t = 0;
> -	int ret = 0;
> +	int ret = 0, length = 0;
> +	u32 timeouts[2] = {0};
> +	struct property *prop;
>
> -	watchdog_check_min_max_timeout(wdd);
> +	watchdog_check_min_max_timeouts(wdd);
>
> -	/* try to get the timeout module parameter first */
> -	if (!watchdog_timeout_invalid(wdd, timeout_parm) && timeout_parm) {
> -		wdd->timeout = timeout_parm;
> -		return ret;
> -	}
> -	if (timeout_parm)
> +	/*
> +	 * Try to get the pretimeout module parameter first
> +	 */
> +	if (!watchdog_pretimeout_invalid(wdd, pretimeout_parm))
> +		timeouts[1] = pretimeout_parm;
> +	else
> +		ret = -EINVAL; /* pretimeout_parm is invalid */
> +
If I understand the code correctly, this permits for pretimeout being specified
as module parameter and timeout as devicetree property. I don't think this
is a good idea. Use either one or the other, but not both. So this can be
simplified to

	if (watchdog_pretimeout_invalid(wdd, pretimeout_parm)
		ret = _EINVAL;

if you use pretimeout directly below.

> +	/*
> +	 * Try to get the timeout module parameter,
> +	 * if it's valid and pretimeout is valid(ret == 0),
> +	 * assignment and return zero. Otherwise, try dtb.
> +	 */
> +	if (timeout_parm) {

You can use
	if (timeout_parm && !ret) {

> +		if (!watchdog_timeout_invalid(wdd, timeout_parm) && !ret) {

instead of checking ret here.

> +			wdd->timeout = timeout_parm;
> +			wdd->pretimeout = timeouts[1];

This is really pretimeout_parm here, which should be used.
Then you don't need timeouts[1].

> +			return 0;
> +		}
>   		ret = -EINVAL;
> +	}
>

Unfortunately this does not set wdd->pretimeout if pretimeout_parm
is set but timeout_parm isn't. So I think you need

	} else if (pretimeout_parm && !ret) {
		wdd->pretimeout = pretimeout;
		return 0;
	}

However, that actually won't work as we may try to set both timeout
and pretimeout, but the current checks validate against the previous
values. I'll need to think about that.

Also, this is getting a bit complicated. Wonder if the code can be simplified.
Something else to think about.

> -	/* try to get the timeout_sec property */
> +	/*
> +	 * Either at least one of the module parameters is invalid,
> +	 * or timeout_parm is 0. Try to get the timeout_sec property.
> +	 */
>   	if (dev == NULL || dev->of_node == NULL)
>   		return ret;
> -	of_property_read_u32(dev->of_node, "timeout-sec", &t);
> -	if (!watchdog_timeout_invalid(wdd, t) && t)
> -		wdd->timeout = t;
> -	else
> -		ret = -EINVAL;
>
> -	return ret;
> +	prop = of_find_property(dev->of_node, "timeout-sec", &length);
> +	if (prop && length > 0 && length <= sizeof(u32) * 2) {
> +		of_property_read_u32_array(dev->of_node,
> +					   "timeout-sec", timeouts,
> +					   length / sizeof(u32));
> +		if (length == sizeof(u32) * 2 &&
> +		    watchdog_pretimeout_invalid(wdd, timeouts[1]))
> +				return -EINVAL;
> +
> +		if (!watchdog_timeout_invalid(wdd, timeouts[0]) &&
> +		    timeouts[0]) {
> +			wdd->timeout = timeouts[0];
> +			wdd->pretimeout = timeouts[1];

Please only set pretimeout here if specified in devicetree.

> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
>   }
> -EXPORT_SYMBOL_GPL(watchdog_init_timeout);
> +EXPORT_SYMBOL_GPL(watchdog_init_timeouts);
>
>   /**
>    * watchdog_register_device() - register a watchdog device
> @@ -119,7 +157,7 @@ int watchdog_register_device(struct watchdog_device *wdd)
>   	if (wdd->ops->start == NULL || wdd->ops->stop == NULL)
>   		return -EINVAL;
>
> -	watchdog_check_min_max_timeout(wdd);
> +	watchdog_check_min_max_timeouts(wdd);
>
>   	/*
>   	 * Note: now that all watchdog_device data has been verified, we
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 6aaefba..af0777e 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -218,6 +218,38 @@ out_timeout:
>   }
>
>   /*
> + *	watchdog_set_pretimeout: set the watchdog timer pretimeout
> + *	@wddev: the watchdog device to set the timeout for
> + *	@pretimeout: pretimeout to set in seconds
> + */
> +
> +static int watchdog_set_pretimeout(struct watchdog_device *wddev,
> +				   unsigned int pretimeout)
> +{
> +	int err;
> +
> +	if (!wddev->ops->set_pretimeout ||
> +	    !(wddev->info->options & WDIOF_PRETIMEOUT))
> +		return -EOPNOTSUPP;
> +
> +	if (watchdog_pretimeout_invalid(wddev, pretimeout))
> +		return -EINVAL;
> +
> +	mutex_lock(&wddev->lock);
> +
> +	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
> +		err = -ENODEV;
> +		goto out_pretimeout;
> +	}
> +
> +	err = wddev->ops->set_pretimeout(wddev, pretimeout);
> +
> +out_pretimeout:
> +	mutex_unlock(&wddev->lock);
> +	return err;
> +}
> +
> +/*
>    *	watchdog_get_timeleft: wrapper to get the time left before a reboot
>    *	@wddev: the watchdog device to get the remaining time from
>    *	@timeleft: the time that's left
> @@ -388,6 +420,27 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
>   		if (wdd->timeout == 0)
>   			return -EOPNOTSUPP;
>   		return put_user(wdd->timeout, p);
> +	case WDIOC_SETPRETIMEOUT:
> +		/* check if we support the pretimeout */
> +		if (!(wdd->info->options & WDIOF_PRETIMEOUT))
> +			return -EOPNOTSUPP;
> +		if (get_user(val, p))
> +			return -EFAULT;
> +		err = watchdog_set_pretimeout(wdd, val);
> +		if (err < 0)
> +			return err;
> +		/*
> +		 * If the watchdog is active then we send a keepalive ping
> +		 * to make sure that the watchdog keeps running (and if
> +		 * possible that it takes the new pretimeout)
> +		 */
> +		watchdog_ping(wdd);
> +		/* Fall */
> +	case WDIOC_GETPRETIMEOUT:
> +		/* check if we support the pretimeout */
> +		if (wdd->info->options & WDIOF_PRETIMEOUT)
> +			return put_user(wdd->pretimeout, p);
> +		return -EOPNOTSUPP;
>   	case WDIOC_GETTIMELEFT:
>   		err = watchdog_get_timeleft(wdd, &val);
>   		if (err)
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index a746bf5..0a7acf0 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -25,6 +25,7 @@ struct watchdog_device;
>    * @ping:	The routine that sends a keepalive ping to the watchdog device.
>    * @status:	The routine that shows the status of the watchdog device.
>    * @set_timeout:The routine for setting the watchdog devices timeout value.
> + * @set_pretimeout:The routine for setting the watchdog devices pretimeout value
>    * @get_timeleft:The routine that get's the time that's left before a reset.
>    * @ref:	The ref operation for dyn. allocated watchdog_device structs
>    * @unref:	The unref operation for dyn. allocated watchdog_device structs
> @@ -44,6 +45,7 @@ struct watchdog_ops {
>   	int (*ping)(struct watchdog_device *);
>   	unsigned int (*status)(struct watchdog_device *);
>   	int (*set_timeout)(struct watchdog_device *, unsigned int);
> +	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
>   	unsigned int (*get_timeleft)(struct watchdog_device *);
>   	void (*ref)(struct watchdog_device *);
>   	void (*unref)(struct watchdog_device *);
> @@ -62,6 +64,9 @@ struct watchdog_ops {
>    * @timeout:	The watchdog devices timeout value.
>    * @min_timeout:The watchdog devices minimum timeout value.
>    * @max_timeout:The watchdog devices maximum timeout value.
> + * @pretimeout:	The watchdog devices pretimeout value.
> + * @min_pretimeout:The watchdog devices minimum pretimeout value.
> + * @max_pretimeout:The watchdog devices maximum pretimeout value.
>    * @driver-data:Pointer to the drivers private data.
>    * @lock:	Lock for watchdog core internal use only.
>    * @status:	Field that contains the devices internal status bits.
> @@ -86,6 +91,9 @@ struct watchdog_device {
>   	unsigned int timeout;
>   	unsigned int min_timeout;
>   	unsigned int max_timeout;
> +	unsigned int pretimeout;
> +	unsigned int min_pretimeout;
> +	unsigned int max_pretimeout;
>   	void *driver_data;
>   	struct mutex lock;
>   	unsigned long status;
> @@ -117,7 +125,20 @@ static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool noway
>   static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
>   {
>   	return ((wdd->max_timeout != 0) &&
> -		(t < wdd->min_timeout || t > wdd->max_timeout));
> +		(t < wdd->min_timeout || t > wdd->max_timeout ||
> +			t <= wdd->pretimeout));

pretimeout can be 0, and t needs to be evaluated against pretimeout even if
max_timeout is 0.

Try
	return (wdd->max_timeout &&
		(t < wdd->min_timeout || t > wdd->max_timeout)) ||
	       (wdd->pretimeout && t <= wdd->pretimeout);

> +}
> +
> +/*
> + * Use the following function to check if a pretimeout value is invalid.
> + * It can be "0", that means we don't use pretimeout.
> + */
> +static inline bool watchdog_pretimeout_invalid(struct watchdog_device *wdd,
> +					       unsigned int t)
> +{
> +	return (wdd->pretimeout != 0 && wdd->max_pretimeout != 0 &&
> +		(t < wdd->min_pretimeout || t > wdd->max_pretimeout ||
> +			(wdd->timeout != 0 && t >= wdd->timeout)));

The check for wdd->pretimeout doesn't make much sense here, as this is the
value we are trying to set. Effectively the above accepts every pretimeout
if wdd->pretimeout is 0. It also accepts every pretimeout if
max_pretimeout == 0, even if wdd->timeout is set and t >= wdd->timeout.

Try

	return (wdd->max_pretimeout && (t < wdd->min_pretimeout ||
					t > wdd->max_pretimeout)) ||
		(wdd->timeout && t >= wdd->timeout);

>   }
>
>   /* Use the following functions to manipulate watchdog driver specific data */
> @@ -132,11 +153,20 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
>   }
>
>   /* drivers/watchdog/watchdog_core.c */
> -extern int watchdog_init_timeout(struct watchdog_device *wdd,
> -				  unsigned int timeout_parm, struct device *dev);
> +int watchdog_init_timeouts(struct watchdog_device *wdd,
> +				  unsigned int pretimeout_parm,
> +				  unsigned int timeout_parm,
> +				  struct device *dev);

Please align continuation lines with '('.

>   extern int watchdog_register_device(struct watchdog_device *);
>   extern void watchdog_unregister_device(struct watchdog_device *);
>
> +static inline int watchdog_init_timeout(struct watchdog_device *wdd,
> +					unsigned int timeout_parm,
> +					struct device *dev)
> +{
> +	return watchdog_init_timeouts(wdd, 0, timeout_parm, dev);
> +}
> +
>   #ifdef CONFIG_HARDLOCKUP_DETECTOR
>   void watchdog_nmi_disable_all(void);
>   void watchdog_nmi_enable_all(void);
>

