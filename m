Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40388 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379Ab2KTGw4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 20 Nov 2012 01:52:56 -0500
Date: Tue, 20 Nov 2012 15:52:37 +0900
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Kukjin Kim <kgene.kim@samsung.com>,
	linux-watchdog@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>,
	patches@opensource.wolfsonmicro.com,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 435/493] watchdog: remove use of __devexit
Message-ID: <20121120065235.GT10560@opensource.wolfsonmicro.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-435-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/FJxnyttrH06HRq2"
Content-Disposition: inline
In-Reply-To: <1353349642-3677-435-git-send-email-wfp5p@virginia.edu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--/FJxnyttrH06HRq2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2012 at 01:26:24PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--/FJxnyttrH06HRq2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqyimAAoJELSic+t+oim97xEP/1Uowg9GikpkBTQZ+wIXHwtz
oxsUSyXp5IQzo0yjJfSAftnTdyKH94FPhkv0SqF4pkLPOQrq/gHXcQYCvSBVVAjN
RTFUHKfi/8mY1p7hPemBMbkRq3Z04OKXjN+HU4i2cq52/GGRb2mS2k8dPBYcxYVP
luT696Lq/rmU8fhOh0oW4JB541r6+p0iCEAvjnNdA3D406ETUH47wZ31q1dx8TIA
uidD5LSHNtxUfgrck0FzeaInMMl8XtFCb7pJFd8oyW+wz1ndmuEtfmnOJNWkRTY+
RNohLbEjQN2tzYZ3ckFK+GFIfs2oVu/ZD43qXut5h3vC5ZQV3zJYFLYH8EbPEEBi
TJ6hrAnMctfpYrHrz4jNluyqIhrgqSXbvw7ArSnOqF9EvpRWQoK+HP9yJkzE2ZwA
sl/NXLvLhLNXo05ez7ypJ0dxXjWhGAKvO2FIGei7FEiRrzoq/QIjZLpa6pINbUVh
7OlSLqDGduTjNdjk3xVfdxyYjJYwQyjgj19nrg5CBt8trgtKq28No1EtQ3jtmxn4
ffa2mOgSanszikuvPzUXENeIh/rII6fwUqhF9ncf0aB70HkkXA8kr8lyL2Bd8mjy
6wFN5NQVe9tIOVmfuD3c/9A7Y+7HcT3V69RUlGz8j+jcQWuH33Bw+bIKI0rFf18t
LFg8LSNpVCW8p2P6ZBUY
=4Xco
-----END PGP SIGNATURE-----

--/FJxnyttrH06HRq2--
