Return-path: <ukl@pengutronix.de>
Date: Tue, 24 Nov 2015 17:11:47 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 1/8] watchdog: Introduce hardware maximum timeout in
 watchdog core
Message-ID: <20151124161147.GH19888@pengutronix.de>
References: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
 <1448248865-21684-2-git-send-email-linux@roeck-us.net>
 <20151124071628.GF19888@pengutronix.de>
 <56547C31.3070901@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56547C31.3070901@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

On Tue, Nov 24, 2015 at 07:03:13AM -0800, Guenter Roeck wrote:
> thanks a lot for the Ack. I have v6 in the works, which changes recording
> of last_keepalive when the watchdog is started. Does your Ack include that
> change, or do you prefer to have another look ?

this change is to sample jiffies before .start is called as I suggested,
right? For that change keeping my ack is ok of course.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
