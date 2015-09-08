Return-path: <ukl@pengutronix.de>
Date: Tue, 8 Sep 2015 12:33:25 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 2/9] watchdog: Introduce hardware maximum timeout in
 watchdog core
Message-ID: <20150908103325.GS14598@pengutronix.de>
References: <1440876758-28047-1-git-send-email-linux@roeck-us.net>
 <1440876758-28047-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1440876758-28047-3-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

On Sat, Aug 29, 2015 at 12:32:31PM -0700, Guenter Roeck wrote:
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index d8b0d3367706..3306249aa17d 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -53,9 +53,12 @@ struct watchdog_device {
>  	unsigned int timeout;
>  	unsigned int min_timeout;
>  	unsigned int max_timeout;
> +	unsigned int max_hw_timeout_ms;
>  	void *driver_data;
> -	struct mutex lock;
>  	unsigned long status;
> +	struct mutex lock;
> +	unsigned long last_keepalive;
> +	struct delayed_work work;
>  	struct list_head deferred;
>  };
>  
> @@ -73,18 +76,31 @@ It contains following fields:
>    additional information about the watchdog timer itself. (Like it's unique name)
>  * ops: a pointer to the list of watchdog operations that the watchdog supports.
>  * timeout: the watchdog timer's timeout value (in seconds).
> +  This is the time after which the system will reboot if user space does
> +  not send a heartbeat request if WDOG_ACTIVE is set.
>  * min_timeout: the watchdog timer's minimum timeout value (in seconds).
> -* max_timeout: the watchdog timer's maximum timeout value (in seconds).
> +  If set, the minimum configurable value for 'timeout'.
> +* max_timeout: the watchdog timer's maximum timeout value (in seconds),
> +  as seen from userspace. If set, the maximum configurable value for
> +  'timeout'. Not used if max_hw_timeout_ms is provided.

s/provided/non-zero/?

> +* max_hw_timeout_ms: Maximum hardware timeout, in milli-seconds.
> +  If set, the infrastructure will send heartbeats to the watchdog driver
> +  if 'timeout' is larger than 'max_hw_timeout / 2', unless WDOG_ACTIVE

This "/ 2" isn't true any more.

> +  is set and userspace failed to send a heartbeat for at least 'timeout'
> +  seconds.
>  * bootstatus: status of the device after booting (reported with watchdog
>    WDIOF_* status bits).
>  * driver_data: a pointer to the drivers private data of a watchdog device.
>    This data should only be accessed via the watchdog_set_drvdata and
>    watchdog_get_drvdata routines.
> -* lock: Mutex for WatchDog Timer Driver Core internal use only.
>  * status: this field contains a number of status bits that give extra
>    information about the status of the device (Like: is the watchdog timer
>    running/active, is the nowayout bit set, is the device opened via
>    the /dev/watchdog interface or not, ...).
> +* lock: Mutex for WatchDog Timer Driver Core internal use only.
> +* last_keepalive: Time of most recent keepalive triggered from user space,
> +  in jiffies.
> +* work: Worker data structure for WatchDog Timer Driver Core internal use only.
>  * deferred: entry in wtd_deferred_reg_list which is used to
>    register early initialized watchdogs.
>  
> [...]
> +static long watchdog_next_keepalive(struct watchdog_device *wdd)
> +{
> +	unsigned int hw_timeout_ms = wdd->timeout * 1000;
> +	unsigned long keepalive_interval;
> +	unsigned long last_heartbeat;
> +	unsigned long virt_timeout;
> +
> +	virt_timeout = wdd->last_keepalive + msecs_to_jiffies(hw_timeout_ms);

Just looking at this line this is wrong. It just happens to be correct
here because hw_timeout_ms non-intuitively is set to wdd->timeout * 1000
which might not reflect what is programmed into the hardware.

I'd write:

	virt_timeout = wdd->last_keepalive + msecs_to_jiffies(wdd->timeout * 1000);

...

> +	if (hw_timeout_ms > wdd->max_hw_timeout_ms)
> +		hw_timeout_ms = wdd->max_hw_timeout_ms;

	hw_timeout_ms = min(wdd->timeout * 1000, wdd->max_hw_timeout_ms);

> +
> +	keepalive_interval = msecs_to_jiffies(hw_timeout_ms / 2);
> +
> +	/*
> +	 * To ensure that the watchdog times out wdd->timeout seconds
> +	 * after the most recent ping from userspace, the last
> +	 * worker ping has to come in hw_timeout_ms before this timeout.
> +	 */
> +	last_heartbeat = virt_timeout - msecs_to_jiffies(hw_timeout_ms);
> +
> +	/*
> +	 * To ensure that the watchdog times out wdd->timeout seconds after
> +	 * the most recent ping from userspace, the last worker ping has to
> +	 * come hw_timeout_ms before this timeout.

duplicated comment.

> +	 */
> +	return min_t(long, last_heartbeat - jiffies, keepalive_interval);
> +}
> +
> [...]
> @@ -61,26 +143,27 @@ static struct watchdog_device *old_wdd;
>  
>  static int watchdog_ping(struct watchdog_device *wdd)
>  {
> -	int err = 0;
> +	int err;
>  
>  	mutex_lock(&wdd->lock);
> +	wdd->last_keepalive = jiffies;
> +	err = _watchdog_ping(wdd);
> +	watchdog_update_worker(wdd, false);

Here the cancel argument could also be true, right? That's because after
a ping (that doesn't modify the timeout) the result of
watchdog_need_worker doesn't change and so either the worker isn't
running + stopping it again doesn't hurt, or the timer is running and so
it's not tried to be stopped.

> +	mutex_unlock(&wdd->lock);
>  
> -	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
> -		err = -ENODEV;
> -		goto out_ping;
> -	}
> +	return err;
> +}
>  
> -	if (!watchdog_active(wdd))
> -		goto out_ping;
> +static void watchdog_ping_work(struct work_struct *work)
> +{
> +	struct watchdog_device *wdd;
>  
> -	if (wdd->ops->ping)
> -		err = wdd->ops->ping(wdd);	/* ping the watchdog */
> -	else
> -		err = wdd->ops->start(wdd);	/* restart watchdog */
> +	wdd = container_of(to_delayed_work(work), struct watchdog_device, work);
>  
> -out_ping:
> +	mutex_lock(&wdd->lock);
> +	_watchdog_ping(wdd);
> +	watchdog_update_worker(wdd, false);

Here for the same reason you could pass true. So there is no caller that
needs to pass false which allows to simplify the function. (i.e. drop
the cancel parameter and simplify it assuming cancel is true)

>  	mutex_unlock(&wdd->lock);
> -	return err;
>  }
>  
>  /*
> [...]
> @@ -119,8 +134,9 @@ static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool noway
>  /* Use the following function to check if a timeout value is invalid */
>  static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
>  {
> -	return ((wdd->max_timeout != 0) &&
> -		(t < wdd->min_timeout || t > wdd->max_timeout));

Is this (old) code correct? watchdog_timeout_invalid returns false if
wdd->max_timeout == 0 && t < wdd->min_timeout. I would have expected:

	return (wdd->max_timeout != 0 && t > wdd->max_timeout) ||
		t < wdd->min_timeout;

> +	return t > UINT_MAX / 1000 ||
> +		(!wdd->max_hw_timeout_ms && wdd->max_timeout &&
> +		 (t < wdd->min_timeout || t > wdd->max_timeout));

So should this better be:

	/* internal calculation is done in ms using unsigned variables */
	if (t > UINT_MAX / 1000)
		return 1;

	/*
	 * compat code for drivers not being aware of framework pings to
	 * bridge timeouts longer than supported by the hardware.
	 */
	if (!wdd->max_hw_timeout && wdd->max_timeout && t > wdd->max_timeout)
		return 1;

	if (t < wdd->min_timeout)
		return 1;

unless I'm missing something.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
