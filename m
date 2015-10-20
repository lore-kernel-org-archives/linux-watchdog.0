Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43611 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560AbbJTPxN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 20 Oct 2015 11:53:13 -0400
Date: Tue, 20 Oct 2015 17:52:58 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Zhiqiang Hou <B48286@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will.deacon@arm.com, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org, mark.rutland@arm.com,
	linux@roeck-us.net, wim@iguana.be, corbet@lwn.net,
	mturquette@baylibre.com, sboyd@codeaurora.org,
	Mingkai.Hu@freescale.com, Shaohui.Xie@freescale.com,
	scottwood@freescale.com, bhupesh.sharma@freescale.com,
	Wenbin.Song@freescale.com
Subject: Re: [PATCH V5 1/6] i2c: Add i2c support to Freescale Layerscape
 platforms
Message-ID: <20151020155258.GM5379@katana>
References: <1445255774-32887-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Jdw4pA1x1k2W7MG"
Content-Disposition: inline
In-Reply-To: <1445255774-32887-1-git-send-email-B48286@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--9Jdw4pA1x1k2W7MG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2015 at 07:56:09PM +0800, Zhiqiang Hou wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
>=20
> Modify the I2C_IMX config to support to Layerscape platforms.
>=20
> Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
> Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>

Three signed offs for a simple Kconfig change? And the person doing
the patch has no signed off?? That looks wrong. Maybe the above signed
offs should be acked by?

> ---
> V5: V4 V3 V2
>  - No change.
>=20
>  drivers/i2c/busses/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 08b8617..14147ec 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -582,10 +582,10 @@ config I2C_IMG
> =20
>  config I2C_IMX
>  	tristate "IMX I2C interface"
> -	depends on ARCH_MXC
> +	depends on ARCH_MXC || ARCH_LAYERSCAPE
>  	help
>  	  Say Y here if you want to use the IIC bus controller on
> -	  the Freescale i.MX/MXC processors.
> +	  the Freescale i.MX/MXC or Layerscape processors.
> =20
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-imx.
> --=20
> 2.1.0.27.g96db324
>=20

--9Jdw4pA1x1k2W7MG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJmNaAAoJEBQN5MwUoCm2GmoP/jRzXnUGzGss8X/pKAnaTGX+
XkYOSlIabsGjbHVARbMorlYLkvkG0AVt8MpfrXKxHBx/xiCU8HRBwhWZzENCLIbz
CvVk0vuEQKDm/T6/TcjPlFbbzKwcwEebydcvsEU/VEej/KM7aWldqbYTYSX3lC2n
bJEOsyvn0tSr6gFFjSS9wyRQZUotbllNWSM9SAzvzMEN91SN+b4vkzTzDwU87q+R
3HUnpE8/eouHrKh2Q15Ak225l25l5IChso1MhWx5w7cfj80Bx0Ni4t+Nk27FfDND
uhMQ4UPqguBNxW1USEsEzHAIfG32VT+stURJoO7iw2ggnBOQweIUtCWOITxCLO2z
jgtDr06CnuqyFQjXsZWsvRo9AXRw+R27ZS0Yt/e7V5w6GHCTv8NIZVoLLphRphI3
DYNo66Cc9M5T4XUyf+a6jSCzxJ73j3L+9tKG+zOJm/8/ETKNBtVs6UEJN0caVTCL
CFUgql4ylmxJpIRGKAyS1BkpFd8Li7qtSWbzeJaULjXgl5Ci8GX8YdlqWQGbKSSc
IBpNFvcJXxlIiFfn3mGsg0y4qm8LS0ONE7mDO1E8X0Qzh9KqlPGsM/G30LfalYOD
qXyzjL9/DF1Jj/Ei1ThVBFqouRPltFrMlv5RzYJQ41b15um+UYxAvnMicZ4eUVkv
4ai9Ux1dRiVnvJcBCbQ2
=EpaM
-----END PGP SIGNATURE-----

--9Jdw4pA1x1k2W7MG--
