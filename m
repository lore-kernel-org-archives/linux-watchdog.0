Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36244 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbaH0IMa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 27 Aug 2014 04:12:30 -0400
Date: Wed, 27 Aug 2014 10:12:17 +0200
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
Subject: Re: [PATCH v5] watchdog: Add DA9063 PMIC watchdog driver.
Message-ID: <20140827081217.GD21770@pengutronix.de>
References: <1409034367-15228-1-git-send-email-mpa@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7D0B39787@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7D0B39787@SW-EX-MBX02.diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Tue, Aug 26, 2014 at 03:21:53PM +0000, Opensource [Steve Twiss] wrote:
>=20
> On 26 August 2014 07:26, Markus Pargmann wrote
>=20
> > Subject: [PATCH v5] watchdog: Add DA9063 PMIC watchdog driver.
> >=20
>=20
> [...]
>=20
> > +
> > +static int da9063_wdt_stop(struct watchdog_device *wdd)
> > +{
> > +	struct da9063_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> > +	int ret;
> > +
> > +	mutex_lock(&wdt->lock);
> > +	ret =3D regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> > +			DA9063_TWDSCALE_MASK,
> > +			DA9063_TWDSCALE_DISABLE);
> > +	if (ret)
> > +		dev_alert(wdt->da9063->dev, "Watchdog failed to stop (err =3D %d)\n",
> > +				ret);
> > +	mutex_unlock(&wdt->lock);
> > +
> > +	return ret;
> > +}
> > +
>=20
> Hi Markus,
>=20
> A quick typo.
> ret =3D regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> should probably be wdt->da9063->regmap

yes, thank you. It seems I forgot to execute my checkpatch script before
sending. Sorry, will send a new version.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT/ZLgAAoJEEpcgKtcEGQQmzAP/RauZ3XnHTjo0RIBQvNJ9ixO
BoS6X1iOmHannOK1YkzxQZ1BiQKKIFrUkG+1JGdubBMQZuwEd6POtuKEfVMeaSEA
Sv+biH03Hxeqww0P9AHZULeeWfuTXABNagfd9bOqCUpNVY9Kw8hPsEY7HZDiTJbi
zRWIvHpO7opYT2tXRa64VFqoMbPJoeUB4LRJdK7Y/y8u++aq6Lt6QPERxcChQFrU
aWu8ZRwQFTchO0cG8b48gAPqioBDo6TpbIRqMIxFJUiB9Tt2qLCzZ+kvqS7fioD8
bkwvLiReTyJAszWHGv4aNjeQitRrOKFFPksSHkex2oWKvtiU1iGkqdPjYXHjbX6k
6DmR9N/kOI6N4gMBhv1Tb/btVLI4xrT9EeyUzMvFQ4woZwJBXNmgVETLYYYRtMQc
wAwvTNmrZvVkAT01P7xBJRdwgWgzTFM5tz9wtpehZEJGa/56Zr7BbF55sccQA/IV
3TBTjzeVNLKz8vjRlIOHZjk8krz8ohOQGKcfgOhujLhCe6p4vhddG7rG514Kld8O
gm2VouBoiiqOUOKZ6VR85M9S7qK7+8H4M152Wudr0MvNn3YNCrfk0exv2K5/7dvB
ipJiuoUkfppBPg4MdEXZnanE3txZckhA2z8TodPazuFEOXqO3lEeHPimhhsa1St5
fHX6Yf+9QrhXAuzgI6fh
=JrJe
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
