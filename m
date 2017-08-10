Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60258 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdHJPFu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 10 Aug 2017 11:05:50 -0400
Date: Thu, 10 Aug 2017 16:05:15 +0100
From: Mark Brown <broonie@kernel.org>
To: "Langer, Thomas" <thomas.langer@intel.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "martin.blumenstingl@googlemail.com"
        <martin.blumenstingl@googlemail.com>,
        "john@phrozen.org" <john@phrozen.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Mehrtens, Hauke" <hauke.mehrtens@intel.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Message-ID: <20170810150515.w66ksbfexbcegy6z@sirena.org.uk>
References: <20170808225247.32266-1-hauke@hauke-m.de>
 <20170808225247.32266-4-hauke@hauke-m.de>
 <20170809114421.oo2bunardgw3p4tk@sirena.org.uk>
 <0DAF21CFE1B20740AE23D6AF6E54843F1EA0A385@IRSMSX101.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s6uae5i4hoypg7dc"
Content-Disposition: inline
In-Reply-To: <0DAF21CFE1B20740AE23D6AF6E54843F1EA0A385@IRSMSX101.ger.corp.intel.com>
Subject: Re: [PATCH v9 03/16] mtd: spi-falcon: drop check of boot select
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--s6uae5i4hoypg7dc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 02:02:16PM +0000, Langer, Thomas wrote:
> > On Wed, Aug 09, 2017 at 12:52:34AM +0200, Hauke Mehrtens wrote:

> > > Do not check which flash type the SoC was booted from before
> > > using this driver. Assume that the device tree is correct and use this
> > > driver when it was added to device tree. This also removes a build
> > > dependency to the SoC code.

> > Why?  Is this assumption reliably true?

> Yes. We only have one type of flash interface in the device tree, as they=
=20
> are connected to the shared EBU (External Bus Unit).

That sounds board specific but this is a driver for a SoC?  In any case
this needs to end up in the commit log.

--s6uae5i4hoypg7dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmMdioACgkQJNaLcl1U
h9BYlAgAgCDu3huZzBs6oYvZZ+POaY/GV5Cs55enzpxuT8F87rnOrYbTGQw66HzP
+4Foc1xogiJOKDNSs+BpPiuFTo/zvwu+ApKkEE8OeaDOQh4gVhCag/OUKz9z5hAZ
ZvSHQud2xiO1FjFZeLFB1KGEA9jb9ltOjWdJxqdiv1S9mV4ITiVho//mhTNf6HcL
RMiKTeDmSz37Q3X1vgrnQehpTYgqUHYCzr/NjUjsJ3nATLZpr8bLbLhh4YKalxqj
Elnt3lXSauR4/LfcfwpSqRYfeMP/LhWAHMRRJpSMLqFVAyWgndZP9IXm9mP4fXia
R3yhSmQxzNY7qhWMoY1vQAfNsr4hwA==
=HdUK
-----END PGP SIGNATURE-----

--s6uae5i4hoypg7dc--
