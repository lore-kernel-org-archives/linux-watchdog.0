Return-path: <P@draigbrady.com>
Message-ID: <55C14E2B.1080904@draigBrady.com>
Date: Wed, 05 Aug 2015 00:43:39 +0100
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
 Timo Kokkonen <timo.kokkonen@offcode.fi>,
 =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] watchdog: Add support for keepalives triggered by
 infrastructure
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On 04/08/15 03:13, Guenter Roeck wrote:
> The watchdog infrastructure is currently purely passive, meaning
> it only passes information from user space to drivers and vice versa.
> 
> Since watchdog hardware tends to have its own quirks, this can result
> in quite complex watchdog drivers. A number of scanarios are especially common.
> 
> - A watchdog is always active and can not be disabled, or can not be disabled
>   once enabled. To support such hardware, watchdog drivers have to implement
>   their own timers and use those timers to trigger watchdog keepalives while
>   the watchdog device is not or not yet opened.
> - A variant of this is the desire to enable a watchdog as soon as its driver
>   has been instantiated, to protect the system while it is still booting up,
>   but the watchdog daemon is not yet running.

Just mentioning that patting the watchdog in the boot loader
(by patching grub etc.) can be a more general solution here as it
avoids hangs if the kernel crashes before it runs the watchdog driver,
which is especially true if PXE loaded across the net for example.
Also this tends to be better spaced between boot start and user space loading.

> - Some watchdogs have a very short maximum timeout, in the range of just a few
>   seconds. Such low timeouts are difficult if not impossible to support from
>   user space. Drivers supporting such watchdog hardware need to implement
>   a timer function to augment heartbeats from user space.

Fair enough.

thanks,
Pádraig.
