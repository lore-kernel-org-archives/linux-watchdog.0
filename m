Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D39A330B01
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010106; cv=none; b=MGUn0qZgGvnu0ZjfU60WwYWaBLep/3KU4PZWS2GoMfy4M0PAqi6MEM72JrtQhC/O1ALxVf7uMQHeaJq2C/abY+kS3vHhFU+x/y4tBz1gD/m0qbR8Mchht8iFRec9Z9H5anZG+ILISqObRhXuLnh1f4GRFsujOLGgp95/0o3GZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010106; c=relaxed/simple;
	bh=Lg2p78CTj8EX1V3nDLgiEEnegleZ1jt+577hykcuVV4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MXKd9cJXclv1Pj003X3AFKufAoGnamKuE5V4C8gP+g++quEv5/pT57WXeUmh1GCB3Lb6RCbv7Ednt1sDmMTONCAuId608AgECb1twGiwH49j3ervse5AgpEO9bqfXOGfJ1MpU9F+zY6p7WNC4XygkVXmywcmEKgC/AEqS/9mLLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOwxbc2N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOwxbc2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57F41F00A3A;
	Thu,  2 Jul 2026 16:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783010105;
	bh=3aM361YCJDrJB+0RufvpxKv2Gycq5mGo1ReFWLksKPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lOwxbc2NUDL2WI+hzG3T9YsCtBX4z4XzcSgFeMjcRFvzBlb5m3aMv+kSkf+4QMKSV
	 5YKSdC50LaDy4RHLE2JAludTnKV5Vnt1Bo3OX5vzWKO769UFf51kvhzbJi+rUP82oJ
	 hQwZLRUjuvnB6zDewD6kPeLbRfeyh0AB3OcOuN0n0tjbrDEEflFTa/AEPp/1+AL6xK
	 2J6xK7yEq4qFd89TTMROjaCy1gIESf1STE4e/QaIZ92SxrvbV9B5NYfvVzoW3waT92
	 Uhg/NoL8tOihMnYt8IlF0TC6tUKxxMlxDXbzyZj4ilp661yimQj+f1rEA40uljfgi+
	 R1agylx+3DOsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] watchdog: rzv2h: Convert WDTDCR handling to regmap
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260702160457.1884345-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702160457.1884345-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702160457.1884345-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 16:35:04 +0000
Message-Id: <20260702163504.E57F41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The regmap framework allocates a standard spinlock by default, whi=
ch causes deadlocks or 'scheduling while atomic' bugs when called from the =
atomic watchdog restart handler.
- [High] Improper error rollback in `rzv2h_wdt_stop()` leaves the watchdog =
unconfigured but out of reset, which can lead to spurious reboots.
- [High] The watchdog restart handler aborts the system reboot if the regma=
p update fails.
- [Medium] Asynchronous `pm_runtime_put()` is followed by synchronous `pm_r=
untime_disable()` in the initialization error path, which cancels the power=
-down and leaves the hardware powered on.
--

commit 3a9f06deb3b8a110dd1799630b20292ab0c85c6e
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Date:   Thu Jul 2 16:04:56 2026 +0000

    watchdog: rzv2h: Convert WDTDCR handling to regmap

    This commit converts the WDTDCR register access from raw readl/writel
    variants over to the regmap framework. This acts as a preparatory step
    to allow the driver to natively support syscon-based system controllers.

> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index e9545b8f5fd09..d0b38450cc320 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c

[ ... ]

> @@ -179,8 +180,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wd=
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
Does this error path leave the watchdog out of reset without restoring its
required configuration?

If rzt2h_wdt_wdtdcr_count_stop() fails, the rollback deasserts the reset, b=
ut
the hardware reset wiped all watchdog configurations like the timeout value
in WDTCR.

Since the core sees the stop failed, won't it assume the watchdog is still
running and resume pinging it?

A subsequent ping would start the down-counter with uninitialized default
registers, which could cause a near-immediate spurious system reboot.

> +		}
> +	}
> =20
>  	pm_runtime_put(wdev->parent);
> =20

[ ... ]

> @@ -242,8 +249,17 @@ static int rzv2h_wdt_restart(struct watchdog_device =
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

[Severity: High]
Should a failure in an auxiliary register write abort an emergency system
reboot?

The restart handler is used to forcefully reboot the system in situations
like a kernel panic. Returning early here skips the rzv2h_wdt_ping() step,
which is what actually triggers the hardware to reset the system.

> +		}
> +	}
> =20
>  	rzv2h_wdt_ping(wdev);
> =20
> @@ -261,24 +277,39 @@ static const struct watchdog_ops rzv2h_wdt_ops =3D {
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
Will this regmap configuration cause deadlocks or scheduling while atomic b=
ugs
when called from the atomic watchdog restart handler?

The regmap framework allocates a standard spinlock by default because the
configuration omits use_raw_spinlock =3D true or disable_locking =3D true.

Since rzv2h_wdt_restart() runs in atomic context (and potentially NMI) duri=
ng
system panic or reboot, attempting to acquire a sleeping spinlock on
PREEMPT_RT could cause a crash. On all systems, if the lock was held by
another thread during a panic, the restart handler could deadlock and preve=
nt
the system from rebooting.

> +
>  static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
>  				 struct rzv2h_wdt_priv *priv)
>  {
> +	void __iomem *wdtdcr;
>  	int ret;
> =20
> -	priv->wdtdcr =3D devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(priv->wdtdcr))
> -		return PTR_ERR(priv->wdtdcr);
> +	wdtdcr =3D devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(wdtdcr))
> +		return PTR_ERR(wdtdcr);
> +
> +	priv->wdtdcr_regmap =3D devm_regmap_init_mmio(&pdev->dev, wdtdcr,
> +						    &rzv2h_wdtdcr_regmap_config);
> +	if (IS_ERR(priv->wdtdcr_regmap))
> +		return PTR_ERR(priv->wdtdcr_regmap);
> =20
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

[Severity: Medium]
Is it safe to use an asynchronous pm_runtime_put() here right before
returning a potential error code?

If rzt2h_wdt_wdtdcr_count_stop() fails, the error propagates back to
rzv2h_wdt_probe(), triggering devm cleanup which immediately calls
pm_runtime_disable().

As noted in the power management subsystem guidelines, calling
pm_runtime_disable() immediately after an async put cancels the pending
async operations. This would permanently leave the device hardware in an
active power state.

Should pm_runtime_put_sync() be used instead?

>  }
> =20
>  static int rzv2h_wdt_probe(struct platform_device *pdev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702160457.1884=
345-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2
