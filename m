Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46043 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbaHOIvK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Aug 2014 04:51:10 -0400
Date: Fri, 15 Aug 2014 10:51:05 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Support Opensource <support.opensource@diasemi.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v3] watchdog: Add DA906x PMIC watchdog driver.
Message-ID: <20140815085105.GH17027@pengutronix.de>
References: <1407926776-16700-1-git-send-email-mpa@pengutronix.de>
 <53EC487E.2000602@roeck-us.net>
 <20140814095733.GG17027@pengutronix.de>
 <53ECD85A.8050903@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5lq+205vWdkqwtk"
Content-Disposition: inline
In-Reply-To: <53ECD85A.8050903@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--r5lq+205vWdkqwtk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2014 at 08:40:10AM -0700, Guenter Roeck wrote:
> On 08/14/2014 02:57 AM, Markus Pargmann wrote:
>=20
> >>>+
> >>>+static int da9063_wdt_probe(struct platform_device *pdev)
> >>>+{
> >>>+	int ret;
> >>>+	struct da9063 *da9063 =3D dev_get_drvdata(pdev->dev.parent);
> >>>+	struct da9063_watchdog *wdt;
> >>>+
> >>>+	if (!da9063)
> >>>+		return -EPROBE_DEFER;
> >>
> >>Can this ever happen ? Isn't this driver instantiated from its parent,
> >>which would ensure that the parent's driver data is set ?
> >
> >No this can't happen. I replaced it with BUG_ON and also introduced a
> >BUG_ON check for dev.parent.
> >
> That is a bit too much. You should only use BUG_ON if the kernel can not
> continue to run, which should not be the case here. I would suggest
> to return -ENODEV.

Okay, thanks.

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--r5lq+205vWdkqwtk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT7cn4AAoJEEpcgKtcEGQQKjgP/jqSMk+IkLKQsSQ8vp4NHNVB
hYJwPOqRjzxu6gBZ5GNu1iBr2CiitEetN3QMVbyGroU6Fy17CJxrISThGzXIUc2A
1uMzARVRUEJPIw+krGSO6fHsTWg0KFVKUTCZ3XGiJB7nt/7Bnuw81d3YUt9H38ze
kQhTUhC6OICFKL1T6kRV2ziNpC3tJwpS1P8VUDWT4hXGCS7qTyatsar4Nz6KJGGE
QpNRnu1k/y0vKPLEIDYZSiNngy13hZRf9Z10MTNLJL2YvBYd6gyC/HyFwOCVCJkw
oa9PI4ztuz1ysNoXcbID9554ZUaf3RwvTYiAvn7O4GZ/+qlCDLgApluorKYYjFHJ
dyWUf1/xq2+JsXcXb/u4ZKRhO47sY2hM6jWTEFBvaxoY0nkcrVsrNyzn8YiF7t2h
OCSWunRlWlKNxWne7ZVg0n3ZPes7hJmKzH5YzNH7e2uNad3j6+NlZF/TBKGxRt4w
NkwipLKPThqDjBTXlsjmTsUz0blbjtsEpgLW0fOhGWoVZ28XJ8fQgz9b9KrdjLDL
Opw1tMCbQ0fBAHcSIBawTZ3x1fnKPkYniSSisSQsFGjzRy6SMtqzzmHXc0gkWdfZ
1N1nveDf8r+mc/Gt6LbRBZ4b3ProysAPjTJTMJ5WP4BX8sJZl5CpJVuBs8D+ouYo
BVaPXjvyzL3CG9CxL/e3
=ygvc
-----END PGP SIGNATURE-----

--r5lq+205vWdkqwtk--
