Return-path: <ukl@pengutronix.de>
Date: Tue, 24 Nov 2015 22:14:08 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 1/8] watchdog: Introduce hardware maximum timeout in
 watchdog core
Message-ID: <20151124211408.GI19888@pengutronix.de>
References: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
 <1448248865-21684-2-git-send-email-linux@roeck-us.net>
 <20151124071628.GF19888@pengutronix.de>
 <56547C31.3070901@roeck-us.net>
 <20151124161147.GH19888@pengutronix.de>
 <56549411.7000209@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56549411.7000209@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

On Tue, Nov 24, 2015 at 08:45:05AM -0800, Guenter Roeck wrote:
> On 11/24/2015 08:11 AM, Uwe Kleine-König wrote:
> >On Tue, Nov 24, 2015 at 07:03:13AM -0800, Guenter Roeck wrote:
> >>thanks a lot for the Ack. I have v6 in the works, which changes recording
> >>of last_keepalive when the watchdog is started. Does your Ack include that
> >>change, or do you prefer to have another look ?
> >
> >this change is to sample jiffies before .start is called as I suggested,
> >right? For that change keeping my ack is ok of course.
> >
> 
> Correct. This is how the code now looks like.
> 
>         started_at = jiffies;
>         if (watchdog_hw_running(wdd) && wdd->ops->ping)
>                 err = wdd->ops->ping(wdd);
>         else
>                 err = wdd->ops->start(wdd);
>         if (err == 0) {
>                 set_bit(WDOG_ACTIVE, &wdd->status);
>                 wdd->last_keepalive = started_at;
>                 watchdog_update_worker(wdd);
>         }

\o/

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
