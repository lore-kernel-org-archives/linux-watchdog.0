Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D14346E017;
	Fri, 11 Sep 2026 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126046; cv=none; b=ft3lVMN9/C8PYISwjcy+PdnPCv2PQa9uqDT4/KsqL1wc8VWfSBZBVehmD3P9a7mAokwKFbVSr1mdo5jO9ooYBX6BRjXb6sk6Sb2oF8/GrENuG+N+8cvAabHyfalg2vBr5CiFeOOcvbVkGDZIvTSSkNYiUK/LfxyZEdah0A/OKwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126046; c=relaxed/simple;
	bh=0EImA0cQRAj8hTbQCOQ4gmx8Kl+2ITOKWDtJ7woDIpE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aSaJmBYzsswfKEL/JY5kaxFnkKutF+8odWqajp0p7xaE/+9eltpm2WFv6Lq9TXQvQSx9PxMez/7NJQQiQO06xuV9HI9yDO51c3/GkePtlGqu+YZhPU85Taw5QueZxlfVdbh5zRqJmVUvHekTmVD1HlhRKvxmkEsrX3YDsrQCSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLBv347A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLBv347A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355FA1F00893;
	Fri, 11 Sep 2026 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789126033;
	bh=GrlyMCW6Soo42+R2ov+ZFhgy/VEA7MigB1YeaiZrqBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLBv347AdWgI5WMV+WFrTTYWDYCj/co4dbRFhbYkaXGbPRpCP/uWnLdn4CBQClAZu
	 PE/IjARhq04MS6e/d9bHDLv7YpUI97tbx9CDgP3eAHYm65eCZK94mgcXCOu+NA5Cdx
	 qkfmFaOUi4O6AxIgS7NKblxI0c1+zn/XC0MnzzfboCfH3udS940fwmunxdZXykA3PR
	 D6VNkU0biXdFsVjFiqPaEe17DTK/jBR46WvI+/SfokhGvZuT66RoD6aRpB7g0wXKLs
	 TPs7yFRrBtIYZB1qEHFJcPRtN7e7XAeuUlp4YQi0yRsqR1UQGID3Vbctg/PEcs9aYr
	 v/fCcQMMxVtGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/8] watchdog: rzv2h: Use pm_runtime_put_sync()
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260911111731.3404308-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911111731.3404308-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:27:12 +0000
Message-Id: <20260911112713.355FA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: rzv2h_wdt_stop() still uses asynchronous pm_runtim=
e_put() during driver unbind, risking a race with pm_runtime_disable().
- [High] Kernel panic from division by zero when the optional 'oscclk' is m=
issing from the device tree.
- [High] Missing NULL check for of_device_get_match_data() return value lea=
ds to a NULL pointer dereference.
--

commit a446e675679ece36ef9554b71239f1b2c12cce73
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

watchdog: rzv2h: Use pm_runtime_put_sync()

pm_runtime_put() may trigger the idle check after pm_runtime_disable()
is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
runtime PM active.

Use pm_runtime_put_sync() to ensure the idle check runs synchronously.

> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index cbf414e0c9a3c..4a5a856060e91 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c
> @@ -270,7 +270,7 @@ static int rzt2h_wdt_wdtdcr_init(struct platform_devi=
ce *pdev,
> =20
>  	ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
> =20
> -	pm_runtime_put(&pdev->dev);
> +	pm_runtime_put_sync(&pdev->dev);
> =20
>  	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but it seems there is another
instance of this same issue in rzv2h_wdt_stop(). During module unbind, the
devres cleanup triggers watchdog_unregister_device(), which calls
rzv2h_wdt_stop(). This function issues an asynchronous pm_runtime_put():

drivers/watchdog/rzv2h_wdt.c:rzv2h_wdt_stop() {
	...
	if (priv->of_data->wdtdcr) {
		ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
		if (ret) {
			reset_control_deassert(priv->rstc);
			return ret;
		}
	}

	pm_runtime_put(wdev->parent);
	...
}

Should this also use pm_runtime_put_sync() to ensure the idle check complet=
es
before the devres cleanup calls pm_runtime_disable()?

[Severity: High]
This is a pre-existing issue, but I noticed a potential NULL pointer
dereference in rzv2h_wdt_probe(). The return value of
of_device_get_match_data() is not checked:

drivers/watchdog/rzv2h_wdt.c:rzv2h_wdt_probe() {
	...
	priv->of_data =3D of_device_get_match_data(dev);
	...
	switch (priv->of_data->count_source) {
	...
}

If the driver is bound via sysfs without device tree match data, could
priv->of_data be NULL here and cause a crash?

[Severity: High]
This is a pre-existing issue, but could the clock rate calculation result i=
n a
division by zero?

drivers/watchdog/rzv2h_wdt.c:rzv2h_wdt_probe() {
	...
	priv->oscclk =3D devm_clk_get_optional_enabled(dev, "oscclk");
	...
	switch (priv->of_data->count_source) {
	case COUNT_SOURCE_LOCO:
		count_clk =3D priv->oscclk;
		break;
	...
	priv->wdev.max_hw_heartbeat_ms =3D (MILLI * priv->of_data->timeout_cycles *
					  priv->of_data->cks_div) / clk_get_rate(count_clk);
	...
}

If the optional 'oscclk' is omitted in the device tree, priv->oscclk will be
NULL. When count_clk is assigned this NULL clock, clk_get_rate(count_clk)
safely returns 0. Will this cause a kernel panic due to division by zero?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911111731.3404=
308-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D4
