Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54628 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab3GFQjz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 6 Jul 2013 12:39:55 -0400
Date: Sat, 6 Jul 2013 18:39:53 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, henrik@henriknordstrom.net,
	linux@roeck-us.net, Carlo Caione <carlo.caione@gmail.com>,
	linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v5] ARM: sunxi: New watchdog driver for
 Allwinner A10/A13
Message-ID: <20130706163953.GB11243@lukather>
References: <1370547265-24854-1-git-send-email-carlo.caione@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <1370547265-24854-1-git-send-email-carlo.caione@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Wim,

On Thu, Jun 06, 2013 at 09:34:25PM +0200, Carlo Caione wrote:
> This patch adds the driver for the watchdog found in the Allwinner A10 and
> A13 SoCs. It has DT-support and uses the new watchdog framework.
>=20
> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>

This patch has been sent over a month ago now, without any review or
comments from your part.

Do you intend to merge it at some point?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR2EhZAAoJEBx+YmzsjxAgzjUP/ju9gjs3/OcDOfO7VtpvO1Lz
Q0LnwSqziMky3DMfBR+XFpIa9L6JvOFQudIF1plXl2oN1AZKE4CMAUXSTIsRr2pt
ojIggZwg97WiZ+tjqvCGcJminDmplHA9hkUoQ3wtQKtKLnO+Z6+DCRwpLBlPB8Yq
EecjSY+vbCCPVfydlK3h0FDbeQIXmBdeVNhEouBsd99azD2j3G9IRwjJvYQ6oHF2
W0G+UCQ23Ewe2qtAmG2wYtTeFbP8JTZ9e+yyMxOngpGJ4+csfCS2u9KfesCiTSGh
89oYylyCqyImKfwCY2Vj8yxki5RvK683VxlS+lQiqK3oMHOkwKAAjpXNn5JjoWkh
B7UsvSVXmpFTlUxX7HeNx1Ft4uZghVBmFnI0iBF5BQVtJiB50vtI45AHy5HiNYgH
IDpEqD85DQb+4QGK7XwgqnwnB3vOC0Gke7xsdUsRRbOCGp7SV6UbdCQjMxBYoR6B
oZAnK28v7lnaGp+CTraXERRcduEd4g0k6JWjdQamDfp1DBkznh4d/KB31p4VQEYj
FAe56gU/T9+UaAw4NeGtC20IYZBBTymn9EVFxgQM3euKwIVWmgohIMgDni10cZ9W
hmwBIR+sXgttj63u4Jz0bIynpsUJdm9gy8Axl/4fDpVMhuNFs3SkFrYHF56KhDsR
jTiPFHIah0Quey0AoGyp
=pU53
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
