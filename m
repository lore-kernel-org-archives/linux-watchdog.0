Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33263 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbaHXPAS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 24 Aug 2014 11:00:18 -0400
Date: Sun, 24 Aug 2014 17:00:07 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Support Opensource <Support.Opensource@diasemi.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Guenter Roeck <linux@roeck-us.net>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4] watchdog: Add DA906x PMIC watchdog driver.
Message-ID: <20140824150007.GD23823@pengutronix.de>
References: <1408192545-23987-1-git-send-email-mpa@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7D0B39421@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7D0B39421@SW-EX-MBX02.diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Fri, Aug 22, 2014 at 03:47:48PM +0000, Opensource [Steve Twiss] wrote:
> On 16 August 2014 13:36, Markus Pargmann [mailto:mpa@pengutronix.de] wrot=
e:
>=20
> > Subject: [PATCH v4] watchdog: Add DA906x PMIC watchdog driver.
>=20
> Hi Markus,
>=20
> >=20
> > From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> >=20
> > This driver supports the watchdog device inside the DA906x PMIC.
> >=20
>=20
> There is only DA9063 , in this case there is no "x". Thanks.

Thanks, fixed in the commit message.

>=20
> [...]
>=20
> > +
> > +/*
> > + * Watchdog selector to timeout in seconds.
> > + *   0: WDT disabled;
> > + *   others: timeout =3D 2048 ms * 2^(TWDSCALE-1).
> > + */
> > +static const int wdt_timeout[] =3D { 0, 2, 4, 8, 16, 32, 65, 131 };
>=20
> This table is just an approximation of the real times provided by the PMI=
C.=20
>=20
> The first three bits in the CONTROL_D register at 0x11 define a scaling v=
alue
> for the nominal maximum time TWDMAX. The 7 values specifying the timeout
> of the watchdog are:
>=20
> 001 =3D 1 =3D 1x =3D 2048ms=20
> 010 =3D 2 =3D 2x =3D 4096ms
> 011 =3D 3 =3D 4x =3D 8192ms
> 100 =3D 4 =3D 8x =3D 16384ms
> 101 =3D 5 =3D 16x =3D 32768ms
> 110 =3D 6 =3D 32x =3D 65536ms
> 111 =3D 7 =3D 64x =3D 131072ms

Thanks. So the 7 values are good approximations for the real values
right?

>=20
>  [...]
>=20
> > +
> > +static int da9063_wdt_disable(struct da9063 *da9063)
> > +{
> > +	return regmap_update_bits(da9063->regmap,
> > DA9063_REG_CONTROL_D,
> > +			DA9063_TWDSCALE_MASK,
> > +			DA9063_TWDSCALE_DISABLE);
> > +}
> > +
> > +static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int
> > regval)
> > +{
> > +	return regmap_update_bits(da9063->regmap,
> > DA9063_REG_CONTROL_D,
> > +			DA9063_TWDSCALE_MASK, regval);
> > +}
> > +
> > +static int _da9063_wdt_kick(struct da9063 *da9063)
> > +{
> > +	return regmap_write(da9063->regmap, DA9063_REG_CONTROL_F,
> > +			DA9063_WATCHDOG);
> > +}
> > +
>=20
> The _da9063_wdt_kick() and da9063_wdt_disable() functions are only used o=
nce
> throughout the code -- in the watchdog_ops functions da9063_wdt_ping() and
> da9063_wdt_stop() respectively.=20
> Since these are just simple regmap calls, could they be added at those pl=
aces
> directly and therefore remove the function calls?

Thanks, I removed those functions and included the regmap function calls
directly as they are already well described by the functions from which
they are called.

>=20
> [...]
>=20
> > +static int da9063_wdt_start(struct watchdog_device *wdd)
> > +{
> > +	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> > +	unsigned int selector;
> > +	int ret;
> > +
> > +	selector =3D da9063_wdt_timeout_to_sel(wdt->wdtdev.timeout);
> > +	if (selector < 0) {
>=20
> Unsigned if < 0

That was already fixed for the next version.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT+f33AAoJEEpcgKtcEGQQgrQQAI4jnLL967atUOH6dXIOPqv2
f5OQKGAl1RBx9SLvJ5Lc0CraTLlNVsCLTPdGmPolgETvcdCd7+jhVJVpGb0sdRzI
36UJXnJCs1wW0BhTyeymjvo5+DqpFGvKVnW8ERslzidvyykMUXh0wssW+IlfuMGa
9373OOnXRTpDB572yRAc+GPMxvRp7CIqD2V/zTe2lm6wuUpCrZszwTxT4FMALRhX
KNUOTLm/AMYQzOCPKk9bAr8wBvuxou5dE9H4mPAVDFm/qpBPTkF+f6OmDMKXgmhM
CCxStQR3l7uGB8er0l+JWhY98G0MEyczDcAv+0Z+gq2cMtLzNUgXPrpqkuubkWwy
72SMwsqMqKRUZCVtkaDwyti/yNMH9lJiFk77UhvBgEYyhFske/gWrqINxGy/tenK
AD1DOONsEd+/Q6KUcZOH5/eFPxzDDodgGhizRHM20p+YmQvEkpixxVR8D2oydgGh
vICEYot4FdtIoaDLpYzCBjL2ploFhQSaWNaQlQyTsfM+c4mmD6XAUM7iMkYi4IeE
aqXVDXHv7PuiMLQXLzyZisyIG2H4W6Z2xsxjZ43ZCaRyz+750jwKjtTpkxPpHcjE
B5KLEoonIoOOHWWvlmDrd3BOZMPn+k6UdQMo2BWGN9S8D2wAiGn9imXOBu2zCBA8
HCP5Ebw+5b3zF3hK02mW
=00Rp
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
