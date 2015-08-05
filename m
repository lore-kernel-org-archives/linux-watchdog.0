Return-path: <ukl@pengutronix.de>
Date: Wed, 5 Aug 2015 09:36:05 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] watchdog: Add support for keepalives triggered by
 infrastructure
Message-ID: <20150805073605.GW9999@pengutronix.de>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
 <55C14E2B.1080904@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55C14E2B.1080904@draigBrady.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Pádraig,

On Wed, Aug 05, 2015 at 12:43:39AM +0100, Pádraig Brady wrote:
> On 04/08/15 03:13, Guenter Roeck wrote:
> > The watchdog infrastructure is currently purely passive, meaning
> > it only passes information from user space to drivers and vice versa.
> > 
> > Since watchdog hardware tends to have its own quirks, this can result
> > in quite complex watchdog drivers. A number of scanarios are especially common.
> > 
> > - A watchdog is always active and can not be disabled, or can not be disabled
> >   once enabled. To support such hardware, watchdog drivers have to implement
> >   their own timers and use those timers to trigger watchdog keepalives while
> >   the watchdog device is not or not yet opened.
> > - A variant of this is the desire to enable a watchdog as soon as its driver
> >   has been instantiated, to protect the system while it is still booting up,
> >   but the watchdog daemon is not yet running.
> 
> Just mentioning that patting the watchdog in the boot loader
> (by patching grub etc.) can be a more general solution here as it
> avoids hangs if the kernel crashes before it runs the watchdog driver,
> which is especially true if PXE loaded across the net for example.
> Also this tends to be better spaced between boot start and user space loading.

the watchdog I'm currently working with on a powerpc platform has a
unchangable timeout of ~1 s. To make the machine boot I patched the
bootloader and need some automatic pinging in the kernel before
userspace takes over.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
