Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F8D44F55F;
	Fri, 11 Sep 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125975; cv=none; b=bqv1HMNosP6QfEUgNz78IpW3N6M+cDve1CBeSBZJ/hBzIXgqaWANduGwVhKKTtGindD756UQs1Ep5I0pRBhbf6XvZJirZ9vYC407MWk/zWfiwYcGF7Hivc1YePq345vO7C6xWHi4gwrhVA2ozyWmsr+/b2ycfTQkJUstsWf3c7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125975; c=relaxed/simple;
	bh=seBYEq9+qZkkQyai8CdB6lT7YtSbhi7app8kmUyqyNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JTt5v5aj9dKJT/cHwxRudoFny77TzWgpX8Q022KbK67Hg9LaiVi5I/FBc6MeZk27pClhwsyNcuCq+bhdPuWWE7S5ppXxCraqR7F7YMBUCs1cQngt9I2RA79ANu/z9XaZoJWNWoajC3Diz9VmP+/FLnhz4UJoFTAKlx0NpacRISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRXpBRdG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRXpBRdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3239E1F00893;
	Fri, 11 Sep 2026 11:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125967;
	bh=LCLqVBrexOloJvj7eM+8M7WlA0mdNgqWtNJD7YSt1/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XRXpBRdGZgz45tNOlLY3USvFRHQVA81g/jKooH2DMuOltKRAu/6WWBx5BKJ4Wg3/0
	 1+UuOnMREWNuAB8QA/95mMhGVbUMKsRspKbYJib3dTbwRDLrb0xuoXJbNW1iKVNPsi
	 STtoDg3PfV4F2AoMZS62y0a49tX8ICEbOS/T2E6vC1Zv2+ZkxL823mWc1e/YATHXpB
	 5z5/BixW60b5ZyO7XjhzNlxyvGRCt1sRRE+F1oszdT0BwaiyXNyhNkB6lOxC4qIV9+
	 uuM0v4RPRbFfHcJouT8gHEwJvVe68pINNJvxjjnUmLrVvXxwGtpi3rusLMuZQcrnI8
	 iUeP7vkKie7bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/8] watchdog: rzv2h: Propagate WDTDCR access errors
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260911111731.3404308-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911111731.3404308-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:26:06 +0000
Message-Id: <20260911112607.3239E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The error path in rzv2h_wdt_stop() leaves the watchdog unconfigure=
d and missing a required delay after reset deassertion.
--

commit 3f7bad2568920b818b4bdb62349364febc443827
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

watchdog: rzv2h: Propagate WDTDCR access errors

The WDTDCR helpers currently access the register directly, but this will
change to use regmap, which can fail. This commit propagates errors from
rzt2h_wdt_wdtdcr_count_start() and rzt2h_wdt_wdtdcr_count_stop() and unwinds
the resources if an error occurs.

> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index 7c6a4855bd8ad..cbf414e0c9a3c 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c
[ ... ]
> @@ -169,8 +179,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wd=
ev)
>  	if (ret)
>  		return ret;
> =20
> -	if (priv->of_data->wdtdcr)
> -		rzt2h_wdt_wdtdcr_count_stop(priv);
> +	if (priv->of_data->wdtdcr) {
> +		ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
> +		if (ret) {
> +			reset_control_deassert(priv->rstc);
> +			return ret;
> +		}
> +	}
> =20
>  	pm_runtime_put(wdev->parent);

[Severity: High]
Does this error path leave the hardware in an uninitialized state?

When rzt2h_wdt_wdtdcr_count_stop() fails in rzv2h_wdt_stop(), the code calls
reset_control_deassert() to bring the hardware out of reset. However, it
does not include the mandatory udelay(3) wait for clock stabilization or
restore the watchdog register configuration via rzv2h_wdt_setup().

This leaves the hardware out of reset but unconfigured, which might trigger=
 an
immediate spurious reboot if default timeouts are active, or fail to reboot
the system during a hang if the watchdog remains dormant.

Could this error handling be updated to fully restore the previous watchdog
state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911111731.3404=
308-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D3
