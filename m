Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:54888 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032742AbeCARNS (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Mar 2018 12:13:18 -0500
Date: Thu, 1 Mar 2018 18:13:16 +0100
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
Subject: Re: [PATCH v6 2/3] watchdog: renesas_wdt: Add R-Car Gen2 support
Message-ID: <20180301171316.bqo3pegczv7dfgjh@katana>
References: <1519919048-21884-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1519919048-21884-3-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uhgphpwwhmbbgrsk"
Content-Disposition: inline
In-Reply-To: <1519919048-21884-3-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--uhgphpwwhmbbgrsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 03:44:07PM +0000, Fabrizio Castro wrote:
> Due to commits:
> * "ARM: shmobile: Add watchdog support",
> * "ARM: shmobile: rcar-gen2: Add watchdog support", and
> * "soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2",
> we now have everything we needed for the watchdog to work on Gen2 and
> RZ/G1.
>=20
> This commit adds "renesas,rcar-gen2-wdt" as compatible string for R-Car
> Gen2 and RZ/G1.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesa=
s.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--uhgphpwwhmbbgrsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqYNKwACgkQFA3kzBSg
KbafYg/+KYhA+kZ9sohBaByDvV4qu1BQVFRC9sM7uBzcw4prQ6vMYPaDfpQPC8v3
5IKaGY/bcOmSvrFx+3j/8cdGynwSj14vYaC40T14iKy+UWxhnQCM6rF+SadH6DME
0G95a9ZAKZWiS7gh98/quK8nr3nR9zcFvdRzKZgPutOaSvQjxLZ0VnNs+sNW3POP
SgfGwiq7DEWQ+GDF/V0GzfBGQ1nepVeZnlC19qLBgMB1biPJvZIp9OsH5ixpjTQE
NNdYcpnMjTCv/xNXgPRrEWhk2AKFVMt2A2S/5TxtJDMNVUJE9u9HdEeCUE6g9SmR
d1RdllCu6zu3/PxL4nw6MECE0BZQRNbgHvmqJhwp0k05rvv8qc5DzAbOo8LNni9J
55LtDiZNmR2bleHxIbIIIFcU9lAGPAiEuLZf+MXypaVOeuCPo6dWjpqsXJwo2swL
F5WCVsjcQ33BWjxvrqc6NiWEbCaqqzOxJyl3kng7djNqBXLTxvISr2ahn0TKJ9J8
f/FVcsWmPNbyABDsb8pa/snRQu+2x/WsMgiedSgjRT79NsoTng0qR3RTOOTK7enw
v7QNDmTmUnDCFqnczinsNXji3YBswxVpm2oFYz3MYMw8z3lmUw797gheW2+7zNcL
tDLyGXBQrR8BE27gTi0hh1EroO9mah+jwi7xip2yQlhWNs2x3qQ=
=ZZ7m
-----END PGP SIGNATURE-----

--uhgphpwwhmbbgrsk--
