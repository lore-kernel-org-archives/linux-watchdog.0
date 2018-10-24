Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35662 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeJXVpa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 24 Oct 2018 17:45:30 -0400
Date: Wed, 24 Oct 2018 14:17:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH v4 4/8] regulator: stpmic1: add stpmic1 regulator driver
Message-ID: <20181024131716.GQ2103@sirena.org.uk>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-5-git-send-email-p.paillet@st.com>
 <20181019115015.GC5895@sirena.org.uk>
 <5BD06B96.3080809@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yFH6hwN92mUA4HK5"
Content-Disposition: inline
In-Reply-To: <5BD06B96.3080809@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--yFH6hwN92mUA4HK5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2018 at 12:54:46PM +0000, Pascal PAILLET-LME wrote:

> I'm sorry, I'm not sure to understand. Would you prefer to not register=
=20
> regulators that
> are not described in the device-tree ?

No, I'm saying register all regulators regardless of if they are in the
device tree - you shouldn't be looking at the init data at all here,
just let the framework match them using of_match.

--yFH6hwN92mUA4HK5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvQcNgACgkQJNaLcl1U
h9CvFQf8Czl2zAXmxAqiGUYNP76+JwWwgghhHVahho872+7g8JBFyzQdqgCk0s0L
js7GKFtIuTp5nX5zI+RciHNZK2rYjqCJ+WMFm0eLrdSXVjBWcFLh/FlnIGDNDYly
gnTcEk3DJQX/fo21bBUAysMBY/e0lYMZZuTIwsYle3I3XIrQFQUfb+EWBdLcV6jJ
2Z4x0bPBSSHIJUVtOaKexxR2WjqP5hBU8IjgfFuzpTG8JTH/OSp2M4MxzSbRBBP5
KCN1SqIWOI1vMUgsx/wagQ9agW9v23CIKy0+k+7zejMbrokDJx2XgPODUbXr6EXp
zHXVPpbuRtuAiVJD3XoKwpKEiqVCSw==
=sJkh
-----END PGP SIGNATURE-----

--yFH6hwN92mUA4HK5--
