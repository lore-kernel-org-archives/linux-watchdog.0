Return-path: <ukl@pengutronix.de>
Date: Mon, 10 Aug 2015 09:24:28 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, kernel@pengutronix.de,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 3/5] watchdog: mpc8xxx: make use of
 of_device_get_match_data
Message-ID: <20150810072428.GP9999@pengutronix.de>
References: <1438942067-1654-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1438942067-1654-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <55C4C733.7000802@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55C4C733.7000802@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

On Fri, Aug 07, 2015 at 07:56:51AM -0700, Guenter Roeck wrote:
> >  	enabled = in_be32(&wd_base->swcrr) & SWCRR_SWEN;
> >  	if (!enabled && wdt_type->hw_enabled) {
> >  		pr_info("could not be enabled in software\n");
> >-		ret = -ENOSYS;
> >-		goto err_unmap;
> >+		return -ENOSYS;
> >  	}
> 
> checkpatch says:
> 
> WARNING: ENOSYS means 'invalid syscall nr' and nothing else
> #65: FILE: drivers/watchdog/mpc8xxx_wdt.c:166:
> +		return -ENOSYS;
> 
> Maybe just use -ENODEV.
That would be a separate patch tough because I'm just changing the code
flow and ENOSYS was there already before.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
