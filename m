Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17824270552
	for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123348; cv=none; b=G7jzbT7LAUOr/g0BwtUDeQQQt1UodH89oZ1Y0x2FRWIpcYyIxOBWxETQbUc/yMqPIqKgk9rIxavqHz0F31BOg1kRnEATXGJzQbCrtf2+l8yF3pWv0GAx0BvRqltRciOMh2IJBwzLwHhx3Zq8jNnS6EA+V7RuSlf7L1XMLb2IiMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123348; c=relaxed/simple;
	bh=zjkCs+t9R1UrsaMtmDV00jSNxuaRywqfKI2C3gkg6ME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f3cYVCjmwmQW2eysQzwW3n5Hm7nFuKK5H8lex79r4n6Ev3TH2BLOiMYBK/sAVddIE6gbezNo6aLYFxUGKcJX30zUchnbgOei3DxqnRfs0PSVkK/0JxCHykqFdFrKFBHac5MzU0+vPoIiVDa6ak5PBzFN7wObmiV38on51ppS/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epBtQEWV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epBtQEWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8443C1F000E9;
	Wed, 15 Jul 2026 13:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784123346;
	bh=sFEO2e8LTfwjoATJhDcMDVp1+nJvX6ozoplb3xEEKMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=epBtQEWVacoSuwBFbw0nc3xyQ9RL/GSz0LPkGIQcYul+XY6kPUcJUfWTuuvT1YBoU
	 WQsI1TEWwi9tH5S9RiVNfnEsl6yqXHG9PVeNs5lk5jyvtj6okWXpVilHHpZ17+j3b5
	 /XbfogXgIaF68A9ikfbBpKx/Cb+e9+1DSyjajnAcMNrBeEpczzqVriyGUi4vxqH1tf
	 iJCYw/otNrExPMYgSoWNvFe/AWel+ubi9l/1S1DVKllsAKANTERE+nOagmVSymGvNH
	 RzX7jrtZeA+LUpeasS3t7MUY9iQ7YpQIvp76JHni5ZOROBzHGx/MxlgqdNPOLYJl0b
	 X5bX8rRQE+xlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: rzv2h: Convert WDTDCR handling to
 regmap
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260715133922.2129340-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715133922.2129340-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715133922.2129340-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 13:49:06 +0000
Message-Id: <20260715134906.8443C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The conversion to the regmap API introduces a potential deadlock a=
nd sleeping in atomic context issues in the watchdog restart handler.
- [High] Deasserting the reset line in the error path of `rzv2h_wdt_stop()`=
 leaves the watchdog running unconfigured, potentially causing spurious reb=
oots.
- [Medium] The restart handler incorrectly aborts if the regmap operation f=
ails, skipping the actual hardware reset trigger.
--

--- Patch [1]: [PATCH v2 1/2] watchdog: rzv2h: Convert WDTDCR handling to r=
egmap ---
commit e599411a91a07a1899caa9c4c300e8ec3242933e
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

watchdog: rzv2h: Convert WDTDCR handling to regmap

This commit converts the WDTDCR register access to use the regmap framework.
It serves as a preparatory step to subsequently support syscon-based system
controllers natively without runtime architectural branching.

> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c
[ ... ]
> @@ -171,8 +174,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wd=
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

[Severity: High]
Will deasserting the reset line in this error path leave the watchdog runni=
ng
unconfigured?

Since reset_control_assert(priv->rstc) was called earlier in rzv2h_wdt_stop=
(),
the hardware's configuration registers, including timeout and clock divisio=
n,
have been cleared.

If rzt2h_wdt_wdtdcr_count_stop() fails and this error path calls
reset_control_deassert(), it brings the hardware out of reset with default
values. The watchdog core assumes the device is still active due to the
returned error and continues to ping it, which could start it counting with
default, short timeouts and trigger a spurious system reboot.

> +		}
> +	}
> =20
>  	pm_runtime_put(wdev->parent);
[ ... ]
> @@ -234,8 +243,17 @@ static int rzv2h_wdt_restart(struct watchdog_device =
*wdev,
>  	rzv2h_wdt_setup(wdev, priv->of_data->cks_min | WDTCR_RPSS_25 |
>  			WDTCR_RPES_75 | WDTCR_TOPS_1024);
> =20
> -	if (priv->of_data->wdtdcr)
> -		rzt2h_wdt_wdtdcr_count_start(priv);
> +	if (priv->of_data->wdtdcr) {
> +		ret =3D rzt2h_wdt_wdtdcr_count_start(priv);
> +		if (ret) {
> +			if (!active) {
> +				reset_control_assert(priv->rstc);
> +				clk_disable(priv->oscclk);
> +				clk_disable(priv->pclk);
> +			}
> +			return ret;

[Severity: Medium]
Since the restart handler executes in a best-effort emergency context, is it
safe to abort early here if a regmap operation fails?

If rzt2h_wdt_wdtdcr_count_start() returns an error, the function returns
immediately and skips the call to rzv2h_wdt_ping() below, which is the raw
register write that triggers the actual hardware reset. Skipping this might
cause the system to hang rather than successfully rebooting during a panic.

> +		}
> +	}
> =20
>  	rzv2h_wdt_ping(wdev);
> =20
[ ... ]
> @@ -253,24 +271,39 @@ static const struct watchdog_ops rzv2h_wdt_ops =3D {
>  	.restart =3D rzv2h_wdt_restart,
>  };
> =20
> +static const struct regmap_config rzv2h_wdtdcr_regmap_config =3D {
> +	.name =3D "wdtdcr",
> +	.reg_bits =3D 32,
> +	.val_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.max_register =3D WDTDCR,
> +	.fast_io =3D true,
> +};

[Severity: High]
Could this regmap configuration lead to deadlocks or sleeping in atomic
context when accessed from the restart handler?

The rzv2h_wdt_restart() function runs in an atomic panic context with
interrupts disabled. However, this regmap config omits .disable_locking =3D=
 true
and .use_raw_spinlock =3D true.

By default, this creates a standard spinlock. On PREEMPT_RT kernels, standa=
rd
spinlocks are sleepable rt_mutexes, which will cause a 'sleeping in atomic
context' BUG. On other kernels, if the restart handler interrupts another C=
PU
that is currently holding the regmap lock, attempting to acquire it in
regmap_clear_bits() could result in a hard deadlock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715133922.2129=
340-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1
