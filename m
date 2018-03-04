Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54324 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751818AbeCDTx4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 4 Mar 2018 14:53:56 -0500
Date: Sun, 4 Mar 2018 20:53:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: =?utf-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?=
        <torso.nafi@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: A case of watchdog+LED shared GPIO pin
Message-ID: <20180304195354.GA14472@amd>
References: <CAEo2pztutpwd0wvJWVmQ2XaT43nQ99StFbDMT7MQ5dkrMdkJvw@mail.gmail.com>
 <20180304191934.GA14207@amd>
 <CAEo2pztPD3BoC==+R2AiJ2D3cyBRWphErNTp-evSsFZueK1-Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <CAEo2pztPD3BoC==+R2AiJ2D3cyBRWphErNTp-evSsFZueK1-Xg@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-03-04 22:45:35, =D0=98=D0=BB=D1=8C=D1=8F=D1=81 =D0=93=D0=B0=D1=
=81=D0=B0=D0=BD=D0=BE=D0=B2 wrote:
> 2018-03-04 22:19 GMT+03:00 Pavel Machek <pavel@ucw.cz>:
> > Improving WDIOC_SETTIMEOUT is obvious solution. I'd go for that.
>=20
> Question is, then, - how to do it in a backwards-compatible manner?
> There is very likely to be some userspace software out there which
> relies on the assumption of the currently used whole seconds semantics
> being in effect.
>=20
> Add a new millisecond argument? But how to detect its presence in the han=
dler?
>=20
> Introduce a new ioctl? But how to do it neatly and reasonably?

New ioctl. Start from the old one. Keep it neat :-). Negotiate with wd
maintainers if that's ok with them, first.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqcTtIACgkQMOfwapXb+vKDCQCfe0WWCHzP15JOAj09WOv2DkrN
2mgAoKvVNg4Xr5QHHfnSxpaMJG2maIwz
=UcyJ
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
