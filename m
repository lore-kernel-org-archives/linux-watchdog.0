Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39340 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034024AbdEYA4O (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 24 May 2017 20:56:14 -0400
Subject: Re: [PATCH v5 2/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Wim Van Sebroeck <wim@iguana.be>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        esben.haabendal@gmail.com, linux-watchdog@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1495462000-28979-3-git-send-email-rasmus.villemoes@prevas.dk>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d0da1701-5500-9cbb-eed1-5581e1a88b60@roeck-us.net>
Date: Wed, 24 May 2017 17:56:11 -0700
MIME-Version: 1.0
In-Reply-To: <1495462000-28979-3-git-send-email-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/22/2017 07:06 AM, Rasmus Villemoes wrote:
> The watchdog framework takes care of feeding a hardware watchdog until
> userspace opens /dev/watchdogN. If that never happens for some reason
> (buggy init script, corrupt root filesystem or whatnot) but the kernel
> itself is fine, the machine stays up indefinitely. This patch allows
> setting an upper limit for how long the kernel will take care of the
> watchdog, thus ensuring that the watchdog will eventually reset the
> machine.
> 
> This is particularly useful for embedded devices where some fallback
> logic is implemented in the bootloader (e.g., use a different root
> partition, boot from network, ...).
> 
> The open timeout is also used as a maximum time for an application to
> re-open /dev/watchdogN after closing it.
> 
> A value of 0 (the default) means infinite timeout, preserving the
> current behaviour.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   Documentation/watchdog/watchdog-parameters.txt |  9 +++++++++
>   drivers/watchdog/watchdog_dev.c                | 26 +++++++++++++++++++++++++-
>   2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 914518a..4801ec6 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -8,6 +8,15 @@ See Documentation/admin-guide/kernel-parameters.rst for information on
>   providing kernel parameters for builtin drivers versus loadable
>   modules.
>   
> +The watchdog core currently understands one parameter,

We have a second parameter queued, handle_boot_enabled. Please rephrase
so we don't have to change the text with each new parameter.

Thanks,
Guenter

> +watchdog.open_timeout. This is the maximum time, in milliseconds, for
> +which the watchdog framework will take care of pinging a hardware
> +watchdog until userspace opens the corresponding /dev/watchdogN
> +device. A value of 0 (the default) means an infinite timeout. Setting
> +this to a non-zero value can be useful to ensure that either userspace
> +comes up properly, or the board gets reset and allows fallback logic
> +in the bootloader to try something else.
> +
>   
>   -------------------------------------------------
>   acquirewdt:
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index caa4b90..c807067 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -66,6 +66,7 @@ struct watchdog_core_data {
>   	struct mutex lock;
>   	unsigned long last_keepalive;
>   	unsigned long last_hw_keepalive;
> +	unsigned long open_deadline;
>   	struct delayed_work work;
>   	unsigned long status;		/* Internal status bits */
>   #define _WDOG_DEV_OPEN		0	/* Opened ? */
> @@ -80,6 +81,21 @@ static struct watchdog_core_data *old_wd_data;
>   
>   static struct workqueue_struct *watchdog_wq;
>   
> +static unsigned open_timeout;
> +module_param(open_timeout, uint, 0644);
> +
> +static bool watchdog_past_open_deadline(struct watchdog_core_data *data)
> +{
> +	if (!open_timeout)
> +		return false;
> +	return time_is_before_jiffies(data->open_deadline);
> +}
> +
> +static void watchdog_set_open_deadline(struct watchdog_core_data *data)
> +{
> +	data->open_deadline = jiffies + msecs_to_jiffies(open_timeout);
> +}
> +
>   static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>   {
>   	/* All variables in milli-seconds */
> @@ -196,7 +212,13 @@ static bool watchdog_worker_should_ping(struct watchdog_core_data *wd_data)
>   {
>   	struct watchdog_device *wdd = wd_data->wdd;
>   
> -	return wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd));
> +	if (!wdd)
> +		return false;
> +
> +	if (watchdog_active(wdd))
> +		return true;
> +
> +	return watchdog_hw_running(wdd) && !watchdog_past_open_deadline(wd_data);
>   }
>   
>   static void watchdog_ping_work(struct work_struct *work)
> @@ -857,6 +879,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
>   		watchdog_ping(wdd);
>   	}
>   
> +	watchdog_set_open_deadline(wd_data);
>   	watchdog_update_worker(wdd);
>   
>   	/* make sure that /dev/watchdog can be re-opened */
> @@ -955,6 +978,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>   
>   	/* Record time of most recent heartbeat as 'just before now'. */
>   	wd_data->last_hw_keepalive = jiffies - 1;
> +	watchdog_set_open_deadline(wd_data);
>   
>   	/*
>   	 * If the watchdog is running, prevent its driver from being unloaded,
> 

