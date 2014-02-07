Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47191 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752814AbaBGNUE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Feb 2014 08:20:04 -0500
Date: Fri, 7 Feb 2014 14:19:48 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] wdt: sunxi: Introduce a new compatible for the A10
 and A31
Message-ID: <20140207131948.GI3192@lukather>
References: <1391349325-11132-1-git-send-email-maxime.ripard@free-electrons.com>
 <52F36E8D.4050503@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1E1Oui4vdubnXi3o"
Content-Disposition: inline
In-Reply-To: <52F36E8D.4050503@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--1E1Oui4vdubnXi3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Thu, Feb 06, 2014 at 12:14:21PM +0100, Hans de Goede wrote:
> On 02/02/2014 02:55 PM, Maxime Ripard wrote:
> >For historical reasons, the Allwinner A10 compatibles are not following =
the
> >patterns used for this other Allwinner SoCs.
> >
> >Introduce a new compatible following the usual pattern, and deprecate th=
e olders.
> >
> >Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >---
> >  Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 7 ++++---
> >  drivers/watchdog/sunxi_wdt.c                             | 1 +
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> >diff --git a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt b/=
Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> >index e39cb26..6e8c937 100644
> >--- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> >+++ b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> >@@ -2,13 +2,14 @@ Allwinner SoCs Watchdog timer
> >
> >  Required properties:
> >
> >-- compatible : should be "allwinner,<soc-family>-wdt", the currently su=
pported
> >-  SoC families being sun4i and sun6i
> >+- compatible : should be either "allwinner,sun4i-a10-wdt" or
> >+               "allwinner,sun6i-a31-wdt" (deprecated:
> >+               "allwinner,sun4i-wdt", "allwinner,sun6i-wdt")
> >  - reg : Specifies base physical address and size of the registers.
> >
> >  Example:
> >
> >  wdt: watchdog@01c20c90 {
> >-	compatible =3D "allwinner,sun4i-wdt";
> >+	compatible =3D "allwinner,sun4i-a10-wdt";
> >  	reg =3D <0x01c20c90 0x10>;
> >  };
>=20
> You talk about deprecating the old compat strings in the commit message, =
but
> here you outright replace them, which will break things with old dtb file=
s ?

I'm replacing them only in the Documentation here.

I only add it to the driver after that, which means that the driver
will be probed with both the new and the old compatibles.

However, the DT maintainers said it was ok to remove them entirely, so
I'll send a v2.

Maxime

>=20
> Other 2 patches in the series look good and are:
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>=20
>=20
> >diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> >index 76332d8..7c8923d 100644
> >--- a/drivers/watchdog/sunxi_wdt.c
> >+++ b/drivers/watchdog/sunxi_wdt.c
> >@@ -206,6 +206,7 @@ static void sunxi_wdt_shutdown(struct platform_devic=
e *pdev)
> >
> >  static const struct of_device_id sunxi_wdt_dt_ids[] =3D {
> >  	{ .compatible =3D "allwinner,sun4i-wdt" },
> >+	{ .compatible =3D "allwinner,sun4i-a10-wdt" },
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, sunxi_wdt_dt_ids);
> >
>=20
> Regards,
>=20
> Hans

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--1E1Oui4vdubnXi3o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS9N10AAoJEBx+YmzsjxAg37wP/1CpySBvZpfmDbYIRk7+31UI
RPg18nqL9Dn4tbtM/++j3WC+mNdAY8pKIMs3t1HeIgJ+m6lqtV441aE8A8wQFKCd
Yy7WI9x5RRGzUmTetwYds8K+eayJTnLjTUKX3RaKp+fOHWU+0bKltjpFOrTUCX2L
T9INNS7QqbNx4W1zvdxXBedjMytQEY9hNmn5fJ322cK4c8+u9mC8BFi3fA/FWchI
VO86yWewliiJnGcFvhBG1YwkQFDf0sjQoumq213uVrHzVGVGxANQgoFVlBAaaTYa
YhGnRF0tIGe0HAKSQGahvh3N+YK47a/sHR+91WezwfS3WWUFANtf3pZhrpHttTbK
9DoZWbj0A9tHzXk4oRbpYaKSSnN31F3w62qe6AxlsDmb8yzN6SKE5pp5qqetvo+A
TL9vqwoPjU9UbZshZy2my0ihrN1/M0q2KVXkZ2fFo/ruWOgy/R0b6jPGsIEoGEXj
mGcoYl2Luu24KTcUwx24VIb8eSRibJ07l2ztiJyyhcsXe7RkeurNQ4j8kEjCw9Pl
+TLf2c1HJliUPqQUx6/JksXIP7IfaAWoZvBoefRCiviBixhG8B+AcYP41PQusaOm
dcUBlJrmyWCd7ePQVdYyb5PhN5cybJOtJ/0E1c0L1Vd2ql8md5XHHDJVEM3pG7wE
Ezw9w6ITs6b4RkMn/k4o
=XAsH
-----END PGP SIGNATURE-----

--1E1Oui4vdubnXi3o--
