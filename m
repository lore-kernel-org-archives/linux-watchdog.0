Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37272 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbaIZEC1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Sep 2014 00:02:27 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XXMji-001JFP-V2
	for linux-watchdog@vger.kernel.org; Fri, 26 Sep 2014 04:02:27 +0000
Message-ID: <5424E535.7060009@roeck-us.net>
Date: Thu, 25 Sep 2014 21:01:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] watchdog: watchdog_dev: WATCHDOG_KEEP_ON feature
References: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl>
In-Reply-To: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/22/2014 01:55 PM, Janusz Uzycki wrote:
> Some applications require to start watchdog before userspace software.
> This patch enables such feature. Only the flag is necessary
> to enable it.
> Moreover kernel's ping is re-enabled when userspace software closed
> watchdog using the magic character. The features improves kernel's
> reliability if hardware watchdog is available.
>
> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>

Hi Janusz,

This patch set is trying to solve four problems at once:

1) Auto-start watchdog when its driver registers
2) Keep watchdog running when its driver registers until userspace opens it
3) Handle watchdogs which can not be stopped after being started
4) Keep watchdog running with kernel timer after it has been closed,
    even if it can be stopped.

The next time adds 'boot time protection', which is really another term
for an initial timeout, and case 5).

That is a bit too much for a single patch and, even more so, a single flag.
Let's look at one case after another.

Auto-start watchdog when its driver registers - this makes sense as a
feature just by itself. A good name for its flag might be something like
WDT_AUTOSTART. A matching module parameter might also make sense.

autostart:
	Set to 0 to disable, -1 to enable with unlimited timeout,
	or <n> for an initial timeout of <n> seconds.

This could be accompanied by a variable in watchdog_device:
	int init_timeout;	/* initial timeout in seconds */

An API function such as watchdog_set_autostart() with the initial timeout
as parameter would also be helpful. This function could then be used to
implement 2).

	if (autostart || (keep_running && this_watchdog_is_running())
		watchdog_set_autostart(&wdd, autostart ? : keep_running);

keep_running could then be a another module parameter with the same meaning
as autostart.

Together this would also solve problem 5) while at the same time keeping
the use cases separate.

For 3) we really need another flag. Actually, it might be sufficient to have
watchdog drivers with this condition simply not provide a 'stop' function.
If we use a flag, something like WDOG_HW_NO_WAY_OUT with matching
WATCHDOG_HW_NOWAYOUT might make sense. Its functionality is slightly
different to the other conditions: It would not auto-start a watchdog,
but keep it running with the internal timer when the watchdog file is closed.

As for 4), I don't really know if it makes sense to have this functionality.

Does this all make sense ?

Some more comments below.

Thanks,
Guenter

> ---
>   drivers/watchdog/watchdog_dev.c | 58 ++++++++++++++++++++++++++-
>   include/linux/watchdog.h        |  5 +++
>   2 files changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 6aaefba..51a65f6 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -41,6 +41,7 @@
>   #include <linux/miscdevice.h>	/* For handling misc devices */
>   #include <linux/init.h>		/* For __init/__exit/... */
>   #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
> +#include <linux/jiffies.h>	/* for ping timer */
>
>   #include "watchdog_core.h"
>
> @@ -277,6 +278,27 @@ out_ioctl:
>   	return err;
>   }
>
> +/* 'keep on' feature */
> +static void watchdog_ping_timer_cb(unsigned long data)
> +{
> +	struct watchdog_device *wdd = (struct watchdog_device *)data;
> +	watchdog_ping(wdd);
> +	/* call next ping half the timeout value */
> +	mod_timer(&wdd->ping_timer,
> +			jiffies + msecs_to_jiffies(wdd->timeout * 500));
> +}
> +
> +static void watchdog_keepon_start(struct watchdog_device *wdd)

This name reflects the intended use case, but not the functionality.
Something like "watchdog_timer_start" might make more sense here.

> +{
> +	watchdog_start(wdd);

This should probably be handled by the caller, to let us separate
cases where the watchdog is already running (for example on close).

> +	watchdog_ping_timer_cb((unsigned long)wdd);
> +}
> +
> +static void watchdog_keepon_stop(struct watchdog_device *wdd)

Same name comment as above. keepon -> timer.

> +{
> +	del_timer_sync(&wdd->ping_timer);
> +}
> +
>   /*
>    *	watchdog_write: writes to the watchdog.
>    *	@file: file from VFS
> @@ -430,6 +452,9 @@ static int watchdog_open(struct inode *inode, struct file *file)
>   	if (!try_module_get(wdd->ops->owner))
>   		goto out;
>
> +	if (test_bit(WDOG_KEEP_ON, &wdd->status))
> +		watchdog_keepon_stop(wdd);
> +
>   	err = watchdog_start(wdd);
>   	if (err < 0)
>   		goto out_mod;
> @@ -472,8 +497,13 @@ static int watchdog_release(struct inode *inode, struct file *file)
>   	if (!test_bit(WDOG_ACTIVE, &wdd->status))
>   		err = 0;
>   	else if (test_and_clear_bit(WDOG_ALLOW_RELEASE, &wdd->status) ||
> -		 !(wdd->info->options & WDIOF_MAGICCLOSE))
> -		err = watchdog_stop(wdd);
> +		 !(wdd->info->options & WDIOF_MAGICCLOSE)) {
> +		if (test_bit(WDOG_KEEP_ON, &wdd->status)) {
> +			watchdog_keepon_start(wdd);
> +			err = 0;
> +		} else
> +			err = watchdog_stop(wdd);
> +	}

I think this all should probably go into some helper function.
The conditions here are getting a bit complicated.

>
>   	/* If the watchdog was not stopped, send a keepalive ping */
>   	if (err < 0) {
> @@ -524,6 +554,14 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
>   {
>   	int err, devno;
>
> +	if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
> +		if (!try_module_get(watchdog->ops->owner))
> +			return -ENODEV;
> +		setup_timer(&watchdog->ping_timer, watchdog_ping_timer_cb,
> +				(unsigned long)watchdog);
> +		watchdog_keepon_start(watchdog);
> +	}
> +
This should be the last action in the probe function.
Reason is that we might have a watchdog which can not be stopped after
it was started once. If one of the error cases below happens, we would
be stuck with a running watchdog and no means to stop it or to keep
it alive.

>   	if (watchdog->id == 0) {
>   		old_wdd = watchdog;
>   		watchdog_miscdev.parent = watchdog->parent;
> @@ -535,6 +573,11 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
>   				pr_err("%s: a legacy watchdog module is probably present.\n",
>   					watchdog->info->identity);
>   			old_wdd = NULL;
> +			if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
> +				watchdog_keepon_stop(watchdog);
> +				watchdog_stop(watchdog);
> +				module_put(watchdog->ops->owner);
> +			}

Won't apply after moving above functions, but in general
complex error cleanup like this should be handled with a goto
to an error handler at the end of the function.

>   			return err;
>   		}
>   	}
> @@ -553,6 +596,11 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
>   			misc_deregister(&watchdog_miscdev);
>   			old_wdd = NULL;
>   		}
> +		if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
> +			watchdog_keepon_stop(watchdog);
> +			watchdog_stop(watchdog);
> +			module_put(watchdog->ops->owner);
> +		}

... to avoid situations with duplicated error handling code like this,
but also to make code easier to read. See CodingStyle.

>   	}
>   	return err;
>   }
> @@ -575,6 +623,12 @@ int watchdog_dev_unregister(struct watchdog_device *watchdog)
>   		misc_deregister(&watchdog_miscdev);
>   		old_wdd = NULL;
>   	}
> +
> +	if (test_bit(WDOG_KEEP_ON, &watchdog->status)) {
> +		watchdog_keepon_stop(watchdog);
> +		watchdog_stop(watchdog);
> +		module_put(watchdog->ops->owner);
> +	}
>   	return 0;
>   }
>
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 2a3038e..650e0d5 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -12,6 +12,7 @@
>   #include <linux/bitops.h>
>   #include <linux/device.h>
>   #include <linux/cdev.h>
> +#include <linux/timer.h>		/* for ping timer */
>   #include <uapi/linux/watchdog.h>
>
>   struct watchdog_ops;
> @@ -95,6 +96,8 @@ struct watchdog_device {
>   #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
>   #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
>   #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
> +#define WDOG_KEEP_ON		5	/* Is 'keep on' feature set? */
> +	struct timer_list ping_timer;	/* timer to keep on hardware ping */
>   };
>
>   #ifdef CONFIG_WATCHDOG_NOWAYOUT
> @@ -104,6 +107,8 @@ struct watchdog_device {
>   #define WATCHDOG_NOWAYOUT		0
>   #define WATCHDOG_NOWAYOUT_INIT_STATUS	0
>   #endif
> +/* other proposal: WATCHDOG_ALWAYS_ACTIVE */
> +#define WATCHDOG_KEEP_ON		(1 << WDOG_KEEP_ON)
>
>   /* Use the following function to check whether or not the watchdog is active */
>   static inline bool watchdog_active(struct watchdog_device *wdd)
>

