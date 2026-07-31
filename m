Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C6A8C1F
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490612; cv=none; b=YrKnzxrMKBRAP8InMCpLMHZG/6+Io8U729Q+EhqCkdgsl628wSq5J14G98v7drUMV8WA4Oyu6l+IW+8rO+7veJPI8oXB57SLoJ4pHUd/PBLBez7Y2dyWQbxiQ0uJzpfTdi4H+UGOZQfz3IK946n8lInig1vCujCxq8f2Kgm6/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490612; c=relaxed/simple;
	bh=Tga10Dj5lniTW6iVyy5J46+8U2Nw0G5qPLTfZ+/+iO8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TdicaXD4ADZ6OGnufBNkkKHeLot1ze2W2l2mbQI20kH/dXP5Vqzh1I14pm2t75kjT157VTsG7EUXdGLyiymSMBSdg2nQuxXKmRVkP0Is2q2Ol2ScPgazi7eJkxqIIqCyNJzRSVpIRgQnejwT5caDe6H0TqgaRzkHIZpvMigbd+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sKiiqLYO; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sKiiqLYO"
Date: Fri, 31 Jul 2026 12:36:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785490599; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=MHkQihcxiYcVSUY0Fpxal2pOCseKtEiigEUxPXVL5xY=;
	b=sKiiqLYOiSQqoT0/I+htn9tFvN13BOjnUI8REJ2p+NaRegiz0+Vd2L0kw+NQPo7YSS5G1z
	/wSKOL9kk0tYqUiShatVUFarqcmjhMqo/YCfeJ9XP/6oCVQOtjnRAO/yNShGhK9vG+7DrS
	xkRe30bCx+HWa6xwx2GjGA0fgx2C4SU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: bd96801_wdt: Fix timeout for enabled WDG
Message-ID: <amxskHmQbi9v-8_l@mva-rohm>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a0cAK5QNLSFJ3KDV"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

--a0cAK5QNLSFJ3KDV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

When watchdog is enabled at the probe time, the bd96801 driver retrieves
the timeout configuration from the registers to set-up the heart-beat
values.

As Sashiko pointed out at
https://lore.kernel.org/all/20260722085819.495211F000E9@smtp.kernel.org/
the timeout values are incorrectly computed in driver, resulting wrong
heartbeat. This leads to devere problems if watchdog was enabled at probe
time.

According to the data-sheet, the "too fast" ping limit is configured as
multiple of FASTNG_MIN. Furthermore, the "too slow" ping limit is
configured as multiples of "too fast" timeout. The FASTNG_MIN is set to
11, meaning 1.1 mS and "too fast" and "too slow" limits are computed from
this. Hence, converting the limits to mS should be done by dividing by 10,
not by dividing by USEC_PER_MSEC.

Fix this by dividing the timeout values with correct scaling factor.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 09dad69757b6 ("watchdog: ROHM BD96801 PMIC WDG driver")
---

Also, drop an extra whitespace while editing the file - feeling like
that single whitespace fix doesn't warrant own patch. Just let me know if
I feel wrong ;)

 drivers/watchdog/bd96801_wdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/bd96801_wdt.c b/drivers/watchdog/bd96801_wdt.c
index 12b74fd2bc05..a25b7cf1488b 100644
--- a/drivers/watchdog/bd96801_wdt.c
+++ b/drivers/watchdog/bd96801_wdt.c
@@ -169,7 +169,6 @@ static int bd96801_set_wdt_mode(struct wdtbd96801 *w, u=
nsigned int hw_margin,
 	int fastng, slowng, type, ret, reg, mask;
 	struct device *dev =3D w->dev;
=20
-
 	if (hw_margin_min * 1000 > FASTNG_MAX_US) {
 		dev_err(dev, "Unsupported fast timeout %u uS [max %u]\n",
 			hw_margin_min * 1000, FASTNG_MAX_US);
@@ -258,10 +257,10 @@ static int bd96801_set_heartbeat_from_hw(struct wdtbd=
96801 *w,
 	fast =3D FASTNG_MIN << sel;
=20
 	sel =3D (val & BD96801_WD_RATIO_MASK) + 1;
-	w->wdt.max_hw_heartbeat_ms =3D (fast << sel) / USEC_PER_MSEC;
+	w->wdt.max_hw_heartbeat_ms =3D (fast << sel) / 10;
=20
 	if ((conf_reg & BD96801_WD_TYPE_MASK) =3D=3D BD96801_WD_TYPE_WIN)
-		w->wdt.min_hw_heartbeat_ms =3D fast / USEC_PER_MSEC;
+		w->wdt.min_hw_heartbeat_ms =3D fast / 10;
=20
 	return 0;
 }

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
--=20
2.55.0


--a0cAK5QNLSFJ3KDV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmpsbJAACgkQeFA3/03a
ocVNAgf+MMF81a5YR7Pf41Vtp2N+78JtZlDvAxn5s+WBrELDmwTvzgzVT36gks+Y
XoWlvGUbzAFPlOQJ45E9Wr9dCfmRwzHbOjYz38C0mjx4ZDU2aUIHs3Mb2nVnE2y8
JxjV58Ew8csHJt88jujxoUPQPSqgdMH065T9my6VvenLJtj8P7JAJlSDd6m2rAhW
yduQrNE7itjeJD5j56dz/ZkdyaMzhXdbTg5qLaGAemzj1uM7oJVPAg6wq5eX35UW
39/SGhAOSUY+LZOoHOOYberwOqUleTlB6x16lYwEpfVbFhqz4I1alVuP/Xz5UoES
z+PXVCTDs79/4hehLqX4YHWuQAs0VA==
=4CB/
-----END PGP SIGNATURE-----

--a0cAK5QNLSFJ3KDV--
