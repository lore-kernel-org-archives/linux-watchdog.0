Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39032 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750952Ab2KTGnO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 20 Nov 2012 01:43:14 -0500
Date: Tue, 20 Nov 2012 15:42:59 +0900
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Kukjin Kim <kgene.kim@samsung.com>,
	linux-watchdog@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>,
	patches@opensource.wolfsonmicro.com,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 152/493] watchdog: remove use of __devinit
Message-ID: <20121120064257.GK10560@opensource.wolfsonmicro.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-152-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQ77YLfPrO/qF/pM"
Content-Disposition: inline
In-Reply-To: <1353349642-3677-152-git-send-email-wfp5p@virginia.edu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--LQ77YLfPrO/qF/pM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2012 at 01:21:41PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--LQ77YLfPrO/qF/pM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqyZkAAoJELSic+t+oim9k7UP/1YWBSxpr2VX71bYDhChNbA/
Tj3Ov+tIHnOCW9PavIGFpv/MCjq3K0E75B3g3zNIQF7emhhtUjnGLsGFozM9RnAN
XRxQimb4GK9Su4/hgFWbyCq3L/Ym4QRl2RH5MY+5uc0xZGpKps2ps0idbFvSp32z
XgayvlyUygIpzKVvAgpaBWjOOag+0ITZgHwTe39B0mHcaoj5rffnRSUNCoEYfB0B
L8E1lrkuueqAUgAf2+BA1wTnIDA88uOkaxnS0qW8bapOGbhDiYWTtP7xTlpwmDkk
indqKa0ZFvXYXzgQwGkS7OHTieHvFaH+x8T7GjTIIyf9txViHSZNEo9xxctrlDYu
JaygggoESD5nDuCF6gSTN64HDZbzdUPCaLtjoGsAz1INkN1ZTPoqF7CNpsxiIGjK
jVXJynkbb9DxEY+2clthJ0FvzB5IlzIklefpHvBzR5PS48wvq54A0VcSxtoAalDW
VkkJEVOzAMbkuKU7/zr3ijjSkihM+7SSu5JTYbhoct0tl3dwDeteyWIvoXmA7lWY
0eodJkRuTxIxtFARnOizhdCeaQ2w2JVo15lT7ObONOLBFzmvor/Lg/wBHUjV9ew4
1P6l5VRxthfpSmIcEGtE6Fmp8pr2N50RyhkgCLdEtmEupCI98TpMNeXdZSp21x4R
ulKrtJE5Zqf3szTAkE5R
=hBLv
-----END PGP SIGNATURE-----

--LQ77YLfPrO/qF/pM--
