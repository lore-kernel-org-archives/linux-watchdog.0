Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33337 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdK1WOr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Nov 2017 17:14:47 -0500
Date: Tue, 28 Nov 2017 14:14:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Wim Van Sebroeck <wim@iguana.be>, Jonathan Corbet <corbet@lwn.net>,
        Esben Haabendal <esben@haabendal.dk>, mnhu@prevas.dk,
        linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: introduce watchdog.open_timeout
 commandline parameter
Message-ID: <20171128221445.GG10144@roeck-us.net>
References: <1511865350-20665-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1511865350-20665-2-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511865350-20665-2-git-send-email-rasmus.villemoes@prevas.dk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Nov 28, 2017 at 11:35:49AM +0100, Rasmus Villemoes wrote:
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
> The existing handle_boot_enabled parameter has the same purpose, but
> that is only usable when the hardware watchdog has a sufficiently long
> timeout (possibly configured by the bootloader). Many hardware watchdogs
> cannot be configured, or can only be configured up to a certain value,
> making the timeout short enough that it is completely impossible to have
> userspace ready soon enough. Hence it is necessary for the kernel to
> handle those watchdogs for a while.
> 
> The open timeout is also used as a maximum time for an application to
> re-open /dev/watchdogN after closing it.
> 
> A value of 0 (the default) means infinite timeout, preserving the
> current behaviour.
> 
> The unit is milliseconds rather than seconds because that covers more
> use cases. For example, one can effectively disable the kernel handling
> by setting the open_timeout to 1 ms. There are also customers with very
> strict requirements that may want to set the open_timeout to something
> like 4500 ms, which combined with a hardware watchdog that must be
> pinged every 250 ms ensures userspace is up no more than 5 seconds after
> the bootloader hands control to the kernel (250 ms until the driver gets
> registered and kernel handling starts, 4500 ms of kernel handling, and
> then up to 250 ms from the last ping until userspace takes over).

This is quite vague, especially since it doesn't count the time from
boot to starting the watchdog driver, which can vary even across boots.
Why not make it specific, for example by adjusting the open timeout with
ktime_get_boot_ns() ?

I would actually make it even more specific and calculate the open
timeout such that the system would reboot after open_timeout, not
after <open_timeout + hardware_timeout>. Any reason for not doing that ?
The upside would be more accuracy, and I don't really see a downside.

Thanks,
Guenter

> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> ---
>  Documentation/watchdog/watchdog-parameters.txt |  8 ++++++++
>  drivers/watchdog/watchdog_dev.c                | 27 +++++++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 6f9d7b4..5363bf3 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -8,6 +8,14 @@ See Documentation/admin-guide/kernel-parameters.rst for information on
>  providing kernel parameters for builtin drivers versus loadable
>  modules.
>  
> +The watchdog core parameter watchdog.open_timeout is the maximum time,
> +in milliseconds, for which the watchdog framework will take care of
> +pinging a hardware watchdog until userspace opens the corresponding
> +/dev/watchdogN device. A value of 0 (the default) means an infinite
> +timeout. Setting this to a non-zero value can be useful to ensure that
> +either userspace comes up properly, or the board gets reset and allows
> +fallback logic in the bootloader to try something else.
> +
>  
>  -------------------------------------------------
>  acquirewdt:
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 1e971a5..b4985db 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -67,6 +67,7 @@ struct watchdog_core_data {
>  	struct mutex lock;
>  	unsigned long last_keepalive;
>  	unsigned long last_hw_keepalive;
> +	unsigned long open_deadline;
>  	struct delayed_work work;
>  	unsigned long status;		/* Internal status bits */
>  #define _WDOG_DEV_OPEN		0	/* Opened ? */
> @@ -83,6 +84,19 @@ static struct workqueue_struct *watchdog_wq;
>  
>  static bool handle_boot_enabled =
>  	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
> +static unsigned open_timeout;
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
>  
>  static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>  {
> @@ -200,7 +214,13 @@ static bool watchdog_worker_should_ping(struct watchdog_core_data *wd_data)
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
> @@ -861,6 +881,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
>  		watchdog_ping(wdd);
>  	}
>  
> +	watchdog_set_open_deadline(wd_data);
>  	watchdog_update_worker(wdd);
>  
>  	/* make sure that /dev/watchdog can be re-opened */
> @@ -959,6 +980,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>  
>  	/* Record time of most recent heartbeat as 'just before now'. */
>  	wd_data->last_hw_keepalive = jiffies - 1;
> +	watchdog_set_open_deadline(wd_data);
>  
>  	/*
>  	 * If the watchdog is running, prevent its driver from being unloaded,
> @@ -1156,3 +1178,6 @@ module_param(handle_boot_enabled, bool, 0444);
>  MODULE_PARM_DESC(handle_boot_enabled,
>  	"Watchdog core auto-updates boot enabled watchdogs before userspace takes over (default="
>  	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)) ")");
> +module_param(open_timeout, uint, 0644);
> +MODULE_PARM_DESC(open_timeout,
> +		 "Maximum time in milliseconds for userspace to take over handling enabled watchdogs (0 = infinite)");
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
