Return-path: <alexander.stein@systec-electronic.com>
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] watchdog: gpio-wdt: Add panic notifier
Date: Mon, 09 Nov 2015 16:46:46 +0100
Message-ID: <5304900.PRXBMJ6Hhh@ws-stein>
In-Reply-To: <5640B96D.6010408@roeck-us.net>
References: <1447062944-12296-1-git-send-email-alexander.stein@systec-electronic.com> <1447062944-12296-2-git-send-email-alexander.stein@systec-electronic.com> <5640B96D.6010408@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

On Monday 09 November 2015 07:19:09, Guenter Roeck wrote:
> On 11/09/2015 01:55 AM, Alexander Stein wrote:
> > This notifier is required when the watchdog is configured as always 
running
> > because in this case the watchdog will be triggered when the kernel panics
> > at boot before any application could open the device, e.g. because the
> > rootfs is broken. This should result in a resetting system. Thus we
> > register a panic notifier which stops triggering the watchdog.
> 
> Shouldn't the timer be stopped instead ?

I think it may be stopped additionally, it would make it alsomore similar to 
gpio_wdt_notify_sys. AFAICS gpio_wdt_disable ensures that a HW_ALGO_LEVEL type 
is set to inactive state otherwise it would stay triggered.

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
