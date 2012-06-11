Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps.mortis.eu ([79.99.135.181]:51512 "EHLO vps.mortis.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144Ab2FKG3u (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Jun 2012 02:29:50 -0400
Date: Mon, 11 Jun 2012 08:20:41 +0200
From: Giel van Schijndel <me@mortis.eu>
To: Justin Wheeler <jwheeler@datademons.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Patch for f71808e_wdt.c.
Message-ID: <20120611062041.GD11604@salidar.me.mortis.eu>
References: <alpine.DEB.2.00.1206110101290.1027@newbox.vps>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1206110101290.1027@newbox.vps>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2012 at 01:07:58 -0400, Justin Wheeler wrote:
> I have a Jetway JNF99 motherboard, featuring the F71869 SuperIO chip, but=
 its
> watchdog chipset ID appears to be 1007 (as opposed to 0814).  Some testing
> confirmed it behaves the exact same as 0814.  The short attached patch ad=
ds
> that chipset ID to the module's ID list so that the Fintek watchdog drive=
r can
> correctly identify and access it.

Acked-by: Giel van Schijndel <me@mortis.eu>

--=20
Met vriendelijke groet,
With kind regards,
Giel van Schijndel
--
"If debugging is the process of removing software bugs, then programming
 must be the process of putting them in."
  -- Edsger Dijkstra

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/VjjcACgkQZBYm/87l50K9CACfe1rUbnhJ81eGXl/tugta4dPS
iSAAn2h/Z7tOkXCLUJbOFmTk21zIt4R+
=0ecz
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
