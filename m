Return-path: <wsa@the-dreams.de>
Date: Wed, 8 Jun 2016 08:34:58 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Robin Gong <b38343@freescale.com>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] watchdog: add set_pretimeout interface
Message-ID: <20160608063458.GA1521@katana>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1465321127-19522-2-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <1465321127-19522-2-git-send-email-vladimir_zapolskiy@mentor.com>
List-ID: <linux-watchdog@vger.kernel.org>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 07, 2016 at 08:38:42PM +0300, Vladimir Zapolskiy wrote:
> From: Robin Gong <b38343@freescale.com>
>=20
> Add set_pretimeout since our watchdog driver has those interfaces and
> obviously, the new common watchdog framework didn't implement this
> interface.
>=20
> Signed-off-by: Robin Gong <b38343@freescale.com>
> [vzapolskiy: rebased, added an inline comment to describe new interface]
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Why didn't you just take my patch and worked on it? This would have
added the documentation Guenter explicitly requested when reviewing
Robin's patch. And it would have get rid of the bug you have in the
*_invalid function. I also don't think the split-up into three patches
is necessary here, but that might just be me.


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXV7yRAAoJEBQN5MwUoCm2Dz0QALMX+tiLW9H5TPOXUvIN68DZ
oMXJzqLGBjO5VRvsZNfOOfHiNqV8bUzWSiueLlgfvdfTz3+vxqXpNmu5jDVT2id3
vUW4K5gEdsCNPhOdR4UeUTOt0xH8py9dWr52sdk6hcchrhd73sZ7immdTtzy+19w
1hb86tFbqE87yuhSd+UyuRHK4wtbTgyJ2tJGl+1iUoL+xu10rrem94jazbHnZB3h
w5igWxWOf/7iZXQm0r5xZSWrlEXVJuleLHbzcI/Wg5x+sp1aTI8Cw9LiS9IOO2FJ
HcyQt8dkTdR+aAdNhawCR537tgHvJ2XHzGsP7vY3XSzeO5yPDmKvctqP8wdRXHbU
8eDyYF90sy+hCUZtsKi5LPCmTJyznp/dGRQ/Djc3nL1k+0LnV2bf7dZircr8iklW
VlZ1SXnKfKPknTvo6MFZaOpn1VAgAzwT+UMSGgZG1tAsEzQkf8Q5bQsTgElmi75A
Zt1Rl24YR6Icikjp16t+47pZGMkHZKaCyFAOXXAeLphbgvP58oDmKcKHtBo2zdYR
lFwCvRsOUOJ+Y4Ec0/8tcnJM8gAygvhsllgj8YEInMCB61UDdd3y/QqrAoWad1Fk
K4d1hebcUHKAwz/N6dqVnW5+UmAazJUz0l4JQN9pT6BXm+AWGVcwaqh7eMazL7S2
MlZVvtOOP985nzx/ceuL
=Rv+o
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
