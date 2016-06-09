Return-path: <wsa@the-dreams.de>
Date: Thu, 9 Jun 2016 23:22:28 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Wim Van Sebroeck <wim@iguana.be>, Robin Gong <b38343@freescale.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] watchdog: add watchdog pretimeout framework
Message-ID: <20160609212228.GR23522@katana>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1465321127-19522-5-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160608065445.GB1521@katana>
 <575826C9.6010808@mentor.com>
 <20160608182052.GC17549@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xr6Gr0irOxp3+3c"
Content-Disposition: inline
In-Reply-To: <20160608182052.GC17549@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


--5xr6Gr0irOxp3+3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > >> * moved sysfs device attributes to watchdog_dev.c, this required to
> > >>   add exported watchdog_pretimeout_governor_name() interface
> > >=20
> > > Why this move? Before, all the pretimeout stuff was nicely encapsulat=
ed
> > > in its own file which could be compiled out. Now things are mixing. W=
hat
> > > was wrong with the approach I took?`
> >=20
> > Simplification of the "struct device" life time management?
> > A lot of time and efforts were spent to centralize it, while you know
> > that I took both approaches, I tend to keep it exclusively in
> > watchdog_dev.c , probably Guenter can express his point of view.
> >=20
>=20
> Yes, I am very much concerned that I'll have to go back and look into
> all the lifetime issues again which we just managed to resolve.
> Not looking forward to it :-(.

I will have a look at it again, too... but I still wonder if this is an
issue if the whole pretimeout governor framework is spawned from
watchdog_dev.c. And I understand things can be subtle here.


--5xr6Gr0irOxp3+3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWd4TAAoJEBQN5MwUoCm20YMP/RI3gAF4RV6VJaW0/YnrF8ZF
mJBQMfapFfrSs+XayHWNqBhSBCczgJxWq1oBHQNVMWNF/7zGoFLGl74Vp/W8rFwK
fc79dmCRaDPdj3HXsa5SmcQLwzB04dzrsQE/hikl7DO4DwpTTvXoTJigFi+3rxCV
9yKlirtsrQLHvCIDp+XK5lbaA0/OysbTi9eu67E5F2eBkTCMMzAN8tv/71vggzdg
VZ+7AJWzpsvcFys0cwjznY5a9iI6zfB1j38jntMa4GFsM9I3p+UJq6xDwqRLTFcr
k9Qc633nRB1XSGOaIcD3qOVd5I7PIk/rhLVLPjO4Ph5Cpser1mzRwpzrLF46vhQb
daL0Vknz6l/HAL1vNUtWed5R+1Ci/Iz4qUqbUPFghhZfrt9ANU2Jn4hiDZgZ8wit
L1G8iY5YcNUkznNZqhaHY78BsoGDmNtOMX8rw5eiluTjdk1VbIB7Vq0E1AVpWK71
sv/NEStbO+ekssMz3Pla7BAobWd4odmlqw1K9SJ4hh0SCDxEnpLuLA011jZA8t7p
nwBvJPnAjk9ah9txlzETDIDkbcuk/5B/JTMQlafg38b9AGdQ+kkszyo7tx2t8lXS
jIhqft91CF6MKG+9vqhDH9A3vZ7BhVmPzH8p+7CNSanfUhFhjC0VE1G2qMKeGPQx
dJ3CGf6IFB0VmSIL5m0j
=BpHZ
-----END PGP SIGNATURE-----

--5xr6Gr0irOxp3+3c--
