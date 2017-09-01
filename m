Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36436 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbdIAQkM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 1 Sep 2017 12:40:12 -0400
Date: Fri, 1 Sep 2017 17:39:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, linux-spi@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        hauke.mehrtens@intel.com
Subject: Re: Applied "spi: spi-falcon: drop check of boot select" to the spi
 tree
Message-ID: <20170901163954.zj2kpqhag7vakucp@sirena.org.uk>
References: <20170417192942.32219-4-hauke@hauke-m.de>
 <E1dnjTy-0006AD-Ox@debutante>
 <20170901142355.GB31297@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yz2qmbdgrt2zqrtv"
Content-Disposition: inline
In-Reply-To: <20170901142355.GB31297@linux-mips.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--yz2qmbdgrt2zqrtv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 01, 2017 at 04:23:55PM +0200, Ralf Baechle wrote:

> Thanks Mark - but there are some ordering dependencies in Hauke's
> patch series so it would be great if I could have an Acked-by to merge
> this patch through the MIPS tree along with the rest of Hauke's series.

Ah, I see - I wasn't copied on the cover letter so I didn't know about
this.  Here's a pull request:

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-falcon-no-board-check

for you to fetch changes up to 1a41aa1376df9e24d0c760df1a6f59765316c457:

  spi: spi-falcon: drop check of boot select (2017-09-01 11:33:22 +0100)

----------------------------------------------------------------
spi: Remove board check from the Falcon driver

MIPS is removing this board check so support a cross tree merge.

----------------------------------------------------------------
Hauke Mehrtens (1):
      spi: spi-falcon: drop check of boot select

 drivers/spi/spi-falcon.c | 5 -----
 1 file changed, 5 deletions(-)

--yz2qmbdgrt2zqrtv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmpjVoACgkQJNaLcl1U
h9BV1gf7Bb/eqetoXini9Wo2ec8W/Faq3iyNLJsm5sq6kdEmyfgg45y+VPDzER/s
S2zaLpkahr6nOhFZVCc+ZuJ0/ONB3j1zKeCul8E0Jquh8R2UhNSIxla2VRnDHDxG
NlCM9pk0eI6NJ4ad78DcIf8q7eeikuFchw66pMIzeZj02AWurYj6Vf15iZxwv/Im
PxAT5C5XG8roa3FRCXNjI+m0sT1jBkjHNFpINm6mj9tUQ3nWW14vjKDjAbyH0ymR
bqLmqWA/TKhZX8Ek4BgQRIcAc8qPPs4atb07cDvahDjvZUZEREik5qe9Vh0wtLXi
D09hfGioArLwS0+IGC2PQ3K95sr7VA==
=Yz51
-----END PGP SIGNATURE-----

--yz2qmbdgrt2zqrtv--
