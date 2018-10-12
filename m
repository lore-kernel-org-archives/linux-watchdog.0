Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42746 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLSPE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 12 Oct 2018 14:15:04 -0400
Date: Fri, 12 Oct 2018 12:43:12 +0200
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
Subject: Re: [PATCH v7 16/24] pwm: jz4740: Add support for the JZ4725B
Message-ID: <20181012104312.GJ9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-17-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-17-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 07:16:27PM +0200, Paul Cercueil wrote:
> The PWM in the JZ4725B works the same as in the JZ4740, except that it
> only has 6 channels available instead of 8.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>      v5: New patch
>    =20
>      v6: - Move of_device_id structure back at the bottom (less noise in
>            patch)
>          - Use device_get_match_data() instead of of_* variant
>    =20
>      v7: No change
>=20
>  drivers/pwm/pwm-jz4740.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAesAACgkQ3SOs138+
s6FK7g//XMqm9tY/j9ebBHkmvyejEcCSzNYK6TscB0/JcxIikY5BBEPT3Zu4yk5K
jvy11nwiuGXxqeoCCvrprgWlMskRbB0vfjaXbkbium0WtcDWECGAD2q0PQ61wT2Q
HwtIecyTHVHp5vTht3FuqhRW/ISdQo/h4aN54HiX3GTvFEPXIobrW/52smXWIGLw
BBE0fz2a94H3zVewmeiqwzViQAfBTT3FqKl13AH0iAfmfT3mjgxsPgnnCGmQo9gc
zt8cvqS9LAPy1cw07bFfiyPGVn3DL4KhlybPi2NTOn+zGKIMJeza0iYKpyh/PcGX
xMgk1VSLKNFQTITXllRnw69ad9QfW2hs3kHqy1W3oTaQe7VmXuUAS0LlFkX4WRG7
vhnwdCZVlGjpdzmt9IduRBUBhZuTkqNLdzF4WhoeQjEeohvmmvKFGjy5OwMw0F9Y
pDYjp0bfECwQNKynPVF+pPSw7B3nh1D97o5VGZGILYXYFIE5MlKOXqMVXpSd2HIj
NmjziYKpPZk6auyQlbdsijlZ/jra0RYGvLdi8bWBJVbpo4IqC9iFjtC4/9vJ0m+R
YLwQlJoZGqRKCVpwdQKDEEBx+4bQxdQcQJZrYueZXMCRIimzWC2H2cmxKpRWdjqw
mokR4lpnDhHpADP3A7wPVKCvMoJn39U1saRvscYMRxkH8cV1J9g=
=OX+r
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--
