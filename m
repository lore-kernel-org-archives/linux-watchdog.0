Return-path: <ukl@pengutronix.de>
Date: Tue, 4 Aug 2015 14:25:13 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 3/8] watchdog: Introduce WDOG_RUNNING flag
Message-ID: <20150804122513.GN9999@pengutronix.de>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
 <1438654414-29259-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1438654414-29259-4-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Aug 03, 2015 at 07:13:29PM -0700, Guenter Roeck wrote:
> The WDOG_RUNNING flag is expected to be set by watchdog drivers if
> the hardware watchdog is running. If the flag is set, the watchdog
> subsystem will ping the watchdog even if the watchdog device is closed.
> 
> The watchdog driver stop function is now optional and may be omitted
> if the watchdog can not be stopped. If stopping the watchdog is not
> possible but the driver implements a stop function, it is responsible
> to set the WDOG_RUNNING flag in its stop function.
> 
> Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/watchdog/watchdog-kernel-api.txt | 19 ++++++++-----
>  drivers/watchdog/watchdog_core.c               |  2 +-
>  drivers/watchdog/watchdog_dev.c                | 39 ++++++++++++++++++++------
>  include/linux/watchdog.h                       |  7 +++++
>  4 files changed, 50 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index 5fa085276874..7fda3c86cf46 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -144,17 +144,18 @@ are:
>    device.
>    The routine needs a pointer to the watchdog timer device structure as a
>    parameter. It returns zero on success or a negative errno code for failure.
> -* stop: with this routine the watchdog timer device is being stopped.
> -  The routine needs a pointer to the watchdog timer device structure as a
> -  parameter. It returns zero on success or a negative errno code for failure.
> -  Some watchdog timer hardware can only be started and not be stopped. The
> -  driver supporting this hardware needs to make sure that a start and stop
> -  routine is being provided. This can be done by using a timer in the driver
> -  that regularly sends a keepalive ping to the watchdog timer hardware.
>  
>  Not all watchdog timer hardware supports the same functionality. That's why
>  all other routines/operations are optional. They only need to be provided if
>  they are supported. These optional routines/operations are:
> +* stop: with this routine the watchdog timer device is being stopped.
> +  The routine needs a pointer to the watchdog timer device structure as a
> +  parameter. It returns zero on success or a negative errno code for failure.
> +  Some watchdog timer hardware can only be started and not be stopped. A
> +  driver supporting such hardware does not have to implement the stop routine.
> +  If a driver has no stop function, the watchdog core will set WDOG_RUNNING and
> +  start calling the driver's keepalive pings function after the watchdog device
> +  is closed.
closed here means stop-closed. I'd like to have that more explicit. When
there is a stop function (for whatever reasons) for a non-stoppable
device, the .stop callback should return 0, right? Make this explicit.

>  * ping: this is the routine that sends a keepalive ping to the watchdog timer
>    hardware.
>    The routine needs a pointer to the watchdog timer device structure as a
> @@ -206,6 +207,10 @@ bit-operations. The status bits that are defined are:
>    any watchdog_ops, so that you can be sure that no operations (other then
>    unref) will get called after unregister, even if userspace still holds a
>    reference to /dev/watchdog
> +* WDOG_RUNNING: Set by the watchdog driver if the hardware watchdog is running.
> +  The bit must be set if the watchdog timer hardware can not be stopped;
This is ambigous. On i.MX2x the watchdog timer cannot be stopped, but
reset-default is off. So at probe (assuming the timer is off) the bit is
not supposed to be set.

> +  otherwise it is optional. If set, the watchdog driver core will send
> +  keepalive pings to the watchdog hardware while the watchdog device is closed.
s/closed/stopped by userspace/

>    To set the WDOG_NO_WAY_OUT status bit (before registering your watchdog
>    timer device) you can either:
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 2703b2511481..b29f0181130b 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -107,6 +107,7 @@ struct watchdog_device {
>  #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
>  #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
>  #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
> +#define WDOG_RUNNING		5	/* True if HW watchdog running */
>  	struct delayed_work work;
>  	struct list_head deferred;
>  };
> @@ -120,6 +121,12 @@ static inline bool watchdog_active(struct watchdog_device *wdd)
>  	return test_bit(WDOG_ACTIVE, &wdd->status);
>  }
>  
> +/* Use the following function to check whether or not the watchdog is running */
Maybe make it more explict here that this flag is about hw-state while
watchdog_active above is about userspace view.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
