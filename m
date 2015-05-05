Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37788 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbbEEILc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 May 2015 04:11:32 -0400
Subject: Re: [PATCHv7 6/8] watchdog: imx2_wdt: Convert to use new core extensions
To: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
references: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <1429701102-22320-7-git-send-email-timo.kokkonen@offcode.fi>
Cc: Wenyou.Yang@atmel.com
From: Marc Kleine-Budde <mkl@pengutronix.de>
message-id: <55487B1D.1060108@pengutronix.de>
Date: Tue, 5 May 2015 10:11:09 +0200
mime-version: 1.0
in-reply-to: <1429701102-22320-7-git-send-email-timo.kokkonen@offcode.fi>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="T8P2i1CNFtRcq2Sjv7L9WQD6nOOAsNABK"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T8P2i1CNFtRcq2Sjv7L9WQD6nOOAsNABK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/22/2015 01:11 PM, Timo Kokkonen wrote:
> Fill in the HW capabilities in watchdog_device structure and call
> watchdgog_init_params() to let watchdog core to init itself
> properly. The watchdog core can then ping stopped watchdog and the
> timer code in the driver can be removed.
>=20
> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>

This patch changes the default behaviour of the imx watchdog. Without
the patch: If the system boot with watchdog enabled (by the bootloader),
the driver sets up a threads to pet the watchdog. With the patch,
imx2_wdt_ping() is called once during probe but the thread is not
started. There are no timeout or early_timeout paremters in the DT or in
the kernel command line.

I don't like the old behaviour, but I think there are some setups that
rely on this feature.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--T8P2i1CNFtRcq2Sjv7L9WQD6nOOAsNABK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVSHsdAAoJECte4hHFiupUgJMQAKV8PaCEzBl49Mx5LqUL4mQD
HbREp+EpV0KLhunHr/S2ydKafwkhq15hDRIXRz1oaIQQORuqgGwvcpZqD7TPdFOY
Dz7spDnO3zF5gAPB0rhnOrTT7WlD+3MRNUX5JtpHWh/hUyZWmHnS0st/ClUeCED5
oDhQqIsPFx3uk/QiNsGqty8zvVU8jkVtxuNxJNsDPm74HwTrKVLgiMuEjDMP8ZYT
aI2PPqd0tshgGNdl4liEKDz1aouEvI3BGpcGLKmO62icVNaSluNxb5iae65gWIJg
8ikeIBnJqwcuvivAfX2tJrf2VoRYMj+PFcaFOzc044X/8DjHIPVYSmC6F3gWQ8Ec
WEEPY6a+uw6QsN/+wRR0W3E/PXxiG7qf+XBUgii1DDeRLAiZdxV5NhPBRakPeQrh
BWqTGvEXgRIWUEgl8bfpT5TZMtQmR01hXzYnpdusWqIC4VVDNydfO/lpoi4hB53Z
ZmD9e3lpSsuiiVCkO0OWJJUuvoszJGtKUhbaL0XOWGgbiOAIBLokWuF5qKE+YWXP
6LD5kVDU17/qz3ajKYpKqy6Htq06sTRnRskb6gSqy5t7Nv17IrOnLpVha+Urjc/h
+MmO56SyCgTE6PEFfDeJ0mPMXxJki+wzooWr9DlktbsZ6dvIR/pU8SKKl9Spt26I
Dx/Jq2AgEQyvbq2DBgra
=1jJl
-----END PGP SIGNATURE-----

--T8P2i1CNFtRcq2Sjv7L9WQD6nOOAsNABK--
