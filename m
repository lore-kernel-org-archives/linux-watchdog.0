Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32805 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbbEDVSG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 May 2015 17:18:06 -0400
Subject: Re: [PATCHv7 1/8] watchdog: Extend kernel API to know about HW limitations
To: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
references: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <1429701102-22320-2-git-send-email-timo.kokkonen@offcode.fi>
Cc: Wenyou.Yang@atmel.com
From: Marc Kleine-Budde <mkl@pengutronix.de>
message-id: <5547E1FA.1070301@pengutronix.de>
Date: Mon, 4 May 2015 23:17:46 +0200
mime-version: 1.0
in-reply-to: <1429701102-22320-2-git-send-email-timo.kokkonen@offcode.fi>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PavtEjj6dgmpxmxP86X2jelDKO2P7xNov"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PavtEjj6dgmpxmxP86X2jelDKO2P7xNov
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/22/2015 01:11 PM, Timo Kokkonen wrote:
> There is a great deal of diversity in the watchdog hardware found on
> different devices. Differen hardware have different contstraints on
> them, many of the constraints that are excessively difficult for the
> user space to satisfy.
>=20
> One such constraint is the length of the timeout value, which in many
> cases can be just a few seconds. Drivers are creating ad hoc solutions
> with timers and workqueues to extend the timeout in order to give user
> space more time between updates. Looking at the drivers it is clear
> that this has resulted to a lot of duplicate code.
>=20
> Add an extension to the watchdog kernel API that allows the driver to
> describe tis HW constraints to the watchdog code. A kernel worker in
> the core is then used to extend the watchdog timeout on behalf of the
> user space. This allows the drivers to be simplified as core takes
> over the timer extending.
>=20
> Tested-by: Wenyou Yang <wenyou.yang@atmel.com>
> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
> ---
>  drivers/watchdog/watchdog_core.c | 101 +++++++++++++++++++++++++++++++=
++++++--
>  drivers/watchdog/watchdog_dev.c  |  75 ++++++++++++++++++++++++++---
>  include/linux/watchdog.h         |  23 +++++++++
>  3 files changed, 189 insertions(+), 10 deletions(-)
>=20
[...]

>  static int watchdog_set_timeout(struct watchdog_device *wddev,
>  							unsigned int timeout)
>  {
> -	int err;
> +	int err =3D 0;
> +
> +	if (wddev->hw_max_timeout) {
> +		int hw_timeout;
> +		/*
> +		 * We can't support too short timeout values. There is
> +		 * really no maximu however, anything longer than HW
> +		 * maximum will be supported by the watchdog core on
> +		 * behalf of the actual HW.
> +		 */
> +		if (timeout < wddev->min_timeout)
> +			return -EINVAL;
> +
> +		mutex_lock(&wddev->lock);

The locking in this function looks weird.

> +		if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
> +			err =3D -ENODEV;
> +			goto out_timeout;
> +		}
> +
> +		if (timeout * HZ > wddev->hw_max_timeout)
> +			schedule_delayed_work(&wddev->work,
> +					wddev->hw_heartbeat);
> +
> +		hw_timeout =3D min(timeout, wddev->hw_max_timeout / HZ);
> +		if (wddev->info->options & WDIOF_SETTIMEOUT)
> +			err =3D wddev->ops->set_timeout(wddev, hw_timeout);
> +
> +		if (hw_timeout < timeout)
> +			wddev->timeout =3D timeout;
> +
> +		goto out_timeout;
> +	}
> =20
>  	if ((wddev->ops->set_timeout =3D=3D NULL) ||
>  	    !(wddev->info->options & WDIOF_SETTIMEOUT))

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PavtEjj6dgmpxmxP86X2jelDKO2P7xNov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVR+H6AAoJECte4hHFiupUwAUP/jbjv20TIq8qg4gU+KESehMk
50PL9PjSmvDXsUDOBt2da1KzfDEa9dXRXswtFAlLT6Mc1bsQmyOZcsyWXQWfqYd3
SeJoEBpLKAJlzDeMbM9+1VZeL4NSPYH8JmtVnMOWgOpDwgoDHwv9XNLe/xCZqw7a
HqWPN85pqqjICNEoSS8Gc2/zX3yfdIl69ZA485Wl/1dKPcBI2HfyP9yNYqmvvGKg
zooTtIBsQDs4HBbK44ZCXcsGTUtAX1iervZdBGLhWEwd3C2zJqF5S4eq1ul30CAJ
B8BAAxW7DR5qlNYIGFAAyZ7PGDS5v2lGL3XWbQnNnOnKAyhbREApAjcvPejENgaB
kDhWCwj13QWuGGBvKqRzPSQCesnZjee0p9O37ANp5jJBIZnJydQgmUHDK4BTdIkO
qyX0mHx4Rv2iNhaCMoHzo8gGeVNyjDgLootS706iew0niOsoe0/6cwKYg6G3lbQc
Bm/f2kl6TYIzNdx/dD/P/mUhuB82fcOlKtNWEIlbB2JWV7ujBx66jtyhMxG9YdOk
UmS1p4+lS69vjch8tYJsYYgl+ykIgOLkiOQGz0Gktx3v9DRy74sANHXoBAn7HYR5
Pi+evQedt7JZoWwT8DuF+y9S7lwb9DGlmheTRES0hh8bAzCrUdN5L3mtovkIEmSf
wrnLd0sX1YRQiI6tkKlo
=2oVK
-----END PGP SIGNATURE-----

--PavtEjj6dgmpxmxP86X2jelDKO2P7xNov--
