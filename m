Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37024 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156Ab2CNSkg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 14 Mar 2012 14:40:36 -0400
Date: Wed, 14 Mar 2012 19:40:33 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH 3/4] watchdog: dev: don't enforce set_timeout()
Message-ID: <20120314184033.GA20092@pengutronix.de>
References: <1328204891-32551-1-git-send-email-w.sang@pengutronix.de>
 <1328204891-32551-4-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <1328204891-32551-4-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2012 at 06:48:10PM +0100, Wolfram Sang wrote:
> Some watchdogs rewrite the timer on every ping, so they don't need a spec=
ific
> set_timeout callback. Allow the callback to be empty for such devices.
>=20
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Wim, I saw that the first two patches are in linux-next, but not this and t=
he
following one? Any remarks?

Thanks,

   Wolfram


> ---
>  .../watchdog/convert_drivers_to_kernel_api.txt     |   10 ++++++----
>  Documentation/watchdog/watchdog-kernel-api.txt     |    4 +++-
>  drivers/watchdog/watchdog_dev.c                    |   11 ++++++-----
>  3 files changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/watchdog/convert_drivers_to_kernel_api.txt b/D=
ocumentation/watchdog/convert_drivers_to_kernel_api.txt
> index be8119b..25647a3 100644
> --- a/Documentation/watchdog/convert_drivers_to_kernel_api.txt
> +++ b/Documentation/watchdog/convert_drivers_to_kernel_api.txt
> @@ -51,10 +51,12 @@ Here is a overview of the functions and probably need=
ed actions:
>  		set
> =20
>  	WDIOC_SETTIMEOUT:
> -		Options in watchdog_info need to have WDIOF_SETTIMEOUT set
> -		and a set_timeout-callback has to be defined. The core will also
> -		do limit-checking, if min_timeout and max_timeout in the watchdog
> -		device are set. All is optional.
> +		Options in watchdog_info need to have WDIOF_SETTIMEOUT set. The core
> +		will also do limit-checking, if min_timeout and max_timeout in the
> +		watchdog device are set. By default, the timeout variable of the
> +		watchdog device will simply get updated. Additionally, a
> +		set_timeout-callback can be defined if further actions are needed
> +		(e.g. hardware setup, more advanced checks). All is optional.
> =20
>  	WDIOC_GETTIMEOUT:
>  		No preparations needed
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentati=
on/watchdog/watchdog-kernel-api.txt
> index 4b93c28..dcf1cfe 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -121,7 +121,9 @@ they are supported. These optional routines/operation=
s are:
>    value of the watchdog_device will be changed to the value that was jus=
t used
>    to re-program the watchdog timer device.
>    (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
> -  watchdog's info structure).
> +  watchdog's info structure. If it is set, and no set_timeout function is
> +  provided, only the update of the timeout value will happen. This is en=
ough
> +  if the ping of the watchdog will rewrite the timer anyway.)
>  * ioctl: if this routine is present then it will be called first before =
we do
>    our own internal ioctl call handling. This routine should return -ENOI=
OCTLCMD
>    if a command is not supported. The parameters that are passed to the i=
octl
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_=
dev.c
> index 1199da0..ec224b4 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -215,17 +215,18 @@ static long watchdog_ioctl(struct file *file, unsig=
ned int cmd,
>  		watchdog_ping(wdd);
>  		return 0;
>  	case WDIOC_SETTIMEOUT:
> -		if ((wdd->ops->set_timeout =3D=3D NULL) ||
> -		    !(wdd->info->options & WDIOF_SETTIMEOUT))
> +		if (!(wdd->info->options & WDIOF_SETTIMEOUT))
>  			return -EOPNOTSUPP;
>  		if (get_user(val, p))
>  			return -EFAULT;
>  		if ((wdd->max_timeout !=3D 0) &&
>  		    (val < wdd->min_timeout || val > wdd->max_timeout))
>  				return -EINVAL;
> -		err =3D wdd->ops->set_timeout(wdd, val);
> -		if (err < 0)
> -			return err;
> +		if (wdd->ops->set_timeout) {
> +			err =3D wdd->ops->set_timeout(wdd, val);
> +			if (err < 0)
> +				return err;
> +		}
>  		wdd->timeout =3D val;
>  		/* If the watchdog is active then we send a keepalive ping
>  		 * to make sure that the watchdog keep's running (and if
> --=20
> 1.7.8.3
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9g5iEACgkQD27XaX1/VRuBlQCeMPSNNt0SdOAW5FWURDV4xdXF
Tg0An3F5nMg7HMZ0Z9Kfb9rR+psYVNtE
=6QmW
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
