Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:45896 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161018AbeCASv6 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Mar 2018 13:51:58 -0500
Date: Thu, 1 Mar 2018 19:51:55 +0100
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
Subject: Re: [PATCH v7 1/3] watchdog: renesas_wdt: Add suspend/resume support
Message-ID: <20180301185155.hyp3ozumigstjsoe@katana>
References: <1519928243-28596-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1519928243-28596-2-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iq3fzocznd3sf6yp"
Content-Disposition: inline
In-Reply-To: <1519928243-28596-2-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--iq3fzocznd3sf6yp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 06:17:21PM +0000, Fabrizio Castro wrote:
> On R-Car Gen2 and RZ/G1 the watchdog IP clock needs to be always ON,
> on R-Car Gen3 we power the IP down during suspend.
>=20
> This commit adds suspend/resume support, so that the watchdog counting
> "pauses" during suspend on all of the SoCs compatible with this driver
> and on those we are now adding support for (R-Car Gen2 and RZ/G1).
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesa=
s.com>

I like it:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for keeping at this topic!


--iq3fzocznd3sf6yp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqYS8YACgkQFA3kzBSg
KbZg+Q//UHc1e22o+NTi2qkTlZz1e0Mqjuj91D7Ky321a7mPoExZM4e76C13P2g4
ecqANqrZL8cJfIbAdjdkHlApcQCNSwtyNoZp6FZEp1zi7WI/C/gNDjyQfmJdjGjz
6GhZmY3TJKx6Gx63o00u9uWdRTSaL6dX+el7gE5hHwlyIaXwRSUSsGhX0tjiomt6
+Wd0CLALRtWglbaLXuXGz1oP8Pi8pUyvQe66GKzgNIKPgJ9Ad9EdWYhDq0BeHl3f
mgf/3trYnLuWnpzW/E4wYIldtoP1C55WmDpIScx5UF/e/bVLQrPf/B6SKSDY0Fq6
28+SeeskWVOrclGeu7rkcFV6meedLlUxovBmQrUeN0nG1+aBclyfgL3fY+8FQqMD
yJaezFnA6Zf/2wtnXzYUBFg0nWH+VHd1qSGmZWVU9SAmzFUQ3lQWD09eeJqVUbNA
4SNRL/o+S9lLgstbJg6gT5RcDxgIJt2oUt0KaouNHYMTIcHqCZWW/dM4lwCGJTAR
z1Qt0RpiN+qfEk1VRWDU03qkICnfisX3Nf1ju8wi6MPEs3oA+KFw5Ndl2DIhH30f
wUxLb9Ij+TOt7z75hc96PmBUncptH9UDlDEIT1SRpezHeAqjX2+RIFN4Fzsxo2ki
LlJeufyyJBCZVaoh+nGA/Gqg8o557yBa3ENN5P5973qnPc9ibNo=
=+SFY
-----END PGP SIGNATURE-----

--iq3fzocznd3sf6yp--
