Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33875 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753939AbaCCKpn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Mar 2014 05:45:43 -0500
Date: Mon, 3 Mar 2014 11:40:42 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] watchdog: sunxi: Change compatible patterns
Message-ID: <20140303104042.GU607@lukather>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hNtiuZBcYkRjyNT4"
Content-Disposition: inline
In-Reply-To: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--hNtiuZBcYkRjyNT4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wim,

On Fri, Feb 07, 2014 at 10:29:23PM +0100, Maxime Ripard wrote:
> Hi,
>=20
> This is the second version of the A10 watchdog compatible changes.
> The only difference with the v1 being that we're now droping the old
> compatibles, instead of keeping them, since the DT maintainers said it was
> fine.
>=20
> Thanks,
> Maxime
>=20
> Maxime Ripard (3):
>   watchdog: sunxi: Change compatibles
>   ARM: sunxi: Add the new watchog compatibles to the reboot code
>   ARM: sunxi: dt: Update the watchdog compatibles

Ping?

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--hNtiuZBcYkRjyNT4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTFFwqAAoJEBx+YmzsjxAgr1wP/jJBf82tiqP+hkKdPFxTH/hi
BgIkmaVugDww6/yQVL0KaAqTdQpmfdNkS1Mj9OnwM5j5FqCN48jkEfsWhwQGrkGn
AaO271AIyUDpzNobKpZASK16qADdpFQXbOkOtv5HgqlJpR5fz6tajefnrcivJPhl
zqpZV6sMcTN3glGz8nJLGUdrPJW0ZR0QkCKTBQ6w4BRokInV9k1OdH4aCHL2v0qy
gzbu2kP2q22OEwafGEPz8j2kE7jt5eXY98yEusI5GzAvU7QehjA8HrnwsWGLGEyt
IFb18F6jv9mZF3JbHgwYFZxUNy9T3GVQyoC32DIuBUgN7wXcx1z4yjUCF99JAuMf
SoYFukQt1tPC5Glc/kOn2KV0o45Av284Mt69JrYkrctAG6DtgETpmgUrZzfgAHA3
zZ2+uVYV149ZzzQH3UsaqmnlFrNVH2KTedJvisF3agt4RwNxtsOsuPtXIIanr6gm
UMJvmYqCUGbkuB4m5pOvSpESNM1sRZ7tyldz/w3JKswokxc+nECvIKKS7sZz6rkE
TiGB3KDNj89ZTdRnJTT8JAeZf6uO55pgalRAe3Y0j0lrqu2gGxjHlFSYxmvHHJaa
BnIQgkFDf1nPqA4IRYwwnRAx/CK1u83Vml4+HO8vuctDLQbxaSkJrWGefVbDT2co
+02GPJ89pVKcF0tN4VzW
=2WBg
-----END PGP SIGNATURE-----

--hNtiuZBcYkRjyNT4--
