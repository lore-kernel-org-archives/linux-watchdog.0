Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C305478E55
	for <linux-watchdog@vger.kernel.org>; Tue, 16 Jun 2026 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630411; cv=none; b=uEqX60qdNE7sBbes6oWp6WvSWvlmzx2b/xq60Gmi/HIoxoTyUY00tO/vp7DK+NosOmcLGKEqlKedghSYepnArqeWQqY4MfvKt1/e80XPHPzhJ4SOSeJTc8VoJ54Qa5IPiEYAhaYv8Wp/1cn6D7vtRkYQYtsfMMFkXk2a2zMcveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630411; c=relaxed/simple;
	bh=wvz/IZ9nYIO9deynV6sRlIvJ5S4pgJkVy1sEMot304w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D6NmrJJmKHu9PCpjKEPv/2rN9H5MSXmEi8IDA6S5fm0X20UNwshleU4+DlCqJ3z0CEfQh7dLzqO65AyKOy27TPiG+nayLL0gFL2ncaYj6FPBI3XVka7l7wSwb531nwSTj9St2RUgptlXV32rMWLxHWW8uEeQUtwS40QHLHEBpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlnvIFtz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlnvIFtz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C951F000E9;
	Tue, 16 Jun 2026 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781630410;
	bh=KG100ujbwUenzY8dSJkvtsg4KAv9ZwJQumdaXKlqW1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MlnvIFtz82x6u/gyvOOGCSZPvHH3eS//LyiFRZBVM51rmeoqT6caYyKkcisMIbrCK
	 K7CWe10Iu0Bu+JZwMujGMeD2Bz2OZQyFb9KTER+J/vBTD2iewNjiVwEX+zJRtpcoFX
	 dK7yEDwqS4Le9yFbCM7qsKiZMfJUB3Jn4jd9KdK3dZfzxmOHihXpqkteizXsMojd6k
	 4NZkN+GQKNsTM8g6LRhqOuwN7hNttcUvh07P4VsxWWQDFl1R9OrKIV5YYNhq6N/68s
	 UwDXuX/dkP30zXECykZtKNGZ9CM5bDkz4gGXO82OKAVr0shk/wlTKVSRBm7L1SIM2a
	 uIXwSl09S6imQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Watchdog: fix pretimeout noop governor logging and
 description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Egidio" <lorenzoegidioms@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260616171955.658-1-lorenzoegidioms@gmail.com>
References: <20260616171955.658-1-lorenzoegidioms@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 17:20:09 +0000
Message-Id: <20260616172009.F2C951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch leaves the `%d` format specifier in the `pr_alert` str=
ing but removes the corresponding argument.
--

commit 0327e7d6697fa21e6b3ac5f9311da43e2ca86831
Author: Lorenzo Egidio <lorenzoegidioms@gmail.com>

Watchdog: fix pretimeout noop governor logging and description

This commit updates the watchdog pretimeout noop governor by removing
the usage of wdd->id to avoid potential compilation issues on different
kernel versions. It also corrects the module description to match the
governor's name.

> diff --git a/drivers/watchdog/pretimeout_noop.c b/drivers/watchdog/pretim=
eout_noop.c
> index 74ec02b9ffca4..ddb5192fb06bc 100644
> --- a/drivers/watchdog/pretimeout_noop.c
> +++ b/drivers/watchdog/pretimeout_noop.c
> @@ -17,7 +17,7 @@
>   */
>  static void pretimeout_noop(struct watchdog_device *wdd)
>  {
> -	pr_alert("watchdog%d: pretimeout event\n", wdd->id);
> +	pr_alert("watchdog%d: pretimeout event\n");

[Severity: Medium]
Does this leave a format specifier without a corresponding argument?=20

The commit message suggested changing the string to=20
"watchdog: pretimeout event\n", but the %d is still present in the format=20
string. This will likely cause pr_alert() to read an uninitialized integer=
=20
from the stack or a register, resulting in garbage values being printed to=
=20
the kernel log.

>  }
> =20
>  static struct watchdog_governor watchdog_gov_noop =3D {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616171955.658-=
1-lorenzoegidioms@gmail.com?part=3D1
