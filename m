Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:54844 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032835AbeCARNI (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Mar 2018 12:13:08 -0500
Date: Thu, 1 Mar 2018 18:13:05 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@iguana.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 3/3] watchdog: renesas_wdt: Add restart handler
Message-ID: <20180301171305.56oconc7kcn2ill6@katana>
References: <1519919048-21884-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1519919048-21884-4-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rvfmfrrt3oz7yhqn"
Content-Disposition: inline
In-Reply-To: <1519919048-21884-4-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--rvfmfrrt3oz7yhqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 03:44:08PM +0000, Fabrizio Castro wrote:
> On iWave's boards iwg20d and iwg22d the only way to reboot the system is
> by means of the watchdog.
> This patch adds a restart handler to rwdt_ops, and also makes sure we
> keep its priority to a medium level, in order to not override other more

the lowest level

> effective handlers.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesa=
s.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

With that fixed:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--rvfmfrrt3oz7yhqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqYNJwACgkQFA3kzBSg
KbaiGRAAtaCNB669k3oM4tM0MIZX27QHl++7Sl8GGGx/wTpd+guc5o4sC7ubsA6L
gOvXNcSIjxCPteGRQfid2y4cMfBb+Utkwz/rgASHIKbdaESZaKPPUgGINuRTjnHl
C2mHFoS+IG310wAEquALfOnpfyFGjJyPeItZVRBE1aGuIBonqM1sTjIcP8g++ciJ
daCZGGN1/d9X1cEvVh5kgnC02JE4sNxsVjzuCNHqTWS5kQ77j6UziJ2wyWsa0Jwv
q16lGFjB8Qo/VXmca8MxEoHygb6nKGPBwUrfT5FbjpQ+Pu99xPE7U95cn1MoemVC
bnCv+TYmDDtjiyC0U/Y93tJog6wrcqpO697uYkcYttUq050d5Xe5FlZ81ydm2JNN
88Luan2CHEaJ1JxWuEwt2GM57wMW6S8UN/2Wgb1i0U4GH6dEbSiCl3XlBvOd5ymx
B/wUFeqJCmaya2eWM+NT96ennyw541IeDjqIvQ7o9hXDr6mIchhVhKsrj5x4otel
nvhccNX0FOcOcfp5LeBANbn0I4BCIvU0d2b1tVTYN5REeMkQ3oCKaCdGSKxbxex9
T5b8Cjxv0jEEb+Gzx+DJdpKnbbWViupxErslPDJLsIBCt6N5tCHKEN2jjieiEcFz
RK5WGT6VgcSkEPsnLZfS6P1ixwoI4SKYboGVxYkS90mOfpS5/3o=
=B4Dn
-----END PGP SIGNATURE-----

--rvfmfrrt3oz7yhqn--
