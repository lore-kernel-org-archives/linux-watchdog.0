Return-path: <ukl@pengutronix.de>
Date: Tue, 5 May 2015 15:53:29 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Felipe Balbi <balbi@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
	unknown author <unknown.author@example.com>, kernel@pengutronix.de
Subject: Re: [PATCH v2 6/4] watchdog: omap: allow to keep timer running at
 probe time
Message-ID: <20150505135329.GJ25193@pengutronix.de>
References: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1430332727-27491-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <55430683.2030102@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55430683.2030102@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

On Thu, Apr 30, 2015 at 09:52:19PM -0700, Guenter Roeck wrote:
> On 04/29/2015 11:38 AM, Uwe Kleine-König wrote:
> >From: unknown author <unknown.author@example.com>
> >
> >On some machines it might be desirable to keep the watchdog that is
> >started in the boot ROM running until userspace starts stroking it to be
> >able to handle boot failures.
> >
> >To not introduce regressions for users not caring about the watchdog
> >keep the previous behaviour of disabling the watchdog in the probe
> >function unless a module parameter stop_at_probe is set to false.
> >
> >Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Uwe,
> 
> would this address the problem you are tryng to solve ?
> 
> http://www.spinics.net/lists/arm-kernel/msg413658.html
yeah, it would. It just doesn't solve my problem now as the series isn't
ready for merging yet :-) I will keep my patch locally for the project
I'm working on and already provided feedback to this thread.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
