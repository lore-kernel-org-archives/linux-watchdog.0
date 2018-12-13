Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40142 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeLMQSg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 13 Dec 2018 11:18:36 -0500
Date: Thu, 13 Dec 2018 17:18:31 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
Message-ID: <20181213161831.GC13531@ulmo>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-16-paul@crapouillou.net>
 <20181213092409.ml4wpnzow2nnszkd@pengutronix.de>
 <1544709795.18952.1@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <1544709795.18952.1@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 03:03:15PM +0100, Paul Cercueil wrote:
> Hi,
>=20
> Le jeu. 13 d=C3=A9c. 2018 =C3=A0 10:24, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> a =C3=A9crit :
> > Hello,
> >=20
> > On Wed, Dec 12, 2018 at 11:09:10PM +0100, Paul Cercueil wrote:
> > >  The PWM in the JZ4725B works the same as in the JZ4740, except that
> > > it
> > >  only has 6 channels available instead of 8.
> >=20
> > this driver is probed only from device tree? If yes, it might be
> > sensible to specify the number of PWMs there and get it from there.
> > There doesn't seem to be a generic binding for that, but there are
> > several drivers that could benefit from it. (This is a bigger project
> > though and shouldn't stop your patch. Still more as it already got
> > Thierry's ack.)
>=20
> I think there needs to be a proper guideline, as there doesn't seem to be
> a consensus about this. I learned from emails with Rob and Linus (Walleij)
> that I should not have in devicetree what I can deduce from the compatible
> string.

Correct. If the compatible string already defines the number of PWMs
that the hardware exposes, there's no need to explicitly say so again in
DT.

Thierry

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwShlcACgkQ3SOs138+
s6FpGBAAnSdBj1VfdT/8QgKaKbqU4xM6IIM84lPPIcpnwOx61r4Q9wKVlcWX7I9h
uYpGNc+ObutBYqeqCt73aJZ6AW9EQyvD47/D2dMHt6SexpCAse2Rg7OfwPxV3qN7
NlfVdBSqtBGcrVZZLtZ3+JPkLzIUhl4UooMQo6j73FCRiww7k1B5YfdrGeN38kDA
o8nMXKNuSRSXSF3KUNeDHx2mIB1BjRJJjW5pOwfIbQbO4EdhxHzkgS54UlZU/bUr
z0gqwFMOGsRPrhSmvDv5CR5GKbbxC/YR3uPcAFOSgEuXr+1LEaEtzhTea5h1yokw
POmWLezWZ6Y8RlhawFhnBWGg44E/HO1x5H3UVUQjmM16I++lovIyZh8PwwAhyO5q
6mEWlcLjBnPoOXh7t8RRmZUJ5s6za2l2oBm6Ot/mjDjrPmabwNCMVDTz5GyHDtK3
uflj6xxSlSt8eQV66yFA62wdoXPz5MFSGumz+kOQQOs2rqzSGh3C7rp3nU5xmE/K
DfsNs92AvWte+ad0nbvZ3IrPYkZH/FdJErx6QMEBUvbwcmwxPh0m4VfKaa8DUZ7Z
s9dKdJYLkT6RtGpBK9qK3Anrh7Cp6+zImtyf7pyh89KN2P4oIQroq51Ape6gpFnt
RZVc3NqUTOk2/RXelfCPC23ShWn1dxzOSOhXrtQ6FQOAKwQ7bkY=
=qfF6
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
