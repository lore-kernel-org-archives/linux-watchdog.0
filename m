Return-path: <ukl@pengutronix.de>
Date: Tue, 29 Sep 2015 10:51:02 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 1/9] watchdog: Always evaluate new timeout against
 min_timeout
Message-ID: <20150929085102.GB3982@pengutronix.de>
References: <1443515252-30085-1-git-send-email-linux@roeck-us.net>
 <1443515252-30085-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1443515252-30085-2-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Sep 29, 2015 at 01:27:24AM -0700, Guenter Roeck wrote:
> Up to now, a new timeout value is only evaluated against min_timeout
> if max_timeout is provided. This does not really make sense; a driver
> can have a minimum timeout even if it does not have a maximum timeout.
> Ensure that it is not smaller than min_timeout, even if max_timeout
> is not set.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
