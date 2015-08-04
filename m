Return-path: <ukl@pengutronix.de>
Date: Tue, 4 Aug 2015 17:41:04 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de
Subject: Re: [PATCH 3/8] watchdog: Introduce WDOG_RUNNING flag
Message-ID: <20150804154104.GT9999@pengutronix.de>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
 <1438654414-29259-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1438654414-29259-4-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

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
Another thing that I noticed just now after looking at a later patch in
this series: Conceptually that worker stuff better fits into
watchdog_core.c than watchdog_dev.c, doesn't it? But maybe this
separation doesn't make sense anyhow?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
