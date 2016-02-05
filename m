Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:43475 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750721AbcBEVkt (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Feb 2016 16:40:49 -0500
Received: from us-aus-mgwout2.amer.corp.natinst.com (nb-snip2-1338.natinst.com [130.164.19.135])
	by us-aus-skprod3.natinst.com (8.15.0.59/8.15.0.59) with ESMTP id u15LemF8018608
	for <linux-watchdog@vger.kernel.org>; Fri, 5 Feb 2016 15:40:48 -0600
Date: Fri, 5 Feb 2016 15:40:48 -0600
From: Josh Cartwright <joshc@ni.com>
To: Kyle Roeschley <kyle.roeschley@ni.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [RFC 3/4] watchdog: ni9x3x_wdt: Add timeout_action sysfs
 attribute
Message-ID: <20160205214048.GF9579@jcartwri.amer.corp.natinst.com>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
 <1454635683-13668-3-git-send-email-kyle.roeschley@ni.com>
 <20160205200803.GC9579@jcartwri.amer.corp.natinst.com>
 <20160205211352.GC11390@senary>
MIME-Version: 1.0
In-Reply-To: <20160205211352.GC11390@senary>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 05, 2016 at 03:13:52PM -0600, Kyle Roeschley wrote:
> On Fri, Feb 05, 2016 at 02:08:03PM -0600, Josh Cartwright wrote:
> > On Thu, Feb 04, 2016 at 07:28:02PM -0600, Kyle Roeschley wrote:
[..]
> > This is...strange.  You're allowing a user to enable an interrupt reset
> > action, but...there is no way that a user can actually _do_ anything
> > when that action occurs.
> >=20
> > I'm reminded of one of these:
> >=20
> >   https://www.youtube.com/watch?v=3DaqAUmgE3WyM
> >=20
> > (The only reason I can think of where this would be a legitimate thing
> > to do was if we were relying on the watchdog interrupt to bring the CPU
> > out of a low power state...but AFAIK that's not something we do).
> >=20
> >   Josh
>=20
> This is another reason (that I forgot to mention) for this being an RFC.
> Ideally we'd poll or select the /dev/watchdogN file to wait on interrupt,=
 but
> this isn't supported by the watchdog core. My next instinct would be to h=
ave an
> sysfs attribute named interrupt or event which a user could read/poll/sel=
ect
> to look for a 1 value indicating that an interrupt has occurred. Else, ma=
ybe
> polling support could be added to the core, but I don't expect it would b=
e very
> useful.

There are already plenty of timer interfaces a user can use for managing
timeouts.  We don't need to invent another one.

Now, we did enumerate what might be a legitimate use case, which is when
an external signal is being used to feed/pet/kick, but that
functionality isn't supported in the cRIO/cDAQ case, so it shouldn't be
included in your patchset.

  Josh

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWtRbgAAoJEKp7ZBKwQFArRxkIAJokpfKVWR/0MdDqMmmC0rFO
bmW0i+kXJx7YXLNfkSVr/NRQspRdJWOCkehBnIKOvALU0SWNS2GbUueufBoyvLja
FdtFBZUPPXnTpZvKIWh9JS1SxpL8PAddmpYs1jbr1WxfYWZucMFN1YiHZxJWUkym
2L/Fki/c7cJhRE6EyAd0qtQf3Wz6HzfTwE7kYY6F1nUBB9hFp/Vp76KDTg9yve0t
7UnC+JGbfS3Tq8atZKEL9TDvVQYM0xJ2S88k0TQkNwuv1rU6aoGYGuAIjKjcbeOg
uYyXe2gfl22yHf+Dwe92xgXsIfYBF1d5h1133syaOSbM4x4YWSZpLRwuavPNHEU=
=lISS
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
