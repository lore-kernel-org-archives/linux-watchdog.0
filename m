Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:51255 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033214AbeCATze (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Mar 2018 14:55:34 -0500
Date: Thu, 1 Mar 2018 20:55:31 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@iguana.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 1/3] watchdog: renesas_wdt: Add suspend/resume support
Message-ID: <20180301195531.cptgcedgviompwkz@ninjato>
References: <1519928243-28596-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1519928243-28596-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180301194101.GB29927@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qy5e6erdwngfvsrr"
Content-Disposition: inline
In-Reply-To: <20180301194101.GB29927@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--qy5e6erdwngfvsrr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 11:41:01AM -0800, Guenter Roeck wrote:
> On Thu, Mar 01, 2018 at 06:17:21PM +0000, Fabrizio Castro wrote:
> > On R-Car Gen2 and RZ/G1 the watchdog IP clock needs to be always ON,
> > on R-Car Gen3 we power the IP down during suspend.
> >=20
> > This commit adds suspend/resume support, so that the watchdog counting
> > "pauses" during suspend on all of the SoCs compatible with this driver
> > and on those we are now adding support for (R-Car Gen2 and RZ/G1).
> >=20
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.rene=
sas.com>
>=20
> Usually, on resume, we just restart the watchdog, with the expectation in=
 mind
> that there may be some delay in userspace before it gets to send the next=
 ping.
> Presumably that is not a concern here, so

I didn't know that. Actually, I'd prefer that. Even less complexity. And
if it is even more consistent with the rest of the drivers...

> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>=20
> > ---
> > v6->v7:
> > * backup and restore register RWTCNT instead of using rwdt_get_timeleft=
 and
> >   rwdt_set_timeleft
> >=20
> >  drivers/watchdog/renesas_wdt.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >=20
> > diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_=
wdt.c
> > index 831ef83..024d54e 100644
> > --- a/drivers/watchdog/renesas_wdt.c
> > +++ b/drivers/watchdog/renesas_wdt.c
> > @@ -49,6 +49,7 @@ struct rwdt_priv {
> >  	void __iomem *base;
> >  	struct watchdog_device wdev;
> >  	unsigned long clk_rate;
> > +	u16 time_left;
> >  	u8 cks;
> >  };
> > =20
> > @@ -203,6 +204,30 @@ static int rwdt_remove(struct platform_device *pde=
v)
> >  	return 0;
> >  }
> > =20
> > +static int __maybe_unused rwdt_suspend(struct device *dev)
> > +{
> > +	struct rwdt_priv *priv =3D dev_get_drvdata(dev);
> > +
> > +	if (watchdog_active(&priv->wdev)) {
> > +		priv->time_left =3D readw(priv->base + RWTCNT);
> > +		rwdt_stop(&priv->wdev);
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused rwdt_resume(struct device *dev)
> > +{
> > +	struct rwdt_priv *priv =3D dev_get_drvdata(dev);
> > +
> > +	if (watchdog_active(&priv->wdev)) {
> > +		rwdt_start(&priv->wdev);
> > +		rwdt_write(priv, priv->time_left, RWTCNT);
> > +	}
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(rwdt_pm_ops, rwdt_suspend, rwdt_resume);
> > +
> >  /*
> >   * This driver does also fit for R-Car Gen2 (r8a779[0-4]) WDT. However=
, for SMP
> >   * to work there, one also needs a RESET (RST) driver which does not e=
xist yet
> > @@ -218,6 +243,7 @@ static struct platform_driver rwdt_driver =3D {
> >  	.driver =3D {
> >  		.name =3D "renesas_wdt",
> >  		.of_match_table =3D rwdt_ids,
> > +		.pm =3D &rwdt_pm_ops,
> >  	},
> >  	.probe =3D rwdt_probe,
> >  	.remove =3D rwdt_remove,
> > --=20
> > 2.7.4
> >=20

--qy5e6erdwngfvsrr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqYWqsACgkQFA3kzBSg
KbY1wA/+O6VmzBO2fc173bjYDMtPGuKA2ZcNBDdhoSNj23HfmDmdJAlxm7XeC3xl
2wlIj0P7HcSm9Ine15vZlJ13Uuo6aGpo6klLbb9r2lwR6yPrDoGSeUB9hdHCaCaZ
0koyxr8zEIlDjL2H02nqzT0mgdpvrrz6voYiKuZi0Zzwimuhueep3DVrguaGeFZR
XSrlepSpopg+sz+xs3X9ngB+jjtaTxx88WjD1ypYYIO48zPKvyoJZta5MmJTv07V
zLXrmFP1DwpKAo32qq0zx5fGDKVErvKC88hPLDRfvNQs06VUCnY+8gvaCwVwH11N
JzjC3FqXAt2PnrUO7w4BN9ILcfd5oqPcfYHe4kLMsr8U0vAo6B3/Yb8D26gf6Kuv
o/UebGw2Ev5RgvX8xPuTLRCh58nxHSbf4A+TuYjTjR0uYs2kOX0qprABNCg3r1fR
hpOn6S0pr9aibTQpGmg3cNi4crECjizLhckCRZeHjrtCkMucFU9MDmkrIn72zHGx
lmf9zX0nemO7vCKVJ/rMdUg10GeyPT8/f3rieuwK4rYzlyqKaxXKKrRuA/7rTbNr
cxsGJ3z6Ihe9ib89r1nmq/P3kyGyxYR7KUlygqKFKYUia7tpL3x12z/AouFAsm0i
kRNahvWaF56nlv8Q7+tXb3jun6EL4vqK3lPJh7rVVccDbpC22Mg=
=p8P1
-----END PGP SIGNATURE-----

--qy5e6erdwngfvsrr--
