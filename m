Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59961 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751725Ab3HZPfq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Aug 2013 11:35:46 -0400
Date: Mon, 26 Aug 2013 17:35:43 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: wim@iguana.be
Cc: Carlo Caione <carlo.caione@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
	henrik@henriknordstrom.net, linux@roeck-us.net
Subject: Re: [PATCH v7] ARM: sunxi: New watchdog driver for Allwinner A10/A13
Message-ID: <20130826153543.GC2695@lukather>
References: <1375212046-12823-1-git-send-email-carlo.caione@gmail.com>
 <20130819110244.GH3173@lukather>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <20130819110244.GH3173@lukather>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 01:02:44PM +0200, Maxime Ripard wrote:
> Hi Wim,
>=20
> On Tue, Jul 30, 2013 at 09:20:46PM +0200, Carlo Caione wrote:
> > This patch adds the driver for the watchdog found in the Allwinner A10 =
and
> > A13 SoCs. It has DT-support and uses the new watchdog framework.
> >=20
> > Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> It would be great if this patch could come in 3.12. Do you have any
> additional comments?

Ping?

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSG3XPAAoJEBx+YmzsjxAg3nEP+gM1hpItbaRYRjZY4vcIwPCT
vyfDcGKKAxYjb3ACpvfbDPFiN11kkJd0SoAu9/xCOELBSLqvGVDzFYC4tiCzVwCz
0RucHTVVyfYibRlm7pMSMJ23PQNaJIvFGx3md2S59Z6b+We+0e7lTWBI6orMcKMC
Q3M4Kp8wbRsN/E6gDWR52rrrC0aSijH0wS2fvlKcQoOZtMrNlgC+u6/TJtvfojlM
O0GBdhk5rWXXVxJeLSaJijeHOH0x3LxC/67rMwbGXhgy5MqkMUNdmI4V7TWniIek
jfX29TpdR4oZkIK9C8eAP71TFO7CKoWixQWflL/utKG2YmPEHASY4r5owz0dSc2s
swaxdRAOE3D11WN/EexuJJZUWq9zHjrtMK67zvX79kwQQE910Ywe3jtx0odlK1aF
9ofCjurHhnWlYGd9nyTWGygdwq7MsgMJZEnBUDMuRd85XY39pNc+MHNcMkTtII4U
YIYRFQxmXuuWuJ5IhMEfPqmBxcPO0wqME1rUBIAPw2mUOLmZY7V1oOc20q6SqGbQ
6Sq3xzM/IFK4T7x8kRasKH7brbRfpv0vVPgeI2r9CibuMv+Nw0yhfmuXS9uc6Cuk
ld72ypAEHSFvtMv4E9K/U02CNBkwVS3mgmIA/XHo/9d5osxviuip4yU0LpMxs15b
R5lC9/SxaVTz9Jg45snh
=hQmm
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
