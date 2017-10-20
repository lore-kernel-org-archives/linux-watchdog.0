Return-Path: <mgr@pengutronix.de>
Return-path: <mgr@pengutronix.de>
Date: Fri, 20 Oct 2017 09:43:51 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"lee.jones@linaro.org" <lee.jones@linaro.org>,
	Support Opensource <Support.Opensource@diasemi.com>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Stefan Christ <s.christ@phytec.de>
Subject: Re: [PATCH 3/6] watchdog: da9062: reset board on watchdog timeout
Message-ID: <20171020074351.65vum7hitlvi6ftf@pengutronix.de>
References: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
 <20171017153027.24665-4-m.grzeschik@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB70194131FC4@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v4lkbwztemczge4r"
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB70194131FC4@SW-EX-MBX02.diasemi.com>
List-ID: <linux-watchdog@vger.kernel.org>


--v4lkbwztemczge4r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 02:28:10PM +0000, Steve Twiss wrote:
> Hi Michael,
>=20
> On 17 October 2017 16:30 Michael Grzeschik wrote:
>=20
> > To: linux-watchdog@vger.kernel.org
> > Subject: [PATCH 3/6] watchdog: da9062: reset board on watchdog timeout
> >=20
> > From: Stefan Christ <s.christ@phytec.de>
> >=20
> > In the default fuse configuration the watchdog poweroffs the system
> > instead of resetting it on a watchdog timeout. This patch changes the
> > behavior. Now the board is reseted and reboots.
>=20
> We call the chip's fuze configuration the "OTP" (one-time programming).
>=20
> >=20
> > Note: This patch requires that the config register CONFIG_I is
> > configured as writable in the da9062 multi function device.
> >=20
> > Signed-off-by: Stefan Christ <s.christ@phytec.de>
> > Signed-off-by: Christian Hemp <c.hemp@phytec.de>
> > ---
> >  drivers/watchdog/da9062_wdt.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >=20
> > diff --git a/drivers/watchdog/da9062_wdt.c
> > b/drivers/watchdog/da9062_wdt.c
> > index 4349a02215489..b95719b349e5c 100644
> > --- a/drivers/watchdog/da9062_wdt.c
> > +++ b/drivers/watchdog/da9062_wdt.c
> > @@ -112,6 +112,20 @@ static int da9062_wdt_start(struct watchdog_device
> > *wdd)
> >  	unsigned int selector;
> >  	int ret;
> >=20
> > +	/*
> > +	 * Use da9062's SHUTDOWN mode instead of POWERDOWN for watchdog reset.
> > +	 * On timeout the PMIC should reset the system, not powering it
> > +	 * off.
> > +	 */
> > +	ret =3D regmap_update_bits(wdt->hw->regmap,
> > +				 DA9062AA_CONFIG_I,
> > +				 DA9062AA_WATCHDOG_SD_MASK,
> > +				 DA9062AA_WATCHDOG_SD_MASK);
> > +	if (ret)
> > +		dev_err(wdt->hw->dev,
> > +			"failed to set wdt reset mode. Expect poweroff on watchdog reset: %=
d\n",
> > +			ret);
> > +
>=20
> I am not quite understanding what you are trying to achieve.
> It seems there could be be few different options here.
>=20
> If the watchdog is running from power on and if the platform hangs early =
in the start-up
> sequence, then waiting to set WATCHDOG_SD in the DA9062 watchdog driver c=
ould be
> too late to modify the chip's behaviour. If the watchdog tripped early, t=
he system might
> already be in POWERDOWN instead of SHUTDOWN before this point.

Agreed.

> If a software change to CONFIG_I is to be done, then this register could =
be modified very
> early in the bootloader. If necessary, the Linux kernel driver can read t=
he CONFIG_I register
> and decide if it needs to modify its behaviour accordingly. In this case,=
 write changes to
> CONFIG_I would not be needed.

I will add that condition around it.

> The trivial option (for software at least) could be a different OTP: to e=
nforce
> WATCHDOG_SD in the hardware.

That is one god point. I will have a look into that.

> DA9062 Datasheet revision 3.4, 27-Jun-2017, page 59, Section 10.
> A hyperlink to the latest datasheet can be found in the DA9062 binding fi=
le:
> Documentation/devicetree/bindings/mfd/da9062.txt

On Page 59 of this document are only ordering informations.

> It doesn't seem correct to make this a permanent change in the general Li=
nux kernel driver.
> At the very least, something like this sould be protected by a device tre=
e boolean.=20

Agreed. I will think adopt your ideas.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--v4lkbwztemczge4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAlnpqS8ACgkQC+njFXoe
LGR6YxAAwgOZbeBFgSntqHzA9DUf6GYBrd11AIrb9E87nM+IewWX7addLSzzvcu6
Sykf3EfT+wfRNdCFDblQnC7acBVT6Dke9LM3RqSRNgiL26BRQEweBPIpej0mEEJ2
BMRs0CEvXbijxuQyUz1N6KTF542ZvB009NxQNEacSChLgKUfsYGgubeF+t35mhkQ
jSEWuLqmnE6U4EvIKvFypKqbWayQoWw25bxRgdde9fC+RcI9vOEWjft6TR5rKHXl
Uw3iY9UTmcR1bHQ0ZWINfNk6KEN1SL/eFNrW/qnsADtlFzqMMoNoT/e3EP5q1kRO
Gy2bdkvrCzNmhZcc3LSz1Y5iiu8kRW6rqRFfMRv+fdw3piOqC5pNu/G4dxbu4D7n
57/DysVAs7PwTtZcaHZ6DhJ4usf7KFGfqkyoPCWmtP3KnJ3/9H5AUmPjK2KTwTvL
HpEiHUtu16YfTOv4n9CVX7lrYATRHZ2POiTpXIuTH/4udoLX+rrhB9XiFqw4ZXMl
3SyrtUZf4vOT4yQAmrCTTGMxO3owFgSSvEheQXGdZha7+d1raxLgju+O2XSILpg0
9I3njYNRJJu0eW5XNgwOOiBnNhrrNGl4esuzP+Yenin1t+/a4mJF1Ku1TUww2cn1
888XPv15Iejnvu/pq9W/Zp7/15o17bGOE81wclR6FdHWNvD9iFE=
=FpGt
-----END PGP SIGNATURE-----

--v4lkbwztemczge4r--
