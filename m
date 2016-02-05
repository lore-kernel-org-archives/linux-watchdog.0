Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:46930 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751553AbcBETxh (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Feb 2016 14:53:37 -0500
Date: Fri, 5 Feb 2016 13:53:36 -0600
From: Josh Cartwright <joshc@ni.com>
To: Kyle Roeschley <kyle.roeschley@ni.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [RFC 2/4] watchdog: ni9x3x_wdt: Add counter sysfs attribute
Message-ID: <20160205195336.GB9579@jcartwri.amer.corp.natinst.com>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
 <1454635683-13668-2-git-send-email-kyle.roeschley@ni.com>
MIME-Version: 1.0
In-Reply-To: <1454635683-13668-2-git-send-email-kyle.roeschley@ni.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 04, 2016 at 07:28:01PM -0600, Kyle Roeschley wrote:
> The NI 9x3x watchdog timer has 30.72 =B5s resolution, so expose this
> by allowing the user to set the timeout counter directly via a sysfs
> attribute.

But _why_?  That isn't clear to me.  Why do we want a user to directly
muck with the counter value?  (As opposed to working in units of time?).

  Josh

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWtP3AAAoJEKp7ZBKwQFAra8kH/0b9qDURjN8Sp68zXThMnlzE
hj3n2EauOKEaN9FTaVK2Of90n0G7+KDwA2DnsdKDcp1gHxjw0fabDwq9myr4/osN
8/kk/L5cfsEchv3OdcsrP4ARAN9ABYEERb48bM11OTR8Va49HmsONhyxCXn/4NNN
oqLSNSU+ph4alXnZ4W3+fpMG7JGSoPyZ2xoGR6W+jm8buy12hiW+lX0X6O4eChjV
5vO87Wz1hhTy0USNO3ZTLoDOrKpYNYZUdw9OM9QIXZxCidUyLHi4u3dBeELlCjUx
LCA7b6tvAd5Ry+dAKayK6Ex63hH1cnNeZ3QLYN+GAHqS3TXm8AqIFat5DRKvc+k=
=vCC0
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
