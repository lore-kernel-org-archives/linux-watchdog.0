Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACDA146A66
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806869; cv=none; b=Vy/2q1yHsrkYWcD/BNflasQiKrb7t8+AjEhYCLz7v+bNi3pJirxYLI8hHLwXnxnZGODert6T1h2MrCG/ko2xNQBO9jiaJyDIwdZ+QNcyxYOYCYKtplqCujtqg2cxB5/VgjpgIKg1WEPvWwMGJJwMyOFBpb4G40R0uCowqgat9jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806869; c=relaxed/simple;
	bh=59uDB8DHQDqgxMra/GkpI9bLwe83TXudZ48EhgXuuUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FtnuMq/jU2TGx4Z3XC4is88jE7PHz12acHKW4Pbzo1IGq12EfwNntWlA0VodTHoXiJY8k5CVZ0SvNOozo1uVF8yzlKXeE9N60V7aWepWUnjkl2hV0Z7uGww/470umLRjWBDMdMHBvBLglc861FCs4AjRqqcweW5kXUf1wEjYm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZocLmFDs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZocLmFDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD441F000E9;
	Thu, 27 Aug 2026 05:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787806867;
	bh=PGv5PhKmObqRjmQD5cfyYjPQNz96aMBqmNWpe06Z6fU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZocLmFDsCp5YqsBlGafG3QxMglB0rKBc/Y2hV5qDnLtKlZ1Uz3qa4Ea4bh5CkHB5L
	 1a6fOEjVnze3Omo0/upghrp7FjZWtX8O8rK/b4aBTK5DWjqyCOexzMTxaZHOkDzXI0
	 PbOBzoSf0LskgucLKjO71FPoSI+0hhfL6LupJgjNCXu3h+ymbAWi9x0igSL6g7MNIP
	 oWS2VwpU8GmkroWV1g3/eLJzMJwDw5yea7r3f17VECZA6P/8iyTs6dQ/lN6I5GqL3/
	 yfhoxLADXfCLcRyxROvzrsvVaqo8De3+Buftj7GLsSW4uwGEzjw/hu+Hsl5N5qHJaz
	 mzuL6gli2EqkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] watchdog: msc313e: Enable clock before accessing
 hardware registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260827044700.554333-3-tzungbi@kernel.org>
References: <20260827044700.554333-1-tzungbi@kernel.org>
 <20260827044700.554333-3-tzungbi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 05:01:07 +0000
Message-Id: <20260827050107.9AD441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Clock reference count is leaked on the probe error path if watch=
dog registration fails.

Pre-existing issues:
- [High] Repeatedly setting the watchdog timeout leaks clock prepare and en=
able references, potentially leading to refcount overflow.
- [High] System will unexpectedly reset during suspend if the hardware watc=
hdog is running but was never opened by userspace.
- [High] Potential division by zero if clk_get_rate() returns 0.
--

commit 363d0038f19004fef94c7716c644171a89070cb1
Author: Tzung-Bi Shih <tzungbi@kernel.org>
Subject: watchdog: msc313e: Enable clock before accessing hardware registers

msc313e_wdt_probe() reads from hardware registers without ensuring the
required clock is enabled. This patch calls clk_prepare_enable() before
reading WDT registers and leaves the clock enabled if the WDT is running.

> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wd=
t.c
> index 3b62650375628..b89b1cddaa5e8 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -98,6 +98,7 @@ static int msc313e_wdt_probe(struct platform_device *pd=
ev)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	struct msc313e_wdt_priv *priv;
> +	int ret;
> =20
>  	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)

[ ... ]

> @@ -120,9 +121,21 @@ static int msc313e_wdt_probe(struct platform_device =
*pdev)
>  	priv->wdev.max_timeout =3D U32_MAX / clk_get_rate(priv->clk);

[Severity: High]
This isn't a bug introduced by this patch, but does this code cause a divis=
ion
by zero panic during device probe if clk_get_rate() returns 0?

>  	priv->wdev.timeout =3D MSC313E_WDT_DEFAULT_TIMEOUT;
> =20
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
>  	/* If the period is non-zero the WDT is running */
> -	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT=
_MAX_PRD_H) << 16))
> +	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT=
_MAX_PRD_H) << 16)) {
>  		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
> +		/*
> +		 * Keep the clock enabled. The watchdog core will skip the next
> +		 * start() and a future stop() will balance the CCF reference
> +		 * count.
> +		 */
> +	} else {
> +		clk_disable_unprepare(priv->clk);
> +	}
> =20
>  	watchdog_set_drvdata(&priv->wdev, priv);
>  	platform_set_drvdata(pdev, priv);

[Severity: Medium]
If the hardware watchdog is already running at boot, the driver intentional=
ly
leaves the clock enabled here. However, if devm_watchdog_register_device()
subsequently fails:

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_probe() {
    ...
	return devm_watchdog_register_device(dev, &priv->wdev);
}

Does this regression leak the clock reference count on the error path if
device registration fails, since the prepared clock is never disabled?


[Severity: High]
This is a pre-existing issue, but repeatedly setting the watchdog timeout
leaks clock prepare and enable references, potentially leading to refcount
overflow.

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_settimeout() {
    ...
	return msc313e_wdt_start(wdev);
}

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_start() {
    ...
	err =3D clk_prepare_enable(priv->clk);
    ...
}

Since the set_timeout callback directly wraps msc313e_wdt_start(), does this
sequence unconditionally increment the clock refcount every time the timeout
is updated, without a corresponding decrement?


[Severity: High]
This isn't a bug introduced by this patch, but will the system unexpectedly
reset during suspend if the hardware watchdog is running but was never open=
ed
by userspace?

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_suspend() {
    ...
	if (watchdog_active(&priv->wdev))
		msc313e_wdt_stop(&priv->wdev);
    ...
}

If the watchdog was left running by the bootloader (WDOG_HW_RUNNING is set)
but never opened by userspace, watchdog_active() is false and the driver
skips stopping it. Meanwhile, the watchdog core suspends its background ping
worker.

Since the hardware timer continues counting down without being pinged, will
it expire and reset the suspended system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827044700.5543=
33-1-tzungbi@kernel.org?part=3D2
