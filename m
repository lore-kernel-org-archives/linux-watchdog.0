Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:33581 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbaEGLYt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 May 2014 07:24:49 -0400
Received: by mail-qa0-f41.google.com with SMTP id dc16so833778qab.0
        for <linux-watchdog@vger.kernel.org>; Wed, 07 May 2014 04:24:49 -0700 (PDT)
Message-ID: <536A17F6.3050006@monstr.eu>
Date: Wed, 07 May 2014 13:24:38 +0200
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>,
	'Wim Van Sebroeck' <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Michal Simek' <michal.simek@xilinx.com>
Subject: Re: [PATCH] watchdog: xilinx: Make of_device_id array const
References: <021701cf69d0$43674870$ca35d950$%han@samsung.com>
In-Reply-To: <021701cf69d0$43674870$ca35d950$%han@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tnmihPJ6jxJqfpIOiRQMvAmI3pIiVpcbT"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tnmihPJ6jxJqfpIOiRQMvAmI3pIiVpcbT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/07/2014 10:42 AM, Jingoo Han wrote:
> Make of_device_id array const, because all OF functions
> handle it as const.
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/of_xilinx_wdt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xil=
inx_wdt.c
> index 57ccae8..1e6e28d 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -225,7 +225,7 @@ static int xwdt_remove(struct platform_device *pdev=
)
>  }
> =20
>  /* Match table for of_platform binding */
> -static struct of_device_id xwdt_of_match[] =3D {
> +static const struct of_device_id xwdt_of_match[] =3D {
>  	{ .compatible =3D "xlnx,xps-timebase-wdt-1.00.a", },
>  	{ .compatible =3D "xlnx,xps-timebase-wdt-1.01.a", },
>  	{},
>=20

Reviewed-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--tnmihPJ6jxJqfpIOiRQMvAmI3pIiVpcbT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNqF/cACgkQykllyylKDCH5nwCfcoIx3HWp9FQmgfw6F8Y1vwqJ
MaEAn2aM4sLrS1+M0Z4FxjIkG/JAbMMX
=k01C
-----END PGP SIGNATURE-----

--tnmihPJ6jxJqfpIOiRQMvAmI3pIiVpcbT--
