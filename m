Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53241 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270Ab1GKVbu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Jul 2011 17:31:50 -0400
Date: Mon, 11 Jul 2011 23:31:45 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/11 v3] Generic Watchdog Timer Driver
Message-ID: <20110711213145.GB5811@pengutronix.de>
References: <20110711135056.GT29245@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <20110711135056.GT29245@infomag.iguana.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Changes since V2:
> * all "flags" are unsigned
> * timeout values are also unsigned
> * removed unnececessary debugging
> * clean-up comments
> * the core will be in drivers/watchdog/ and not in drivers/watchdog/core/

Also (just in case someone started converting drivers):

* some error-codes changed
* .name has been removed from watchdog_device in favor of watchdog_info->id=
entity

I already started converting a few drivers and will post the patches as RFC
tomorrow. In general, converting went quite well and despite a few comments
(see later mails), I think this could go into 3.1, so that converted drivers
can go into 3.2 together with (probably) a few updates to the framework. Th=
ere
is potential for a bit more consolidation, yet I think the basic stuff could
go in now.

Thanks to Wim and Alan for their work and CELF/LF for supporting the final
steps :)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4ba8EACgkQD27XaX1/VRulFwCfdxUpZIlxkvlHBSjg8APwAbTv
GKYAoIgNGbiLLBdlwcpph/zV3dBwPZdf
=1962
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
