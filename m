Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50367 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbdGVUcF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 22 Jul 2017 16:32:05 -0400
Date: Sat, 22 Jul 2017 22:31:59 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        wsa+renesas@sang-engineering.com, justinpopo6@gmail.com,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH 1/2] watchdog: renesas-wdt: Check the return value from
 clk_prepare_enable()
Message-ID: <20170722203159.GA6399@tetsubishi>
References: <1500754979-19836-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <1500754979-19836-1-git-send-email-festevam@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 22, 2017 at 05:22:58PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>=20
> clk_prepare_enable() may fail, so we should better check its return value
> and propagate it in the case of error.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

True. Yet, I have a patch in preparation which fully switches to
RuntimePM which will make manual clk handling superfluous.

I'd prefer to drop this patch because I'd need to revert it anyhow.


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZc7Y/AAoJEBQN5MwUoCm2W3IP/i0A3flVIXZbccaRXGmp/bR7
8Hsg5ZhdBNDfWNqhtsVYh/Y767650LsNgQTXKK0A+GBgtcaHmMh2K15LRjYMEdEx
sGeMKrvASs3qdtnAw3fcXoIVTahEZCDQ7fKJWKQIu/5WIVdEws/lZUj2NJIEL0Vx
mt6ObxH8TSAhrXHfXPfjjYw/YH9UolTID2uW+oWuJb5EVV41U/iGAxSVn3WkaGVX
N+i6FRZgmM0mBYi+BWvY5DW3pkQ+8FdYKQGGAwgZMUQEsm8n+ggmx04M5rejt+cj
xJgeBei8czQdZnZuaRarvEbau6wYr3vIX7GI0c7VwS/zReXcf6KC/4zmbkYFkMUQ
3uQGq/m2TboqH0KKEuojKGv+pySmNjgLva3qfEFojq77Bh5OnN//T63OjVMnzjHx
ZGI0D2U2JqUQM+61zRf+YIhtL08Ft1GWvHpmKc7BYJTFQLeRJ+rZJAzBEA+f1OLq
0zOkDyw5wfh20qa10pstt3kBRziLiUcbDekNg43OX6vccI6K1IgG60n6P2VFNPZI
GQQtwiLJA8Jf9tgz0o6zQhMIb7IAFsleJoQ5zCmFtrx3mlCDngyoBaXj6eOlNgtm
PtrGELuVHKQi9a6DvL43z0sNwOoIhR4eBxpIOsW9rx33vNQGRjzZS7w0EkdzcBFC
0qfQ1WHiacnxiioMK+wA
=BHQG
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
