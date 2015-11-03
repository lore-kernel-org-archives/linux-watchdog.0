Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48283 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbbKCHlZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 02:41:25 -0500
Subject: Re: [PATCH v2 1/2] watchdog: add WDIOC_SETPRETIMEOUT and
 WDIOC_GETPRETIMEOUT
To: Robin Gong <b38343@freescale.com>, wim@iguana.be
References: <1446531084-15365-1-git-send-email-b38343@freescale.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56386522.3000505@roeck-us.net>
Date: Mon, 2 Nov 2015 23:41:22 -0800
MIME-Version: 1.0
In-Reply-To: <1446531084-15365-1-git-send-email-b38343@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/02/2015 10:11 PM, Robin Gong wrote:
> Since the watchdog common framework centrialize the IOCTL interfaces of
> device driver now, the SETPRETIMEOUT and GETPRETIMEOUT need to be added
> in the common code.
>
> Signed-off-by: Robin Gong <b38343@freescale.com>
> ---

It would help if you could document the changes made here.

>   drivers/watchdog/watchdog_dev.c | 37 +++++++++++++++++++++++++++++++++++++
>   include/linux/watchdog.h        | 10 ++++++++++
>   2 files changed, 47 insertions(+)
>
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
> index d74a0e9..f936152 100644
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
> @@ -86,6 +88,7 @@ struct watchdog_device {
>   	const struct watchdog_ops *ops;
>   	unsigned int bootstatus;
>   	unsigned int timeout;
> +	unsigned int pretimeout;

This new variable also needs to be added to and documented in
Documentation/watchdog/watchdog-kernel-api.txt.

Thanks,
Guenter

>   	unsigned int min_timeout;
>   	unsigned int max_timeout;
>   	void *driver_data;
> @@ -123,6 +126,13 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
>   		(t < wdd->min_timeout || t > wdd->max_timeout));
>   }
>
> +/* Use the following function to check if a pretimeout value is invalid */
> +static inline bool watchdog_pretimeout_invalid(struct watchdog_device *wdd,
> +					       unsigned int t)
> +{
> +	return wdd->timeout && t >= wdd->timeout;
> +}
> +
>   /* Use the following functions to manipulate watchdog driver specific data */
>   static inline void watchdog_set_drvdata(struct watchdog_device *wdd, void *data)
>   {
>

