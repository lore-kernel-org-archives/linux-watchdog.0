Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:57941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbcHZE65 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 26 Aug 2016 00:58:57 -0400
Subject: Re: Linux-compatible watchdog add-on?
To: Nicolas Boullis <nboullis@debian.org>,
        linux-watchdog@vger.kernel.org
References: <20160825163149.GB3636@haddock.home>
From: Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <7ad22fc1-02c1-7d99-657f-770d16c3aa92@rempel-privat.de>
Date: Fri, 26 Aug 2016 06:58:15 +0200
MIME-Version: 1.0
In-Reply-To: <20160825163149.GB3636@haddock.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ig4MFbkhrBH6u3xN1uunlhs5J7dhDRXB7"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ig4MFbkhrBH6u3xN1uunlhs5J7dhDRXB7
Content-Type: multipart/mixed; boundary="MiVQiq3r36oDJSdtaHiiv8pJri1fTWbKr"
From: Oleksij Rempel <linux@rempel-privat.de>
To: Nicolas Boullis <nboullis@debian.org>, linux-watchdog@vger.kernel.org
Message-ID: <7ad22fc1-02c1-7d99-657f-770d16c3aa92@rempel-privat.de>
Subject: Re: Linux-compatible watchdog add-on?
References: <20160825163149.GB3636@haddock.home>
In-Reply-To: <20160825163149.GB3636@haddock.home>

--MiVQiq3r36oDJSdtaHiiv8pJri1fTWbKr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

Am 25.08.2016 um 18:31 schrieb Nicolas Boullis:
> Hi,
>=20
> Sorry if my question is off-topic for this list.
>=20
> I have a computer that experienced a kernel failure while a was far awa=
y=20
> and nobody could reboot it. So I thought it would be nice to have a=20
> watchdog. Unfortunately, to the best of my knowledge, it has no hardwar=
e=20
> watchdog, so I thought I should add one.
>=20
> Hence, do you have suggestions for I=C2=B2C-, serial- or USB-connected =

> watchdog add-ons? It should of course be compatible with linux.
>=20
> I found=20
>   http://www.berkprod.com/Product_Web_Pages/usb_v1_pc_watchdog.aspx
> but I think it is a little too expensive.
>=20
> If no such thing exists, I might consider designing my own (open=20
> hardware) I=C2=B2C- or USB-connected watchdog add-on, using a cheap MCU=
=2E But=20
> then I would welcome opinions on what the interface between the host an=
d=20
> watchdog should look like.

How about SPI?
If yes, you can try this project:
https://plus.google.com/102032716864870215256/posts/PwMMKYP5PKR
https://plus.google.com/102032716864870215256/posts/QJqPxSi1Str

Linux side is configured as watchdog, MCU side currently do only demo
blinking, but watchdog should be a main future.


--=20
Regards,
Oleksij


--MiVQiq3r36oDJSdtaHiiv8pJri1fTWbKr--

--ig4MFbkhrBH6u3xN1uunlhs5J7dhDRXB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAle/zHUACgkQHwImuRkmbWnNRgD9FgWQPCZRyggpLEtepW+HzJDi
c86PcCbGX6VsdUqPmRYA/RaN4OBHc4MAIimjz5C0pSkNYNOHPwwzfjBnrM9mjFam
=B8Lj
-----END PGP SIGNATURE-----

--ig4MFbkhrBH6u3xN1uunlhs5J7dhDRXB7--
