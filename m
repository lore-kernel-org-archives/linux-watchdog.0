Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57706 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbbKTDSh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 19 Nov 2015 22:18:37 -0500
Subject: Re: [PATCH 1/7] watchdog: core: add reboot notifier support
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
References: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1447880542-19320-2-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564E9107.2010403@roeck-us.net>
Date: Thu, 19 Nov 2015 19:18:31 -0800
MIME-Version: 1.0
In-Reply-To: <1447880542-19320-2-git-send-email-damien.riegel@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/18/2015 01:02 PM, Damien Riegel wrote:
> Many watchdog drivers register a reboot notifier in order to stop the
> watchdog on system reboot. Thus we can factorize this code in the
> watchdog core.
>
> For that purpose, a new notifier block is added in watchdog_device for
> internal use only, as well as a new watchdog_stop_on_reboot helper
> function.
>
> If this helper is called, watchdog core registers the related notifier
> block and will stop the watchdog when SYS_HALT or SYS_DOWN is received.
>
> Since this operation can be critical on some platforms, abort the device
> registration if the reboot notifier registration fails.
>

Hi Damien,

Good idea. Couple of comments below.

Thanks,
Guenter

> Suggested-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> ---
>   Documentation/watchdog/watchdog-kernel-api.txt |  8 ++++++
>   drivers/watchdog/watchdog_core.c               | 35 ++++++++++++++++++++++++++
>   include/linux/watchdog.h                       |  9 +++++++
>   3 files changed, 52 insertions(+)
>
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index dbc6a65..0a37da7 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -53,6 +53,7 @@ struct watchdog_device {
>   	unsigned int timeout;
>   	unsigned int min_timeout;
>   	unsigned int max_timeout;
> +	struct notifier_block reboot_nb;
>   	struct notifier_block restart_nb;
>   	void *driver_data;
>   	struct mutex lock;
> @@ -76,6 +77,9 @@ It contains following fields:
>   * timeout: the watchdog timer's timeout value (in seconds).
>   * min_timeout: the watchdog timer's minimum timeout value (in seconds).
>   * max_timeout: the watchdog timer's maximum timeout value (in seconds).
> +* reboot_nb: notifier block that is registered for reboot notifications, for
> +  internal use only. If the driver calls watchdog_stop_on_reboot, watchdog core
> +  will stop the watchdog on such notifications.
>   * restart_nb: notifier block that is registered for machine restart, for
>     internal use only. If a watchdog is capable of restarting the machine, it
>     should define ops->restart. Priority can be changed through
> @@ -240,6 +244,10 @@ to set the default timeout value as timeout value in the watchdog_device and
>   then use this function to set the user "preferred" timeout value.
>   This routine returns zero on success and a negative errno code for failure.
>
> +To disable the watchdog on reboot, the user must call the following helper:
> +
> +static inline void watchdog_stop_on_reboot(struct watchdog_device *wdd);
> +
>   To change the priority of the restart handler the following helper should be
>   used:
>
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 28dc901..2d49f8d 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -138,6 +138,23 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
>   }
>   EXPORT_SYMBOL_GPL(watchdog_init_timeout);
>
> +static int watchdog_reboot_notifier(struct notifier_block *nb,
> +				    unsigned long code, void *data)
> +{
> +	struct watchdog_device *wdd = container_of(nb, struct watchdog_device,
> +						   reboot_nb);
> +
> +	if (code == SYS_DOWN || code == SYS_HALT) {
> +		int ret;
> +
> +		ret = wdd->ops->stop(wdd);

Nitpick, maybe, but only stop if running ?
Maybe that isn't a problem, but I am a bit concerned about side
effects of trying to stop a watchdog which isn't running.

> +		if (ret)
> +			return NOTIFY_BAD;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>   static int watchdog_restart_notifier(struct notifier_block *nb,
>   				     unsigned long action, void *data)
>   {
> @@ -238,6 +255,21 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>   		return ret;
>   	}
>
> +	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
> +		wdd->reboot_nb.notifier_call = watchdog_reboot_notifier;
> +
> +		ret = register_reboot_notifier(&wdd->reboot_nb);
> +		if (ret) {
> +			dev_err(wdd->dev, "Cannot register reboot notifier (%d)\n",
> +				ret);
> +			watchdog_dev_unregister(wdd);
> +			device_destroy(watchdog_class, devno);
> +			ida_simple_remove(&watchdog_ida, wdd->id);
> +			wdd->dev = NULL;
> +			return ret;

At some point this really asks for a proper error handler in this function.
Separate patch, though.

> +		}
> +	}
> +
>   	if (wdd->ops->restart) {
>   		wdd->restart_nb.notifier_call = watchdog_restart_notifier;
>
> @@ -286,6 +318,9 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
>   	if (wdd->ops->restart)
>   		unregister_restart_handler(&wdd->restart_nb);
>
> +	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status))
> +		unregister_reboot_notifier(&wdd->reboot_nb);
> +
>   	devno = wdd->cdev.dev;
>   	ret = watchdog_dev_unregister(wdd);
>   	if (ret)
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 5b52c83..a88f955 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -65,6 +65,7 @@ struct watchdog_ops {
>    * @timeout:	The watchdog devices timeout value (in seconds).
>    * @min_timeout:The watchdog devices minimum timeout value (in seconds).
>    * @max_timeout:The watchdog devices maximum timeout value (in seconds).
> + * @reboot_nb:	The notifier block to stop watchdog on reboot.
>    * @restart_nb:	The notifier block to register a restart function.
>    * @driver-data:Pointer to the drivers private data.
>    * @lock:	Lock for watchdog core internal use only.
> @@ -92,6 +93,7 @@ struct watchdog_device {
>   	unsigned int timeout;
>   	unsigned int min_timeout;
>   	unsigned int max_timeout;
> +	struct notifier_block reboot_nb;
>   	struct notifier_block restart_nb;
>   	void *driver_data;
>   	struct mutex lock;
> @@ -102,6 +104,7 @@ struct watchdog_device {
>   #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
>   #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
>   #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
> +#define WDOG_STOP_ON_REBOOT	5	/* Should be stopped on reboot */
>   	struct list_head deferred;
>   };
>
> @@ -121,6 +124,12 @@ static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool noway
>   		set_bit(WDOG_NO_WAY_OUT, &wdd->status);
>   }
>
> +/* Use the following function to stop the watchdog on reboot */
> +static inline void watchdog_stop_on_reboot(struct watchdog_device *wdd)
> +{
> +	set_bit(WDOG_STOP_ON_REBOOT, &wdd->status);
> +}
> +
>   /* Use the following function to check if a timeout value is invalid */
>   static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
>   {
>

