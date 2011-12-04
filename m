Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:45108 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592Ab1LDQeW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 4 Dec 2011 11:34:22 -0500
To: Wolfram Sang <w.sang@pengutronix.de>
cc: Heiko Schocher <hs@denx.de>, Vitaly Bordug <vbordug@ru.mvista.com>,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] drivers, char: add U-Boot bootcount driver
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <20111204114741.GA5788@pengutronix.de>
References: <1322991921-21096-1-git-send-email-hs@denx.de> <20111204114741.GA5788@pengutronix.de>
Date: Sun, 04 Dec 2011 17:34:17 +0100
Message-Id: <20111204163417.1AD6625EA22@gemini.denx.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Dear Wolfram,

in message <20111204114741.GA5788@pengutronix.de> you wrote:
>=20
> >       Description: OSDL CGL specifies that carrier grade Linux
> >       shall provide support for detecting a repeating reboot cycle
> > 	due to recurring failures. This detection should happen in
> > 	user space before system services are started.
>
> So, technically, a flag would be enough, not necessarily a counter? Alt=
hough a
> counter probably has more advantages...

The real-life applications we have seen so far all required a counter.
They all required to switch to a recovery mode or other alternative
boot sequence after N failed boot attempts, with N > 1 in all cases.

> >                   reg =3D <0x23060 0x20>;
>
> I assume that non-volatile memory would qualify as a boot-counter, so t=
hose
> could be tied to I2C busses etc? reg would not fit then.

Actually all kind of non-volatile storage can be used - it depends
on specific hardware roperties.  Some SoCs have registers that are
guaranteed not to change theier value during a reset; on other systems
we have storage or NVRAM in RTCs or similar, or we can use SRAM, or
I2C or SPI attached EEPROM, or even storage on SDCard, USB or other
storage devices.

This binding covers the memory type only.

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"There is nothing new under the sun, but there are lots of old things
we don't know yet."                                  - Ambrose Bierce
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
