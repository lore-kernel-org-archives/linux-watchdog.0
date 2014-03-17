Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59447 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756787AbaCQQZD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 17 Mar 2014 12:25:03 -0400
Date: Mon, 17 Mar 2014 17:22:43 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] watchdog: sunxi: Change compatible patterns
Message-ID: <20140317162243.GP27873@lukather>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140303104042.GU607@lukather>
 <20140311205405.GA10228@spo001.leaseweb.com>
 <20140312091649.GU2815@lukather>
 <20140312180751.GC1484@spo001.leaseweb.com>
 <20140313111558.GH2815@lukather>
 <20140315083711.GA11070@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JB7KW7Ey7eB5HOHs"
Content-Disposition: inline
In-Reply-To: <20140315083711.GA11070@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--JB7KW7Ey7eB5HOHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2014 at 09:37:11AM +0100, Wim Van Sebroeck wrote:
> Hi Maxime,
>=20
> >=20
> > On Wed, Mar 12, 2014 at 07:07:51PM +0100, Wim Van Sebroeck wrote:
> > > > > I'm OK with the patches, but what is the preferred way to get the=
m upstream?
> > > > > via watchdog tree or via arch/soc tree?
> > > >=20
> > > > Since it touches the machine restart code, I'd prefer to merge it
> > > > myself if it's ok?
> > >=20
> > > No Problem. You have my Acked-by.
> >=20
> > Actually, I only have to keep together patches 2 and 3. Could you
> > merge the first one? I'll handle the two others.
>=20
> First one added to linux-watchdog-next.

Thanks!

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--JB7KW7Ey7eB5HOHs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTJyFTAAoJEBx+YmzsjxAgCowP/2lkcw9jGLp8zI/nlYc5nF3u
K/Az312TIHgpAHiJ4/2t1UlmintB7VreNGk18XlLLfodmrEcf3RETmRWnxGPqLcv
BadZPGwzVQA85VKuXhUnE98W4ovbckhw2hteqCojPiXtrmLENSf9bA8Zp6huuGv2
LM2pTOIn+vMq2ZLpLSTxg0L9JRRjs0wXvgB7ee2TC+e7MAOk7wqe39LGz24BpogO
U0viEn/CYwqT2g52fTgDAdrQbAxdVxTwSVPu7FWAVDNG55RbzEqGxG4L/5GKWSD+
/+jHTaMn2QhbYmmlVICtaLLtrZCdFiypYy3BJgDUJ1p/hhgotCIA3cvURKqWFCJ4
4NCvDpzArRxJYfC6GKUi5KpVxlYhuG4efBiv663qmwJQaoYp+HLK5bdHlGfBz8ZE
Yxpi4R9qG09e2xsp+BQEM4xp9jFe6ltUw5qAjjRQz/BS1isB6I8qpAReGz19J82t
h9iiuXSTqAqjKXznAi+b2qKsf45q+nNMZukMIGjq1Tz+p+1Opqs/5ojmpW+cGAZ0
B1ocGWknnag4fAehMFU2qcMDlR0UnGQnoJL2k0DEhTcNkNROt23k0bAwmvN20h4D
WY/U6thZDJuXUu+FieAYgPYzWKLtkal/cWJ6wxwNybuQcfpsFauIYAFSvC5HvAGC
G3ljPR2LviGykB29yoyM
=+A/v
-----END PGP SIGNATURE-----

--JB7KW7Ey7eB5HOHs--
