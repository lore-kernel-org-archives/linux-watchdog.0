Return-path: <ukl@pengutronix.de>
Date: Tue, 24 Nov 2015 08:13:33 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 5/8] watchdog: Simplify update_worker
Message-ID: <20151124071333.GE19888@pengutronix.de>
References: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
 <1448248865-21684-6-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1448248865-21684-6-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

On Sun, Nov 22, 2015 at 07:21:02PM -0800, Guenter Roeck wrote:
> Drop 'cancel' parameter; simply cancel worker unconditionally
> if not needed.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

This is a good change, but given that watchdog_update_worker is
introduced in this series it should be squashed accordingly.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
