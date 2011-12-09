Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52841 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab1LIJWZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 9 Dec 2011 04:22:25 -0500
Date: Fri, 9 Dec 2011 10:22:19 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-watchdog@vger.kernel.org,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, Wim Van Sebroeck <wim@iguana.be>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] rtc: stmp3xxx: add wdt-accessor function
Message-ID: <20111209092219.GA3327@pengutronix.de>
References: <1323364783-1059-1-git-send-email-w.sang@pengutronix.de>
 <1323364783-1059-2-git-send-email-w.sang@pengutronix.de>
 <20111209002722.GG7913@S2100-06.ap.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20111209002722.GG7913@S2100-06.ap.freescale.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2011 at 08:27:24AM +0800, Shawn Guo wrote:
> Hi Wolfram,
>=20
> On Thu, Dec 08, 2011 at 06:19:41PM +0100, Wolfram Sang wrote:
> > @@ -0,0 +1,15 @@
> > +/*
> > + * stmp3xxx_rtc_wdt.h
> > + *
> > + * Copyright (C) 2011 Wolfram Sang, Pengutronix e.K.
> > + *
> > + * This file is released under the GPLv2.
> > + */
> > +#ifndef __LINUX_STMP3XXX_RTC_WDT_H
> > +#define __LINUX_STMP3XXX_RTC_WDT_H
> > +
> > +struct stmp3xxx_wdt_pdata {
> > +	void (*wdt_set_timeout)(struct device *dev, u32 timeout);
>=20
> Passing callback with platform_data will make device tree migration
> difficult.  Is there any possibility we can save the callback here?

This won't affect the device tree. The platform_data is not set up per
board. It is the RTC driver which adds the platform_data to the
platform_device which was also created inside the RTC driver. So, device
tree or not, simply enable the watchdog in Kconfig and all will be fine.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7h00sACgkQD27XaX1/VRvNbwCgjpL+jEvYZRDSBVEbmlQzTrBf
xV0An0l6qrfSxI7e9xPaofo9Wt6mQKNA
=LyoP
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
