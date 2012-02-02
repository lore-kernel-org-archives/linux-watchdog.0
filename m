Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54264 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086Ab2BBUXj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 Feb 2012 15:23:39 -0500
Date: Thu, 2 Feb 2012 21:23:38 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Roland Stigge <stigge@antcom.de>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH 0/4] pnx4008: convert to watchdog framework
Message-ID: <20120202202338.GA14490@pengutronix.de>
References: <1328204891-32551-1-git-send-email-w.sang@pengutronix.de>
 <4F2AEBC5.9060308@antcom.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <4F2AEBC5.9060308@antcom.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2012 at 09:02:13PM +0100, Roland Stigge wrote:
> On 02/02/2012 06:48 PM, Wolfram Sang wrote:
> > Patch 3/4 is of special interest, because it extends the core to allow =
to set
> > timeouts without having a dedicated callback. Since the core automatica=
lly sets
> > 'timeout' in the watchdog device (and does limit checking, too), there =
is
> > nothing else left to do for this device since it uses that value every =
time in
> > start/ping.
> >=20
> > Please review and consider for inclusion. Roland, if you'd like to test=
 them,
> > too, please do and donate "Tested-by" tags. Thanks!
>=20
> Works for me: Applies cleanly, compiles, boots, watchdog barks
> (rebooting appropriately when using /dev/watchdog).

Great, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8q8MoACgkQD27XaX1/VRsZGgCgls7F3FMTIgIbnSaKP81R8NGr
J7EAn3SdJiRktvgWhZQRFif0rljzBZrV
=o7+N
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
