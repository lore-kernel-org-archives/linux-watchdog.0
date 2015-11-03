Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36419 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716AbbKCCZK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Nov 2015 21:25:10 -0500
Subject: Re: [RFC PATCH 01/13] watchdog: core: add restart handler support
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
References: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446514586-31455-2-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56381B03.6030201@roeck-us.net>
Date: Mon, 2 Nov 2015 18:25:07 -0800
MIME-Version: 1.0
In-Reply-To: <1446514586-31455-2-git-send-email-damien.riegel@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/02/2015 05:36 PM, Damien Riegel wrote:
> Many watchdog drivers implement the same code to register a restart
> handler. This patch provides a generic way to set such a function.
>
> The patch adds a new restart watchdog operation. If a restart priority
> greater than 0 is needed, the driver can call
> watchdog_set_restart_priority to set it.
>
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Makes sense, and good idea. Unless the patch was written by Vivien,
the second tag should probably be a Reviewed-by: or Acked-by:, though.

Couple of additional comments below.

> ---
>   Documentation/watchdog/watchdog-kernel-api.txt |  2 ++
>   drivers/watchdog/watchdog_core.c               | 35 ++++++++++++++++++++++++++
>   include/linux/watchdog.h                       |  5 ++++
>   3 files changed, 42 insertions(+)
>
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index d8b0d33..10e6132 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -100,6 +100,7 @@ struct watchdog_ops {
>   	unsigned int (*status)(struct watchdog_device *);
>   	int (*set_timeout)(struct watchdog_device *, unsigned int);
>   	unsigned int (*get_timeleft)(struct watchdog_device *);
> +	int (*restart)(struct watchdog_device *);
>   	void (*ref)(struct watchdog_device *);
>   	void (*unref)(struct watchdog_device *);
>   	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
> @@ -164,6 +165,7 @@ they are supported. These optional routines/operations are:
>     (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
>     watchdog's info structure).
>   * get_timeleft: this routines returns the time that's left before a reset.
> +* restart: this routine restarts the machine.

Please describe the expected return values.
0 - ok, or a negative error value, presumably.

>   * ref: the operation that calls kref_get on the kref of a dynamically
>     allocated watchdog_device struct.
>   * unref: the operation that calls kref_put on the kref of a dynamically
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 873f139..9c8a8e8 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -32,6 +32,7 @@
>   #include <linux/types.h>	/* For standard types */
>   #include <linux/errno.h>	/* For the -ENODEV/... values */
>   #include <linux/kernel.h>	/* For printk/panic/... */
> +#include <linux/reboot.h>	/* For restart handler */
>   #include <linux/watchdog.h>	/* For watchdog specific items */
>   #include <linux/init.h>		/* For __init/__exit/... */
>   #include <linux/idr.h>		/* For ida_* macros */
> @@ -137,6 +138,28 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
>   }
>   EXPORT_SYMBOL_GPL(watchdog_init_timeout);
>
> +static int watchdog_restart_notifier(struct notifier_block *nb,
> +				     unsigned long action, void *data)
> +{
> +	struct watchdog_device *wdd = container_of(nb, struct watchdog_device,
> +						   restart_nb);
> +
> +	int ret;
> +
> +	ret = wdd->ops->restart(wdd);
> +	if (ret)
> +		return NOTIFY_BAD;
> +
> +	return NOTIFY_DONE;
> +}
> +
> +void watchdog_set_restart_priority(struct watchdog_device *wdd,
> +				   int priority)

Fits one line.

> +{
> +	wdd->restart_nb.priority = priority;
> +}
> +EXPORT_SYMBOL_GPL(watchdog_set_restart_priority);
> +
>   static int __watchdog_register_device(struct watchdog_device *wdd)
>   {
>   	int ret, id = -1, devno;
> @@ -202,6 +225,15 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>   		return ret;
>   	}
>
> +	if (wdd->ops->restart) {
> +		wdd->restart_nb.notifier_call = watchdog_restart_notifier;
> +
> +		ret = register_restart_handler(&wdd->restart_nb);
> +		if (ret)
> +			dev_err(wdd->dev, "Cannot register restart handler (%d)\n",
> +				ret);

dev_warn, please.

> +	}
> +
>   	return 0;
>   }
>
> @@ -238,6 +270,9 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
>   	if (wdd == NULL)
>   		return;
>
> +	if (wdd->ops->restart)
> +		unregister_restart_handler(&wdd->restart_nb);
> +
>   	devno = wdd->cdev.dev;
>   	ret = watchdog_dev_unregister(wdd);
>   	if (ret)
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index e90e3ea..e1a4dc4 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -26,6 +26,7 @@ struct watchdog_device;
>    * @status:	The routine that shows the status of the watchdog device.
>    * @set_timeout:The routine for setting the watchdog devices timeout value.
>    * @get_timeleft:The routine that get's the time that's left before a reset.
> + * @restart:	The routine for restarting the machine.
>    * @ref:	The ref operation for dyn. allocated watchdog_device structs
>    * @unref:	The unref operation for dyn. allocated watchdog_device structs
>    * @ioctl:	The routines that handles extra ioctl calls.
> @@ -45,6 +46,7 @@ struct watchdog_ops {
>   	unsigned int (*status)(struct watchdog_device *);
>   	int (*set_timeout)(struct watchdog_device *, unsigned int);
>   	unsigned int (*get_timeleft)(struct watchdog_device *);
> +	int (*restart)(struct watchdog_device *);
>   	void (*ref)(struct watchdog_device *);
>   	void (*unref)(struct watchdog_device *);
>   	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
> @@ -88,6 +90,7 @@ struct watchdog_device {
>   	unsigned int timeout;
>   	unsigned int min_timeout;
>   	unsigned int max_timeout;
> +	struct notifier_block restart_nb;
>   	void *driver_data;
>   	struct mutex lock;
>   	unsigned long status;
> @@ -142,6 +145,8 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
>   }
>
>   /* drivers/watchdog/watchdog_core.c */
> +extern void watchdog_set_restart_priority(struct watchdog_device *wdd,
> +					  int priority);

extern is unnecessary (yes, we'll need to fix that for the other exported
functions, but no need to introduce new ones), and then it fits one line.

>   extern int watchdog_init_timeout(struct watchdog_device *wdd,
>   				  unsigned int timeout_parm, struct device *dev);
>   extern int watchdog_register_device(struct watchdog_device *);
>

