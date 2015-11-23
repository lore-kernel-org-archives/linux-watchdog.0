Return-path: <alexander.stein@systec-electronic.com>
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, Timo Kokkonen <timo.kokkonen@offcode.fi>, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 2/8] watchdog: Introduce WDOG_RUNNING flag
Date: Mon, 23 Nov 2015 17:30:10 +0100
Message-ID: <8288660.mctbFIZEK3@ws-stein>
In-Reply-To: <1448248865-21684-3-git-send-email-linux@roeck-us.net>
References: <1448248865-21684-1-git-send-email-linux@roeck-us.net> <1448248865-21684-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Sunday 22 November 2015 19:20:59, Guenter Roeck wrote:
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index f66859117d1f..3f0963b2c33e 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -212,6 +212,14 @@ bit-operations. The status bits that are defined are:
>    any watchdog_ops, so that you can be sure that no operations (other then
>    unref) will get called after unregister, even if userspace still holds a
>    reference to /dev/watchdog
> +* WDOG_RUNNING: Set by the watchdog driver if the hardware watchdog is running.
> +  The bit must be set if the watchdog timer hardware can not be stopped.
> +  The bit may also be set if the watchdog timer is running aftyer booting,
                                                                 ^
                                                                 typo
Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010
