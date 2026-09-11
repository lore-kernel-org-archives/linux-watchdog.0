Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5CC46C820;
	Fri, 11 Sep 2026 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126364; cv=none; b=AZ1JKNYnJsrZTrsuVQi77HcANM4I+jic5M0NvHZYmi90uOX1YKLTybXSLMws+t899HWk5keczUk1vEv3zQrpgdk3Jb87xWeIrcw2m1R8Pi9uHPom3cSX/FBDSsMY+vxkKrP0sGbXdP4q9ZAV0iiTwhq9bJt4xotu0nqsbK5Bl9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126364; c=relaxed/simple;
	bh=4QdKHJnxfCg2TibksmmoIvTiihhQ8k069Yn1Q5P87lw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dysQvG2pO/zljcHUsI2vqblvR2fmKS3diVaayR9suLUCkn3uTJ17/54n4hNqg5w553WP1rokcA+m8hDIN2ErpsJWya0LVgVQ8CqGfH9qqcyE5Q0V3vqOTmYz/JXVlVsGft0KvAlQsaF1o5jBUHJeKR2G6bvh7H5rCLQ+sMC4srM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjAKvaEP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjAKvaEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0178F1F00899;
	Fri, 11 Sep 2026 11:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789126337;
	bh=oXRo3GkZkhTeda33qWkodMuay+UkYe2oRx5JPaQoxNA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjAKvaEP7kIh+1SJ4h5+GTDyH3WPab7XLee2BDcSj13Fem3ye8iucoVquF+ZAYFwg
	 esHI8iPMHTAu+P+AJuidUHM2U0OwhOXyE6yDrOjhbIH46i4UVBcpp1RU6LkmGGISRa
	 UYyjPn2hYhFKaSaNAo/TtL+odadaMfp7s4xiWcEUSWVy5S4b1M8ZIHxpP/nQBUupoX
	 RET/DasTr9KY97s4uyPo4dixIiSTgjwcR2KLwofOjtMUxJya/3utFxh+C4oZ4fSB40
	 YA0kUw+qrsPOoqnUTsEQB5iwGE+OViWeOL5ept35ZWFdSm4OlGgIiX5NvxtepWmtHu
	 Ukq5wenEGH6xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/8] watchdog: rzv2h: Drop enabling clocks in the
 restart handler
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260911111731.3404308-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911111731.3404308-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:32:16 +0000
Message-Id: <20260911113217.0178F1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked division by zero during probe if the optional 'oscclk' i=
s missing from the device tree.
--

commit e61522c3f4f781e0b8cf17bd6e22135a7d714358
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

watchdog: rzv2h: Drop enabling clocks in the restart handler

The watchdog restart handler runs from do_kernel_restart() with
interrupts disabled and after smp_send_stop() has halted the other CPUs.
Calling clk_enable() from the !watchdog_active() path takes the clock
framework's global enable_lock, which can cause a spin if another CPU holds=
 it.
This commit keeps pclk and oscclk enabled for the lifetime of the watchdog
device by using devm_clk_get_enabled() and devm_clk_get_optional_enabled().

> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index 3b6abb66a1da0..bd86da71b0eb8 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c

[ ... ]

> @@ -290,11 +277,11 @@ static int rzv2h_wdt_probe(struct platform_device *=
pdev)
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
> =20
> -	priv->pclk =3D devm_clk_get_prepared(dev, "pclk");
> +	priv->pclk =3D devm_clk_get_enabled(dev, "pclk");
>  	if (IS_ERR(priv->pclk))
>  		return dev_err_probe(dev, PTR_ERR(priv->pclk), "Failed to get pclk\n");
> =20
> -	priv->oscclk =3D devm_clk_get_optional_prepared(dev, "oscclk");
> +	priv->oscclk =3D devm_clk_get_optional_enabled(dev, "oscclk");

[Severity: High]
This is a pre-existing issue, but can this optional clock fetch result in a
divide by zero oops?

If the optional "oscclk" is legitimately omitted from the device tree (or t=
he
device tree is malformed), priv->oscclk will be successfully returned as NU=
LL.

Later in rzv2h_wdt_probe(), if the chip variant uses COUNT_SOURCE_LOCO, this
NULL pointer is assigned to count_clk and evaluated:

	switch (priv->of_data->count_source) {
	case COUNT_SOURCE_LOCO:
		count_clk =3D priv->oscclk;
		break;
	...

	priv->wdev.max_hw_heartbeat_ms =3D (MILLI * priv->of_data->timeout_cycles *
					  priv->of_data->cks_div) / clk_get_rate(count_clk);

Because clk_get_rate(NULL) safely returns 0, the unchecked division will
cause a divide error exception during device probe. Should this verify
count_clk or its rate before the division?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911111731.3404=
308-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1
