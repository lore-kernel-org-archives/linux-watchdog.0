Return-path: <ukl@pengutronix.de>
Date: Tue, 4 Aug 2015 17:44:22 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 5/8] watchdog: imx2: Convert to use infrastructure
 triggered keepalives
Message-ID: <20150804154422.GU9999@pengutronix.de>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
 <1438654414-29259-6-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1438654414-29259-6-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

On Mon, Aug 03, 2015 at 07:13:31PM -0700, Guenter Roeck wrote:
> The watchdog infrastructure now supports handling watchdog keepalive
> if the watchdog is running while the watchdog device is closed.
> Convert the driver to use this infrastructure.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/imx2_wdt.c | 72 ++++++++-------------------------------------

I tested the series on an i.MX27 machine and it works nicely. When the
watchdog is already running at probe time it is constantly pinged until
userspace opens /dev/watchdog. With the patch I sent earlier today the
functionallity is also given, that is the machine resets iff I stop
pinging. And when I do a stopping-close the worker looks for this in
hardware non-stoppable device.

Very nice, and also \o/ for the diffstat,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
