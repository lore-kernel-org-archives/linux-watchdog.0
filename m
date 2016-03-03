Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44645 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbcCCUt4 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2016 15:49:56 -0500
Date: Thu, 3 Mar 2016 21:48:29 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: richard.dorsch@gmail.com
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, lee.jones@linaro.org,
	jdelvare@suse.com, linux@roeck-us.net, wim@iguana.be,
	jo.sunga@advantech.com
Subject: Re: [PATCH v3 4/6] Add Advantech iManager I2C driver
Message-ID: <20160303204829.GD1711@katana>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
 <1452468675-5827-5-git-send-email-richard.dorsch@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Content-Disposition: inline
In-Reply-To: <1452468675-5827-5-git-send-email-richard.dorsch@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 10, 2016 at 03:31:13PM -0800, richard.dorsch@gmail.com wrote:
> From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
>=20
> Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>

Well, most of the comments for the other drivers regarding the style
apply to this driver as well. I'll wait and see if the MFD core parts
get improved before throughly reviewing this one.


--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW2KMdAAoJEBQN5MwUoCm2xKUP/0uCMriwGwx67kUXIWd5AM7g
8dMKT5b3zGEe36FyhtXGxmgEPwjDs9x0IDIi0WLInheMejYbQHGYL5bOpny4/LOv
3H2l/R+M8hFIDkImNc3BHpXcTMFzV61AOkAWQNMzxEDCLXoVpPg9QQqLQKzEFATf
gqgzS7T/G9LXI62qR3kLDGhkg++p+UUl+eibNAO3HP/bM4MqI3IPM+LqBqYvhuO+
VES6Rh+I7v6ZLYGrLJH2ackYdjERsk01Jnz+BEkBkUd7pc1sPkxMwlQ6bg+k7dGm
NgX1PfGDGmSAzjVtX6LRqNGgnf4iyeybkO7tC0NWJe/mLtLnWiQCC6JuSiXIRQzn
X5Dv3ZXC82R6J8bTK+48cd3L/F8VVBPoe7Loa2wcGUMumGYZD722FlQC7zihXv9O
VDEvEaH+KZBL9A2IiaZQDyhN2aCvd+OX/bOlMixZBNasPaBt0waz9Ddm9B+vSrt0
Me1dTKimgV0Cbt6x/JrKqaxYiB7Rlp0KRLnsN+2TTY+FdvnlEy8KxflN1pbBu3+2
VdvlAPCNQ21H+BjEezogTUd+ohq3aL/Bzdkj3XKyE0OPFhvqmaiqYf00R2E04F1s
nWOWU/rF4pXLu/a3h+N16LY97pTPcop46O3aLip/fTmw0SiHiPtHJvESAyysvSq0
KNe50tG8RYRw01hIM9z7
=8XLJ
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--
