Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59633 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760262AbbKTO7Z (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Nov 2015 09:59:25 -0500
Date: Fri, 20 Nov 2015 15:59:13 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will.deacon@arm.com, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org, mark.rutland@arm.com,
	linux@roeck-us.net, wim@iguana.be, corbet@lwn.net,
	mturquette@baylibre.com, sboyd@codeaurora.org,
	Mingkai.Hu@freescale.com, Shaohui.Xie@freescale.com,
	scottwood@freescale.com, bhupesh.sharma@freescale.com,
	Wenbin.Song@freescale.com, B48286@freescale.com
Subject: Re: [PATCHv8 1/5] i2c: imx: fix a compiling error
Message-ID: <20151120145913.GB1752@katana>
References: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2015 at 05:53:18PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
>=20
> drivers/i2c/busses/i2c-imx.c:978:2: error: implicit declaration of
> function =E2=80=98pinctrl_select_state=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
>   pinctrl_select_state(i2c_imx->pinctrl, i2c_imx->pinctrl_pins_gpio);
>   ^
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>

Applied to for-current, thanks!


--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWTzVBAAoJEBQN5MwUoCm2y8UP/0gfMsczqO2iwBCCPslkIE4m
8ABnrXW3RsbF+ox1EAEtpY/d4Sc9PNpRqqh5Zf3VNm8UU36rbn/2DP3yNqNwybv4
mK+uQWOUI3pIbMaxWj61smKp2tG4ZorPqOlMeD7fdalEHk/HAIsKLqmxFgF2wRIH
23JjjQxXDrlNeS4whSD/RZpgjnoon812OfGQM3qbMaZpylVGDByqCXdXOcAM0T6W
XbYK4BAnpK9bYQCpT/aL0YnBroq1a5ojaj0rVAJQSoAi1bIYHKdSrHxT11aqzGlQ
ZlHPgUV2BEmyOJarQ6DOytuwIjt1qaFgdBHq533+9udvGc5s+oaMtWN///PMlyKo
u9RQZXLSJJKHpgNa38qhGNkoYqLroS6cc3Vyxlzief6Qrobvq87LZZWkQpyU6St1
SYaK4W/3NpLgj2ZZvyW5FyMQWNHw8BC95VvImK//UTzUrl5kjdg6RjOE/b+1gGCQ
Sl9jm1sMrOdrGGd9pxqyW9PQIbKm/KykcI12+SUcwmD0UMs3cW3FLIul9Zut4/vD
uUiGU42wdtUiJZOcWeNHRV5pN+lJwaaQBc+OydOJF8XTW+OJNNbf+0TWxWuAFXZg
gLWbojrPBgRP9MfRVbD3QMg4j/RYH3ZutKay7cZ31KREM7izS/GlAAO1dH3k/hhP
UZH3iDoESnT9U92Bwa2R
=vItH
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
