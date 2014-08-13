Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44592 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbaHMKuE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Aug 2014 06:50:04 -0400
Date: Wed, 13 Aug 2014 12:50:01 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v3] watchdog: Add DA906x PMIC watchdog driver.
Message-ID: <20140813105001.GF17027@pengutronix.de>
References: <1407926776-16700-1-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pyE8wggRBhVBcj8z"
Content-Disposition: inline
In-Reply-To: <1407926776-16700-1-git-send-email-mpa@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 13, 2014 at 12:46:16PM +0200, Markus Pargmann wrote:
> From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
>=20
> This driver supports the watchdog device inside the DA906x PMIC.
>=20
> Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/watchdog/Kconfig      |   7 ++
>  drivers/watchdog/Makefile     |   1 +
>  drivers/watchdog/da9063_wdt.c | 228 ++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 236 insertions(+)
>  create mode 100644 drivers/watchdog/da9063_wdt.c

Forgot to add --notes to send-email.

Here are the changes in v3:
     - Cleanup error handling for timeout selection and setting
     - Fix race condition due to late wdt drvdata setup
     - Remove static struct watchdog_device. It is not initialized in the p=
robe
       function
     - Use WATCHDOG_NOWAYOUT_INIT_STATUS for the status
     - Remove 0 shift using DA9063_TWDSCALE_SHIFT

Best regards,

Markus Pargmann

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT60LZAAoJEEpcgKtcEGQQGEYQALyTR1vhhIjH7EzHU+QKgu+H
tzp+YXp88G4dehHB7qe5ZeIQMq3vuNgzAL2mgK9fA37aFi7Nheixo9gbxpuXsPOy
+IG66S9/ZzsMyuXpQNtcQ3vh4bZ9Rt2K4HlqKgfDlqnaoihNyKha9N/bQJAMWYzr
IlartP0Fd4BDX4vLgGEr4d6c83GhgsYieoAUrOx24Rn133z1yX2+z4MCPsNuicSo
DBP4N8vnku9v8I7p50xnkLHgetxVzMq77H+TkjE0751AHKRQWsMKOuXxR79QRYSV
sHcXIkMXLU0b/yxh45NKxcGgC/ts3xO9xN+TozlOfVuUpEbveWaKsAkUQBvO2OB0
TOh0zGkH+EH8yuJysIcBgirmlYZ32iWz7zAoVOn33ATTwKMz1byhJ1J+rKQXNDJi
jIeNkycgq2m2GXklNsZEnwZhmoP/OMjmZ3zQZRhS3v2570rpycsxCCm2uGH6AuqG
ja7NnnAytHJHVpSZiA6FX4REzn7eiy5Ko5NK05NS5dNqeRc2Oam0JYVO/1p2zipJ
Fa6lileaP2r0d0BFxtD+zTBSgUcRQYRVvPE+YYygpOGq8nuPwwG1+TYdXuA9ckBq
fhBE/jKnNY406ttgI+iDbF+mwOvG2JYtOtEDnA+3Yq7h76QBKqs+mMnxW2c6gZLA
GIWMHojkiZ1zP//KhfcK
=YOJ+
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
