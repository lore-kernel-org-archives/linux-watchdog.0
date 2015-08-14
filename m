Return-path: <ukl@pengutronix.de>
Date: Fri, 14 Aug 2015 13:23:28 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 2/8] watchdog: Introduce hardware maximum timeout in
 watchdog core
Message-ID: <20150814112328.GT9999@pengutronix.de>
References: <1439010167-13818-1-git-send-email-linux@roeck-us.net>
 <1439010167-13818-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1439010167-13818-3-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

On Fri, Aug 07, 2015 at 10:02:41PM -0700, Guenter Roeck wrote:
> [...]
> @@ -61,26 +135,27 @@ static struct watchdog_device *old_wdd;
>  
>  static int watchdog_ping(struct watchdog_device *wdd)
>  {
> -	int err = 0;
> +	int err;
>  
>  	mutex_lock(&wdd->lock);
> +	err = _watchdog_ping(wdd);
> +	wdd->last_keepalive = jiffies;
> +	watchdog_update_worker(wdd, false, false);
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
> +	watchdog_update_worker(wdd, false, false);
>  	mutex_unlock(&wdd->lock);
> -	return err;
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
> +		watchdog_update_worker(wdd, false, false);
> +	}
>  
>  out_start:
>  	mutex_unlock(&wdd->lock);
> @@ -146,8 +224,10 @@ static int watchdog_stop(struct watchdog_device *wdd)
>  	}
>  
>  	err = wdd->ops->stop(wdd);
> -	if (err == 0)
> +	if (err == 0) {
>  		clear_bit(WDOG_ACTIVE, &wdd->status);
> +		watchdog_update_worker(wdd, true, false);
> +	}
>  
>  out_stop:
>  	mutex_unlock(&wdd->lock);
> @@ -211,6 +291,8 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
>  
>  	err = wdd->ops->set_timeout(wdd, timeout);
>  
> +	watchdog_update_worker(wdd, true, false);

I still try to wrap my head around this function. You pass cancel=true
for stop and set_timeout to ensure that the worker doesn't continue to
run. That's fine.

For watchdog_start you pass cancel=false. I guess the background is that
after one of the next patches the worker might already run for handling
the watchdog being unstoppable. Maybe it's easier to grasp the logic if
you don't try to be too clever here: stop the worker on start
unconditionally and possibly restart it if the hardware needs extra
poking to fulfil the timeout set?

> +	if (!watchdog_wq)
> +		return -ENODEV;
> +
> +	INIT_DELAYED_WORK(&wdd->work, watchdog_ping_work);
> +
> +	if (!wdd->max_hw_timeout_ms)
> +		wdd->max_hw_timeout_ms = wdd->max_timeout * 1000;

With this (and assuming wdd->max_timeout > 0) the check for
max_hw_timeout_ms != 0 is not necessary, is it?

> +
>  	if (wdd->id == 0) {
>  		old_wdd = wdd;
>  		watchdog_miscdev.parent = wdd->parent;
> [...]
> @@ -585,9 +680,21 @@ int watchdog_dev_unregister(struct watchdog_device *wdd)
>  
>  int __init watchdog_dev_init(void)
>  {
> -	int err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
> +	int err;
> +
> +	watchdog_wq = alloc_workqueue("watchdogd",
> +				      WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
> +	if (!watchdog_wq) {
> +		pr_err("Failed to create watchdog workqueue\n");
> +		err = -ENOMEM;
> +		goto abort;

Why not return -ENOMEM directly?

> +	}
> +
> +	err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
>  	if (err < 0)
>  		pr_err("watchdog: unable to allocate char dev region\n");
> +
> +abort:
>  	return err;

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
