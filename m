Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36016 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379Ab2KTGiI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 20 Nov 2012 01:38:08 -0500
Date: Tue, 20 Nov 2012 15:37:59 +0900
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Kukjin Kim <kgene.kim@samsung.com>,
	linux-watchdog@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>,
	patches@opensource.wolfsonmicro.com,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 123/493] watchdog: remove use of __devexit_p
Message-ID: <20121120063756.GH10560@opensource.wolfsonmicro.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-123-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIIRZ1HQ6FgrlPgb"
Content-Disposition: inline
In-Reply-To: <1353349642-3677-123-git-send-email-wfp5p@virginia.edu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--WIIRZ1HQ6FgrlPgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2012 at 01:21:12PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--WIIRZ1HQ6FgrlPgb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqyTxAAoJELSic+t+oim9hAoP/RpJZyzBgJF0tLZdiZrqY2VX
GevbRRTh0nEU+yl3dL4guKqJji9IEqbEiXovmH4Q4ZugiGC4vcktDPIusDorFOC4
aAbZBFgvb3LTUFS619z1OPXwOV8pzVTsE0EaOzKUA+GPOu4VdFuoaEZPD380Awgm
1oGraOLMfHvDd368d9TnMPvKRQnB0ZnoaMb1HiKIxg7SyW8lujNgWtdIh0wrvAJb
0L6DMmILTdIeqdcvImTWJe5VyiIy6tRVAM4P4sPq1WVJc5Fn4COWFK+GhzDpaoGl
bnpnCJKTJWjQ5dj/QP8i1AIJEHTBQ1ixamDtlrllgKXatTjoWOfMLADCEAflSH2Q
VzXIAVV4VnZziylpuN84gpaYODaLlXB3Vb6U/21t60OOCyYtb6YF/bzmvE9i+KM9
M6B6PyHpvkminAAdEEP7NjhJp50/SK/vMincAUj2RD0uJSFbkvUv/d/V+F3BzJzl
5EKoyj9DEbg1a/Wq41X17z+OatPUMQE1RPE8WkRvfbsDaTEawb/prpg6A3Yr9pPC
cpTXyWtN87060IpE9319JujLRnmgdVcOva2U9q+ArulcjXWRrLFMlqGokzr/L+Vl
C+JVhCHO4K0tseRVVvoGm4a2JOOWif7P4AEACS4I4xLzIx0oesUMZXLgG/sVe5ek
AnnFyyTuwb0DXbU4G23b
=BMYi
-----END PGP SIGNATURE-----

--WIIRZ1HQ6FgrlPgb--
