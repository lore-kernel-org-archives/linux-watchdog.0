Return-path: <prvs=1682412c0=Rasmus.Villemoes@prevas.dk>
Subject: Re: [PATCH v3 0/2] watchdog: allow setting deadline for opening
 /dev/watchdogN
To: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1481534273-7600-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1481722654-6266-1-git-send-email-rasmus.villemoes@prevas.dk>
CC: Guenter Roeck <linux@roeck-us.net>, Sylvain Lemieux
	<slemieux.tyco@gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <1a8dd51c-451f-604f-ec21-c8de46533564@prevas.dk>
Date: Mon, 2 Jan 2017 09:04:30 +0100
MIME-Version: 1.0
In-Reply-To: <1481722654-6266-1-git-send-email-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 2016-12-14 14:37, Rasmus Villemoes wrote:

> If a watchdog driver tells the framework that the device is running,
> the framework takes care of feeding the watchdog until userspace opens
> the device. If the userspace application which is supposed to do that
> never comes up properly, the watchdog is fed indefinitely by the
> kernel. This can be especially problematic for embedded devices.
>
> These patches allow one to set a maximum time for which the kernel
> will feed the watchdog, thus ensuring that either userspace has come
> up, or the board gets reset.

Ping.

Rasmus
