Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39540 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdH2Sec (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Aug 2017 14:34:32 -0400
Date: Tue, 29 Aug 2017 19:33:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, robh@kernel.org,
        andy.shevchenko@gmail.com, p.zabel@pengutronix.de, kishon@ti.com,
        mark.rutland@arm.com
Subject: Re: [PATCH v10 03/16] spi: spi-falcon: drop check of boot select
Message-ID: <20170829183330.bw32izdgscs3qv7n@sirena.org.uk>
References: <20170819221823.13850-1-hauke@hauke-m.de>
 <20170819221823.13850-4-hauke@hauke-m.de>
 <20170828112327.GA15640@linux-mips.org>
 <40428f8d-f781-7952-30c6-41f65ec1096b@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="em6bza2p3zhdutf5"
Content-Disposition: inline
In-Reply-To: <40428f8d-f781-7952-30c6-41f65ec1096b@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--em6bza2p3zhdutf5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2017 at 01:29:33PM +0200, Hauke Mehrtens wrote:

> Mark could you please have a look at the commit message if it is better n=
ow.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway.

--em6bza2p3zhdutf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmls3kACgkQJNaLcl1U
h9B79gf/Wa/VFkXnOlBBNgm63YVzh2QsxE9mKHpvq1zfYnZKXeW4dHKXtXd0NT0T
WDNmcLPyxJ6nmEPAxsarDv86W1wQ6oS91N+17jgdkneocp290gLk6C/esWLR+AqZ
NU8f9FA+hl/YQ6ZLRiyz3EaB3kDGxGyIJCLgAj8MP0qogG8I5a05/fwc184qpG/I
98rvKfPPfZilzOeeK34nxoFTQrp7q9+HHS5I0ZtJuTeHBXnjofkBcNULZRUSP3db
jMnk1GqbA+FcGnAbwRAxHXzsCCAUsk+Y5V63hYyReFUo1nVwC0E5xLvF1wguhVv3
xilvTr6q7n8CeXYiyp8J4HIDf8VgUw==
=BO/Z
-----END PGP SIGNATURE-----

--em6bza2p3zhdutf5--
