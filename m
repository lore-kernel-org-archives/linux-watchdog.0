Return-path: <wsa@the-dreams.de>
Date: Thu, 9 Jun 2016 23:14:39 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Robin Gong <b38343@freescale.com>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] watchdog: add watchdog pretimeout framework
Message-ID: <20160609211439.GQ23522@katana>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1465321127-19522-5-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160608065445.GB1521@katana>
 <575826C9.6010808@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7kD9y3RnPUgTZee0"
Content-Disposition: inline
In-Reply-To: <575826C9.6010808@mentor.com>
List-ID: <linux-watchdog@vger.kernel.org>


--7kD9y3RnPUgTZee0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> * removed support of sleepable watchdog pretimeout governors
> >=20
> > This does.
>=20
> Same as above.

Just to make sure: I meant this does make reviewing easier since the
bottom half handling is the biggest thing to discuss and it is good to
seperate it out.


--7kD9y3RnPUgTZee0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWdw/AAoJEBQN5MwUoCm2psgQAKBsHpLGdbYlqXo0mylF7Uel
i1topCnYJs2XuDH3cOtbgVOmKC4Ieq1d52SAOOqNv7e11bkCIsV0G2gQ3ZkAGYjw
sFmig85Cf3gRt1Zlh4S7s7WTF7VPIwaxdklwvazcHU7MMq/nhpIj0Iv5LdqC8on4
9t9pf+kMseXeQeRjM7KGI3bGoAYNrioQ/ZMKmGsxsBiKrVzm8KecyPnuJB6wnCH+
XsoEnq6k7iqSNV6HLGKifL3QXPWfGiXUaElXPBXvNtGZOxOhFFPdwW8EFvdJ1BQm
CXwlgComxusrg+r75igcCPK5IHvJmJRfN2ybWMaTd75L9b/zr7SNfwgHaUK4z79k
BvgE+OlfD9Kc67a8sE3FrRSagXGINJondn8ss0qCpU1nvDi6dRtZ4u7AnkQHrulO
rxMhb7iVBND6BLpz5jx7FZANciRzRuXLtFnJT3UMOvb3YaDdSZcOC28h3A8nU/KD
eSwft9m6bSrh5KYBJDRLxrBch73+zQw/91cmK+e8YtllGktYb9jI2UH1LSBUkKU+
CW+tP8NtmY1v4lYEsyQh1V3K2JUKVcG0t2AUvdU4Xu5EPMUUpmteT5YOvYpgFjxT
bKQVwuvsj2CQ+Gx9nkDCLokh0A65YehC3z76DVDRh177nf2ksY0roJ6dmn75iRXP
Kg7FZ4gyzIH154XEFQxi
=FygY
-----END PGP SIGNATURE-----

--7kD9y3RnPUgTZee0--
