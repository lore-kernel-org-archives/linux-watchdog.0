Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60871 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab3FWNQx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 23 Jun 2013 09:16:53 -0400
Date: Sun, 23 Jun 2013 15:16:48 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Carlo Caione <carlo.caione@gmail.com>, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
	henrik@henriknordstrom.net, linux@roeck-us.net
Subject: Re: [PATCH v5] ARM: sunxi: New watchdog driver for Allwinner A10/A13
Message-ID: <20130623131647.GE26008@lukather>
References: <1370547265-24854-1-git-send-email-carlo.caione@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <1370547265-24854-1-git-send-email-carlo.caione@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wim,

On Thu, Jun 06, 2013 at 09:34:25PM +0200, Carlo Caione wrote:
> This patch adds the driver for the watchdog found in the Allwinner A10 and
> A13 SoCs. It has DT-support and uses the new watchdog framework.
>=20
> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>

It would be great if we have this patch merged for 3.11, unless if you
have additional comments of course.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRxvU/AAoJEBx+YmzsjxAgVj8P/i1emoKrXShGPA8yNSDQDJAU
liuobqwXtZdUqFaGTDJoJd9K2kLXpdgkWK/YKiGgSZj4osX4iSqQeGYEPbLBpxK0
4W4tjN/5FvgJHU5a7GDiYRkIfxUFseMeH+aqM1Vw/J9otkyK1hdsxoW9pxaD+DPO
btKDGzV1F0TRGU4ChmURubwwKPdLTpfXui4sUx30h7lGINwYZqLlswVLJE6Y1IZw
Qy1g2HXu0GxPD0hmLm4mzZoPgPB/XscNXwl//+kji2A2lhnv1AXUcrEbI+E91VxV
HIatNCWcKAF2523YJw9D6+zgE1GRfqcjAUpkvA2D/3P0qujR9Fb5Q9SU4GFhr0pR
04fmKJkHM9JwHjDtNDDKd+Er3KUUmjcLz7+FqhlIGQgFjVxgYRu3HdCKvo5UNCr6
QJphaDdAXdupoQwObVWIujyECqOrlF41uxtV8FNMQg6X4A0uH260Z6gRjMUa82XH
pmbimR95piQjlCZ/5B/3pW//u5MIe81yd77Mk/8nOeiJrUNnVvTs0E1cXrVvHTos
VXjEvOgso2veraMITCGmDzzaRGQ7rRpMsaKh+/lwGlDQY0oA2wSaBm9Iowx6Fren
NogUmwg/KE/mKR7AYvHVpb61WoMYAOKSXO3Cf8IscSDNU48RJYKyRtcbdiLY0svL
bu13cE/f3xEuBknNcvW9
=qrLF
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
