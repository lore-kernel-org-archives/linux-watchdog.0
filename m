Return-path: <Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Bhumika Goyal <bhumirks@gmail.com>, "julia.lawall@lip6.fr"
	<julia.lawall@lip6.fr>, "wim@iguana.be" <wim@iguana.be>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"rjui@broadcom.com" <rjui@broadcom.com>, "sbranden@broadcom.com"
	<sbranden@broadcom.com>, "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, Support Opensource
	<Support.Opensource@diasemi.com>, "baruch@tkos.co.il" <baruch@tkos.co.il>,
	"manabian@gmail.com" <manabian@gmail.com>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] watchdog: constify watchdog_info structures
Date: Tue, 3 Jan 2017 13:51:54 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03370142A7539F@SW-EX-MBX01.diasemi.com>
References: <1482771911-13548-1-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1482771911-13548-1-git-send-email-bhumirks@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On 26 December 2016 17:05, Bhumika Goyal wrote:

> Declare watchdog_info structures as const as they are only stored in the
> info field of watchdog_device structures. This field is of type const
> struct watchdog_info *, so watchdog_info structures having this property
> can be declared const too.

> diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.=
c
> index 2fc19a3..d86a57e 100644
> --- a/drivers/watchdog/da9052_wdt.c
> +++ b/drivers/watchdog/da9052_wdt.c
> @@ -140,7 +140,7 @@ static int da9052_wdt_ping(struct watchdog_device
> *wdt_dev)
>  	return ret;
>  }
>=20
> -static struct watchdog_info da9052_wdt_info =3D {
> +static const struct watchdog_info da9052_wdt_info =3D {
>  	.options	=3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>  	.identity	=3D "DA9052 Watchdog",
>  };
> diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.=
c
> index 8377c43..4f30818 100644
> --- a/drivers/watchdog/da9055_wdt.c
> +++ b/drivers/watchdog/da9055_wdt.c
> @@ -108,7 +108,7 @@ static int da9055_wdt_stop(struct watchdog_device
> *wdt_dev)
>  	return da9055_wdt_set_timeout(wdt_dev, 0);
>  }
>=20
> -static struct watchdog_info da9055_wdt_info =3D {
> +static const struct watchdog_info da9055_wdt_info =3D {
>  	.options	=3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>  	.identity	=3D "DA9055 Watchdog",
>  };

For DA9052 and DA9055:

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
