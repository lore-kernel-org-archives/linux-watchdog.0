Return-path: <ukl@pengutronix.de>
Date: Tue, 4 Aug 2015 17:38:24 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 4/8] watchdog: Make set_timeout function optional
Message-ID: <20150804153823.GS9999@pengutronix.de>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
 <1438654414-29259-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1438654414-29259-5-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

On Mon, Aug 03, 2015 at 07:13:30PM -0700, Guenter Roeck wrote:
> For some watchdogs, the hardware timeout is fixed, and the
> watchdog driver depends on the watchdog core to handle the
> actual timeout. In this situation, the watchdog driver might
> only set the 'timeout' variable but do nothing else.
> This can as well be handled by the infrastructure, so make
> the set_timeout callback optional. If WDIOF_SETTIMEOUT is
> configured but the .set_timeout callback is not available,
> update the timeout variable in the infrastructure code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/watchdog/watchdog-kernel-api.txt | 4 ++++
>  drivers/watchdog/watchdog_dev.c                | 9 ++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index 7fda3c86cf46..2f1a4ad7e565 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -178,6 +178,10 @@ they are supported. These optional routines/operations are:
>    because the watchdog does not necessarily has a 1 second resolution).
>    (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
>    watchdog's info structure).
> +  If the watchdog driver does not have to perform any action but setting the
> +  timeout value of the watchdog_device, this callback can be omitted.
> +  If set_timeout is not provided but WDIOF_SETTIMEOUT is set, the watchdog
> +  infrastructure updates the timeout value of the watchdog_device internally.
What is the semantic of struct watchdog_device.timeout? Is it the
corrently configured hw-timeout? Or what userspace sees? In the former
case timeout shouldn't be updated. And in the latter case it's wrong
that the worker thread uses this member to determine the needed rate for
it's auto pinging.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
