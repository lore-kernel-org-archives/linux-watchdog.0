Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48433 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755882AbdAJSIV (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jan 2017 13:08:21 -0500
Date: Tue, 10 Jan 2017 10:08:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Wim Van Sebroeck <wim@iguana.be>, Jonathan Corbet <corbet@lwn.net>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
Message-ID: <20170110180818.GC13904@roeck-us.net>
References: <1483974153-466-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1483974153-466-3-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483974153-466-3-git-send-email-rasmus.villemoes@prevas.dk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 09, 2017 at 04:02:32PM +0100, Rasmus Villemoes wrote:
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
>  Documentation/watchdog/watchdog-parameters.txt |  9 +++++++++
>  drivers/watchdog/watchdog_dev.c                | 26 +++++++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index e21850e..2ae0fdf 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -8,6 +8,15 @@ See Documentation/admin-guide/kernel-parameters.rst for information on
>  providing kernel parameters for builtin drivers versus loadable
>  modules.
>  
> +The watchdog core currently understands one parameter,
> +watchdog.open_timeout. This is the maximum time, in milliseconds, for
> +which the watchdog framework will take care of pinging a hardware
> +watchdog until userspace opens the corresponding /dev/watchdogN
> +device. A value of 0 (the default) means an infinite timeout. Setting
> +this to a non-zero value can be useful to ensure that either userspace
> +comes up properly, or the board gets reset and allows fallback logic
> +in the bootloader to try something else.
> +
>  
>  -------------------------------------------------
>  acquirewdt:
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 21809e4..8bc9f24 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -66,6 +66,7 @@ struct watchdog_core_data {
>  	struct mutex lock;
>  	unsigned long last_keepalive;
>  	unsigned long last_hw_keepalive;
> +	unsigned long open_deadline;
>  	struct delayed_work work;
>  	unsigned long status;		/* Internal status bits */
>  #define _WDOG_DEV_OPEN		0	/* Opened ? */
> @@ -80,6 +81,21 @@ static struct watchdog_core_data *old_wd_data;
>  
>  static struct workqueue_struct *watchdog_wq;
>  
> +static unsigned open_timeout;
> +module_param(open_timeout, uint, 0644);
> +
> +static bool watchdog_past_open_deadline(struct watchdog_core_data *data)
> +{
> +	if (!open_timeout)
> +		return false;
> +	return time_is_before_jiffies(data->open_deadline);

Doesn't this return true if the time is _before_ the open deadline ?
Should it be time_is_after_jiffies() ?

> +}
> +
> +static void watchdog_set_open_deadline(struct watchdog_core_data *data)
> +{
> +	data->open_deadline = jiffies + msecs_to_jiffies(open_timeout);

The open deadline as defined applies to the time after the device was
instantiated, not to the time since boot. Would it be better to make it
"time since boot" ?

Also, are you sure about using milli-seconds (instead of seconds) ?
I can not really imagine a situation where this would be needed
(especially and even more so in the context of using "time after
instantiating").

Thanks,
Guenter

> +}
> +
>  static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>  {
>  	/* All variables in milli-seconds */
> @@ -196,7 +212,13 @@ static bool watchdog_worker_should_ping(struct watchdog_core_data *wd_data)
>  {
>  	struct watchdog_device *wdd = wd_data->wdd;
>  
> -	return wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd));
> +	if (!wdd)
> +		return false;
> +
> +	if (watchdog_active(wdd))
> +		return true;
> +
> +	return watchdog_hw_running(wdd) && !watchdog_past_open_deadline(wd_data);
>  }
>  
>  static void watchdog_ping_work(struct work_struct *work)
> @@ -857,6 +879,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
>  		watchdog_ping(wdd);
>  	}
>  
> +	watchdog_set_open_deadline(wd_data);
>  	watchdog_update_worker(wdd);
>  
>  	/* make sure that /dev/watchdog can be re-opened */
> @@ -955,6 +978,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>  
>  	/* Record time of most recent heartbeat as 'just before now'. */
>  	wd_data->last_hw_keepalive = jiffies - 1;
> +	watchdog_set_open_deadline(wd_data);
>  
>  	/*
>  	 * If the watchdog is running, prevent its driver from being unloaded,
> -- 
> 2.7.4
> 
