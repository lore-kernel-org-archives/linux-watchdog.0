Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:38108 "EHLO
	imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932718AbcAYQR3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Jan 2016 11:17:29 -0500
Date: Mon, 25 Jan 2016 16:17:26 +0000
From: James Hogan <james.hogan@imgtec.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Wim Van Sebroeck <wim@iguana.be>,
	<linux-arm-kernel@lists.infradead.org>,
	Andrew Bresticker <abrestic@chromium.org>,
	Naidu Tellapati <naidu.tellapati@gmail.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Guenter Roeck <linux@roeck-us.net>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog: imgdpc: select WATCHDOG_CORE
Message-ID: <20160125161726.GB23845@jhogan-linux.le.imgtec.org>
References: <1453737991-1960626-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <1453737991-1960626-1-git-send-email-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2016 at 05:06:27PM +0100, Arnd Bergmann wrote:
> The imgpdc_wdt driver can be built on all architectures with
> CONFIG_COMPILE_TEST, but fails if no other watchdog driver is
> enabled:
>=20
> drivers/watchdog/built-in.o: In function `pdc_wdt_remove':
> imgpdc_wdt.c:(.text+0x74): undefined reference to `watchdog_unregister_de=
vice'
>=20
> This adds the normal 'select WATCHDOG_CORE' that is needed to
> ensure the driver always builds cleanly.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  drivers/watchdog/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 4f0e7be0da34..0dc61f1a552e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1383,6 +1383,7 @@ config IMGPDC_WDT
>  	tristate "Imagination Technologies PDC Watchdog Timer"
>  	depends on HAS_IOMEM
>  	depends on METAG || MIPS || COMPILE_TEST
> +	select WATCHDOG_CORE
>  	help
>  	  Driver for Imagination Technologies PowerDown Controller
>  	  Watchdog Timer.
> --=20
> 2.7.0
>=20

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWpkqWAAoJEGwLaZPeOHZ6I4oP/iAI0Vf3VpRPQ4lrej8zt04n
jiFSRkfC4Ee1NFcrSMO/dRXZqag18A00fHdkRpPp+GZXWxwkvvXPA6gpzxM60ywh
9RQOofdvIt85P24yGXWxxT/qg+vz/9APZCxzmjKJfUDxX5e0QjqA3XcYZWmx5JF7
U6lBRP+IfRQF/QGh2N26SSNEsarkHbxQwJJ7C/W1ss3PcZwa8+JxmBB/PuETFMhO
h9SEttPpsZ1Ild+Tske1gFM0nCq6EiLU0DtD2qnyR3ssCMnW0wx2MFwTF5EC+IhT
GJbmMXeLCiew7amlmuXa43HQgJpCgjgywi2fnKORoo3VF8i4oSMljmW8/hKI1Hx1
ZWT4A9GpJwuVurdNnIojJMiaHzQ+yieg1bqHgeMISOtO0MpQcrSgzKzDNaXTBPL7
hQJAauTZzA7hJthUeLthXuywthHkjuGpbcdERK+eU71EhN4kvET7jgWSWY8NvZnt
+ZNTbh7UhvHbSzsTSec4Zmcx/HZsLucqZI9AzLiN/p+BAmiVQZq5WkNt+Ojp1zEk
z/aaVdtoGdoc5M56yNENi7NMc8/w/Bxc4eW+wor2ZLEdwmrdFwZQXsGNzmbUMvwJ
O51xJvOTo3Xt5IJGKWQu6wAlS33quNJCPR0nrKKZ6GEsEHQ3rPZUg4QXhCnZZneG
13gvp1sAbcSgQJSQNOaB
=4Fob
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
