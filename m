Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49063 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756687Ab2CGQmw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 11:42:52 -0500
Date: Wed, 7 Mar 2012 17:42:40 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] watchdog/coh901327: convert to use watchdog core
Message-ID: <20120307164240.GA1130@pengutronix.de>
References: <1331131929-22383-1-git-send-email-linus.walleij@stericsson.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <1331131929-22383-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

> -static long coh901327_ioctl(struct file *file, unsigned int cmd,
> +static long coh901327_ioctl(struct watchdog_device *wdt_dev, unsigned in=
t cmd,
>  			    unsigned long arg)
>  {
>  	int ret =3D -ENOTTY;
>  	u16 val;
> -	int time;
> -	int new_options;
>  	union {
>  		struct watchdog_info __user *ident;
>  		int __user *i;
>  	} uarg;

'uarg' is nice name for the union ;) You probably don't need that anymore.
If we keep the ioctl, that is, because...

=2E..

>  	case WDIOC_GETTIMELEFT:
>  		clk_enable(clk);
>  		/* Read repeatedly until the value is stable! */

I was wondering if it pays to put this IOCTL to watchdog_dev and add another
callback to watchdog_ops? I'd think so. Wim, Linus, what do you think? We d=
on't
save much (yet?), but since this is part of the kernel-API it might be nice=
 to
have the common part centralized, even if it is mainly put_user (which migh=
t be
nice, too, since most users of GETTIMELEFT cast the result to various types=
).

> +static struct watchdog_device coh901327_wdt =3D {
> +	.info =3D &coh901327_ident,
> +	.ops =3D &coh901327_ops,
> +	/*
> +	 * Max margin is 327 since the 10ms
> +	 * timeout register is max
> +	 * 0x7FFF =3D 327670ms ~=3D 327s.
> +	 */

I'd drop that comment, but well...

> +	.min_timeout =3D 0,
> +	.max_timeout =3D 327,

Thanks!

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9XkAAACgkQD27XaX1/VRuF9wCfd24PbBPt1KnZZTcmsVtAioQF
yCAAn0ipZixP0/hW17QTZ3UWqXD8XHtp
=IjIJ
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
