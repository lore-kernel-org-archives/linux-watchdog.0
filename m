Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:43404 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbeB0Ugh (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Feb 2018 15:36:37 -0500
Date: Tue, 27 Feb 2018 21:36:35 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: Re: [PATCH] watchdog: renesas_wdt: adapt timer setup to recommended
 procedure
Message-ID: <20180227203635.vascbeuka3hnpx5q@katana>
References: <20180226214905.24516-1-wsa+renesas@sang-engineering.com>
 <20180226223853.GC5924@roeck-us.net>
 <20180227130058.pmgo33zjvbxwmlad@ninjato>
 <86da4e12-0d0c-c07a-eecd-76466f713da1@roeck-us.net>
 <20180227162256.fgyd3oikydrq3e7i@katana>
 <20180227171915.GC1212@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d3hosqavipf7p7cj"
Content-Disposition: inline
In-Reply-To: <20180227171915.GC1212@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--d3hosqavipf7p7cj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> AFAICS this only applies if the watchdog is already running at boot,
> which is not currently supported to start with.

Hmm, probably this is a good occasion to add support for it. I'll check.

Thanks!


--d3hosqavipf7p7cj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqVwU8ACgkQFA3kzBSg
KbZuqxAApo9dnRtQ9NVGkuchbWu6zljloGW8Zthvk67i5lHLDfJKxaSMjj3890fD
j24H4Vz8r/nFrDPu+K7du69l87jBb2lMPyo5tGp2kZugiBB53rHILwi+aSryFsqD
p23/mBYFDdJnotVNXlBC1NlvdNCdnukI1JH4fU2nXBrlcWBsy78NQ9/JlX9vs03n
NKGgH5x4AcBamDBV1T221OU+pJquxAgeePPC4GJOfBjUMN8C5zvpJ2Y5hkvXy4FG
TDCgnQBimp5Xi9XUufDG4F49uEhVB5PdBt2nPtH2IKIZzLEZGmducvpHbx5VB4oH
+nixcTNBmQMY5lHP2jZp+n6RArnaP1ZtyuuWoKJ9i3v3yya7KeILw9UGoVssgwAn
+GYip753q3D3J1CJ725/41lRUrYuCSY/kMhH2aGDtcfO6zgXSxLVBCkeMa4gbUib
P60R5yinsQVn78NB9hhPv9BaUGGetpsTzJ83MMFDTUprdSMPsiOFfzbX7zenDLyt
PJwROKjrIWuwmL+XNWuIwAU3cCBIU+QPaiOosBBSRGJgSNVJ+11F+2txPAaPlD+g
8w5NUPRR3KFlNojHJtIoNrDaM/2FvC96YzYPKnQE8dg5j2rY8MtVLccEPJS1zO5O
eeiOJrtOQ8dF/Osd3IAPUdN7rTAY9rGkEKuun13n8e3Q+YiCiP0=
=VXqF
-----END PGP SIGNATURE-----

--d3hosqavipf7p7cj--
