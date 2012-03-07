Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59013 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605Ab2CGKeW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 05:34:22 -0500
Date: Wed, 7 Mar 2012 11:34:14 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Viresh Kumar <viresh.kumar@st.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	spear-devel@list.st.com, viresh.linux@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	srinidhi.kasagar@stericsson.com, linus.walleij@stericsson.com,
	alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 00/15] watchdog/mpcore: updates & fixes
Message-ID: <20120307103414.GA2568@pengutronix.de>
References: <cover.1331115751.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> This patchset contains fixes and updates for ARM mpcore watchdog driver.

It probably makes sense to convert this to use the watchdog-core. See
Documentation/watchdog/convert_drivers_to_kernel_api.txt for some
guidance.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9XOaYACgkQD27XaX1/VRueMwCdFI/qIMuiui9KgSucJGPSUmwk
uRYAoISVh6tJyZaExVSZujBQGhjWKTSO
=Bfzl
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
