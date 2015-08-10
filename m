Return-path: <ukl@pengutronix.de>
Date: Mon, 10 Aug 2015 09:25:34 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: kernel@pengutronix.de, Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 3/5] watchdog: mpc8xxx: make use of
 of_device_get_match_data
Message-ID: <20150810072534.GQ9999@pengutronix.de>
References: <1438942067-1654-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1438942067-1654-4-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1438942067-1654-4-git-send-email-u.kleine-koenig@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, Aug 07, 2015 at 12:07:45PM +0200, Uwe Kleine-König wrote:
> This function is new in v4.2-rc1 and makes a forward declaration of the
> match table superfluous which can so be removed.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
This patch is broken, it is supposed to do less, I'll look into this
later.


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
