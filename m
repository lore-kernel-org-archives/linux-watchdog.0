Return-Path: <andrew@aj.id.au>
Return-path: <andrew@aj.id.au>
Message-ID: <1505788256.4080.24.camel@aj.id.au>
Subject: Re: [PATCH 1/4] watchdog: aspeed: Retain watchdog enabled state
From: Andrew Jeffery <andrew@aj.id.au>
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, joel@jms.id.au, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
	ryan_chen@aspeedtech.com
Date: Tue, 19 Sep 2017 12:00:56 +0930
In-Reply-To: <bef08c5f-b0ae-a2e4-34a1-c9e1500b4234@roeck-us.net>
References: <20170918054905.16470-1-andrew@aj.id.au>
	 <20170918054905.16470-2-andrew@aj.id.au>
	 <bef08c5f-b0ae-a2e4-34a1-c9e1500b4234@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-7O0ssMshb1jqry7wQGKh"
Mime-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>


--=-7O0ssMshb1jqry7wQGKh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-09-18 at 06:25 -0700, Guenter Roeck wrote:
> On 09/17/2017 10:49 PM, Andrew Jeffery wrote:
> > An unintended post-condition of probe() is that the watchdog is
> > disabled. Rework probe() such that we retain the value of the "enabled"
> > bit from the control register, and take the appropriate actions with
> > respect to the watchdog core if so. Otherwise, just configure the
> > watchdog as directed.
> >=20
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > =C2=A0 drivers/watchdog/aspeed_wdt.c | 9 +++++----
> > =C2=A0 1 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wd=
t.c
> > index 79cc766cd30f..99bc6fbd8852 100644
> > --- a/drivers/watchdog/aspeed_wdt.c
> > +++ b/drivers/watchdog/aspeed_wdt.c
> > @@ -221,7 +221,8 @@ static int aspeed_wdt_probe(struct platform_device =
*pdev)
> > > > =C2=A0=C2=A0		return -EINVAL;
> > > > =C2=A0=C2=A0	config =3D ofdid->data;
> > =C2=A0=C2=A0
> > > > -	wdt->ctrl =3D WDT_CTRL_1MHZ_CLK;
> > > > +	wdt->ctrl |=3D readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE;
> > > > +	wdt->ctrl |=3D WDT_CTRL_1MHZ_CLK;
> > =C2=A0=C2=A0
> > > > =C2=A0=C2=A0	/*
> > > > =C2=A0=C2=A0	=C2=A0* Control reset on a per-device basis to ensure =
the
> > @@ -243,11 +244,11 @@ static int aspeed_wdt_probe(struct platform_devic=
e *pdev)
> > > > =C2=A0=C2=A0	if (of_property_read_bool(np, "aspeed,external-signal"=
))
> > > > =C2=A0=C2=A0		wdt->ctrl |=3D WDT_CTRL_WDT_EXT;
> > =C2=A0=C2=A0
> > > > -	writel(wdt->ctrl, wdt->base + WDT_CTRL);
> > -
> > > > -	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)=C2=A0=C2=A0{
> > > > +	if (wdt->ctrl & WDT_CTRL_ENABLE) {
> > =C2=A0=C2=A0		aspeed_wdt_start(&wdt->wdd);
>=20
> Why call the start function in this case ?

... Good question. It was already there so I didn't touch it. I expect
it can be dropped - I'll look into it.

>=20
> > > > > > =C2=A0=C2=A0		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status); > +	}=
 else {
> > > > +		writel(wdt->ctrl, wdt->base + WDT_CTRL);
> > > > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0
> > > > =C2=A0=C2=A0	if (of_device_is_compatible(np, "aspeed,ast2500-wdt"))=
 {
> >=20
>=20
>=20
--=-7O0ssMshb1jqry7wQGKh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZwIFgAAoJEJ0dnzgO5LT5YO0P/2w012SKGaAuLhqb3hI3Vxm4
K2UYvo4pGUZ50RpJAh+rRXmM6WcF4zYYeD3KvtHTeug6BXcAjnJLQE99NEDMnTlx
OdWGbM7mcLPDrb00UUkwJ7FK5pgNAIB04kmSkg5Ey1PXaUS8Yy9167BbVKbsA3iW
4po/s4cFMJU9PnEofXmGvpSeyckt95gYMc2r7t7SOKQk0WujNNAtacjS283EG+Gk
X/eIE2EfARVQTbBsIsjrD0Ah9FvajkEnu1Foc/v6Fb5a/oYBin798SFfXAjRxP/B
B5mGPmmTZuRnOET7OsoeVKw67a6bVwCzG+l1tvmQ/nADH866JMjihRLNucAsOtiu
v9IDNvaNHL+PqTdzOi+XHqliRBGDZP+R3afPniN4SH57NrH3rP4K7SyPeM3tc8K2
ofbj60kqOyUcXqSyzMM6t8F+hgzvRuZacBl+EujFYVf1gq+MAbca0eTilthAAxoE
VL44baTg4ePV/3KFiYGoFHditPC6jJffdehpcacLHr6RE38STDcYd8/2E+fqnSXo
DRt1ypKo3XAVmrukvUVH5uthSK76yIP1gtSGQT+uLFqyYTNv3qWIGOGTx5Q0qKDE
WT1q2mdVbiljqY+N4gJ/Z7Sgp7d+ZGKXPRef/F5G43Ox7nIq2Mnp9PiWCP1twZQv
e/MicuUiFu6d8Yw+AzbZ
=uKuz
-----END PGP SIGNATURE-----

--=-7O0ssMshb1jqry7wQGKh--
