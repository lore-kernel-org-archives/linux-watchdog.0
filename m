Return-path: <ukl@pengutronix.de>
Date: Tue, 4 Aug 2015 13:24:31 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] watchdog: Add support for keepalives triggered by
 infrastructure
Message-ID: <20150804112431.GK9999@pengutronix.de>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

On Mon, Aug 03, 2015 at 07:13:26PM -0700, Guenter Roeck wrote:
> This patch set does not solve all limitations of the watchdog subsystem.
> Specifically, it does not add support for the following features.
> 
> - It is desirable to be able to specify a maximum early timeout,
>   from booting the system to opening the watchdog device.
> - Some watchdogs may require a minimum period of time between
>   heartbeats. Examples are DA9062 and possibly AT91SAM9x.

Other things that come to my mind:
 - move handling of nowayout into the core
 - some drivers use a reboot notifier. Not sure what they are intended
   to do there. For i.MX2x it triggers a reboot; for gpio-wdt it tries
   to stop the watchdog.

Of course this doesn't mean this should addressed here. I like the
series in general.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
