Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49943 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750781AbdIRFyD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 18 Sep 2017 01:54:03 -0400
Message-ID: <1505714034.4080.16.camel@aj.id.au>
Subject: Re: [PATCH 0/4] watchdog: aspeed: Retain enabled state and move to
From: Andrew Jeffery <andrew@aj.id.au>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, linux@roeck-us.net, joel@jms.id.au,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Date: Mon, 18 Sep 2017 15:23:54 +0930
In-Reply-To: <20170918054905.16470-1-andrew@aj.id.au>
References: <20170918054905.16470-1-andrew@aj.id.au>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-uD2mYu7Q2COBPhEVL4W+"
Mime-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--=-uD2mYu7Q2COBPhEVL4W+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-09-18 at 15:19 +0930, Andrew Jeffery wrote:
> Hello,
>=20

*snip*

Ah, my subject got truncated. It should read:

    watchdog: aspeed: Retain enabled state and move to arch_initcall
--=-uD2mYu7Q2COBPhEVL4W+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZv19yAAoJEJ0dnzgO5LT5giAQAI8k0YudAOlkIKMzMzPzbphW
PxM2fwlZFul0wfDwXxvagoXfhqCu009h+HVotUilxAZarxvCxjXGmx9Dfc+mlw61
QXMdsNAHP2UkK8IEPbvSlk6hAqDaG05qjMLRQ31whj70oHw8POu0z349rIAErlvU
KHesli4MEGG5H1zzg5zHpcF8gRlCeYxIE4UnTG6kY5csBqaEXtahi+vbNgzj+3CI
fu6QCrZrNoDK+wDKng3gLhnQKyFOgnpr97ZkxZgdbNS67bq0zpSVDyzx08KLgOQy
shpDpRkwAGzAkNQD0673/4bVfs4uqBgkravR3g97Av7t4V6qhX9sNuP58G6oUdV4
vklvlLn1IHuYxEkYF+2Vq8upexnC4sJul5DjRhLP/wp+0B71Xpr5Q0I2ds9iR31A
dZdjTSRzJzuKJketartbPUoFYS9XSQn1XtSZ9HsRx2fcjYiiqdW9kD0JL65f0HPz
DDLMJ/mONA1UFzFm0E0CJ1BbKXiLkJfpqoU0/5Y48XX3IWfGu56MvdwNfxk0q6lF
RKrom1pAxCTP5rQb+xtqtJ8FPpbsJx+2t4Kgx7UvoHjF0MS81NJU6WdVO3ulrHVh
4KwMHoxi+d1qp2e9JZRh9xYjkmSU8aR3fQYO3u3Xn/9o1aa8ClrW46/no3qy2Syh
yCe25riFyk93e0lG+56H
=RZK0
-----END PGP SIGNATURE-----

--=-uD2mYu7Q2COBPhEVL4W+--

