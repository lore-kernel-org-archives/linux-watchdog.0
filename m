Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36626 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757468Ab2CGMs2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 07:48:28 -0500
Date: Wed, 7 Mar 2012 13:48:24 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: viresh kumar <viresh.linux@gmail.com>
Cc: Viresh Kumar <viresh.kumar@st.com>, wim@iguana.be,
	linux-watchdog@vger.kernel.org, spear-devel@list.st.com,
	linux-arm-kernel@lists.infradead.org,
	srinidhi.kasagar@stericsson.com, linus.walleij@stericsson.com,
	alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 00/15] watchdog/mpcore: updates & fixes
Message-ID: <20120307124824.GD2568@pengutronix.de>
References: <cover.1331115751.git.viresh.kumar@st.com>
 <20120307103414.GA2568@pengutronix.de>
 <CAOh2x=n6Xx0r7OsTvYTY9d6V11WgGuruF9D3kGVb8DosqAtatw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <CAOh2x=n6Xx0r7OsTvYTY9d6V11WgGuruF9D3kGVb8DosqAtatw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > It probably makes sense to convert this to use the watchdog-core. See
> > Documentation/watchdog/convert_drivers_to_kernel_api.txt for some
> > guidance.
> >
>=20
> Sorry for not checking that earlier.
> Will align my patchset to that.

Cool, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9XWRgACgkQD27XaX1/VRsrVgCbBpdUGgzPelQbetbysF3/Tkj0
cOsAoJgn72EpqnTSm4fH6+f3a19hxA5N
=LoQP
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
