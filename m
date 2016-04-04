Return-path: <wsa@the-dreams.de>
Date: Mon, 4 Apr 2016 21:12:28 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/4] watchdog: add driver for Renesas Gen3 WDT
 watchdogs
Message-ID: <20160404191228.GA12187@katana>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
 <CAMuHMdXQFD281m7iWc7RRdunW8Fo9nQfLBwytD1L3abW1ephtw@mail.gmail.com>
 <20160404145919.GE2983@katana>
 <CAMuHMdU3m74FV_+XTD0n7_SmW97aUD0ZpJ2q=YLmsAEtjF+udQ@mail.gmail.com>
 <20160404152506.GA19188@roeck-us.net>
 <CAMuHMdUb1ORUygOmFBE7RCe3vBxk60AEdSg+UgHBty6GfFHmEQ@mail.gmail.com>
 <20160404175239.GA24667@roeck-us.net>
 <CAMuHMdWtTYwe8ssqMfW9XrRxKpvYmTRVwUWdDFW_-8aBEYTQ7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWtTYwe8ssqMfW9XrRxKpvYmTRVwUWdDFW_-8aBEYTQ7w@mail.gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > You mean it just hangs ? That is bad. If that is the case, it is not re=
liable
> > and thus should be a low priority (or at best medium priority) restart =
handler
> > (which can be replaced with a working higher priority one).
>=20
> On my Salvator-X board, it hangs. The call into PSCI doesn't return.
> As this is firmware, it may depend on the version of the firmware.

Yes, this is also where I stopped looking into it. I dunno what is
expected behaviour from PSCI and such...


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXArycAAoJEBQN5MwUoCm2ICMP/0F+QwQRvQXc2ZE69zyGqiAb
fEToPbd7QxwH8Gg4p/UZp6fsiujKCzX0URplCZVwK5On/mPn/VXDeW1EtiRzxL7f
wOWYPdDLUQDEwxDNzTfszei4Vq6ZKjqi0q/c1JZJRzQffYiMAna4YJaxpXMGnIJM
6uQd+OfiQXBM6pnPrDWz2WZe2fjUx3u7MFS5QBzH//OsiCcd4yD48nuqu2mGc+/3
YHkTedcI9BqWGdlSVPkS+aEei5QlHHunWK5bdcNaHcx+eSYVqu847oQ0LeBtMT4y
LZLWCKRbvRvgt65g1uu/gz7Q6mSMW6FlE59dSVgiDt1JGOwUb/jstkVyPhctWV0J
tehdNmddrl+tBPEdo+dfeFKmWYiDTDWE+1o2j8SkXbAeKy3Kb9zFdPNMlb9SLVua
tfa7ix9IHGvNILj5A8q1GkL/6d3KVV8xIbSiFZAK/gnXYLe2iPQRxeDqeMWJV3XI
BFkCoFEnvAsyjGJG0/5oWmV0VsIY84FjmEa3yfzYMlZWAwKTJPsIu7x1nWMecAu5
Xo/dRXDPcUFioRzaM+Vq50RX/nsEPZqoKVMsKcF1RcHzL+fRvljAZSaGYqMui8qd
DkMfw1OAD4sz2Hjwy6Yq3dzkmbFa3G4M3F6RZr9WX/5e+CGSJSuinxxUzmRVNHH3
VDhxvv54/kdlJFoHdObM
=h4V0
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
