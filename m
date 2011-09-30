Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41420 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab1I3R0z (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Sep 2011 13:26:55 -0400
Date: Fri, 30 Sep 2011 19:26:52 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Andrew Morton <akpm@google.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] rtc: stmp3xxx: add wdt-accessor function
Message-ID: <20110930172652.GA13242@pengutronix.de>
References: <1317212997-26668-1-git-send-email-w.sang@pengutronix.de>
 <1317212997-26668-2-git-send-email-w.sang@pengutronix.de>
 <20110928122849.42f903a2.akpm@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20110928122849.42f903a2.akpm@google.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > Andrew, Wim: Alessandro was not around in the last weeks, so I'd sugges=
t this
> > patch goes via the watchdog-tree together with the rest of this series =
if it
> > passes the review of the watchdog-list? All changes here are in prepara=
tion for
> > the watchdog driver and do not affect the general RTC. Is that okay?
>=20
> OK by me.  Be careful about the Kconfig setup when doing
> cross-subsystem dependencies like this.  Otherwise you get sad emails
> from Randy when his build breaks.

Yes, the watchdog driver depends on the RTC.

> > +	.name =3D "stmp3xxx_rtc_wdt",
> > +	.id =3D -1,
> > +};
> > +
> > +void stmp3xxx_wdt_setup(struct device *dev, u32 timeout)
>=20
> I'd suggest documenting `timeout' at least.  Why would one want to set
> it to zero and what effect does that have?  What are its units?

See below.

> The patch adds a global symbol but fails to declare that symbol in a
> header file.  This is always wrong.

I admit the aproach was quite wrong. I exported the function but wanted the
watchdog driver to be the only user (and so the parameters of the function =
were
quite specific to the watchdog driver). Thus, I kind of tried to hide its
interface for other users. I will try to come up with something better,
probably passing the function via the platform_device created at runtime. I
also played with sharing resources, yet that would require a top-level driv=
er
managing the resources and two sub-level drivers (RTC and watchdog) which f=
eels
unneccessary complex to me.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk6F+9wACgkQD27XaX1/VRtWdACeLII23pnInQjWufBEZwk4ZWDg
DXkAn3zptUg/Cy9lWjKkZSevzQeag5rw
=MlfH
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
