Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51436 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLSLt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 12 Oct 2018 14:11:49 -0400
Date: Fri, 12 Oct 2018 12:39:57 +0200
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
Subject: Re: [PATCH v7 12/24] pwm: jz4740: Use regmap and clocks from TCU
 driver
Message-ID: <20181012103957.GF9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-13-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-13-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 07:16:23PM +0200, Paul Cercueil wrote:
> The ingenic-timer "TCU" driver provides us with a regmap, that we can
> use to safely access the TCU registers.
>=20
> It also provides us with clocks, that can be (un)gated, reparented or
> reclocked from devicetree, instead of having these settings hardcoded in
> this driver.
>=20
> While this driver is devicetree-compatible, it is never (as of now)
> probed from devicetree, so this change does not introduce a ABI problem
> with current devicetree files.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>      v5: New patch
>    =20
>      v6: Drop requirement of probing from devicetree
>    =20
>      v7: No change
>=20
>  drivers/pwm/Kconfig      |   2 +
>  drivers/pwm/pwm-jz4740.c | 124 +++++++++++++++++++++++++++++++----------=
------
>  2 files changed, 83 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a4d262db9945..58359bf22b96 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -202,6 +202,8 @@ config PWM_IMX
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MACH_INGENIC
> +	depends on COMMON_CLK
> +	select INGENIC_TIMER
>  	help
>  	  Generic PWM framework driver for Ingenic JZ47xx based
>  	  machines.
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index a7b134af5e04..1bda8d8e9865 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -14,21 +14,21 @@
>   */
> =20
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>

Why do you need this?

Thierry

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAef0ACgkQ3SOs138+
s6Etkw/8CDqjDhw3dT5o3iLxU8WHHcL1syZVxtoMp8myKzUL83S+RIRFfWhrXYrg
0GoMLZCuuq5YQAFmH2IyOrcyQNP8za88WJmW6ahO5rUj2dToorEqD2kijC8Z1YY4
gJBm2OpTKROOUoZdP3fUkcLsJradOzua+wrzHeKkIOwleWWIRC4yXnfkPSlvYdAH
0ul5Nhteg6ulN25WE8uPEFGqWPgMAA0+tU64/COQ4V9Yg7P5YJbERNax72Dm7v0N
eIppDnmtbVtt+SvJ+QAM8NgZogMhJnkdf8T7Ax8UPGMG6JSxmVsSz0hCMB5IVenF
Lfp5u68cXO6hxyhku3ss4nthU8QMprEsM55chBEHvXyH7+4IsB6U+WEfc5tGxxN+
AJcQgan0mRO179DjdCYtxcELpJVRLglzhpjTIJisip+Kp0WtxJPd7wYtovMVlEHl
VyqEXCearUquqFdJ3R20ZN5sUanv5miTaK9QpNYdQrkCv9t3/KK5KdutUZDpyDD7
3kubTcLr4W3cSqwrq2GJF6KV+9b6VdLUeZgmPHvAj/81pfHFb3j7Q9gmjJLgGgBr
tVNXoCLSOaWWya9qrLPeKoZmm90zG3NpEoyExycPdai8qDGLIuhOspNZ7SG/ixFw
eKm2sG95UCmCkGVSaIUVTZRgslDEv63kjKKG6qoza9kEMRjmqCg=
=TBBW
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
