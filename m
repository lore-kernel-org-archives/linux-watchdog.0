Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:41771 "EHLO
	imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751107AbbCTUxS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Mar 2015 16:53:18 -0400
Date: Fri, 20 Mar 2015 20:53:15 +0000
From: James Hogan <james.hogan@imgtec.com>
To: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>
CC: James Hogan <james@albanarts.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	Jude Abraham <Jude.Abraham@imgtec.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/2] watchdog: imgpdc: Runtime fixes
Message-ID: <20150320205315.GB22574@jhogan-linux.le.imgtec.org>
References: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 20, 2015 at 11:45:43PM +0000, James Hogan wrote:
> A couple of basic runtime fixes for the IMG PDC watchdog driver. These
> were found by attempting to enable the driver for TZ1090 and running
> under Meta QEMU. Note that QEMU doesn't emulate the actual watchdog
> functionality beyond the soft reset register, so I cannot claim to have
> tested the driver's watchdog timer functionality yet.
>=20
> James Hogan (2):
>   watchdog: imgpdc: Fix probe NULL pointer dereference
>   watchdog: imgpdc: Fix default heartbeat

Thanks Guenter for the reviews.

Any chance of these fixes getting merged in time for v4.0?

FWIW I've now tried the driver on real TZ1090 hardware (with these
patches) and it appears to work as expected.

Cheers
James

>=20
>  drivers/watchdog/imgpdc_wdt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> Cc: Jude Abraham <Jude.Abraham@imgtec.com>
> Cc: linux-watchdog@vger.kernel.org
> --=20
> 2.0.5
>=20

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVDIi7AAoJEGwLaZPeOHZ6ZX0P/0O9HUY5XRyAXOsOcubXe4Wo
+3brhaFj+1/wtEPoMtS5Ti76MM+Be0BY5RsbbYmWVgp2CLe4w4JQDAqfPcIYKmQU
iXF4AqQL0M/89Ad3xJqWMgy6N9jSgeqpp0ci6jCi3ieHykflxCB6nQh+EgvDRNDN
AgGUQZWItb94WX9+7he2ZxdPEIcDvYqlfxcH5Z2dbRO42W3NEAokNlX5Uevg0k/q
f+i+UGk1SDXSwnv7j5FduaQG4U3Hs++1nsJDUP/AFPxZwvXw+lHWP9NK8do1/eF+
Tzw6ZTtWA1PyPVTroC1ZnQ+2imVNm5QPovDFovWvJWwedrB1wSq3LV6Wq0xKvT1I
sgKTCUr5Gc8afryo8296hsSAZguo472DjrxmMJKt0frUAr4EO4RBDyaN3Jg536E7
qNmSqNJo9pskdOTeGyiQGxJCBBUe2gaeYM+tRlrBOo6ddvJjSNx4d1x2bOVTxzRc
9VhG+z1SmBQayp6PBlAzBxYzQyRLgu1VQqWQ+PfGjJIBS8UHAQqYiPS/oOLJ1i0x
97mhA12qjJi+tE4IKqXQK5RH1EzJB25n0ACnJ7MzM91LaWRjKARmrYSHej7tsGtC
9lUkzGUl/HbX6ch0ZND865it6VoBzC0GzZapBAnnnxLiaFv3aPks2fAxrBpw8qCk
TaK6BFbKmVgudayrfH61
=VDZf
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
