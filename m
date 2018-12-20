Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35358 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387920AbeLTRjJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Dec 2018 12:39:09 -0500
Date: Thu, 20 Dec 2018 18:39:04 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>, ezequiel@collabora.co.uk,
        prasannatsmkumar@gmail.com, linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>, od@zcrc.me
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
Message-ID: <20181220173904.GE9408@ulmo>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-16-paul@crapouillou.net>
 <20181213092409.ml4wpnzow2nnszkd@pengutronix.de>
 <1544709795.18952.1@crapouillou.net>
 <20181213204219.onem3q6dcmakusl2@pengutronix.de>
 <CACRpkdbABtDgwKai=8Pfji7qVb-XHsX8pDsuDdS5hhg7qEN0Bw@mail.gmail.com>
 <20181214142628.zwi4hadrju53z6f3@pengutronix.de>
 <1544969932.1649.1@crapouillou.net>
 <20181217075321.k45vhgnszeqs3tea@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Content-Disposition: inline
In-Reply-To: <20181217075321.k45vhgnszeqs3tea@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 08:53:21AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Sun, Dec 16, 2018 at 03:18:52PM +0100, Paul Cercueil wrote:
> > Hi,
> >=20
> > Le ven. 14 d=C3=A9c. 2018 =C3=A0 15:26, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> a =C3=A9crit :
> > > Hello,
> > >=20
> > > On Fri, Dec 14, 2018 at 02:50:20PM +0100, Linus Walleij wrote:
> > > > On Thu, Dec 13, 2018 at 9:42 PM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > [Adding Linus Walleij to Cc:]
> > > > > On Thu, Dec 13, 2018 at 03:03:15PM +0100, Paul Cercueil wrote:
> > > > > > Le jeu. 13 d=C3=A9c. 2018 =C3=A0 10:24, Uwe Kleine-K=C3=B6nig
> > > > > > <u.kleine-koenig@pengutronix.de> a =C3=A9crit :
> > > > > > > On Wed, Dec 12, 2018 at 11:09:10PM +0100, Paul Cercueil wrote:
> > > > > > > >  The PWM in the JZ4725B works the same as in the JZ4740,
> > > > > > > >  except that it only has 6 channels available instead of
> > > > > > > >  8.
> > > > > > >
> > > > > > > this driver is probed only from device tree? If yes, it
> > > > > > > might be sensible to specify the number of PWMs there and
> > > > > > > get it from there.
> > > > > > > There doesn't seem to be a generic binding for that, but ther=
e are
> > > > > > > several drivers that could benefit from it. (This is a bigger=
 project
> > > > > > > though and shouldn't stop your patch. Still more as it alread=
y got
> > > > > > > Thierry's ack.)
> > > > > >
> > > > > > I think there needs to be a proper guideline, as there doesn't =
seem to be
> > > > > > a consensus about this. I learned from emails with Rob and  Lin=
us (Walleij)
> > > > > > that I should not have in devicetree what I can deduce from the=
 compatible
> > > > > > string.
> > > > >
> > > > > I understood them a bit differently. It is ok to deduce things fr=
om the
> > > > > compatible string. But if you define a generic property (say) "nu=
m-pwms"
> > > > > that is used uniformly in most bindings this is ok, too. (And the=
n the
> > > > > two different devices could use the same compatible.)
> > > > >
> > > > > An upside of the generic "num-pwms" property is that the pwm core=
 could
> > > > > sanity check pwm phandles before passing them to the hardware dri=
vers.
> > > >=20
> > > >  I don't know if this helps, but in GPIO we have "ngpios" which is
> > > >  used to augment an existing block as to the number of lines actual=
ly
> > > >  used with it.
> > > >=20
> > > >  The typical case is that an ASIC engineer synthesize a block for
> > > >  32 GPIOs but only 12 of them are routed to external pads. So
> > > >  we augment the behaviour of that driver to only use 12 of the
> > > >  32 lines.
> > > >=20
> > > >  I guess using the remaining 20 lines "works" in a sense but they
> > > >  have no practical use and will just bias electrons in the silicon
> > > >  for no use.
> > >=20
> > > This looks very similar to the case under discussion.
> > >=20
> > > >  So if the PWM case is something similar, then by all means add
> > > >  num-pwms.
> > >=20
> > > .. or "npwms" to use the same nomenclature as the gpio binding?
> >=20
> > If we're going to do something like this, should it be the drivers or
> > the core (within pwmchip_add) that checks for this "npwms" property?
>=20
> Of course this should be done in the core. The driver than can rely on
> the validity of the index. But as I wrote before, this shouldn't stop
> your patch from going in.
>=20
> But if Thierry agrees that this npmws (or num-pwms) is a good idea, it
> would be great to start early to convert drivers.

Do we actually need this? It seems like Paul's patch here properly
derives the number of available PWMs from the compatible string, so I
don't see what the extra num-pwms (or whatever) property would add.

Thierry

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwb07cACgkQ3SOs138+
s6HqPQ/9EvqzyNbYIZcLq9uI1GFXYCcBJH2WDzabK4dC9qZDaof2UMjSPj5rBEaL
EOZv/Yn+EaN5IoIo65MIVyPzB5dSyFuh2MZkBlXpH0c2JhIY/d/hd+7ZmxdjEVib
CcBiBHi+QP+CJhQ5gKDFtqwXiU1hlff560NFpfDfFVNWtyeXN+2I1caEftRybYsq
R+V/boJKSK+HygyNlKxY8bpZq2p/9eC2hndeJNI1rXdzXuv/if4+ZC9ZqKlDOLbz
3zOHzMjHAl33uUVpQhJR11x+KmAnkTPBZ0Mn3Jv1AtAL/3FCOkNDwBx2CXjUnUxC
HzRLcURjKRctjATnpd2tJwtuJZUyFxY0dcysRK0/+C/DD0Rj78aECIXald7npdDl
MVk5SNplY1WpWkzdM8rwYWYuskHpU5IWB2haq6FLju6vq6ABEQYlg95OskrjZOih
QPW2aN7CPgKfCilVhS1Ur3r4t6FxX/w33rEuJNeVaNsn2jFuQrVLeff1iHoXeRNg
832gbMNIdJnSEV18tXizFVwvC3s1GWKiBLk7spSLTuxGaYQr82Na9DyBTdsqj/0a
V2AttQ1GeTlDN/GjmqQrpfDYG6LJK7SRsXSmqsXR6J7187gSfRoLMzivYMaxJGsj
qgbreq98AzZ1z5GiHQKL0NFRHaoHlTSMprrjhLsnIy+sBV+8t/g=
=pWXg
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
