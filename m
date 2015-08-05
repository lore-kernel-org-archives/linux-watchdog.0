Return-path: <ukl@pengutronix.de>
Date: Wed, 5 Aug 2015 10:27:21 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de
Subject: Re: [PATCH 0/8] watchdog: Add support for keepalives triggered by
 infrastructure
Message-ID: <20150805082721.GY9999@pengutronix.de>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
 <55C14E2B.1080904@draigBrady.com>
 <20150805073605.GW9999@pengutronix.de>
 <55C1C041.3080504@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55C1C041.3080504@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Guenter,

On Wed, Aug 05, 2015 at 12:50:25AM -0700, Guenter Roeck wrote:
> On 08/05/2015 12:36 AM, Uwe Kleine-König wrote:
> >the watchdog I'm currently working with on a powerpc platform has a
> >unchangable timeout of ~1 s. To make the machine boot I patched the
> >bootloader and need some automatic pinging in the kernel before
> >userspace takes over.
> >
> 
> Does using arch_initcall in the watchdog driver help here, or is that
> still too slow and you really need to hack the kernel ?

I didn't do any measurements yet, but having the bootloader extracting
the kernel, and then send a ping before jumping into it is good enough
even without CONFIG_GPIO_WATCHDOG_ARCH_INITCALL to get the machine up.
(Userspace doesn't do any watchdog handling yet.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
