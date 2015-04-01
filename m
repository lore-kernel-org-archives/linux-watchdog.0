Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:34319 "EHLO
	imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752431AbbDAWWV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Apr 2015 18:22:21 -0400
Date: Wed, 1 Apr 2015 23:22:18 +0100
From: James Hogan <james.hogan@imgtec.com>
To: Andrew Bresticker <abrestic@chromium.org>
CC: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Ezequiel Garcia" <ezequiel.garcia@imgtec.com>
Subject: Re: [PATCH V2 1/3] watchdog: imgpdc: Allow timeout to be set in
 device-tree
Message-ID: <20150401222218.GB13077@jhogan-linux.le.imgtec.org>
References: <1427910196-28568-1-git-send-email-abrestic@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <1427910196-28568-1-git-send-email-abrestic@chromium.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, Apr 01, 2015 at 10:43:14AM -0700, Andrew Bresticker wrote:
> Since the heartbeat is statically initialized to its default value,
> watchdog_init_timeout() will never look in the device-tree for a
> timeout-sec value.  Instead of statically initializing heartbeat,
> fall back to the default timeout value if watchdog_init_timeout()
> fails.

Whoops. Sorry about that. I wasn't aware that a timeout-sec value was
expected. It isn't mentioned in the DT binding documentation for this
device :-(.

>=20
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> ---
> New for v2.
> ---
>  drivers/watchdog/imgpdc_wdt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
> index 0deaa4f..89b2abc 100644
> --- a/drivers/watchdog/imgpdc_wdt.c
> +++ b/drivers/watchdog/imgpdc_wdt.c
> @@ -42,7 +42,7 @@
>  #define PDC_WDT_MIN_TIMEOUT		1
>  #define PDC_WDT_DEF_TIMEOUT		64
> =20
> -static int heartbeat =3D PDC_WDT_DEF_TIMEOUT;
> +static int heartbeat;
>  module_param(heartbeat, int, 0);
>  MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds "
>  	"(default=3D" __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
> @@ -195,9 +195,9 @@ static int pdc_wdt_probe(struct platform_device *pdev)
> =20
>  	ret =3D watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
>  	if (ret < 0) {
> -		pdc_wdt->wdt_dev.timeout =3D pdc_wdt->wdt_dev.max_timeout;
> +		pdc_wdt->wdt_dev.timeout =3D PDC_WDT_DEF_TIMEOUT;

The watchdog_init_timeout kerneldoc comment suggests that the old value
should be the default timeout, i.e. that timeout should be set to
PDC_WDT_DEF_TIMEOUT before calling watchdog_init_timeout, rather than
whenever ret < 0.

Indeed, if heartbeat is set to an invalid non-zero value,
watchdog_init_timeout will still try and set timeout from DT, but also
still returns -EINVAL regardless of whether that succeeds, and this
would incorrectly override the timeout from DT with the hardcoded
default.

>  		dev_warn(&pdev->dev,
> -			 "Initial timeout out of range! setting max timeout\n");
> +			 "Initial timeout out of range! setting default timeout\n");

It feels wrong for a presumably safe & normal situation (i.e. no default
in DT, which arguably shouldn't contain policy anyway) to show a
warning, but it can also show due to an invalid module parameter (or
invalid DT property) which is most definitely justified.

The caller can check (ret < 0 && heartbeat) to tell if heartbeat was
invalid, but unfortunately it can't easily tell if the DT property is
out of range rather than simply absent.

Cheers
James

>  	}
> =20
>  	pdc_wdt_stop(&pdc_wdt->wdt_dev);
> --=20
> 2.2.0.rc0.207.ga3a616c
>=20

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVHG+aAAoJEGwLaZPeOHZ6WDAQAIo5k89CQWqWlceGY1453sNU
4vbDZyCk51sCKsZ6xExpCqWEeHzkzncKDrSxy+rJOF/Jb2FH3TTFqajKDzlAfM+8
CwqkC7BAxucnnFTTe/cK1VkRZiP1JS8sjNHA+bP77hRL9/zmc4I1KOTirMht7lXt
TbUXGGF6PQkOZcDa5uCgt4xvfn5n9t8GjnaTGsobjILzawESX0DJtUQUIzwFj9Bn
bvBYnUOFaBMGzmpMDnedOPS7MxH3MEOlbApvf4KEGuIwFdytmSYvkjc72215oiUl
EiIYeul6uYkEZwPmOSjYMXBc+rTe3uEpWK5TxRWVJm381bQ3jIXbiWwK48gnKf3Q
Nl7QftY7s+cQGClEOzVWYUQS3fCcT0TrQHtwv/4VP0S3Oc5mC3/bMekVsUECgQP6
ihJ7L5G675bD/c0iRsmNEw0iQbXpBLRC1ky7ufGBFlDtNIMPNps96xx2VHrSinDi
cbbCKfj6bSZgYaNKqZ8cqaxVUwszU4N6aFIu7SbOkvw7yvDvdvJeflY6vAeJgQr2
luBimVhXIaAHLXXsqYWCbDi2t0ocv61kDnRm555DUCgYNVeWVEIfJCdMnfmH0f3P
yl6pMIacsZiMlMRH1Kf1IgRnz2fJdBZKE30UXZKg6lUjKmdfa0FGPvxlsVR3+Yk4
eAEjtprxbWndZ1M23Bhs
=InNA
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
