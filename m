Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380073;
	b=IZcKPQPBxXT6NErFzdnWPQZPaZbduoNTNXNv4uiRbMhZBpD4IrdwBOeHaCfoFVemFQdL
	 KrCRT95R/Vrl17fPivBEHSa0cSRHeT13LKQqd1MIbjZXJgo/KYj4TvqA4QCR15SE2nKwg
	 viHnt8GDsscQ48LZLxRC8mB2pPKgAqj/rFq6hgjqZP6zaVAeY1QeheBZniE9Ik8du2YlW
	 zvJ5pBfOu3iI8XOmXnpxdUxQzbPUAYX5vOBJbSBcyFeVFYeOxsmhaqo1/fidETYPPBMVi
	 7VsGMT0lwyXgmlA+Tcaex05vTCaCi1IK6NqYd3EpDzQjT13pIBo1CCUUlMJMoaEGGCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380073;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vViICgqsVJP6R3wCAPwb+zYFqGBa+yxRTxZzZbj63SM=;
	b=izs9C49mkyVZUW+VLUmsoYi1HjKVenUucaJA/OSSJlMl90fPQkSTlg0p7j3gLBM3tJkP
	 TIMh5tIUuRo32yAjL9wmF9i8TZe2IuLWQXlWt4XPmCAWw6JgT0pBAVfc5QiRuMcVVHFwv
	 mXYLkLvrGBhHyIFPz3h60CaipjnR1jkTi4IcSmoNu0x++MHjvNixXT1xRHLDcqvUxzXot
	 AntRqu/FrP/lqblNCZ8yrG20AgdMUiSXiNHoUNW3UIc5zGAOlqyKrJ6l5QMHqISluH4UP
	 BVBLD70LLwbLDgqxJa/imNBpRWET/6m1itwwrCvnKkVboYBH9eQyR55b+RkNgbeidsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfWqnCrZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A71606A320
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfWqnCrZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACE41F00A05;
	Wed, 11 Nov 2026 06:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794380073;
	bh=vViICgqsVJP6R3wCAPwb+zYFqGBa+yxRTxZzZbj63SM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nfWqnCrZSe9R6ED+LJpQrv4hCNW/9rkgCOH9NCfx2KJGkFpVLDLOHmFvuHOLLTfXo
	 Y4esHODqs7BdbehzPtlgNixZxVEruEECAvsNmHTyAIwecmGJZwy36rAqfzwcBIOnxM
	 lv+vFdOiuVTfDRzkMmfN2Yk19q/WMimkwuaqiNxwEbVLPUK95vtt9x7x6tDfet/oKM
	 pMHkY3c3bRL3FopvfdkkW1VTYQKiEcLONYpRHcJNhaAm3tFQftR+xrQu703JRwc8ol
	 xb4BYYnQqyYvP//EJ9HWFsCyUvgRv2dih8yrbA1QkL2bzodlmSgiNUvuR9RiXju6O1
	 NAWPS0qsyYcwg==
Message-ID: <sashiko-outbox-208470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: npcm: fix sleeping clock call in restart
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: zhaofeng2@cmss.chinamobile.com
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261111064150.260-1-zhaofeng2@cmss.chinamobile.com>
References: <20261111064150.260-1-zhaofeng2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:54:32 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] watchdog: npcm: open-coded devm_clk_get_optional_prepared() in
  npcm_wdt_probe()
--

commit d887f7d373bb7c1fa8a0907fd176d60b84597a65
Author: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

watchdog: npcm: fix sleeping clock call in restart handler

This commit prepares the watchdog clock at probe time and registers a devm
cleanup action so that npcm_wdt_restart() can call clk_enable() in atomic
context instead of clk_prepare_enable().

> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> index 4d8f212871447..4fb17f758cdbc 100644
> --- a/drivers/watchdog/npcm_wdt.c
> +++ b/drivers/watchdog/npcm_wdt.c

[ ... ]

> @@ -386,6 +390,11 @@ static const struct watchdog_ops npcm_wdt_ops =3D {
>  	.restart =3D npcm_wdt_restart,
>  };
> =20
> +static void npcm_clk_unprepare(void *data)
> +{
> +	clk_unprepare(data);
> +}
> +
>  static int npcm_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -414,6 +423,20 @@ static int npcm_wdt_probe(struct platform_device *pd=
ev)
>  	if (IS_ERR(wdt->clk))
>  		return PTR_ERR(wdt->clk);
> =20
> +	/*
> +	 * Prepare the clock once and keep it prepared for the lifetime
> +	 * of the driver: npcm_wdt_restart() runs in atomic context and
> +	 * may only call clk_enable().
> +	 */
> +	ret =3D clk_prepare(wdt->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(&pdev->dev, npcm_clk_unprepare,
> +				       wdt->clk);
> +	if (ret)
> +		return ret;

[Severity: Low]
Could devm_clk_get_optional_prepared(&pdev->dev, NULL) be used here
instead of open-coding clk_prepare(), devm_add_action_or_reset(), and
npcm_clk_unprepare()?  Also, since wdt->clk now stays prepared for the
lifetime of the driver, npcm_wdt_start() and npcm_wdt_stop() only need
clk_enable() and clk_disable() rather than clk_prepare_enable() and
clk_disable_unprepare().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111064150.260-=
1-zhaofeng2@cmss.chinamobile.com?part=3D1
