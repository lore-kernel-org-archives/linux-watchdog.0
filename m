Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45870 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbcJ1R7n (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 28 Oct 2016 13:59:43 -0400
Date: Fri, 28 Oct 2016 18:59:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Message-ID: <20161028175918.tb4ntnelofse7kjf@sirena.org.uk>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
 <c8529abdbe8a07ac0d7b09ab24fad73ab56116be.1477501000.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7qsjzthrt7pfq7qy"
Content-Disposition: inline
In-Reply-To: <c8529abdbe8a07ac0d7b09ab24fad73ab56116be.1477501000.git.stwiss.opensource@diasemi.com>
Subject: Re: [PATCH V2 06/10] regulator: da9061: BUCK and LDO regulator driver
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--7qsjzthrt7pfq7qy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 26, 2016 at 05:56:38PM +0100, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> Regulator support for the DA9061 is added into the DA9062 regulator drive=
r.
> =20
> The regulators for DA9061 differ from those of DA9062.
> A new DA9061 enumeration list for the LDOs and Bucks supported by this
> device is added. Regulator information added: the old regulator
> information for DA9062 is renamed from local_regulator_info[] to
> local_da9062_regulator_info[] and a new array is added to support
> local_da9061_regulator_info[].

Acked-by: Mark Brown <broonie@kernel.org>

--7qsjzthrt7pfq7qy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYE5H2AAoJECTWi3JdVIfQVxkH/jkLzUk7fRE29zqArap+RyWE
pjNSKx51EbFFtj84+HxyQAaVq8gEh9g2X6SGh/fBGb752qyYwdJPIGCS/+2eMVZO
OpIT3J2jF/Ur4WR7+zm8Uwfe0uXj+xLEI8Se0kZa23Bwmrz0ghLb57SODoGlLDma
rXqe7rNpQg9N5wovZGsg/Jc8j1M4bwzSyPmJRVAfDlQ4rt16+DshORLaZtfRE//Q
QHmxZzMOeC1CngeAZBqfI3CH1YOPvG2xn7ghu4LWDRiK48sZMVCT25c9SuPF5cow
UGXwTUGCRWOSNcJeW4/PDpVikEKo/Y91QY+6hCk4jLzhM+kniMh5IRk8nH72tBM=
=Ad0J
-----END PGP SIGNATURE-----

--7qsjzthrt7pfq7qy--
