Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5FE48EC64
	for <linux-watchdog@vger.kernel.org>; Thu, 10 Sep 2026 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045164; cv=none; b=OpwWFAWWhvSOwJ7zi/qbA986JwSkFtAIu949Ie8LPjWXtxNDqO103PiK9Ccw8bFWHlndJMtXCSEAbBo9up1pPkb6660RkGYF7+xIgxTDZKTftSsB3kmoWy7toAYPF3istlidMlxYsW7ou3Y3mhOH3nY24xOjwGeSPjJFsmMKUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045164; c=relaxed/simple;
	bh=OHH58YKAzYDO4wkDd8xIWDJbZ1MoFI/L7c35ub/4hxk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u6pgoevfiangNVvvTm5gMtV6sg7BlqBd0LdsRtki69YpN430I4xRDvaovK1zpQKzM+fTCymTdND1O09zcYpxTJFmmSBKRNHICcdNv53fc0s4jnDDH6EwH8SPslf/ckp6468wWzBgVCkV2Hkpby5s3nQpbxWtZCY739gQgB4uX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXgxqToK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXgxqToK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1BE1F000FF;
	Thu, 10 Sep 2026 12:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045160;
	bh=pFp9vQ5nkU2ebTfMcfJAUm+y8jdfZHXu+dwi/Ug/bIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXgxqToKpHQlEuPnWZr0IvGSutenfGrmP/0f3VOr3qgpVHjaH+yC4Tf49hrgaCaJM
	 ef4zDPNP27OfdBERy7HTr877ASKIWXlalJjFV5z9PLOxCGnvQWm3jcWh9B1oYdtCWa
	 I0+ZnTR2WNe4HIGwxbmIDkMEM/kEHwjiS8zfckfaAL/61m16u5JkW8/2SzkCUAk7sn
	 sm6ge3sQdctFtIJ/QEJJrCMMtrwjp5hdr7HVeyRJjMstl7E90g9aUJoQ1zK+R5e1tV
	 4Dfr4+aH/tjXsDqCnMp0/9LCa8+WyEI0WlB6dZZeqtAKk6cLDwwYYG7M4Em+sAXMTe
	 TPlDe6JbCzAIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: PM: use DEFINE_SIMPLE_DEV_PM_OPS and
 pm_sleep_ptr for dev_pm_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Jun" <lijun01@kylinos.cn>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260910124730.1127847-1-lijun01@kylinos.cn>
References: <20260910124730.1127847-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 12:59:20 +0000
Message-Id: <20260910125920.BC1BE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unmanaged clock leading to a potential system crash or unbalanced =
clock disable when the watchdog is already running at boot.
- [High] The watchdog is not stopped during system suspend if it was starte=
d by the bootloader but not opened by userspace, leading to an unexpected s=
ystem reset.
--

commit 100d7c43f251465f9d9e677807d28017a2e6ff77
Author: Li Jun <lijun01@kylinos.cn>
Subject: watchdog: PM: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr for de=
v_pm_ops

This commit replaces the deprecated SIMPLE_DEV_PM_OPS with
DEFINE_SIMPLE_DEV_PM_OPS and uses pm_sleep_ptr() to conditionally drop the
dev_pm_ops structure when CONFIG_PM_SLEEP is disabled.

> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
[ ... ]
> @@ -248,7 +248,7 @@ static int da9062_wdt_probe(struct platform_device *p=
dev)
>  	return devm_watchdog_register_device(dev, &wdt->wdtdev);
>  }
> =20
> -static int __maybe_unused da9062_wdt_suspend(struct device *dev)
> +static int da9062_wdt_suspend(struct device *dev)
>  {
>  	struct watchdog_device *wdd =3D dev_get_drvdata(dev);

[Severity: High]
This isn't a bug introduced by this patch, but does da9062_wdt_suspend()
properly handle a hardware watchdog that was left running by the bootloader?

If the hardware watchdog is started by the bootloader (WDOG_HW_RUNNING is s=
et)
but userspace has not opened /dev/watchdog, watchdog_active() evaluates to
false. During system suspend, the callback checks only watchdog_active()
and skips stopping the hardware timer:

    if (watchdog_active(wdd))
        return da9062_wdt_stop(wdd);

Meanwhile, the watchdog core suspends its background ping worker. The hardw=
are
timer continues ticking without being pinged and will eventually reset the
system unexpectedly while it is suspended.

[ ... ]
> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wd=
t.c
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -133,7 +133,7 @@ static int msc313e_wdt_probe(struct platform_device *=
pdev)
>  	return devm_watchdog_register_device(dev, &priv->wdev);
>  }

[Severity: High]
This is a pre-existing issue, but could the clock handling in
msc313e_wdt_probe() lead to a system crash or an unbalanced disable warning?

In msc313e_wdt_probe(), the clock is acquired but not logically enabled.
If the bootloader left the watchdog running, WDOG_HW_RUNNING is set. The
watchdog core immediately starts a background ping worker, bypassing the
driver's start() callback, so the clock remains logically disabled in the
Common Clock Framework (CCF).

During late boot, CCF disables all unused clocks, turning off the hardware
clock. Subsequent pings from the worker will access unclocked registers,
causing a bus fault.

Additionally, if the watchdog is later stopped, msc313e_wdt_stop() executes:

    clk_disable_unprepare(priv->clk);

Since the clock was never enabled by the driver during start, this will
trigger an unbalanced clock disable warning.

> -static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
> +static int msc313e_wdt_suspend(struct device *dev)
>  {
>  	struct msc313e_wdt_priv *priv =3D dev_get_drvdata(dev);

[Severity: High]
This is also a pre-existing issue, but this suspend function appears to sha=
re
the exact same logic flaw as da9062_wdt_suspend() mentioned above.

If WDOG_HW_RUNNING is set but userspace hasn't opened the device, the driver
skips stopping the hardware timer because watchdog_active() is false:

    if (watchdog_active(&priv->wdev))
        msc313e_wdt_stop(&priv->wdev);

With the core suspending the ping worker, the un-pinged hardware timer will
reset the system during suspend.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910124730.1127=
847-1-lijun01@kylinos.cn?part=3D1
