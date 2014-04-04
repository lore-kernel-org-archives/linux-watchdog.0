Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:42781 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789AbaDDPUR (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Apr 2014 11:20:17 -0400
Date: Fri, 4 Apr 2014 17:20:12 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawn.guo@linaro.org>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: imx2_wdt: handle enabled watchdog properly
Message-ID: <20140404152011.GC5529@katana>
References: <1396623242-15234-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <1396623242-15234-1-git-send-email-agust@denx.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2014 at 04:54:01PM +0200, Anatolij Gustschin wrote:
> If the watchdog is already enabled (e.g. started by the boot loader),
> we need to handle this case properly and start reloading the watchdog
> time-out counter as frequently as needed.
>=20
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Uh, this driver has not been converted to use the watchdog framework
yet? I'd suggest this should be the first step.

@Wim: Does the watchdog core already handle the case that the wdt might
have been started by the bootloader?


--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTPs2rAAoJEBQN5MwUoCm2FcIP/AnzR2CXTxIz6m+6+KNx2xHT
hHzEtodm/kHOlm+hUIyXRdTue7tZID6Pqa+pXInXQI5ZABy0I91iBQSsv8NQpUzu
pdBz/zHMRCSqi1pAKNT3zzEDPm0DsbLoye7yMmGWWw4AQuBqHspFAphcySeNAIV9
b0Js9SjWMcomoGw5JvQC54mKaZTz++fLbM5RmE6WAkAkq1cOpfi0+uloLDP2bFSj
p2w68uICIXoP8zvM40ePSSmjl+kGi6dHvfBUGLrmLau1NT1wy3sXtfHLdNivcI7d
44F1a/A/V9qd/0CMZhO/VoMf1wSIaytTTUKfN3apBUX4c+v7XcnPay9A+rmgVlVQ
5tHqAX+yAUCQhm+mZ0jgrmrERSga17N0IH4CX/aiib8a3+xZDh3DTHiXtQFI3alV
JD9Ij92ToFDr1Ind9YunprGC3S+ZRr+iqh8Y0Hu+AZiLFaSk+bx+eRNT1pZfxWIF
i4lv4iteXHPfCXb+dVwuelP+e21tza0zYVm159alg6rtDl5GVgoVc6wMwK4lIucX
0JTdShGHjPJn/p9wDu387F3ZeZ1nt3GzZ9NUL9y9WpjKZpTCZJu6VBja3Bgw1Pf2
96fa9D1DQBFlf4xFH6OxNY8b87m8PRE8YPgQYMHIyRtNotfDxSiCb8xwFjixabvQ
wCyJyjQe6ZFI0KtHDjzU
=KaIW
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
