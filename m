Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3192E37F730;
	Wed, 13 May 2026 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778639254; cv=none; b=OZjQEIY4jJX+Su/lqPA/Y+HwmjsfgcadszPX0JbOVFcWAEet95hfsSHIQH20v3PwY3zSSvvq9d53WBfxA1w8kqyFeeHhxsHaisRftZdzcaPmhR/YJK8N1Pnk5skqMpXh491dFDGpuwAlw1Ss3JFoVxQiye+/BxgaTQUliTu67a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778639254; c=relaxed/simple;
	bh=3SSGM/TyAl2BOfXmKatXk9XkF67dEwYp/xjjoHolIK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R6jmo1sKxobVn63hQCanbchJy1ZQKKsqIGYqQDPvUlPL5cDFeKltQ+09NHAgps+YDFlutvSSZ7RREHGuddgxYIDnEv/eFQN5WwZ/RUAdq9m7TqZVtvp2xKgU86j6p1ghGArTYRFkPoyKZBV3x8PqtIlnhP7jp6P5oyOKHys2rcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHNGex57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHNGex57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7277DC2BCB0;
	Wed, 13 May 2026 02:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778639253;
	bh=3SSGM/TyAl2BOfXmKatXk9XkF67dEwYp/xjjoHolIK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IHNGex57D84m5oApn7ey/0tE+GlfnY575jeVtSr80lQqUB0ERo5MDpiV92BkTb93+
	 Xjv5Wa4gMJbaZX4Q8nQrmC77vX9NNC1W0Qrp4l3c2Zlb7ICdKuYA4AUtKeYkyKvMHV
	 Cqjv8AQNC66e+nI/yD74SsjnEnTbTqGimzA3AUMlQ5iOmaMSmJcgTL7VQAw2pnhxu1
	 ONNYqj5So3o0KjT6nOG1xcoBK1DpTjDhaJDGJfN4kYAF+GlCilyZlzLjOy9N7MBI6Y
	 cgI889SibO0l59i8YPT6gSpWyN7xwx+eV2KAYoKZrp505bMc3pSwtosLiGY6RAO41y
	 cTcmhFPjZQM5A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/9] watchdog: rzv2h: Add syscon support for RZ/T2H
 and RZ/N2H WDT control register
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, linux-watchdog@vger.kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260511185058.1926869-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260511185058.1926869-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 02:27:32 +0000
Message-Id: <20260513022733.7277DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Calling syscon `regmap_update_bits()` in the watchdog restart =
handler causes sleep-in-atomic BUGs and deadlocks.
- [High] Propagating non-fatal syscon errors aborts the system restart sequ=
ence.
- [High] Flawed error recovery in `rzv2h_wdt_stop()` leaves hardware active=
 but unconfigured.
- [High] Asynchronous `pm_runtime_put()` on probe error paths leads to perm=
anent power state leaks.
--

commit 350f84b9c5fd68e22e1aff72f286a475ec335167
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

watchdog: rzv2h: Add syscon support for RZ/T2H and RZ/N2H WDT control regis=
ter

This commit adds syscon support for accessing the WDTDCR register on
RZ/T2H and RZ/N2H SoCs. It updates the WDT driver to support both a
dedicated syscon regmap interface and direct mapping for backward
compatibility.

> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index e9545b8f5fd09..e14ff853a4e9f 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c

[ ... ]

> @@ -179,8 +208,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wd=
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

Does error recovery here leave the hardware active but unconfigured?

Since reset_control_assert() was called earlier in this function, the
configuration registers are cleared. If we deassert the reset and return
an error, the watchdog core assumes the stop operation failed and keeps the
WDOG_HW_RUNNING flag active, causing its background worker to continue
calling rzv2h_wdt_ping().

Could pinging the unconfigured hardware start the watchdog with arbitrary
default values and trigger an immediate, unintended system reset?

[ ... ]

> @@ -242,8 +277,17 @@ static int rzv2h_wdt_restart(struct watchdog_device =
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
> +		}
> +	}

Does using regmap_update_bits() via rzt2h_wdt_wdtdcr_count_start() in this
restart handler cause sleep-in-atomic or deadlock issues?

Restart handlers execute in atomic context with local interrupts disabled
during the machine_restart() sequence. Syscon regmaps use spinlock_t, which
sleeps on PREEMPT_RT kernels.

Additionally, since the syscon is shared with other peripherals, if another
CPU was interrupted and stopped while holding the regmap spinlock, could
this spin indefinitely and hang the system?

Is it safe to return early on syscon errors here?

rzv2h_wdt_restart() is a system reboot handler. By returning early, it skips
rzv2h_wdt_ping(), which is the operation that actually triggers the hardware
reset. Aborting the restart sequence because a shared control register
failed to update guarantees the system will hang instead of rebooting.

Should the restart handler ignore non-fatal setup errors and make a
best-effort attempt to trigger the reset?

[ ... ]

> @@ -264,21 +308,37 @@ static const struct watchdog_ops rzv2h_wdt_ops =3D {
>  static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
>  				 struct rzv2h_wdt_priv *priv)
>  {
> +	struct device_node *np =3D pdev->dev.of_node;
>  	int ret;

[ ... ]

>  	ret =3D pm_runtime_resume_and_get(&pdev->dev);
>  	if (ret)
>  		return ret;
> =20
> -	rzt2h_wdt_wdtdcr_count_stop(priv);
> +	ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
> =20
>  	pm_runtime_put(&pdev->dev);
> =20
> -	return 0;
> +	return ret;
>  }

Could this asynchronous pm_runtime_put() cause a permanent power state leak
on error paths?

If rzt2h_wdt_wdtdcr_count_stop() fails, the function returns an error. This
leads to a probe failure, and the devres teardown immediately calls
pm_runtime_disable().

Since pm_runtime_disable() executes a barrier that cancels any pending
asynchronous suspend requests, the device power domain could be left
permanently powered on in the RPM_ACTIVE state.

Should this use pm_runtime_put_sync() instead when returning an error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511185058.1926=
869-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D7
