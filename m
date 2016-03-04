Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:62367 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759114AbcCDP6T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Mar 2016 10:58:19 -0500
Date: Fri, 4 Mar 2016 16:56:55 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Yang, Wenyou" <wenyou.yang@atmel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1] watchdog: sama5d4_wdt: Reset delay on start
Message-ID: <20160304165655.6b4a65a6@ipc1.ka-ro>
In-Reply-To: <CAGkQfmNpsOUE9PgnnNWYzodsfjzfw=e7UK+qMG9acKTEU8yufw@mail.gmail.com>
References: <1457000979-15717-1-git-send-email-romain.izard.pro@gmail.com>
	<56D8E649.8030500@atmel.com>
	<56D91BDC.1030604@roeck-us.net>
	<CAGkQfmN9wDkrc=frsSdBYYtMPf4VaTpcmYjX6_wARs=a78-bPQ@mail.gmail.com>
	<56D988F0.8050803@roeck-us.net>
	<CAGkQfmOLVwpckKP+axdi1501ghqq_UAmCygJv_tfa=bCOLvCzA@mail.gmail.com>
	<56D99404.60305@roeck-us.net>
	<20160304155952.2f433f3f@ipc1.ka-ro>
	<CAGkQfmNpsOUE9PgnnNWYzodsfjzfw=e7UK+qMG9acKTEU8yufw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Fri, 4 Mar 2016 16:26:59 +0100 Romain Izard wrote:
> Hi Lothar,
>=20
> 2016-03-04 15:59 GMT+01:00 Lothar Wa=C3=9Fmann <LW@karo-electronics.d=
e>:
> >> >>>>> I also check the WDT_MR register before and after enabling
> >> >>>>> watchdog, the WDV and WDD fields are correct.
> >> >>>>>
> >> >>>>> Can you check it again? thank you.
> >> >>>
> >> >>>
> >> >>> Working case:
> >> >>> MR on kernel startup:   0x3fffafff
> >> >>> MR after watchdog init: 0x0fffafff
> >> >>> MR after start:         0x0fff2fff
> >> >>>
> >> >>> Problem case:
> >> >>> MR on kernel startup:   0x00008000
> >> >>> MR after watchdog init: 0x0fffafff
> >> >>> MR after start:         0x0fff2fff
> >> >>>
> >> >>> So this means that the counter reload does not seem to work ve=
ry well
> >> >>> if WDD/WDV have been set to 0 in the past. The other question =
is why
> >> >>> does U-Boot (from the Atmel branch based on 2015.1) put this s=
tange
> >> >>> value in this register.
> >> >>>
> >> >>
> >> >> Can you check the value of AT91_WDT_SR ? Maybe it tells us some=
thing.
> >> >>
> >> > I didn't report it because it contained 0 at all times. So no in=
formation.
> >> >
> >> >> Also, in the error case, can you check if the watchdog times ou=
t at all
> >> >> after you applied your patch ?
> >> >
> >> > It times out after 16s as expected, and reboot occurs correctly.
> >> >
> >>
> >> Interesting. So it looks like AT91_WDT_WDRSTT has to be set if the=
 timer
> >> values in MR are changed from 0 to another value, or maybe after e=
ach
> >> timer value change. Wonder if that should be done in the init func=
tion,
> >> after MR is set (with the watchdog disabled).
> >>
> >> Thoughts, anyone ?
> >>
>=20
> > Are you aware of the Notes in the SAMA5D4 Reference Manual (Chapter
> > 19.5.2 Watchdog Timer Mode Register):
> >
> > |Note: The first write access prevents any further modification of
> > |      the value of this register. Read accesses remain possible.
> > |Note: The WDD and WDV values must not be modified within three slo=
w
> > |      clock periods following a restart of the watchdog performed =
by
> > |      a write access in WDT_CR. Any modification will cause the wa=
tchdog
> > |      to trigger an end of period earlier than expected.
>=20
> This text is valid for older versions of the Watchdog controller, fou=
nd
> in AT91SAM9 and SAMA5D3 chips. But SAMA5D4 & SAMA5D2 have a newer
> revision, which supports multiple writes to the MR register.
>=20
> Are you sure about your datasheet? I have this in the latest version
> found on Atmel's site.
>=20
> > Atmel-11238B-ATARM-SAMA5D4-Datasheet_24-Aug-15
> > Section 18.5.2
> >
OK, I obviously had an outdated Manual.


Lothar Wa=C3=9Fmann
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
