Return-path: <ukl@pengutronix.de>
Date: Sun, 26 Apr 2015 21:14:13 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Lokesh Vutla <lokeshvutla@ti.com>, Felipe Balbi <balbi@ti.com>,
	kernel@pengutronix.de
Subject: Re: [PATCH 3/3] watchdog: omap: simplify assignment of bootstatus
Message-ID: <20150426191413.GA19431@pengutronix.de>
References: <1429868913-24049-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1429868913-24049-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150424190317.GV19431@pengutronix.de>
 <553D0410.4010802@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <553D0410.4010802@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

On Sun, Apr 26, 2015 at 08:28:16AM -0700, Guenter Roeck wrote:
> if you don't mind, can you sesend the entire series ?
yeah, that's my plan. I already fixed it for Felipe's comments and
intend to resend tomorrow.

> I don't think patch 1 applies after 1a, and it might make sense
> to add some more explanation to patch 2. FWIW, I would say that using
> to_omap_wdt_dev() instead of watchdog_get_drvdata() simplifies the code,
> or simply that the functions are no longer needed in the driver (ugliness
> may be seen as personal opinion).
> 
> When you do so, please feel free to add
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net> to all four patches.
Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
