Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53309 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751853AbaEOIzD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 May 2014 04:55:03 -0400
Date: Thu, 15 May 2014 10:52:14 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>
Cc: Guenter Roeck <linux@roeck-us.net>, wim@iguana.be,
	carlo.caione@gmail.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: sunxi: Fix compilation with C=2
Message-ID: <20140515085214.GP29258@lukather>
References: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar>
 <533EF39D.6090907@roeck-us.net>
 <536FD3B3.3030100@elopez.com.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XQ/JOjNzrAcf1KaA"
Content-Disposition: inline
In-Reply-To: <536FD3B3.3030100@elopez.com.ar>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--XQ/JOjNzrAcf1KaA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2014 at 04:46:59PM -0300, Emilio L=F3pez wrote:
> El 04/04/14 15:02, Guenter Roeck escribi=F3:
> >On 04/04/2014 10:24 AM, Emilio L=F3pez wrote:
> >>When compiling sunxi_defconfig while using C=3D2, the following error
> >>causes the compilation to fail:
> >>
> >>     drivers/watchdog/sunxi_wdt.c:60:15: error: constant 0b0001 is not
> >>a valid number
> >>
> >>Fix it by using hex notation instead of the non-standard binary one
> >>
> >>Signed-off-by: Emilio L=F3pez <emilio@elopez.com.ar>
> >
> >Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >
>=20
> Wim, Maxime, any comments on this?

I'm fine with this. Wim? Do you want to take this patch, or can we
have an Acked-by?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--XQ/JOjNzrAcf1KaA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdIA+AAoJEBx+YmzsjxAgzK8QAJoySaHN4AnZYvJGKwwi6lCI
Fn4mMEROIa9glTbBdOGw0qF7ltQcaq/pp3lG8N1+IyJTTxmB2luBOsGG23kqSOMU
BYkD3B05qQHawjvIXRwa3ctKf5a26GIDRU0Mdk8nIGT7ExM9HIx0z4ilve/omLHV
pzFQW7DpxMH6qrm1TbVWIWNVtGWnNsvvqa+AzFkhPnhI8LnG/yR/fUudzoS5GA2W
SDiDddtQvIs2s5scKN4XWVdBAGwkDBPGP7mN5hlN2NERmbv9JjCnZkfdGLuVTHpT
76CEJqyb21kWBOhDckhFP7KheYdvZIeSmgPT5fCnX0naH7V7KXDEcAvXYjSNM7EB
RBj+DZeSpN3e8AdKAgAWQ7SL7z/yMokM4YJAxsJi2wtQt2dQqcjJoasRLhdBNL9f
iIoffLDu57rI78JXV+cagP+ZJK5GwsjQboFFaNk4gS3PF9JIfsSVNgGmzTGcRu5w
Xk2WOmLEzTMvwcQCgXAEoo4Z8VdEVVu2NW0mWB6PSmmLq4f6UaIv2Ss/7qDUStv/
xh+wchofyItzOHV/T87wHycdoGxdC6B8tuaF0kxqk/iwzSMkIUVKeGJmqRGC0UKg
IfPTjDHM1GtXukKiz/LsTbmLTHxs4MvfeM2up+R1K7IIB0DitcXM8NE5PBC84f2c
DEIwOigkKYaAJ9aMGJUt
=eBSb
-----END PGP SIGNATURE-----

--XQ/JOjNzrAcf1KaA--
