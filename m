Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34195 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624AbbJWInk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 23 Oct 2015 04:43:40 -0400
Date: Fri, 23 Oct 2015 10:43:25 +0200
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
Subject: Re: [PATCH V6 1/6] i2c: Add i2c support to Freescale Layerscape
 platforms
Message-ID: <20151023084325.GA13380@katana>
References: <1445587282-29529-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <1445587282-29529-1-git-send-email-B48286@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2015 at 04:01:17PM +0800, Zhiqiang Hou wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
>=20
> Modify the I2C_IMX config to support to Layerscape platforms.
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>

Added COMPILE_TEST and applied to for-next, thanks!


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKfMtAAoJEBQN5MwUoCm2Y6MP/AlcVfAGRZO4gVAJlVoLeBIp
kln/ZisN9qzfPLj9OcnYzlCKbPY13Tu/5YYCT5/V2aIGOLs30HqPCr8nb9KN7dPu
scVCHtaqiX/0WP0lYulYFfac4kv7835XOU96mHUNDYjj9ne2bpGhqRWVzdiTCHQc
66g8qX2lcvrJs0159Zp2DWpymfa4hDVUx0aZExdaHJI9ArCxOf1NHNA3G4k9UQUZ
Dcd+i4zqDyfd0E87fu3NdFAHvS8TL7VvgQNw3tnoS+G3CeLvz3jzdbKBG8At/7ov
jBOi3X06mSNCT/Xe7VYTfwquwUC2XIplxynhd67PEy2G8DQLMYfWZJYthpwODCel
sh0RNG4AbULWPdP7+W8Xqqs5PM+FTlAixZ4FW021t+yel5FaVnzjvD0BWxej4Dlr
mpyJoIm9WWpHyMNjigwPPRhPUEGoisikG4UxqklykbZv542/RG65aImcLaBegUcX
aD9upwOUoJH9VTCbY9BjGW5h0iYuThMjuu3r/hH8KAhp8iviDZFWuOgM1WD+hsoC
iRGZ92l+E9lAXfiDliDNpsSoTM+YVVDsFYXI5ANNzsxTutk30qLrJysXCYJdfs7p
lg5o0lEoVHra9Oc06mJPO2COnOXIUCJ8qKXkF4jqIuKMX/qFEK2q/G9Y/Dnx4wpR
izvQXLsRvnVqztNhWnd2
=6yF3
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
