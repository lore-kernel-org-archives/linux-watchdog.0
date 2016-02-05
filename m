Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:56099 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754899AbcBEU1W (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Feb 2016 15:27:22 -0500
Date: Fri, 5 Feb 2016 14:27:20 -0600
From: Josh Cartwright <joshc@ni.com>
To: Kyle Roeschley <kyle.roeschley@ni.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [RFC 4/4] watchdog: ni9x3x_wdt: Let user control watchdog mode
Message-ID: <20160205202720.GD9579@jcartwri.amer.corp.natinst.com>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
 <1454635683-13668-4-git-send-email-kyle.roeschley@ni.com>
MIME-Version: 1.0
In-Reply-To: <1454635683-13668-4-git-send-email-kyle.roeschley@ni.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 04, 2016 at 07:28:03PM -0600, Kyle Roeschley wrote:
> When first powering on, the NI 903x/913x watchdog starts in boot mode.
> If not switched from boot mode to user mode within 30 seconds of power
> on, the device status LED indicates an unrecoverable error. While before
> this was handled automatically, now add a module parameter to disable
> this behavior.
>=20
> In order to still have a useful watchdog, also add a R/W sysfs attribute
> `mode' which can be used to switch the watchdog mode from boot to user
> mode (but not user to boot mode).

Hmm.  Instead of an attribute, why don't we just ensure the watchdog is
in "user" mode in start()?

  Josh

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWtQWiAAoJEKp7ZBKwQFArpfUH/0MnhIAwhP+pR8M2dMnLUWHj
Ilg7YK8Se85dL0vW5ZsF2KdCkv0Tpo2V1hrAlPnuKZ9R1hDqPiroRO3/LdPYzy6D
wGZdMx2qpAvrHQkfIeeI16vPP9prsx1amrdhSIpENj6J/uiGa1QFsrhDWfUGreDR
vsfGosBaFM7RzmvncdjELv7+AoboTg28iRElbjIrNonL4Nujlk6qgMjOyQXjTcSa
yGW/ZTjG1K3G2X81A9nZS8FWlj8CGWKaMoqX+rtT0ST+OA1AdGCrzlY7I9NZLxWj
9apPa4bDpsF2atX0qhiQwPvwd8cTzk+Zu6Uu9IQRiOoQj44OEH/yzImaQptYR4A=
=OyDg
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
