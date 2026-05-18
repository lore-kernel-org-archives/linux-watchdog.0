Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFB396567
	for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139166; cv=none; b=QVqw75tGuhpSCQgxT5Q5zWMf8Gv2+bdAKf7Rf3BYkbhYue8DDUBtLFbkaYWGrfzbpfK/HSV/YAbDgKDvTMoTJwMj8Gjt9vHqmFMPmZOg7vP7L87jstCIPFwwbf3T9Yqj7fz5cXhf3+rXDLKBW0YAxdAT9TDCKt/oUxMFWmWqOcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139166; c=relaxed/simple;
	bh=z/IKQT2qNU1preXnMIOsfMyp9Ueam2BnnYvUReOeqmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ad/jL7nBa396Dp6nVS2N/4PVLLWuZNX90PJmyNu/sCVbT69zfTfRGRyJeg4CJYiFC5CpfbZJEzLcf4jY5NzPSA1NBI+y0f1E9yuv3NFlU3FaY8tbRDt6akK4ApBeRv6xNEhx5pPuacVuWqbuIgfplxMcvw8pdQ+rMM5mGuH5xho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7F0bxvh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7F0bxvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24FDC2BCB7;
	Mon, 18 May 2026 21:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779139165;
	bh=z/IKQT2qNU1preXnMIOsfMyp9Ueam2BnnYvUReOeqmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=j7F0bxvhjIFo5hiT6lUbfvTcDmmPgTDGhdAFxRIJgrwfKpIS3PDspfd6ycKThtBf4
	 oHcsEG/50wVJ4UyDlSLskX5ik4PaFSQUWLtD425V1JTZWcuoAeKMa8v0o+NLzrFSmo
	 qm4JkN4XgUkWuGxjxYCjQ7n6U8qDI5vIFHTOkmgbUZI9jkvhQ2RTRcOdfG2IpWgeI8
	 jFbTImUBSdbMJvRUvC8XIwZrHwOGZ9z7JxLRKrzUl7IVlZQjRO8VqfQVfTfdgGVmai
	 bFW0Fqxkzn8Ch5jXGqARLTnzwEmWksM3ByEUnsdOH847B7eoM0qEMOMpCBxIvz06ui
	 xBwVjEphLSmiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: ath79_wdt: select OF and COMPILE_TEST
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260518210957.10545-1-rosenp@gmail.com>
References: <20260518210957.10545-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 21:19:24 +0000
Message-Id: <20260518211925.A24FDC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Permanent failure of deferred probing and device re-binding due to=
 uncleared global `wdt_base` pointer on error paths.
- [Medium] Mismatch between Kconfig changes and commit message regarding OF=
 dependency.
--

commit 279311df3b831cb8a967974beeea1a51baecd0ac
Author: Rosen Penev <rosenp@gmail.com>

watchdog: ath79_wdt: select OF and COMPILE_TEST

This has always been an OF driver. Select OF in Kconfig.

Add COMPILE_TEST for all platforms, not just ARM.

> watchdog: ath79_wdt: select OF and COMPILE_TEST
>=20
> This has always been an OF driver. Select OF in Kconfig.

There is a discrepancy between the commit message and the implemented code.
The commit message states it will "select OF", but the patch implements
"depends on OF". Could the commit message be updated to match the
implementation?

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5d..1590f82941ba8 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1811,7 +1811,8 @@ config M54xx_WATCHDOG
> =20
>  config ATH79_WDT
>  	tristate "Atheros AR71XX/AR724X/AR913X hardware watchdog"
> -	depends on ATH79 || (ARM && COMPILE_TEST)
> +	depends on ATH79 || COMPILE_TEST
> +	depends on OF

[ ... ]

While reviewing this patch, I noticed an existing issue in the probe
function's error handling. The driver uses a global pointer to enforce a
singleton instance:

drivers/watchdog/ath79_wdt.c:ath79_wdt_probe() {
    ...
	if (wdt_base)
		return -EBUSY;

	wdt_base =3D devm_platform_ioremap_resource(pdev, 0);
	if (IS_ERR(wdt_base))
		return PTR_ERR(wdt_base);

	wdt_clk =3D devm_clk_get_enabled(&pdev->dev, "wdt");
	if (IS_ERR(wdt_clk))
		return PTR_ERR(wdt_clk);
    ...
}

If devm_platform_ioremap_resource() returns an error pointer, or if a
later step like devm_clk_get_enabled() returns -EPROBE_DEFER, the global
wdt_base pointer is never cleared.

Does this permanently break deferred probing and device re-binding? On a
second probe attempt, the uncleared wdt_base pointer would still evaluate
to true, causing the probe to immediately fail with -EBUSY.

Similarly, since ath79_wdt_remove() does not clear wdt_base, will unloading
and reloading the driver also fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518210957.1054=
5-1-rosenp@gmail.com?part=3D1
