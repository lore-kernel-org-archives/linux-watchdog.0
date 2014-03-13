Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40634 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753565AbaCMLUI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 13 Mar 2014 07:20:08 -0400
Date: Thu, 13 Mar 2014 12:15:58 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] watchdog: sunxi: Change compatible patterns
Message-ID: <20140313111558.GH2815@lukather>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140303104042.GU607@lukather>
 <20140311205405.GA10228@spo001.leaseweb.com>
 <20140312091649.GU2815@lukather>
 <20140312180751.GC1484@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xEruU51OOzV9VdJQ"
Content-Disposition: inline
In-Reply-To: <20140312180751.GC1484@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--xEruU51OOzV9VdJQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Wed, Mar 12, 2014 at 07:07:51PM +0100, Wim Van Sebroeck wrote:
> > > I'm OK with the patches, but what is the preferred way to get them up=
stream?
> > > via watchdog tree or via arch/soc tree?
> >=20
> > Since it touches the machine restart code, I'd prefer to merge it
> > myself if it's ok?
>=20
> No Problem. You have my Acked-by.

Actually, I only have to keep together patches 2 and 3. Could you
merge the first one? I'll handle the two others.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--xEruU51OOzV9VdJQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTIZNuAAoJEBx+YmzsjxAgWDMP/1EFCGMCOqT+Rt4g4SoVHq6g
klCg76vY2gaWO/L5SaiMkEDlKJPl8uwWm8wYYtY8jrMMEBLXW8Hp2osITJFZtJ9I
Qqk9ybXCHKoxXCkSHJ2x4pXOZZ1SvL9ERpgt59CkzmAonVPK4/rUoDr+Ue+GA5iW
awVCoB4YnmYhpkreWqDykRcovpk7GR/1rV4W9LBk6LBkwUkWvU0u27c4BI4GYIvH
cLn+zZM+urPflod0oS4TnE8VxOo+ythy09Po+M1TfPVr79uighzts81vGX39bfKX
+LTzBtqAhYaIPTfUJsrqX5suiJlVYwMWH5dywQQZZJUTcXmmPNc74hiK+MkDAX+k
07ocioWt+omK7rGso0L4ieAQOYr+0zPgc7KUCp3LJuA7MT3t/jQMdyQ8+A1G+mWW
rdBp8amc2aaJov6dcVgw7smmPZ+7bMz3aTPcCM2LWI8lQliFm1pSwC/8SfduDyMW
UvwezXDENGDQGQGdVlWqnrAHcuWqtGfSSMtu3Sl1WOfqNacC52xYPvhgu2jr/RMW
rDIFqqPQQVf/jrcaXzoi0MCmvIcXi+kxS2M+6qO5mk/AUAY8x/wDh70swZz5SSe1
FiKzpXLK6dIU2FNtyRDzpV5W3awMduOOwLpCkqbxUMz6D9PRxVRDp5e/Luxjvres
9e5poecue/I5Y0ZRary7
=DSD3
-----END PGP SIGNATURE-----

--xEruU51OOzV9VdJQ--
