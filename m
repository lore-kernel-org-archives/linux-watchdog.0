Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:46889 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbdKIHxh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 9 Nov 2017 02:53:37 -0500
Date: Thu, 9 Nov 2017 07:47:19 +0000
From: James Hogan <james.hogan@mips.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 2/3] watchdog: jz4780: Allow selection of jz4740-wdt
 driver
Message-ID: <20171109074718.GR15260@jhogan-linux>
References: <20170908183558.1537-1-malat@debian.org>
 <20170908183558.1537-2-malat@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eLe8FOcWSbbyMVJD"
Content-Disposition: inline
In-Reply-To: <20170908183558.1537-2-malat@debian.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

--eLe8FOcWSbbyMVJD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wim,

On Fri, Sep 08, 2017 at 08:35:54PM +0200, Mathieu Malaterre wrote:
> This driver works for jz4740 & jz4780
>=20
> Suggested-by: Maarten ter Huurne <maarten@treewalker.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

I just noticed that though Ralf applied the other two patches in this
series (defconfig + dt), he hadn't applied this patch.

Please can we have an ack from a watchdog maintainer so this can get
into 4.15 via the MIPS tree? It could alternatively go via the watchdog
tree if you prefer.

Thanks
James

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c722cbfdc7e6..ca200d1f310a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1460,7 +1460,7 @@ config INDYDOG
> =20
>  config JZ4740_WDT
>  	tristate "Ingenic jz4740 SoC hardware watchdog"
> -	depends on MACH_JZ4740
> +	depends on MACH_JZ4740 || MACH_JZ4780
>  	select WATCHDOG_CORE
>  	help
>  	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoC=
s.
> --=20
> 2.11.0
>=20
>=20

--eLe8FOcWSbbyMVJD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloEB/0ACgkQbAtpk944
dnqjVA/+NBFJj9xGzjZBF7j8SB64O6oIE+ZUb3J6D3PwsWW/jOfxiEPPz7pQmZQ0
BNkL5TGx2K/kb+TW3qpc5H/80q3WlZzU6Z6XV/gC7JR3SEfuguJxZ7tsavWUsyJD
g0nWcyb8x6usMvHLQFwDWPApkak4XvLp7p9EkeBrAPGlMeveJAbxBWCwywG92dg3
BiaVP9JkOV/tz1c4I33vnDKGNedBqPRjrLKcdKqnzddaHXKyaAtoGiLl6UkcaNMb
l0yuOzz2NVLIuML7dzkYbiqsCoBjOMQo8QI8HOaGFkc+qvZLYJ5f5gDQ2CD8gERU
mDG52f9xueoHIQIdQ3exAHVrudRrwNXLDaZ7IChj3tert96QWkqeB+zBKpEBpgth
ojwM7mvSeiX02EPLW5iQCJQejKw/dydN4xWEZHJdGQtCZZXOl3MpVQlrioyJTBzM
PZIS1XYJpAurF4Ve63s/KcgFOHR0zGSnQMa9ZIov1OlcS9vXOuwM49Dyr3EgjcJC
lIE1EKTSnfoPSM0o9ft0U6m+ve9IUPcVCfmIm2433N9VPPL9f/WyTDR01D9tXXv3
EmcV7JU4rHhc2X+y4Jy0tnAsI1iN/sT8VdxoH1D8Ab+4q7MgBNpEHmq84e0rVv5n
uugOr6IvWBb/rQprex7mL2Tq3KLlF8ZT1DSH5oXVugQSDgTQUgU=
=UwIM
-----END PGP SIGNATURE-----

--eLe8FOcWSbbyMVJD--
