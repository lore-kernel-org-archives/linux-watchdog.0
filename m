Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:56938 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbdGRHV3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 18 Jul 2017 03:21:29 -0400
Date: Tue, 18 Jul 2017 09:21:27 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>
Subject: Re: [PATCH 1/5] watchdog: renesas_wdt: avoid (theoretical) type
 overflow
Message-ID: <20170718072127.GA1627@katana>
References: <20170717151230.12680-1-wsa+renesas@sang-engineering.com>
 <20170717151230.12680-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdV+yAy+QmDWFn8a7U8F1F5NcoV5C-1e8LeCV-jKcQHnMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV+yAy+QmDWFn8a7U8F1F5NcoV5C-1e8LeCV-jKcQHnMA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > -       unsigned long rate;
> > -       unsigned int clks_per_sec;
> > +       unsigned long rate, clks_per_sec;
>=20
> If you make this change, you should also update rwdt_priv.clks_per_sec
> (yes I know it's removed in a later patch in this series).

Right. I will change but also wait a bit for more comments.

Thanks!


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllttvIACgkQFA3kzBSg
KbZ7mA/+N5/wCYwSaM5l0ZrVpv5DSgQkZm8rra0G+y18u83JfJgzKx0WarCKqNuc
OgHEwO/Uxm/jaPUAnzVYVCP38KH6bD/A+oxn7RBjFFzoUgG3b6Cyb3TowuatCKR1
3zm+xx79AfcKiWnX/s0YQ0qd1mn2E8+3gHto1P7dCb5/PCkXZ6u7Xrm/bShY/HEf
sZE/qZaY06mmlSd6B8rryMfKHmsyJveBBErPxvAVXi389FYF6aA4b/pbsokPzIjc
vXry6/Nq7intT/pkKbRrpYyaMrAsQcimmgCCECOJBd9Z1Sgwtfk0HfpEsaOez5ey
BDOkTtvTQzH0IrElyuaqAkMaYzPMwJwU7rBuXB/tDPI8ckqS3rLNOUSn1//rSeSV
imm7RPfu8HFvHqrPoN3swZI2PNWziJ6Yvmj87W+DV7sznWcwtJFjNN392MOyUMS8
uHm3HA2IQFpaIK/Wd6xndZ+KylW0qQd3Kg7Jc7vp73RhqNMw8Vdf3CDVT0csnp0l
8ewm/zZ9eCcSDKkS44OeeMeThZwc3qbBV0sELgyCZj8HBIJGp4q9u37TInp4bnnd
cmoPGvEUgUdXfrPAkT6y5HfPNVbeKIDWIL5k5RymETdqUBPZbgcoClxL1Wi2w5y4
HuDeR/LqYZ4fAydc4FhlHeGhoo8RnXxjbG4oE+Ydspq6mjqTHjU=
=nxvn
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
