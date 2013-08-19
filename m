Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54739 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751221Ab3HSLCr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 19 Aug 2013 07:02:47 -0400
Date: Mon, 19 Aug 2013 13:02:44 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: wim@iguana.be
Cc: Carlo Caione <carlo.caione@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
	henrik@henriknordstrom.net, linux@roeck-us.net
Subject: Re: [PATCH v7] ARM: sunxi: New watchdog driver for Allwinner A10/A13
Message-ID: <20130819110244.GH3173@lukather>
References: <1375212046-12823-1-git-send-email-carlo.caione@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Content-Disposition: inline
In-Reply-To: <1375212046-12823-1-git-send-email-carlo.caione@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wim,

On Tue, Jul 30, 2013 at 09:20:46PM +0200, Carlo Caione wrote:
> This patch adds the driver for the watchdog found in the Allwinner A10 and
> A13 SoCs. It has DT-support and uses the new watchdog framework.
>=20
> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

It would be great if this patch could come in 3.12. Do you have any
additional comments?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSEftUAAoJEBx+YmzsjxAgtZkP/29dgyBauvZq2FzZUv6MziL4
MdveQgojspHP9UmFGdzIGMn8IQ9P59p7QfAuuuz6whm22xcbC9b8lJnFFNIypPt4
AK+U6con7smqsRgM7TA2YlSGM36H+9/2q/+b9LXjy9LOiyoABfmqrT6xgHoT8a1C
l3nvhZpFV1OC+90y7osYZWhxPYUPGbHcJr6ngdTeMclcF0N6dzEewhhFkXzfkU3K
ZKIvm7rxvaSAcLQfZoGLzVF/HM6uJSAl7HJjzW14+ik/JLnCGgdqXXqTBHGHTITo
b9MdGxZ7q3xvRMhLC87D0XVu5nGGEB4QZSLxO85Jyk83QYVMV2DnKgETfOsCL3Sa
rvv6RynuUWzSJ/GkbwG557cLGbHU33u3nrqMsnt42wSTNVn/Ze4n4BXB9L9i199V
DMIqZZxrim8KxcLjKm213sDMOuzJKIcxp2NHvtqZU8x1b+Ao5mH7w0ZmfwWV+WgE
sHosaGdoqO7kgnVEXDPHp3WQPpBbxzL7xN1z/FNlmuIEVM7ueYms+nj65YJCbnT6
RVjg3QxEr0qOEO0vErzTM+msVSZ38XXd6b770y0w8DigLO4+a0BKw8iASMcW9tbz
ALuBY4YJYB9bZD1K0qv4GsGxNSw24trLGy6niTDRB8PcVQlb3PAGgWCkeYhMmSnI
t2ApgULjXxUshL+1omqy
=1mKH
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
