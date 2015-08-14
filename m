Return-path: <ukl@pengutronix.de>
Date: Fri, 14 Aug 2015 21:04:03 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 3/8] watchdog: Introduce WDOG_RUNNING flag
Message-ID: <20150814190403.GU9999@pengutronix.de>
References: <1439010167-13818-1-git-send-email-linux@roeck-us.net>
 <1439010167-13818-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1439010167-13818-4-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index 25b00b878a7b..6a54dc15a556 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> [...]
> @@ -193,9 +194,12 @@ they are supported. These optional routines/operations are:
>  The status bits should (preferably) be set with the set_bit and clear_bit alike
>  bit-operations. The status bits that are defined are:
>  * WDOG_ACTIVE: this status bit indicates whether or not a watchdog timer device
> -  is active or not. When the watchdog is active after booting, then you should
> -  set this status bit (Note: when you register the watchdog timer device with
> -  this bit set, then opening /dev/watchdog will skip the start operation)
> +  is active or not from user perspective. User space is expected to send
> +  heartbeat requests to the driver while this flag is set. If the watchdog
> +  is active after booting, and you don't want the infrastructure to send
> +  heartbeats to the watchdog driver, then you should set this status bit.

IMHO this should not be the driver author's choice! If you implement
policy in the kernel it should at least be implemented in the framework
and preferably easily changeable. (At least with Kconfig, but better use
a kernel parameter (or both, the latter overriding the former).)

> +  Note: when you register the watchdog timer device with this bit set,
> +  then opening /dev/watchdog will skip the start operation.
>  * WDOG_DEV_OPEN: this status bit shows whether or not the watchdog device
>    was opened via /dev/watchdog.
>    (This bit should only be used by the WatchDog Timer Driver Core).
> @@ -209,6 +213,11 @@ bit-operations. The status bits that are defined are:
>    any watchdog_ops, so that you can be sure that no operations (other then
>    unref) will get called after unregister, even if userspace still holds a
>    reference to /dev/watchdog
> +* WDOG_RUNNING: Set by the watchdog driver if the hardware watchdog is running.
> +  The bit must be set if the watchdog timer hardware can not be stopped.
> +  The bit may also be set if the watchdog timer is running aftyer booting,
> +  before the watchdog device is opened. If set, the watchdog infrastructure
> +  will send keepalives to the watchdog hardware while WDOG_ACTIVE is not set.
>  
>    To set the WDOG_NO_WAY_OUT status bit (before registering your watchdog
>    timer device) you can either:
> [...]
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index c04ba1a98cc8..676e233d5e7b 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -59,7 +59,8 @@ static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>  	unsigned int m = wdd->max_timeout * 1000;
>  	unsigned int t = wdd->timeout * 1000;
>  
> -	return watchdog_active(wdd) && hm && (!m || hm < m) && t > hm;
> +	return (watchdog_active(wdd) && hm && (!m || hm < m) && t > hm) ||
> +	       (t && !watchdog_active(wdd) && watchdog_running(wdd));

What is the meaning of

	!t && !watchdog_active(wdd) && watchdog_running(wdd)

? Can this happen at all? If not, drop "t && "?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
