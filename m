Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42078 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322AbbBQN6B (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Feb 2015 08:58:01 -0500
Date: Tue, 17 Feb 2015 22:56:49 +0900
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <wsa@the-dreams.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lee Jones <lee.jones@linaro.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Linux I2C <linux-i2c@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20150217135649.GU9110@finisterre.sirena.org.uk>
References: <CAMuHMdUasUmnHRi5t3GStrt-WKw0Das4noTmZPNtcbqA7nmDvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q43QQdzFtqSKgsg+"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUasUmnHRi5t3GStrt-WKw0Das4noTmZPNtcbqA7nmDvQ@mail.gmail.com>
Subject: Re: ARM: shmobile: koelsch: da9210/da9063 interrupt storm (was: Re:
 [PATCH 3/4] ARM: shmobile: koelsch: Add DA9063 PMIC device node for system
 restart)
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--Q43QQdzFtqSKgsg+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2015 at 01:05:07PM +0100, Geert Uytterhoeven wrote:

> However, as soon as the da9210 driver will get interrupt support (I wrote
> something, based on the da9211 driver) and the da9210 will have an interr=
upts
> property in DTS, the interrupt storm will reappear, irrespectively of the=
 order
> in which the two drivers are initialized.

Well, there's another problem there - unless things changed since I last
looked we don't support shared threaded IRQs.

> So far I see only two solutions:
>   - Add platform code that matches against "renesas,koelsch" (and
>     "renesas,lager"), and mask the interrupts in both the da9210 and da90=
63.
>     This code has to run after the i2c master driver has been initialized,
>     but before the i2c slave drivers are initialized.
>   - Handle the masking in the bootloader (u-boot), which already knows ho=
w to
>     reset the board by kicking the da9063. This requires everybody to upg=
rade
>     his bootloader, though.

> Does anyone have a better solution?

We could try to make the code that masks interrupts on error handle
screaming shared interrupts a bit more gracefully during bootstrap by
shutting things up a bit more aggressively and retrying when something
else registers but that just feels like it's going to open up a
particularly messy rabbit hole. =20

Of the options you list above the platform code sounds the most
palatable.

> Question: Is it really the default state of the regulator to not mask
> any interrupts?
> Or could this have been changed by the bootloader? I couldn't find code r=
elated
> to that in U-Boot, but as I didn't compile the bootloader myself, I can't=
 be
> 100% certain about the source code.

It wouldn't surprise me, having talked with designers of analogue chips
they can at times have some innovative ideas about interaction with the
processor and interrupts in particular.  It's also possible that there's
some transient condition that occurs during startup that causes the
interrupts to be flagged.

--Q43QQdzFtqSKgsg+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU40icAAoJECTWi3JdVIfQaqMH/A+XEE0puUZvRgRzYukFQoCM
J0zLRFq2WaIMykXpVnZ7RZTB0vSG4OkWoEZFlydE/cUxq9HmffXkTUFh0JSxuu44
tLHw4crwegcQ/FvnaCIiENEKEkMc783Xw9TSUPC5pOGawXZVWhzAxcP4WP1vvStD
9H/MLVzm0G6F1e3S0+rDFbDgSPeGqfuWa6QfIXLAZEJqXRWauPvT+k+sYbU+bjql
XaJU/G2KizCCRom6b/U0LA0Hptsox/WmT+XelSMQi7DJJYJaXlMzOcjE5YdHaa/O
Zv05Q5rCgDQFQtMcEMl3uXnJX9mOaqGQSV6qGk6S70ZneJu6dqLSTR7dum+Karg=
=DxLE
-----END PGP SIGNATURE-----

--Q43QQdzFtqSKgsg+--
