Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55949 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdB0EEa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 26 Feb 2017 23:04:30 -0500
Date: Sun, 26 Feb 2017 20:04:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: wim@iguana.be, edumazet@google.com, peterz@infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        niklass@axis.com
Subject: Re: watchdog: softdog: fire watchdog even if softirqs do not get to
 run
Message-ID: <20170227040425.GA9023@roeck-us.net>
References: <1487355902-28020-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487355902-28020-1-git-send-email-niklass@axis.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 17, 2017 at 07:25:02PM +0100, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> 
> Checking for timer expiration is done from the softirq TIMER_SOFTIRQ.
> 
> Since commit 4cd13c21b207 ("softirq: Let ksoftirqd do its job"),
> pending softirqs are no longer always handled immediately, instead,
> if there are pending softirqs, and ksoftirqd is in state TASK_RUNNING,
> the handling of the softirqs are deferred, and are instead supposed
> to be handled by ksoftirqd, when ksoftirqd gets scheduled.
> 
> If a user space process with a real-time policy starts to misbehave
> by never relinquishing the CPU while ksoftirqd is in state TASK_RUNNING,
> what will happen is that all softirqs will get deferred, while ksoftirqd,
> which is supposed to handle the deferred softirqs, will never get to run.
> 
> To make sure that the watchdog is able to fire even when we do not get
> to run softirqs, replace the timers with hrtimers.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Niklas,

Please rebase onto current mainline, test, and resubmit.

Thanks,
Guenter

> ---
>  drivers/watchdog/softdog.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
> index c7bdc986dca1..0f67cd068465 100644
> --- a/drivers/watchdog/softdog.c
> +++ b/drivers/watchdog/softdog.c
> @@ -21,13 +21,12 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/hrtimer.h>
>  #include <linux/init.h>
> -#include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/reboot.h>
> -#include <linux/timer.h>
>  #include <linux/types.h>
>  #include <linux/watchdog.h>
>  
> @@ -54,7 +53,10 @@ module_param(soft_panic, int, 0);
>  MODULE_PARM_DESC(soft_panic,
>  	"Softdog action, set to 1 to panic, 0 to reboot (default=0)");
>  
> -static void softdog_fire(unsigned long data)
> +static struct hrtimer softdog_ticktock;
> +static struct hrtimer softdog_preticktock;
> +
> +static enum hrtimer_restart softdog_fire(struct hrtimer *timer)
>  {
>  	module_put(THIS_MODULE);
>  	if (soft_noboot) {
> @@ -67,41 +69,42 @@ static void softdog_fire(unsigned long data)
>  		emergency_restart();
>  		pr_crit("Reboot didn't ?????\n");
>  	}
> -}
>  
> -static struct timer_list softdog_ticktock =
> -		TIMER_INITIALIZER(softdog_fire, 0, 0);
> +	return HRTIMER_NORESTART;
> +}
>  
>  static struct watchdog_device softdog_dev;
>  
> -static void softdog_pretimeout(unsigned long data)
> +static enum hrtimer_restart softdog_pretimeout(struct hrtimer *timer)
>  {
>  	watchdog_notify_pretimeout(&softdog_dev);
> -}
>  
> -static struct timer_list softdog_preticktock =
> -		TIMER_INITIALIZER(softdog_pretimeout, 0, 0);
> +	return HRTIMER_NORESTART;
> +}
>  
>  static int softdog_ping(struct watchdog_device *w)
>  {
> -	if (!mod_timer(&softdog_ticktock, jiffies + (w->timeout * HZ)))
> +	if (!hrtimer_active(&softdog_ticktock))
>  		__module_get(THIS_MODULE);
> +	hrtimer_start(&softdog_ticktock, ktime_set(w->timeout, 0),
> +		      HRTIMER_MODE_REL);
>  
>  	if (w->pretimeout)
> -		mod_timer(&softdog_preticktock, jiffies +
> -			  (w->timeout - w->pretimeout) * HZ);
> +		hrtimer_start(&softdog_preticktock,
> +			      ktime_set(w->timeout - w->pretimeout, 0),
> +			      HRTIMER_MODE_REL);
>  	else
> -		del_timer(&softdog_preticktock);
> +		hrtimer_cancel(&softdog_preticktock);
>  
>  	return 0;
>  }
>  
>  static int softdog_stop(struct watchdog_device *w)
>  {
> -	if (del_timer(&softdog_ticktock))
> +	if (hrtimer_cancel(&softdog_ticktock))
>  		module_put(THIS_MODULE);
>  
> -	del_timer(&softdog_preticktock);
> +	hrtimer_cancel(&softdog_preticktock);
>  
>  	return 0;
>  }
> @@ -134,6 +137,11 @@ static int __init softdog_init(void)
>  	watchdog_set_nowayout(&softdog_dev, nowayout);
>  	watchdog_stop_on_reboot(&softdog_dev);
>  
> +	hrtimer_init(&softdog_ticktock, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	softdog_ticktock.function = softdog_fire;
> +	hrtimer_init(&softdog_preticktock, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	softdog_preticktock.function = softdog_pretimeout;
> +
>  	ret = watchdog_register_device(&softdog_dev);
>  	if (ret)
>  		return ret;
