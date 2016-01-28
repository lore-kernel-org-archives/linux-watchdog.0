Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:57706 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932841AbcA1LGP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 28 Jan 2016 06:06:15 -0500
Date: Thu, 28 Jan 2016 11:05:20 +0000
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, wim@iguana.be,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
Message-ID: <20160128110520.2e73c91a@lxorguk.ukuu.org.uk>
In-Reply-To: <20160128001836.GA15216@sophia>
References: <20160125190942.GA6824@sophia>
	<20160125192810.2487661b@lxorguk.ukuu.org.uk>
	<56A6889E.60208@roeck-us.net>
	<56A6B198.2080205@gmail.com>
	<56A6CB48.4010402@roeck-us.net>
	<56A80391.40009@gmail.com>
	<56A84F75.3050805@roeck-us.net>
	<20160128001836.GA15216@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > 8-bit read of 299h =E2=80=93 save this value
> > 8-bit write of 60h to 299h
> > 16-bit read of 29ah should return the base address of the WDT which=
 is 564h
> > 8-bit write of saved value to 299h - don=E2=80=99t want t accidenta=
lly change the WDT base address =20
>=20
> If the system does return a value of 0x564, then it's pretty safe to =
say
> that the watchdog timer is implemented on the chip. However, I'm not
> sure it would be safe to send write commands to a port address until =
the
> hardware has been identified; this second method may not be the best
> route either.
>=20
> What do you think?

Pokng at 299/29a could hang other systems, so DMI is definitely
preferable if it's not described in ACPI as it perhaps ought to have
been. If all boards with that DMI string have the device then sorted, i=
f
not then perhaps check 299/29a after the DMI match.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
