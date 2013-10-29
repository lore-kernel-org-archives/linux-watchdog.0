Return-Path: <wimvs@spo001.leaseweb.com>
Date: Tue, 29 Oct 2013 08:37:23 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>
Subject: Re: [PATCH V2 03/35] watchdog: use dev_get_platdata()
Message-ID: <20131029073723.GC19569@spo001.leaseweb.com>
References: <008001ce8d13$c6805fc0$53811f40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008001ce8d13$c6805fc0$53811f40$@samsung.com>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Jingoo,

> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/iTCO_wdt.c         |    2 +-
>  drivers/watchdog/mv64x60_wdt.c      |    2 +-
>  drivers/watchdog/omap_wdt.c         |    2 +-
>  drivers/watchdog/rdc321x_wdt.c      |    2 +-
>  drivers/watchdog/stmp3xxx_rtc_wdt.c |    4 ++--
>  drivers/watchdog/ux500_wdt.c        |    2 +-
>  drivers/watchdog/wm831x_wdt.c       |    8 +++-----
>  7 files changed, 10 insertions(+), 12 deletions(-)

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.
