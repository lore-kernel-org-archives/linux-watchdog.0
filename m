Return-path: <ukl@pengutronix.de>
Date: Mon, 23 Nov 2015 08:53:04 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 1/8] watchdog: Introduce hardware maximum timeout in
 watchdog core
Message-ID: <20151123075304.GA5369@pengutronix.de>
References: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
 <1448248865-21684-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1448248865-21684-2-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

first of all thanks for picking this series up again.

I think all of this feedback doesn't need to stop your patches getting
in. It should all be possible to improve afterwards.

On Sun, Nov 22, 2015 at 07:20:58PM -0800, Guenter Roeck wrote:
> @@ -160,7 +176,11 @@ they are supported. These optional routines/operations are:
>    and -EIO for "could not write value to the watchdog". On success this
>    routine should set the timeout value of the watchdog_device to the
>    achieved timeout value (which may be different from the requested one
> -  because the watchdog does not necessarily has a 1 second resolution).
> +  because the watchdog does not necessarily have a 1 second resolution).
> +  Drivers implementing hw_max_timeout_ms set the hardware watchdog timeout
> +  to the minimum of timeout and hw_max_timeout_ms. Those drivers set the

Actually this is something that the wdg core could abstract for drivers.
Oh well, apart from hw_max_timeout_ms having ms accuracy.

> +  timeout value of the watchdog_device either to the requested timeout value
> +  (if it is larger than hw_max_timeout_ms), or to the achieved timeout value.
>    (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
>    watchdog's info structure).
>  * get_timeleft: this routines returns the time that's left before a reset.
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 56a649e66eb2..1dba3f57dba3 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> [...]
> +static long watchdog_next_keepalive(struct watchdog_device *wdd)
> +{
> +	unsigned int timeout_ms = wdd->timeout * 1000;
> +	unsigned long keepalive_interval;
> +	unsigned long last_heartbeat;
> +	unsigned long virt_timeout;
> +	unsigned int hw_timeout_ms;
> +
> +	virt_timeout = wdd->last_keepalive + msecs_to_jiffies(timeout_ms);

I think it's sensible to store

	last_keepalive + timeout

(i.e. the expected expiration time) in struct watchdog_device instead of
last_keepalive. This moves the (maybe expensive) calculation to a
context that has userspace interaction anyhow. On the other hand this
complicates the set_timeout call. Hmm.

> +	hw_timeout_ms = min(timeout_ms, wdd->max_hw_timeout_ms);
> +	keepalive_interval = msecs_to_jiffies(hw_timeout_ms / 2);
> +
> +	/*
> +	 * To ensure that the watchdog times out wdd->timeout seconds
> +	 * after the most recent ping from userspace, the last
> +	 * worker ping has to come in hw_timeout_ms before this timeout.
> +	 */
> +	last_heartbeat = virt_timeout - msecs_to_jiffies(hw_timeout_ms);
> +	return min_t(long, last_heartbeat - jiffies, keepalive_interval);
> +}
> [...]
> @@ -61,26 +137,25 @@ static struct watchdog_device *old_wdd;
>  
>  static int watchdog_ping(struct watchdog_device *wdd)
>  {
> -	int err = 0;
> +	int err;
>  
>  	mutex_lock(&wdd->lock);
> +	wdd->last_keepalive = jiffies;
> +	err = _watchdog_ping(wdd);
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
>  	mutex_unlock(&wdd->lock);
> -	return err;

Calling this function might come after last_keepalive + timeout in which
case the watchdog shouldn't be pinged.

>  }
>  
>  /*
> @@ -107,8 +182,11 @@ static int watchdog_start(struct watchdog_device *wdd)
>  		goto out_start;
>  
>  	err = wdd->ops->start(wdd);
> -	if (err == 0)
> +	if (err == 0) {
>  		set_bit(WDOG_ACTIVE, &wdd->status);
> +		wdd->last_keepalive = jiffies;
> +		watchdog_update_worker(wdd, true);
> +	}

I think it's more correct to sample jiffies before calling .start.
Something like:

	unsigned long started_at = jiffies;

	err = wdd->ops->start(wdd);
	if (err == 0)
		wdd->last_keepalive = jiffies;

>  
>  out_start:
>  	mutex_unlock(&wdd->lock);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
