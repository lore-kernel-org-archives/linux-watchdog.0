Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47011 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759585AbbKUDa4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Nov 2015 22:30:56 -0500
Subject: Re: [PATCH v3 1/2] watchdog: add WDIOC_SETPRETIMEOUT and
 WDIOC_GETPRETIMEOUT
To: Robin Gong <b38343@freescale.com>, wim@iguana.be, corbet@lwn.net
References: <1446539294-15419-1-git-send-email-b38343@freescale.com>
Cc: linux-doc@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564FE56B.4060008@roeck-us.net>
Date: Fri, 20 Nov 2015 19:30:51 -0800
MIME-Version: 1.0
In-Reply-To: <1446539294-15419-1-git-send-email-b38343@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/03/2015 12:28 AM, Robin Gong wrote:
> Since the watchdog common framework centrialize the IOCTL interfaces of
> device driver now, the SETPRETIMEOUT and GETPRETIMEOUT need to be added
> in the common code.
>

Hi Robin,

Sorry for the long delay. I finally found the time to think about this.
I like the approach - it is simple and straightforward - but we'll need
to do a bit more.

First, we need to define the semantics. It must be possible to disable the
pretimeout, which we probably want to do by setting it to 0.

Second, we need to decide what to do when the _timeout_ is updated and the
pretimeout is configured but would be out of range. The easy solution would be
to update pretimeout to "timeout - 1" in that case. That would be tricky, though,
since it would have to be set _before_ updating the timeout, and the actually
selected timeout may differ from the asked for timeout.

Therefore, I think this should be left to the driver: Add a note stating that
the driver is responsible for updating pretimeout to a valid range if the
timeout is changed. Only the driver can implement this without race condition.

Some of the necessary changes outlined below.

Thanks,
Guenter

> Signed-off-by: Robin Gong <b38343@freescale.com>
> ---
>   Documentation/watchdog/watchdog-kernel-api.txt | 12 +++++++++
>   drivers/watchdog/watchdog_dev.c                | 37 ++++++++++++++++++++++++++
>   include/linux/watchdog.h                       | 11 ++++++++
>   3 files changed, 60 insertions(+)
>
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index d8b0d33..20aa841 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -51,6 +51,7 @@ struct watchdog_device {
>   	const struct watchdog_ops *ops;
>   	unsigned int bootstatus;
>   	unsigned int timeout;
> +	unsigned int pretimeout;
>   	unsigned int min_timeout;
>   	unsigned int max_timeout;
>   	void *driver_data;
> @@ -73,6 +74,7 @@ It contains following fields:
>     additional information about the watchdog timer itself. (Like it's unique name)
>   * ops: a pointer to the list of watchdog operations that the watchdog supports.
>   * timeout: the watchdog timer's timeout value (in seconds).
> +* pretimeout:	The watchdog devices pre_timeout value.

    ... (in seconds)

>   * min_timeout: the watchdog timer's minimum timeout value (in seconds).
>   * max_timeout: the watchdog timer's maximum timeout value (in seconds).
>   * bootstatus: status of the device after booting (reported with watchdog
> @@ -99,6 +101,7 @@ struct watchdog_ops {
>   	int (*ping)(struct watchdog_device *);
>   	unsigned int (*status)(struct watchdog_device *);
>   	int (*set_timeout)(struct watchdog_device *, unsigned int);
> +	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
>   	unsigned int (*get_timeleft)(struct watchdog_device *);
>   	void (*ref)(struct watchdog_device *);
>   	void (*unref)(struct watchdog_device *);
> @@ -163,6 +166,15 @@ they are supported. These optional routines/operations are:
>     because the watchdog does not necessarily has a 1 second resolution).
>     (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
>     watchdog's info structure).

Add note to set_timeout semantics stating that the driver is responsible
for updating pretimeout if supported and enabled, and if the new timeout
conflicts with the old pretimeout.

> +* set_pretimeout: this routine check and changes the pre_timeout value of
> +  the watchdog, because some watchdog device can trigger the pre_timeout
> +  interrupt before watchdog timeout event happened, so that we have chance
> +  to save some critical information or something else before watchdog
> +  triggered. The pre_timeout value means the number of seconds before
> +  watchdog timeout.It returns 0 on success, -EINVAL for "parameter out
Missing space         ^

> +  of range" and and -EIO for "could not write value to the watchdog".
> +  (Note: the WDIOF_SETPRETIMEOUT needs to be set in the options field of the
> +  watchdog's info structure).

Also add a note that setting pretimeout to 0 disables it.

>   * get_timeleft: this routines returns the time that's left before a reset.
>   * ref: the operation that calls kref_get on the kref of a dynamically
>     allocated watchdog_device struct.
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 6aaefba..f4a02e5 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -218,6 +218,37 @@ out_timeout:
>   }
>
>   /*
> + *	watchdog_set_pretimeout: set the watchdog timer pretimeout
> + *	@wddev: the watchdog device to set the timeout for
> + *	@timeout: pretimeout to set in seconds
> + */
> +
> +static int watchdog_set_pretimeout(struct watchdog_device *wddev,
> +				   unsigned int timeout)
> +{
> +	int err;
> +
> +	if (!wddev->ops->set_pretimeout ||
> +	    !(wddev->info->options & WDIOF_PRETIMEOUT))
> +		return -EOPNOTSUPP;
> +	if (watchdog_pretimeout_invalid(wddev, timeout))
> +		return -EINVAL;
> +
> +	mutex_lock(&wddev->lock);
> +
> +	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
> +		err = -ENODEV;
> +		goto out_timeout;
> +	}
> +
> +	err = wddev->ops->set_pretimeout(wddev, timeout);
> +
> +out_timeout:
> +	mutex_unlock(&wddev->lock);
> +	return err;
> +}
> +

We'll also want a function watchdog_init_pretimeout(), similar to
watchdog_init_timeout().

> +/*
>    *	watchdog_get_timeleft: wrapper to get the time left before a reboot
>    *	@wddev: the watchdog device to get the remaining time from
>    *	@timeleft: the time that's left
> @@ -393,6 +424,12 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
>   		if (err)
>   			return err;
>   		return put_user(val, p);
> +	case WDIOC_SETPRETIMEOUT:
> +		if (get_user(val, p))
> +			return -EFAULT;
> +		return watchdog_set_pretimeout(wdd, val);
> +	case WDIOC_GETPRETIMEOUT:
> +		return put_user(wdd->pretimeout, p);
>   	default:
>   		return -ENOTTY;
>   	}
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index d74a0e9..281b949 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -25,6 +25,7 @@ struct watchdog_device;
>    * @ping:	The routine that sends a keepalive ping to the watchdog device.
>    * @status:	The routine that shows the status of the watchdog device.
>    * @set_timeout:The routine for setting the watchdog devices timeout value.
> + * @set_pretimeout:The routine for setting the watchdog devices pretimeout.
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
> @@ -60,6 +62,7 @@ struct watchdog_ops {
>    * @ops:	Pointer to the list of watchdog operations.
>    * @bootstatus:	Status of the watchdog device at boot.
>    * @timeout:	The watchdog devices timeout value.
> + * @pretimeout: The watchdog devices pre_timeout value.
>    * @min_timeout:The watchdog devices minimum timeout value.
>    * @max_timeout:The watchdog devices maximum timeout value.
>    * @driver-data:Pointer to the drivers private data.
> @@ -86,6 +89,7 @@ struct watchdog_device {
>   	const struct watchdog_ops *ops;
>   	unsigned int bootstatus;
>   	unsigned int timeout;
> +	unsigned int pretimeout;
>   	unsigned int min_timeout;
>   	unsigned int max_timeout;
>   	void *driver_data;
> @@ -123,6 +127,13 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
>   		(t < wdd->min_timeout || t > wdd->max_timeout));
>   }
>
> +/* Use the following function to check if a pretimeout value is invalid */
> +static inline bool watchdog_pretimeout_invalid(struct watchdog_device *wdd,
> +					       unsigned int t)
> +{
> +	return wdd->timeout && t >= wdd->timeout;

0 is valid:

	return t && wdd->timeout && t >= wdd->timeout;

> +}
> +
>   /* Use the following functions to manipulate watchdog driver specific data */
>   static inline void watchdog_set_drvdata(struct watchdog_device *wdd, void *data)
>   {
>

