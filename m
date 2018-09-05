Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39530 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbeIEUEm (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Sep 2018 16:04:42 -0400
Date: Wed, 5 Sep 2018 17:33:55 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jerry.Hoemann@hpe.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH v3 1/4] watchdog: core: add mechanism to prevent
 removing if NOWAYOUT
Message-ID: <20180905153354.GA7726@kunai>
References: <20180829074241.1943-1-wsa+renesas@sang-engineering.com>
 <20180829074241.1943-2-wsa+renesas@sang-engineering.com>
 <20180829205535.GA30332@anatevka.americas.hpqcorp.net>
 <CAMuHMdVZ_TPLFqj1fkdW6uPm_urDYHKk9Rp8hXd_9gm-0CXcuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVZ_TPLFqj1fkdW6uPm_urDYHKk9Rp8hXd_9gm-0CXcuA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Is the intent of the proposed changes to prevent the unload of
> > a module if it was loaded with the "nowayout" parameter?
> >
> > If so, I thought the WD "nowayout" semantic was only supposed to be in =
effect
> > after /dev/watchdog was opened.  The proposed change looks like it make=
s the
> > "nowayout" semantic take effect before /dev/watchdog is opened.
>=20
> Thanks, that's IMHO a very valid point.

I agree, thanks for this input.


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluP914ACgkQFA3kzBSg
KbYN2g/+Mk/ZBqqGBiS9pB2AiyAMRaKVcXxm9801Xw0TqveyT9m091Cat/sdcxWo
64rknPJ3DRyCYx+kqvPrMSbH1Ej07NSRBNkniphYEXpTUaP7kVsBRA/NavU7NO+8
XTxR3Jl9DbkLCrbieAEckUbbStFm0TT/+iLpe2USrC40csickIp1tEz6NmcgcjAj
VCJ6cuNrtuqZr/rVTZu+73n//GC6BspV986jUI0+qhpvFnwIf41iIiZ3JhUBrTrZ
yNTkcc4BBNb/5i940p3vJHv0fM7cmTWgxJe1h/f650h2xWd+K7nCnBuL9+GSX+RT
wbkFLLX7cTgQ4ctJxc+BWWiCc3bmouWndWq0oguTPS9yZvefZ+XfJRFxWdPYYEjA
c7bRTZo6Ygc62chu8rbsXn9L43nupi3RUbqvPoOdNSwWMzgP9e+BsG7ZEg26Knwz
tLLKFDCVSUbf1CtmL8r4P2q2B+cM1tpSZUYkCQ5AxZha/Lwu+0hWMCudiddDxiuj
aFksFpZTmRiUOsk6yOWfQ0itqibiBy9w0K0mQRm3Vh1+hWmbpAOZZ+LgGrlK4Bfa
M+WgmCICh4UdoGUjVQAPZ9nW97Nt+ALqvfFNo8FscjqK6rVwn4BTaoawmvwtcuND
iQsGzas/ey/ntxVXfAPk3gwa3pFBJu/WrjXeVKlUta3DQuKpxtI=
=Gcdq
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
