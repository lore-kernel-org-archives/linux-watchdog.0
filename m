Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FBF3EDAC5
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779228513; cv=none; b=crr9HTmtuT4GDdYdpHvOBf5F0BEgeetZKB8B2m6kk0Ob40OZq4TpNLyhkmzbZEYt1/B7V8c+xRmFuwPe5pxQVj7bS1qXdmjQ2UOIConv62E3UUKs09O93y7dwem7DAzuZnihT42DYEKT98wLfLOwp4OjK1fUE7cDxqBjs7Cb0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779228513; c=relaxed/simple;
	bh=XhT5EJoekNMPz3l+KQwlBA18nzKH/sThexqxf+AQcpI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aZt+28mC0VR8g1ofVyzH3Y6FMVkMl/c8Fsn6ONZfNjhPc2SDjLrtvqk+RScAe+g+lGB0frEvSiUiTl4aTPHEf4EedYklmfEr7QIJEiJqR0l1KFgENp+MGFqnIt6Kdv5Fr5gYchhFTMPwYdjP2yKXJsVZCuPzqy2Zo+prWWLlL/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZfX1bxV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZfX1bxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3131F0089A;
	Tue, 19 May 2026 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779228512;
	bh=CpElTvs/0KQwdhYbpuG8VSW+eQsGvTU7adhU3+V+8J8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZfX1bxVTKWldRHIj2TZM1l91EqL6JoSo0BOPIGwQLqFghoy8ounjMMn2tkWlYGQZ
	 WfNGd5ZGf9Os53rxmWAm085biw+N+0NoU1uTEnshG8INM+rUOUWXidokWpLSNPhWgy
	 yJkHTpsMaOZxsE0oQ4tQ76fxSWb5gmD/lt36FBIHWjvikxI/NvidzRIc2rJ2S/m+/G
	 JTIV6MfCDamPWr8oWlwqJnC+284WAW6/DDjK4jCnGsu0JY1ig5QfeA+kRcZsIFP39d
	 xh9H4tvvE4ziTKmtgdoNUnISkm2w73V+SUmUbPOMU4Hsrh4X3XPz+7P0Z7pz29DcL4
	 xiGKP5KlcODDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: orion_wdt: Use devm APIs for clock and
 watchdog management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260519214229.16656-1-rosenp@gmail.com>
References: <20260519214229.16656-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 22:08:31 +0000
Message-Id: <20260519220832.4A3131F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The local variable `ret` is declared but never used in multiple clo=
ck initialization functions (`orion_wdt_clock_init`, `armada370_wdt_clock_i=
nit`, `armada375_wdt_clock_init`, `armadaxp_wdt_clock_init`).
--

commit 2de00d567f4d73cf286aa9c7120abab320758a10
Author: Rosen Penev <rosenp@gmail.com>

watchdog: orion_wdt: Use devm APIs for clock and watchdog management

Replace clk_get/clk_prepare_enable/clk_put with devm_clk_get_enabled
and devm_clk_get_optional_enabled so the clock lifecycle is managed
automatically. Switch to devm_watchdog_register_device to eliminate
the manual remove callback and the disable_clk error path.

> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 0e145f762f6f2..b81ba2607c6d5 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -81,14 +81,9 @@ static int orion_wdt_clock_init(struct platform_device=
 *pdev,
>  {
>  	int ret;
> =20
> -	dev->clk =3D clk_get(&pdev->dev, NULL);
> +	dev->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(dev->clk))
>  		return PTR_ERR(dev->clk);
> -	ret =3D clk_prepare_enable(dev->clk);
> -	if (ret) {
> -		clk_put(dev->clk);
> -		return ret;
> -	}
> =20
>  	dev->clk_rate =3D clk_get_rate(dev->clk);
>  	return 0;

[Severity: Low]
This isn't a bug, but with the removal of clk_prepare_enable(), the local
variable ret is no longer used in this function. Should the declaration be
removed to prevent compiler warnings?

[ ... ]

> @@ -99,14 +94,9 @@ static int armada370_wdt_clock_init(struct platform_de=
vice *pdev,
>  {
>  	int ret;
> =20
> -	dev->clk =3D clk_get(&pdev->dev, NULL);
> +	dev->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(dev->clk))
>  		return PTR_ERR(dev->clk);
> -	ret =3D clk_prepare_enable(dev->clk);
> -	if (ret) {
> -		clk_put(dev->clk);
> -		return ret;
> -	}
> =20
>  	/* Setup watchdog input clock */

[Severity: Low]
This isn't a bug, but ret is also left unused in armada370_wdt_clock_init()
after these changes.

[ ... ]

> @@ -122,14 +112,11 @@ static int armada375_wdt_clock_init(struct platform=
_device *pdev,
>  {
>  	int ret;
> =20
> -	dev->clk =3D of_clk_get_by_name(pdev->dev.of_node, "fixed");
> -	if (!IS_ERR(dev->clk)) {
> -		ret =3D clk_prepare_enable(dev->clk);
> -		if (ret) {
> -			clk_put(dev->clk);
> -			return ret;
> -		}
> +	dev->clk =3D devm_clk_get_optional_enabled(&pdev->dev, "fixed");
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);

[Severity: Low]
This isn't a bug, but ret is also left unused in armada375_wdt_clock_init()
after these changes.

[ ... ]

> @@ -163,14 +144,9 @@ static int armadaxp_wdt_clock_init(struct platform_d=
evice *pdev,
>  	int ret;
>  	u32 val;
> =20
> -	dev->clk =3D of_clk_get_by_name(pdev->dev.of_node, "fixed");
> +	dev->clk =3D devm_clk_get_enabled(&pdev->dev, "fixed");
>  	if (IS_ERR(dev->clk))
>  		return PTR_ERR(dev->clk);
> -	ret =3D clk_prepare_enable(dev->clk);
> -	if (ret) {
> -		clk_put(dev->clk);
> -		return ret;
> -	}
> =20
>  	/* Fix the wdt and timer1 clock frequency to 25MHz */
>  	val =3D WDT_AXP_FIXED_ENABLE_BIT | TIMER1_FIXED_ENABLE_BIT;

[Severity: Low]
This isn't a bug, but ret is also left unused in armadaxp_wdt_clock_init()
after these changes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519214229.1665=
6-1-rosenp@gmail.com?part=3D1
