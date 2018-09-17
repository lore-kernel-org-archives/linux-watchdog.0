Return-Path: <romain.izard@mobile-devices.fr>
Return-path: <romain.izard@mobile-devices.fr>
MIME-Version: 1.0
Sender: romain.izard@mobile-devices.fr
In-Reply-To: <20180914102732.GP14988@piout.net>
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
 <20180914101339.7382-3-romain.izard.pro@gmail.com> <20180914102732.GP14988@piout.net>
From: Romain Izard <romain.izard.pro@gmail.com>
Date: Mon, 17 Sep 2018 15:58:45 +0200
Message-ID: <CAGkQfmPydsn6cH2pHQ9HQeGQo0J4qJ9vXjkQD+_W5iyz---KEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: sama5d4: write the mode register in two steps
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Marcus Folkesson <marcus.folkesson@gmail.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-watchdog@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

2018-09-14 12:27 GMT+02:00 Alexandre Belloni <alexandre.belloni@bootlin.com>:
> On 14/09/2018 12:13:39+0200, Romain Izard wrote:
>> The specification for SAMA5D2 and SAMA5D4 chips, that use this IP for
>> their watchdog timer, has the following advice regarding the Mode Register:
>>
>> "When setting the WDDIS bit, and while it is set, the fields WDV and WDD
>> must not be modified."
>>
>> I have observed on a board based on a SAMA5D2 chip that using any other
>> timeout duration than the default 16s in the device tree will reset the
>> board when the watchdog device is opened; this is probably due to ignoring
>> the aforementioned constraint.
>>
>> To fix this, read the content of the Mode Register before writing it,
>> and split the access into two parts if WDV or WDD need to be changed.
>>
>
> Hum, that is really weird because when I developed
> 015b528644a84b0018d3286ecd6ea5f82dce0180, I tested with a program doing:
>
>         flags = WDIOS_DISABLECARD;
>         ioctl(fd, WDIOC_SETOPTIONS, &flags);
>         for (i = 16; i > 2; i--) {
>                 ioctl(fd, WDIOC_SETTIMEOUT, &i);
>         }
>
>         ioctl(fd, WDIOC_KEEPALIVE, &dummy);
>
>         flags = WDIOS_ENABLECARD;
>         ioctl(fd, WDIOC_SETOPTIONS, &flags);
>
>         for (i = 16; i > 2; i--) {
>                 ioctl(fd, WDIOC_SETTIMEOUT, &i);
>         }
>
> This would immediately reproduce the reset when changing WDV/WDD with
> WDDIS set.
>
> I'll test again.
>

The issue is visible when setting a custom value for the timeout on startup.
In the past it was only possible to do so with a module parameter, and the
previous patch in the series makes it possible to do with the device tree.

When using the Linux4SAM 5.7 release, it is sufficient to set the timeout on
the command line to reproduce the issue:

In the bootloader:
# setenv bootargs $bootargs sama5d4_wdt.wdt_timeout=10

To trigger an immediate reset (with some code that should work):
# (echo 1; while sleep 3; do echo 1; done) > /dev/watchdog

Best regards,
-- 
Romain Izard
