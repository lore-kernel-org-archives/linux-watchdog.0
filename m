Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F39513543;
	Tue, 29 Sep 2026 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679971; cv=none; b=XxWy4XkNtUnmfojQuXiOrg5d13xgXHDZ75mHbK/N6fwLosNGKojkHm2/Z3WtSDtdvxv8XFTha7bpFCjkrtwjLdjWIOLuwRMiIOVbpVRctFVDTL8vC3ZJMTjn4DuIeCMQDIpFj3PxMcb0MrPO/6/KqazQC12Zz0KaTJXC3tSD1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679971; c=relaxed/simple;
	bh=THRbLMgQU5ELhjx/D7gt9yIJER60cNcFRMKyzcNuPAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T001xcWAwJor5cu3+uIFkdQe9cVG5CasWcog7Y714puG3ZnMfm6FsKr8fnRxhfIdb8wOXrcHHDukMUUFJLEonEjzI6a1WLye7NMNUd7VZy5LiSLdRxMG6WBIr3SuUbacw2IHc8ZHWZCBMCtwNkaNwu1YqCaAB93XC6hOqg9zCGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Al8mWn6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al8mWn6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D533D1F000FF;
	Tue, 29 Sep 2026 11:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790679963;
	bh=Ne+LAM94EKOmfH0s8ao4jZ9yEXIMBv03SQIbhg1rwDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Al8mWn6uqPpZpF3J8/Z5nX+I1GX4lDahAY56z6hG0znckQC5Ye7dHWANHTY3lX2gx
	 lT2FIXzTNRAWhZKfyPd4C22SsdFbPt+XaIK10JKaUnF8vGp7ybbPl1sbojvpigmuKV
	 SnxN3ikhueN1AEZ1U+xt7F+GVaSJJaR/ekPNwf8OZNDLrt1LpWFwCerRSkY4+JMViq
	 K4Mg6y6B+adcpZb/yY16kPnJpHTHDCp7i7cidwbBd8Z71JiCms8L9FIDIycOj7jHCo
	 6efrs9Kd75dn5e3TfKL5LdYVsZnS60I88Ou5htAcbT1FyC757R09reA7fVeXbx7UsA
	 /SbV+JyB1QcmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/8] watchdog: rzv2h: Drop enabling clocks in the
 restart handler
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260929105021.542730-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260929105021.542730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260929105021.542730-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:06:02 +0000
Message-Id: <20260929110602.D533D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] watchdog: unintended system reset during suspend due to permanentl=
y enabled clocks
--

commit 465743d35253a3a281f9ce8cea373ed0c3ae3e5a
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

watchdog: rzv2h: Drop enabling clocks in the restart handler
   =20
The commit drops dynamic clock enable/disable operations from the watchdog
restart handler to avoid deadlocking on the clock framework's global
enable_lock. Instead, it keeps the peripheral and oscillator clocks enabled
for the lifetime of the device using devm_clk_get_enabled() and
devm_clk_get_optional_enabled().

> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index f247e42d54f54..55ac11fcfcabd 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c

[ ... ]

> @@ -292,11 +279,11 @@ static int rzv2h_wdt_probe(struct platform_device *=
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
Does switching to devm_clk_get_enabled() and devm_clk_get_optional_enabled()
prevent the PM framework from fully gating these clocks during suspend?

By permanently incrementing the CCF enable_count by 1 here in probe, it app=
ears
that pm_clk_suspend() will only drop the count from 2 to 1 during system
suspend, leaving the clocks physically enabled.

If the clocks remain running while the system is suspended and the ping wor=
ker
is frozen, won't the hardware watchdog counter inevitably underflow and tri=
gger
an unintended system reset?

>  	if (IS_ERR(priv->oscclk))
>  		return dev_err_probe(dev, PTR_ERR(priv->oscclk), "Failed to get oscclk=
\n");
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929105021.5427=
30-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D3
