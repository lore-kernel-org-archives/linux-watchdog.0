Return-path: <ukl@pengutronix.de>
Date: Tue, 24 Nov 2015 08:16:28 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 1/8] watchdog: Introduce hardware maximum timeout in
 watchdog core
Message-ID: <20151124071628.GF19888@pengutronix.de>
References: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
 <1448248865-21684-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1448248865-21684-2-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

On Sun, Nov 22, 2015 at 07:20:58PM -0800, Guenter Roeck wrote:
> Introduce an optional hardware maximum timeout in the watchdog core.
> The hardware maximum timeout can be lower than the maximum timeout.
> 
> Drivers can set the maximum hardware timeout value in the watchdog data
> structure. If the configured timeout exceeds the maximum hardware timeout,
> the watchdog core enables a timer function to assist sending keepalive
> requests to the watchdog driver.
> 
> Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
