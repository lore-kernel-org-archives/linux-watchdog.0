Return-path: <ukl@pengutronix.de>
Date: Tue, 4 Aug 2015 14:18:16 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/8] watchdog: Introduce hardware maximum timeout in
 watchdog core
Message-ID: <20150804121816.GM9999@pengutronix.de>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
 <1438654414-29259-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1438654414-29259-3-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Aug 03, 2015 at 07:13:28PM -0700, Guenter Roeck wrote:
> Introduce an optional hardware maximum timeout in the watchdog core.
> The hardware maximum timeout can be lower than the maximum timeout.
Is this only until all drivers are converted to make use of the central
worker? Otherwise this doesn't make sense, right?
 
> Drivers can set the maximum hardare timeout value in the watchdog data
s/hardare/hardware/

> structure. If the configured timeout exceeds half the value of the
> maximum hardware timeout, the watchdog core enables a timer function
> to assist sending keepalive requests to the watchdog driver.
I don't understand why you want to halve the maximum hw-timeout. If my
watchdog has hw-max-timeout = 5s and userspace sets it to 3s there
should be no need for assistance?! I think the implementation is the
other way round?

> ---
>  Documentation/watchdog/watchdog-kernel-api.txt |  14 +++
>  drivers/watchdog/watchdog_dev.c                | 121 +++++++++++++++++++++----
>  include/linux/watchdog.h                       |  21 ++++-
>  3 files changed, 135 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index d8b0d3367706..5fa085276874 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -53,9 +53,12 @@ struct watchdog_device {
>  	unsigned int timeout;
>  	unsigned int min_timeout;
>  	unsigned int max_timeout;
> +	unsigned int max_hw_timeout_ms;
> +	unsigned long last_keepalive;
>  	void *driver_data;
>  	struct mutex lock;
>  	unsigned long status;
> +	struct delayed_work work;
>  	struct list_head deferred;
>  };
>  
> @@ -73,8 +76,18 @@ It contains following fields:
>    additional information about the watchdog timer itself. (Like it's unique name)
>  * ops: a pointer to the list of watchdog operations that the watchdog supports.
>  * timeout: the watchdog timer's timeout value (in seconds).
> +  This is the time after which the system will reboot if user space does
> +  not send a heartbeat request if the watchdog device is opened.
> +  This may or may not be the hardware watchdog timeout. See max_hw_timeout_ms
> +  for more details.
Hmm, what is timeout then? Is this the value that the driver currently
handles? Or the framework with the automatic pings? Probably the
former?! This needs better wording.

>  * min_timeout: the watchdog timer's minimum timeout value (in seconds).
>  * max_timeout: the watchdog timer's maximum timeout value (in seconds).
> +* max_hw_timeout_ms: Maximum hardware timeout, in milli-seconds. May differ
> +  from max_timeout. If set, the infrastructure will send a heartbeat to the
> +  watchdog driver if 'timeout' is larger than 'max_hw_timeout / 2',
> +  unless user space failed to ping the watchdog for 'timeout' seconds.
In the long run max_timeout should be removed, right?

> +* last_keepalive: Time of most recent keepalive triggered from user space,
> +  in jiffies.
>  * bootstatus: status of the device after booting (reported with watchdog
>    WDIOF_* status bits).
>  * driver_data: a pointer to the drivers private data of a watchdog device.
> @@ -85,6 +98,7 @@ It contains following fields:
>    information about the status of the device (Like: is the watchdog timer
>    running/active, is the nowayout bit set, is the device opened via
>    the /dev/watchdog interface or not, ...).
> +* work: Worker data structure for WatchDog Timer Driver Core internal use only.
>  * deferred: entry in wtd_deferred_reg_list which is used to
>    register early initialized watchdogs.
>  
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 06171c73daf5..25849c1d6dc1 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -37,7 +37,9 @@
>  #include <linux/errno.h>	/* For the -ENODEV/... values */
>  #include <linux/kernel.h>	/* For printk/panic/... */
>  #include <linux/fs.h>		/* For file operations */
> +#include <linux/jiffies.h>	/* For timeout functions */
>  #include <linux/watchdog.h>	/* For watchdog specific items */
> +#include <linux/workqueue.h>	/* For workqueue */
>  #include <linux/miscdevice.h>	/* For handling misc devices */
>  #include <linux/init.h>		/* For __init/__exit/... */
>  #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
> @@ -49,6 +51,53 @@ static dev_t watchdog_devt;
>  /* the watchdog device behind /dev/watchdog */
>  static struct watchdog_device *old_wdd;
>  
> +static struct workqueue_struct *watchdog_wq;
> +
> +static inline bool watchdog_need_worker(struct watchdog_device *wdd)
> +{
> +	unsigned int hm = wdd->max_hw_timeout_ms;
> +	unsigned int m = wdd->max_timeout * 1000;
> +
> +	return watchdog_active(wdd) && hm && hm != m &&
> +		wdd->timeout * 500 > hm;

I don't understand what max_timeout is now that there is max_hw_timeout.
So I don't understand why you need hm != m either.

Taking the example from above (hw-maxtimeout = 5000ms, current timeout =
3s) this doesn't trigger.

And the other way round:
 - hw-max-timeout = 3s
 - timeout = 5s

In this case userspace might send a ping only after 4 seconds, but
watchdog_need_worker will be false.

What is the meaning of WDOG_ACTIVE now? does it mean userspace has the
device open? Then this looks wrong, too.

/me wonders if he understood that function correctly?!

> @@ -88,6 +96,8 @@ struct watchdog_device {
>  	unsigned int timeout;
>  	unsigned int min_timeout;
>  	unsigned int max_timeout;
> +	unsigned int max_hw_timeout_ms;
> +	unsigned long last_keepalive;
>  	void *driver_data;
>  	struct mutex lock;
>  	unsigned long status;
It would be nice to group this a bit to make it more clear which members
are supposed to be set by driver and which are not.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
