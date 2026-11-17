Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908177;
	b=Q/XLH+DWlzLfnrG3GLN3MkPni6wJoprJH5Hz99uYn0IOx9/Kwf+mBJWBFgJk7P7D9Ix7
	 pA0HU/99dgjnMQOsa+53KVn1zvnYdFhHy74sKw89iZL0QyfFRmUTRQJ3eEPaHaSNHran1
	 lPtO96F95W9DNiyLlgVsOlpBu1uskQUuMrVX3Yp1jqesfQF7VonZ9WZgx+kJ6O02t9Mwg
	 nD5JaUggtM/1XXnRZGtmq6OoUntOCLXKVy0ZOQBzaQjpNNarDY+iX0Ha2fWZemedQDlNh
	 A3EYEoI93lZQZdjKAqO5yIeU09DdLbSqMAJm1RlnfpjKLFPTIWleVMp9X4K16JsWxJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908177;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rw60leFI4D5Nyd90yXF+UOMfI6voDXSSskxBI5Hp+DU=;
	b=pDvuRVlG+RprHuzAkoWdHxw9So+U1m1AZiwi2X9YTX6jNeFXMH1i6KHChPEix5a9+0Ax
	 xD6H1Bl+lON8bjOcSx4bZ5sncG3kdF1yBMbJQL6iKbbeNvKMr2Z2tb/hMDl7Tqhr2nV57
	 zFpRaJrgIBgxlYGbeHdYPaP/O6Fcadbg7DPBZTeD2Ywi+cwKQTEPfF8bMsdhRvn+5tE/E
	 akcn9sGI/ZWYmnUc/c0ds3hbqh6qcILi9BvOHqVrjiZDwaN7b8grWurw0fv0LQ7MHekd0
	 EfiEQYle8WNLRl5BCUL9jaQ1j2tirezMWQo8wnd4zTeJMIQDRXFF2oM7hfw5xDLCe+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CzR7MX/x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26110606A323;
	Tue, 17 Nov 2026 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzR7MX/x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F731F000C4;
	Tue, 17 Nov 2026 09:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794908176;
	bh=rw60leFI4D5Nyd90yXF+UOMfI6voDXSSskxBI5Hp+DU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CzR7MX/xoEwr7QvsuiWvQH0EdQv/z8sqt5zttxbnirYGA++TFqtF2ST/OCtR0SHYy
	 pxOu9oOtfbVQWzhqI/kIaXru2U+fxSbzCkl+fsT0Rk1ENgAGKsuItoL7BuQ625HMyl
	 0jhvJ7hxHKDpsswcp2HRWiKiY/Rpsx/pB2SDVf77k91oMWBU/2mQVy6njmBtNLYmRg
	 oKrkMQiWCl+yQ0kSamH20808ynCJU2YIIA0yqaMRF0hufwKmnjFZtj0oYZwONBtJb9
	 Q3psbfmUEyRAPet02IV8QUwaZN/mlJRnoy5xS1BC4U4pKBr4Ae3S8SubLU3upnG7Hi
	 gsu/wa2QBodNA==
Message-ID: <sashiko-outbox-218496@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: sunxi_wdt: stop the watchdog across system
 suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yang Siyuan" <hsyysy@163.com>
Cc: linux-watchdog@vger.kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20261117092036.12192-1-hsyysy@163.com>
References: <20261117092036.12192-1-hsyysy@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:36:16 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] watchdog: sunxi_wdt: unused function warnings when
  CONFIG_PM_SLEEP=3Dn
- [Low] watchdog: sunxi_wdt: redundant running_at_suspend state in
  sunxi_wdt_suspend()
--

commit 5093f8c201de1c0caf9e3ec2bb9831935e62dd95
Author: Yang Siyuan <hsyysy@163.com>

watchdog: sunxi_wdt: stop the watchdog across system suspend

This commit adds system sleep PM callbacks to stop the Allwinner watchdog
before suspend and restart it on resume if it was running.

> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> index a6500ebf24bad..23b50cb8d3ebc 100644
> --- a/drivers/watchdog/sunxi_wdt.c
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -55,6 +55,7 @@ struct sunxi_wdt_dev {
>  	struct watchdog_device wdt_dev;
>  	void __iomem *wdt_base;
>  	const struct sunxi_wdt_reg *wdt_regs;
> +	bool running_at_suspend;
>  };
> =20
>  /*
> @@ -225,6 +226,36 @@ static int sunxi_wdt_start(struct watchdog_device *w=
dt_dev)
>  	return 0;
>  }
> =20
> +/*
> + * The hardware watchdog has a maximum timeout of 16 seconds.  A system
> + * suspend easily lasts longer than that, and the watchdog core only can=
cels
> + * its ping worker during suspend; it does not stop the timer.  Stop the
> + * watchdog explicitly while suspended and re-arm it on resume.
> + */
> +static int sunxi_wdt_suspend(struct device *dev)
> +{
> +	struct sunxi_wdt_dev *sunxi_wdt =3D dev_get_drvdata(dev);
> +
> +	sunxi_wdt->running_at_suspend =3D sunxi_wdt_is_running(&sunxi_wdt->wdt_=
dev);
> +	sunxi_wdt_stop(&sunxi_wdt->wdt_dev);
> +
> +	return 0;
> +}
> +
> +static int sunxi_wdt_resume(struct device *dev)
> +{
> +	struct sunxi_wdt_dev *sunxi_wdt =3D dev_get_drvdata(dev);
> +
> +	if (sunxi_wdt->running_at_suspend)
> +		sunxi_wdt_start(&sunxi_wdt->wdt_dev);
> +
> +	return 0;
> +}

[Severity: Low]
Could sunxi_wdt_suspend() and sunxi_wdt_resume() check
watchdog_hw_running(&sunxi_wdt->wdt_dev) instead of tracking
running_at_suspend?  Both sunxi_wdt_probe() and the watchdog core already
maintain WDOG_HW_RUNNING in wdt_dev.status, and guarding sunxi_wdt_stop()
with watchdog_hw_running() also avoids reading and writing wdt_mode on
suspend when the watchdog is inactive.

Also, this driver neither sets max_hw_heartbeat_ms nor calls
watchdog_stop_ping_on_suspend(), so the comment's reference to the
watchdog core cancelling its ping worker during suspend does not apply
here.

> +
> +static const struct dev_pm_ops sunxi_wdt_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(sunxi_wdt_suspend, sunxi_wdt_resume)
> +};
> +
>  static const struct watchdog_info sunxi_wdt_info =3D {

[ ... ]

> @@ -348,6 +381,7 @@ static struct platform_driver sunxi_wdt_driver =3D {
>  	.driver		=3D {
>  		.name		=3D DRV_NAME,
>  		.of_match_table	=3D sunxi_wdt_dt_ids,
> +		.pm		=3D &sunxi_wdt_pm_ops,
>  	},
>  };

[Severity: Medium]
Does building with CONFIG_PM_SLEEP=3Dn warn about unused functions for
sunxi_wdt_suspend() and sunxi_wdt_resume()?  SET_SYSTEM_SLEEP_PM_OPS()
expands to nothing when CONFIG_PM_SLEEP is disabled, leaving both static
functions unreferenced.  Using DEFINE_SIMPLE_DEV_PM_OPS() with
pm_sleep_ptr(&sunxi_wdt_pm_ops) lets the compiler drop the callbacks and
PM ops structure without warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117092036.1219=
2-1-hsyysy@163.com?part=3D1
