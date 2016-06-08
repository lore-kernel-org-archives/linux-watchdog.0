Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56401 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932835AbcFHH43 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 8 Jun 2016 03:56:29 -0400
Date: Wed, 8 Jun 2016 09:56:19 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Robin Gong <b38343@freescale.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] watchdog: add watchdog pretimeout framework
Message-ID: <20160608075619.GF1521@katana>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Content-Disposition: inline
In-Reply-To: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Changes from v2 to v3:

This series was odd to review. I am used to that we build stuff on top
of each other to strive for the best technical solution. I didn't expect
that you like all of my changes, but at least some of them were obviously
correct. But since even those were ignored, it really feels like a step
backwards and thus, the reviewing time a bit wasted :(

Stuff like 64-bit support and the softdog timer (so people can actually
test the framework) is completely missing, too. Why not adding those?
They are easy patches.


--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXV8+jAAoJEBQN5MwUoCm2mW4P/j1jX42f1c6PL4OQv1TOgxLc
Mm24KJpOCjv27TM8Z98uFiOm/V+P5ol1fRliuliTZc30tka1Beg2SxSPNtSsZgao
YvInYVzR9SZN+uFiX6AU23vUFemqidqkX+/Gue17ymayoaBXwAniN/YanyoteVu0
MQGi0C8nwMGJR0jmCNeBSeIasGCqtEqqSjynBkVm1w0H6BaMFcUF5T7mfTkOQuDz
UehQYQIPtTgADXNKQ8TRgSgRk++wndgThNwrwqAU10vE/JNScB+C5jDS+jmpb8jX
DgTbybFKS0XO+bf5/NqdifL5Q6CIN8Xm2Q2McE6xNGQplNU4SralaI5sqxasArQN
fhpzjKqHSdfkkZUE+Sxarei9IG48kxuusb1PmOkg6R4LZaF3q+zuJYueYmdmDIFV
+/4XtsK+DjEZXf9zm9cnIypugR2k4cu7ZyqFb43SqrIYn/kCIBzIUVYXjkn5qmYD
vdKjJuVqEawidPxOr1koLsFgZUNbFoRyiC6oQ0vovIXXB2HLGbTwo88cDZcOyUzM
JRWNSyn8rSHmtWSTxrxELMU1RcjHgl2/5S3bsNU1XpELz8ki84iNsffkMxEKxWLK
UvCZ4FNx01GYliXgj8NJNcPVjraS8FlCZHzLVNEyS6tD4uzpy0TeP7k2pZNMU9mF
r228S2idL3VtGQOReabv
=OR8W
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--
