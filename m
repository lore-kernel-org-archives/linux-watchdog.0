Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF8318B83
	for <linux-watchdog@vger.kernel.org>; Sun, 11 Oct 2026 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791761562; cv=none; b=H5aOvJ+vUKZsp/DwAXZg2/r2lRQokcAVF7lAq7rgF1B2rocCZsswdkYCRDEh6lwH0ZCvi019bvIEDdipb5jUOsV5GT+rl3jJlJLfNvD//mfj1toulRiSurBx06BIczLTf4ymTfSQVQJycBRDD1F1znPS/XwLTlPrJDwnCIauD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791761562; c=relaxed/simple;
	bh=L5mEs+ruJ8zZYluPO2AIb5bXVMsnokgRJoyeVnAnHww=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KD6Fnp7FmluPEmMgCAlRJniTXUB/F+b6XbG/2xGzp4OhBH7Vfm3dIXt5Y+jDVq04RixNpKqpGEMkuc3UgL34HG0T1OqRf6vojlaSPUoZ5cuS9YklPbiWVkhMQ9dQH7hDHPnXTYrsy1t4t6sSvzTwB/mS33JAxWcDBJPTaT3HshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmcHAvMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmcHAvMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AB21F0089B;
	Sun, 11 Oct 2026 23:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791761561;
	bh=vosjW9vM64UvD5nYUeAp7QiDVjRgYVldFq9yYoCojxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YmcHAvMdhbfOphu09pLUT+HudZNpEvfUtTtldP8uH7bnexQLKc8LQgLO+hBxKuxcp
	 DPy9OwW5EfY3iFOtPq+GE8KpzbqNGGtBinxpAn9AZTkQVO7wG7xkpzoSm0pP1DfUHu
	 bh4FtQjjCzdCoG8I2i20QQUiHiEsXCkADlI4Zc9SwVane1diQvnlTtIFOr4xQfGzkV
	 /asBnIu2OpaESRV0WE8vYfH35MlEeOM965n+fVwTCKCL2jnYaPYlCm5t/cvnnEpCVz
	 Pn9e4b00z8bgqxfo6C6kN93Ia3VyktIKwDYCkZsFh2bnOICT5xyJQluJXES9ioiyR/
	 0neBCN7vLNYcw==
Message-ID: <sashiko-outbox-167515@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: orion_wdt: stop the watchdog during system
 suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261012-orion-wdt-suspend-v1-1-1676cb79e29e@iav.lv>
References: <20261012-orion-wdt-suspend-v1-1-1676cb79e29e@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 23:32:40 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] watchdog: orion_wdt: uninitialized pretimeout timer on Armada 370 =
resume
- [Low] pm: dev_pm_ops structure wrapped with pm_sleep_ptr() instead of pm_=
ptr()
--

commit 56ff9bfe90545f6af378431628185580afe76771
Author: Igor Velkov <iav@iav.lv>

watchdog: orion_wdt: stop the watchdog during system suspend

The watchdog timer keeps counting across system suspend while the
userspace that pings it is frozen, so it expires and resets the system.
Stop the timer on suspend and restart it on resume when it is active or
running in hardware.

> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 5d56e93f04064..0e3d896fe930d 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c

[ ... ]

> @@ -668,6 +668,29 @@ static void orion_wdt_shutdown(struct platform_devic=
e *pdev)
>  	orion_wdt_stop(wdt_dev);
>  }
> =20
> +static int orion_wdt_suspend(struct device *dev)
> +{
> +	struct watchdog_device *wdt_dev =3D dev_get_drvdata(dev);
> +
> +	if (watchdog_active(wdt_dev) || watchdog_hw_running(wdt_dev))
> +		return orion_wdt_stop(wdt_dev);
> +
> +	return 0;
> +}
> +
> +static int orion_wdt_resume(struct device *dev)
> +{
> +	struct watchdog_device *wdt_dev =3D dev_get_drvdata(dev);
> +
> +	if (watchdog_active(wdt_dev) || watchdog_hw_running(wdt_dev))
> +		return orion_wdt_start(wdt_dev);

[Severity: High]
Can this cause the pretimeout timer to fire prematurely or immediately upon
system resume?

When orion_wdt_resume() calls orion_wdt_start(), it eventually invokes
armada370_start() on Armada 370/XP:

drivers/watchdog/orion_wdt.c:armada370_start() {
    ...
	/* Enable watchdog timer */
	reg =3D dev->data->wdt_enable_bit;
	if (dev->wdt.info->options & WDIOF_PRETIMEOUT)
		reg |=3D TIMER1_ENABLE_BIT;
	atomic_io_modify(dev->reg + TIMER_CTRL, reg, reg);
    ...
}

The pretimeout timer (TIMER1) is enabled here without restoring or reloadin=
g its
duration (TIMER1_VAL_OFF). If context was lost or the timer resumes from its
residual value before suspend, could this trigger a kernel panic depending =
on
the pretimeout governor?

> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(orion_wdt_pm_ops, orion_wdt_suspend,
> +				orion_wdt_resume);
> +
>  static struct platform_driver orion_wdt_driver =3D {
>  	.probe		=3D orion_wdt_probe,
>  	.remove		=3D orion_wdt_remove,
> @@ -675,6 +698,7 @@ static struct platform_driver orion_wdt_driver =3D {
>  	.driver		=3D {
>  		.name	=3D "orion_wdt",
>  		.of_match_table =3D orion_wdt_of_match_table,
> +		.pm	=3D pm_sleep_ptr(&orion_wdt_pm_ops),

[Severity: Low]
Does this violate the PM subsystem guidelines by using pm_sleep_ptr() inste=
ad
of pm_ptr() for the dev_pm_ops structure pointer?

>  	},
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-orion-wdt-=
suspend-v1-1-1676cb79e29e@iav.lv?part=3D1
