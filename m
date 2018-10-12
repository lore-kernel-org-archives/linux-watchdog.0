Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37207 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeJLSNm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 12 Oct 2018 14:13:42 -0400
Date: Fri, 12 Oct 2018 12:41:50 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 14/24] pwm: jz4740: Drop dependency on MACH_INGENIC,
 use COMPILE_TEST
Message-ID: <20181012104150.GH9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-15-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-15-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 07:16:25PM +0200, Paul Cercueil wrote:
> Depending on MACH_INGENIC prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
>=20
> On other architectures, this driver can still be built, thanks to
> COMPILE_TEST. This is used by automated tools to find bugs, for
> instance.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>      v5: New patch
>    =20
>      v6: No change
>    =20
>      v7: No change
>=20
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAem4ACgkQ3SOs138+
s6G1TRAAux8060Bb39lvD0m2DyAcY+wj728JjVVoR4ewIrMKra16L/zRXspBZiK5
NE29yVOUrXx3h/C0/JD5zNTx7b6LajBoTYJ48FS2UVh3u04rky6MLHCyH97SnIA7
WKt+PWrDi5pXZ5ooh6tNURClbe5iETYuVjjXudUFjVtNC0ptAEaY9PvX7HrlcB0R
Eu1OUbp0k/RBhktlJJPkX/K/NqpBhncHo1GqHa2SRKf7+xkLia3V2SrszJC4q/g/
EtLjaOrsOjHkcolpePxX9Gc1V52Jpy6yDuB/TSmsAAkZGLbUBDZWh5VH21XJlbBZ
EDC28EJRnPDp3L6i9S2Kpy2anUNFblez+DAYY+takC3q/B+pKs/z4crRI9EwcVBA
AQFDwWbovRGB0Ery54rZSUYIOBKclO1hlBbMYROpd7bsadsA/PE4VtjGjrlkSJhz
GDF3anIdsvB5h23zZySwW3rOAKr8hGehlrWWu9tPCxacnKLZavMOHOThSDG2St9v
60glgFNZCH86gcJ47HOgg3pr+xejpvwF9s85dN378nNIqxiMEPiF6rrvELG+YzFp
Tv89gFw+06At4es9Gh+BlTqwYoiNGuIakwJHKoczVXCKxRThMiLkrjzhpomgh28y
x9DLbMSigzYstEPL1Q/VlRZGEYWRRa/vCWqu9Y0RMSSxnmMSLkc=
=ywfF
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--
