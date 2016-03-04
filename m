Return-path: <romain.izard@mobile-devices.fr>
MIME-Version: 1.0
Sender: romain.izard@mobile-devices.fr
In-Reply-To: <20160304155952.2f433f3f@ipc1.ka-ro>
References: <1457000979-15717-1-git-send-email-romain.izard.pro@gmail.com>
 <56D8E649.8030500@atmel.com> <56D91BDC.1030604@roeck-us.net>
 <CAGkQfmN9wDkrc=frsSdBYYtMPf4VaTpcmYjX6_wARs=a78-bPQ@mail.gmail.com>
 <56D988F0.8050803@roeck-us.net> <CAGkQfmOLVwpckKP+axdi1501ghqq_UAmCygJv_tfa=bCOLvCzA@mail.gmail.com>
 <56D99404.60305@roeck-us.net> <20160304155952.2f433f3f@ipc1.ka-ro>
From: Romain Izard <romain.izard.pro@gmail.com>
Date: Fri, 4 Mar 2016 16:26:59 +0100
Message-ID: <CAGkQfmNpsOUE9PgnnNWYzodsfjzfw=e7UK+qMG9acKTEU8yufw@mail.gmail.com>
Subject: Re: [PATCH v1] watchdog: sama5d4_wdt: Reset delay on start
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>, LKML <linux-kernel@vger.kernel.org>,
	"Yang, Wenyou" <wenyou.yang@atmel.com>, Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Hi Lothar,

2016-03-04 15:59 GMT+01:00 Lothar Wa=C3=9Fmann <LW@karo-electronics.de>:
>> >>>>> I also check the WDT_MR register before and after enabling
>> >>>>> watchdog, the WDV and WDD fields are correct.
>> >>>>>
>> >>>>> Can you check it again? thank you.
>> >>>
>> >>>
>> >>> Working case:
>> >>> MR on kernel startup:   0x3fffafff
>> >>> MR after watchdog init: 0x0fffafff
>> >>> MR after start:         0x0fff2fff
>> >>>
>> >>> Problem case:
>> >>> MR on kernel startup:   0x00008000
>> >>> MR after watchdog init: 0x0fffafff
>> >>> MR after start:         0x0fff2fff
>> >>>
>> >>> So this means that the counter reload does not seem to work very wel=
l
>> >>> if WDD/WDV have been set to 0 in the past. The other question is why
>> >>> does U-Boot (from the Atmel branch based on 2015.1) put this stange
>> >>> value in this register.
>> >>>
>> >>
>> >> Can you check the value of AT91_WDT_SR ? Maybe it tells us something.
>> >>
>> > I didn't report it because it contained 0 at all times. So no informat=
ion.
>> >
>> >> Also, in the error case, can you check if the watchdog times out at a=
ll
>> >> after you applied your patch ?
>> >
>> > It times out after 16s as expected, and reboot occurs correctly.
>> >
>>
>> Interesting. So it looks like AT91_WDT_WDRSTT has to be set if the timer
>> values in MR are changed from 0 to another value, or maybe after each
>> timer value change. Wonder if that should be done in the init function,
>> after MR is set (with the watchdog disabled).
>>
>> Thoughts, anyone ?
>>

> Are you aware of the Notes in the SAMA5D4 Reference Manual (Chapter
> 19.5.2 Watchdog Timer Mode Register):
>
> |Note: The first write access prevents any further modification of
> |      the value of this register. Read accesses remain possible.
> |Note: The WDD and WDV values must not be modified within three slow
> |      clock periods following a restart of the watchdog performed by
> |      a write access in WDT_CR. Any modification will cause the watchdog
> |      to trigger an end of period earlier than expected.

This text is valid for older versions of the Watchdog controller, found
in AT91SAM9 and SAMA5D3 chips. But SAMA5D4 & SAMA5D2 have a newer
revision, which supports multiple writes to the MR register.

Are you sure about your datasheet? I have this in the latest version
found on Atmel's site.

> Atmel-11238B-ATARM-SAMA5D4-Datasheet_24-Aug-15
> Section 18.5.2
>
> Note: Write access to this register has no effect if the LOCKMR
>       command is issued in WDT_CR (unlocked on hardware reset).
> Note: The WDT_MR register values must not be modified within three slow
>       clock periods following a restart of the watchdog performed by
>       a write access in WDT_CR. Any modification will cause the watchdog
>       to trigger an end of period earlier than expected.
>

It matches the comments from Wenyou when he committed the sama5d4
watchdog driver to replace the existing at91sam9 watchdog.

Best regards,
--=20
Romain Izard
