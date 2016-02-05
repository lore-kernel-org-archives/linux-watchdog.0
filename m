Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:41485 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752107AbcBEVel (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Feb 2016 16:34:41 -0500
Received: from us-aus-mgwout1.amer.corp.natinst.com (nb-chan1-1338.natinst.com [130.164.19.134])
	by us-aus-skprod2.natinst.com (8.15.0.59/8.15.0.59) with ESMTP id u15LYfg0026746
	for <linux-watchdog@vger.kernel.org>; Fri, 5 Feb 2016 15:34:41 -0600
Date: Fri, 5 Feb 2016 15:34:41 -0600
From: Josh Cartwright <joshc@ni.com>
To: Kyle Roeschley <kyle.roeschley@ni.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [RFC 4/4] watchdog: ni9x3x_wdt: Let user control watchdog mode
Message-ID: <20160205213441.GE9579@jcartwri.amer.corp.natinst.com>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
 <1454635683-13668-4-git-send-email-kyle.roeschley@ni.com>
 <20160205202720.GD9579@jcartwri.amer.corp.natinst.com>
 <20160205210328.GB11390@senary>
MIME-Version: 1.0
In-Reply-To: <20160205210328.GB11390@senary>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 05, 2016 at 03:03:28PM -0600, Kyle Roeschley wrote:
> On Fri, Feb 05, 2016 at 02:27:20PM -0600, Josh Cartwright wrote:
> > On Thu, Feb 04, 2016 at 07:28:03PM -0600, Kyle Roeschley wrote:
> > > When first powering on, the NI 903x/913x watchdog starts in boot mode.
> > > If not switched from boot mode to user mode within 30 seconds of power
> > > on, the device status LED indicates an unrecoverable error. While bef=
ore
> > > this was handled automatically, now add a module parameter to disable
> > > this behavior.
> > >=20
> > > In order to still have a useful watchdog, also add a R/W sysfs attrib=
ute
> > > `mode' which can be used to switch the watchdog mode from boot to user
> > > mode (but not user to boot mode).
> >=20
> > Hmm.  Instead of an attribute, why don't we just ensure the watchdog is
> > in "user" mode in start()?
> >=20
> >   Josh
>=20
> Seems like a good idea, except for the fact that we then lose a way to qu=
ery
> the current watchdog mode.

Is that a problem?  It isn't clear what a user would even do with that
information if they had it.

  Josh

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWtRVqAAoJEKp7ZBKwQFArJTcH/2XiGNzp7bONqsBZfOE6VZMZ
77umtsIFTJSR6fV5APWcgtGxDNzBf3hOJ0pqXVYAao7eOTjGUYrcdJJRDVcSplut
Pn7ep/4X2LsB7+XyYZ3Tt7VY5vRtKnwXbeuF4KhuDsfmXN/3ZMvf4iIyw0mCLLQH
JZk6oix3mGvCPvJIqXReh3UF5cZR2x2HYWkmXN2jHFm+ykgi3KA7VSXu/Q9PGHWW
iimHPPkjUsCuuBIT49Z/Ke7Fdd3mmgYBaFnt/91a5lq2FaV7n8afqIyXqtVtg3il
d+UXvFUcT/514jeH9UxPpO8Azy+6eSwi3fjPjdOGv93dxkkxZDY+xxnt1F6Vs/E=
=1ucg
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
