Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33610 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933643AbcIFJNP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 6 Sep 2016 05:13:15 -0400
Date: Tue, 6 Sep 2016 11:13:11 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Wim Van Sebroeck <wim@iguana.be>, kernel-janitors@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: tegra: constify watchdog_ops structures
Message-ID: <20160906091311.GD15644@ulmo.ba.sec>
References: <1472751326-22897-1-git-send-email-Julia.Lawall@lip6.fr>
 <1472751326-22897-2-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Content-Disposition: inline
In-Reply-To: <1472751326-22897-2-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2016 at 07:35:25PM +0200, Julia Lawall wrote:
> Check for watchdog_ops structures that are only stored in the ops field of
> a watchdog_device structure.  This field is declared const, so watchdog_o=
ps
> structures that have this property can be declared as const also.
>=20
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct watchdog_ops i@p =3D { ... };
>=20
> @ok@
> identifier r.i;
> struct watchdog_device e;
> position p;
> @@
> e.ops =3D &i@p;
>=20
> @bad@
> position p !=3D {r.p,ok.p};
> identifier r.i;
> struct watchdog_ops e;
> @@
> e@i@p
>=20
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct watchdog_ops i =3D { ... };
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
>  drivers/watchdog/tegra_wdt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzoinAAoJEN0jrNd/PrOhrMQQAIVqHIuEAicJcJ4m90FFH2Qa
q9cx/e8JFfl0RCFEdvYsKO3TOfJuYDfnkvBUx8ieIJCELGTuy5i/w/oDpq+eXcm2
T1zxYqAFZhMViDjDJE83vNh9AvXMa29LfpLBHW2gYvl103cHxz2UPivWGsVqLzP4
ImMG1QfiC8fSRdPqcGEftjH+RJUuMEWYkCNJayMFNSzukOAFVhezV6Jqq8RyTgHA
ZfRV2eGO15OMQRWzEAiQuyL21T+wbw1Pvz6dzkDkTG8aK96Ytex+TjdYoprewFYF
7kjiOHGaqyUjDPTaZ8le6RBQwUeygdRF2k4vb4MUgIPjJhgnFofXwd3u+gkxDHqs
G5E+DFh21b+iNGFTXUOle0SL/aPuL2f3kbYJlrNX7uPlGx2ZqwlzhvrP4dJzuakZ
bQkdlz3grTl0ip+7ktyIkxJXEorNASUzoaaBz3x2ChSqzKl76gEoJ0axmLgp2rkh
azpwPvHW3lhKyfQfQvHX5CnLC2Ky6focMNx2nJ5HQKzDMz8oSpfLCw25lAKVzbzD
StzItthk8sHneQ/PCtZW7WAhbXjTiMv7Ji8CgUoyY2I/V9UHLstHRztxI4KW7AIR
VH7YaoQqJCyS8sdIrucH738+hNXy/+rjAbRmbCxkD33y0aPgiYPGyGw+7htV58vk
q83juYV9gXwHuxvtFr7c
=n4Zm
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
