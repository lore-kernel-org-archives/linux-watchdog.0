Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42212 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756139AbdABPWn (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 2 Jan 2017 10:22:43 -0500
Subject: Re: [PATCH v3 2/2] watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1481534273-7600-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1481722654-6266-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1481722654-6266-3-git-send-email-rasmus.villemoes@prevas.dk>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <02c2de88-fa70-39ee-b9e3-89e0dee5523c@roeck-us.net>
Date: Mon, 2 Jan 2017 07:22:39 -0800
MIME-Version: 1.0
In-Reply-To: <1481722654-6266-3-git-send-email-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/14/2016 05:37 AM, Rasmus Villemoes wrote:
> The watchdog framework takes care of feeding a hardware watchdog until
> userspace opens /dev/watchdogN. If that never happens for some reason
> (buggy init script, corrupt root filesystem or whatnot) but the kernel
> itself is fine, the machine stays up indefinitely. This patch allows
> setting an upper limit for how long the kernel will take care of the
> watchdog, thus ensuring that the watchdog will eventually reset the
> machine if userspace fails to come up.
>
> This is particularly useful for embedded devices where some fallback
> logic is implemented in the bootloader (e.g., use a different root
> partition, boot from network, ...).
>
> The open timeout is also used as a maximum time for an application to
> re-open /dev/watchdogN after closing it.
>
> The open timeout is taken from the device property "open-timeout", and
> if that is not present, defaults to CONFIG_WATCHDOG_OPEN_TIMEOUT, which
> in turn defaults to 0, which means there is no upper limit (as must be
> the default, since there may be existing systems out there relying on
> the kernel taking care of the watchdog forever).
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  drivers/watchdog/Kconfig         | 14 ++++++++++++++
>  drivers/watchdog/watchdog_core.c | 16 ++++++++++++++++
>  drivers/watchdog/watchdog_dev.c  | 22 +++++++++++++++++++++-
>  include/linux/watchdog.h         |  7 +++++++
>  4 files changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 3eb58cb..890418c 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -52,6 +52,20 @@ config WATCHDOG_SYSFS
>  	  Say Y here if you want to enable watchdog device status read through
>  	  sysfs attributes.
>
> +config WATCHDOG_OPEN_TIMEOUT
> +	int "Default timeout value for opening watchdog device (seconds)"
> +	default 0
> +	help
> +	  If a watchdog driver indicates to the framework that the
> +	  hardware watchdog is running, the framework takes care of
> +	  pinging the watchdog until userspace opens
> +	  /dev/watchdogN. This value (overridden by the device's
> +	  "open-timeout" property if present) sets an upper bound for
> +	  how long the kernel does this - thus, if userspace hasn't
> +	  opened the device within the timeout, the board reboots. A
> +	  value of 0 means there is no timeout.
> +
> +

Dual empty line. Also, as mentioned before, I am not a friend of such
configuration variables. It forces distribution vendors to make the decision
for everyone. Please consider defining a command line parameter such as
watchdog_open_timeout.

>  #
>  # General Watchdog drivers
>  #
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 74265b2..d968e0f 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -38,6 +38,7 @@
>  #include <linux/idr.h>		/* For ida_* macros */
>  #include <linux/err.h>		/* For IS_ERR macros */
>  #include <linux/of.h>		/* For of_get_timeout_sec */
> +#include <linux/property.h>	/* For device_property_read_u32 */
>
>  #include "watchdog_core.h"	/* For watchdog_dev_register/... */
>
> @@ -191,6 +192,19 @@ void watchdog_set_restart_priority(struct watchdog_device *wdd, int priority)
>  }
>  EXPORT_SYMBOL_GPL(watchdog_set_restart_priority);
>
> +static void
> +watchdog_set_open_timeout(struct watchdog_device *wdd)
> +{
> +	u32 t;
> +	struct device *dev;
> +
> +	dev = wdd->parent;
> +	if (dev && !device_property_read_u32(dev, "open-timeout", &t))
> +		wdd->open_timeout = t;

The check if dev == NULL is unnecessary.

New devicetree properties need to be documented and approved by devicetree maintainers.

> +	else
> +		wdd->open_timeout = CONFIG_WATCHDOG_OPEN_TIMEOUT;
> +}
> +
>  static int __watchdog_register_device(struct watchdog_device *wdd)
>  {
>  	int ret, id = -1;
> @@ -225,6 +239,8 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>  		return id;
>  	wdd->id = id;
>
> +	watchdog_set_open_timeout(wdd);
> +
Consider moving this call to watchdog_dev_register().

>  	ret = watchdog_dev_register(wdd);
>  	if (ret) {
>  		ida_simple_remove(&watchdog_ida, id);
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index ca0a000..f153091 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -80,6 +80,18 @@ static struct watchdog_core_data *old_wd_data;
>
>  static struct workqueue_struct *watchdog_wq;
>
> +static bool watchdog_past_open_deadline(struct watchdog_device *wdd)
> +{
> +	if (!wdd->open_timeout)
> +		return false;
> +	return time_is_before_jiffies(wdd->open_deadline);
> +}
> +
> +static void watchdog_set_open_deadline(struct watchdog_device *wdd)
> +{
> +	wdd->open_deadline = jiffies + msecs_to_jiffies(1000 * wdd->open_timeout);
> +}
> +
>  static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>  {
>  	/* All variables in milli-seconds */
> @@ -194,7 +206,13 @@ static int watchdog_ping(struct watchdog_device *wdd)
>
>  static bool watchdog_worker_should_ping(struct watchdog_device *wdd)
>  {
> -	return wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd));
> +	if (!wdd)
> +		return false;
> +
> +	if (watchdog_active(wdd))
> +		return true;
> +
> +	return watchdog_hw_running(wdd) && !watchdog_past_open_deadline(wdd);
>  }
>
>  static void watchdog_ping_work(struct work_struct *work)
> @@ -857,6 +875,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
>  		watchdog_ping(wdd);
>  	}
>
> +	watchdog_set_open_deadline(wdd);
>  	watchdog_update_worker(wdd);
>
>  	/* make sure that /dev/watchdog can be re-opened */
> @@ -955,6 +974,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>
>  	/* Record time of most recent heartbeat as 'just before now'. */
>  	wd_data->last_hw_keepalive = jiffies - 1;
> +	watchdog_set_open_deadline(wdd);
>
>  	/*
>  	 * If the watchdog is running, prevent its driver from being unloaded,
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 35a4d81..a89a293 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -76,6 +76,11 @@ struct watchdog_ops {
>   * @max_hw_heartbeat_ms:
>   *		Hardware limit for maximum timeout, in milli-seconds.
>   *		Replaces max_timeout if specified.
> + * @open_timeout:
> + *              The maximum time for which the kernel will ping the
> + *              device after registration.
> + * @open_deadline:
> + *              Set to jiffies + @open_timeout at registration.
>   * @reboot_nb:	The notifier block to stop watchdog on reboot.
>   * @restart_nb:	The notifier block to register a restart function.
>   * @driver_data:Pointer to the drivers private data.
> @@ -107,6 +112,8 @@ struct watchdog_device {
>  	unsigned int max_timeout;
>  	unsigned int min_hw_heartbeat_ms;
>  	unsigned int max_hw_heartbeat_ms;
> +	unsigned int open_timeout;
> +	unsigned long open_deadline;

None of those need to be visible in drivers. I don't see why the variables should be
defined here and not in struct watchdog_core_data.

>  	struct notifier_block reboot_nb;
>  	struct notifier_block restart_nb;
>  	void *driver_data;
>

