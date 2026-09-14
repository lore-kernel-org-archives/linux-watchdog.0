Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06E2931D5
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405405; cv=none; b=YosF/psqhQirHaBQxz4HfteFDKqexnqS+U7wCFpBPe6ZP2bSsMxXxHR0C+wg1khlxg29rnGYydQWmuoePg2NO1zH+p5a2P7PPzQRJfe+47w28Is81Rw5pqM63CTtmZXBbCn9Za9TgtQiJEC4t7zl32nsU1YRnOf3f/sZRTBgWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405405; c=relaxed/simple;
	bh=JSiHdvh7DWiZqi58FpIukQBnqlTqJlfWuTvpRQ4qP9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iFNsC2tfli/BCEBLiN7tDG0hVSDSCZSlKMF1zN30/7uIRev1zv72Tg/uZaVgmREpSC5c89noIes7yOVgTy25RMkgLxi6EZ2gstU4CtBGpqzEM1usRLkwlU12j/u/YoBq2c1EDLaPGvG+APl6U1pBn3qFxCX81C+QWFwdh5CnaVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9yvxXeb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9yvxXeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3691F000FF;
	Mon, 14 Sep 2026 17:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789405404;
	bh=9wnecXu8SAnV0vJPdKV/GIwURpC/7soJjyc9kssnScc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W9yvxXeb6zGfkATKy9+H6bHqKt/BY/Wd6GYjpG8AKj12KJsKyMqV6AQQ2L97dLMko
	 EYetkZWs0721aQghN2plMfYTOBaYT5VoBwCLqCgUZvmMp1HQ0lMAiuShsBIBhi5XKX
	 prRUDJpkHJcW49Qk4QGOW8H/0DZ8LPXnzlwVwU5M+hUTHlgymkMgE04cigGB8cqR7D
	 c4ajINKlx9SqcMUqX9N0gIglL2mcgWNuZ2hPwEEgwyz/1fb19WTo05ZEQin9/jcqCi
	 e6KZ5FPHZ7x4rhCaeuP20qW8vXDMfhxInbRrMiu8kI1tp8DC7mpAPNBB0Ee2T/ceRT
	 GORefXHcTw1MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: starfive-wdt: fix PM reference leak in probe
 error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ivy Lopez" <skunkolee@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260914165022.169877-1-skunkolee@gmail.com>
References: <20260914165022.169877-1-skunkolee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 17:03:23 +0000
Message-Id: <20260914170323.EB3691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] Double clock disable in the probe error path leads to clock underf=
low.
- [High] Double pm_runtime_put_sync() and usage counter underflow when fall=
ing through from err_unregister_wdt.

Pre-existing issues:
- [High] Missing `pm_runtime_disable()` when `probe()` fails during clock e=
nablement or PM resume.
- [High] `starfive_wdt_set_timeout()` unconditionally enables the watchdog =
hardware, which can unexpectedly start a stopped watchdog.
- [High] Unbalanced PM usage count decrement in shutdown callback.
- [High] Hardware access while runtime suspended in remove() and shutdown().
- [Medium] The driver incorrectly treats a return value of 1 from pm_runtim=
e_put_sync() as an error.
- [Medium] The driver permanently leaks the PM usage count across driver un=
binds if early_enable is true.
--

commit bf7d8a19365abbc34b40d8597c85a439ec80777c
Author: Ivy Lopez <skunkolee@gmail.com>

watchdog: starfive-wdt: fix PM reference leak in probe error path

pm_runtime_resume_and_get() increments the runtime PM usage counter
on success. If a later step in probe() fails (reset_init, clock rate
check, watchdog_start, or watchdog_register_device), control reaches
err_exit, which calls pm_runtime_disable() but never puts the
reference, leaking the PM usage count.

> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-=
wdt.c
> index af55adc4a3c69..f87f8d5a3dabb 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -510,6 +510,8 @@ static int starfive_wdt_probe(struct platform_device =
*pdev)
>  	watchdog_unregister_device(&wdt->wdd);
>  err_exit:
>  	starfive_wdt_disable_clock(wdt);
> +	if (pm_runtime_enabled(&pdev->dev))
> +		pm_runtime_put_sync(&pdev->dev);

[Severity: High]
The probe function correctly calls pm_runtime_resume_and_get(&pdev->dev),
which implicitly enables the clocks via starfive_wdt_runtime_resume().

On failure, the code jumps to err_exit and explicitly calls
starfive_wdt_disable_clock(wdt).

By adding pm_runtime_put_sync(&pdev->dev) here, it synchronously invokes
starfive_wdt_runtime_suspend(), which also calls
starfive_wdt_disable_clock(wdt) a second time.

Does this code double-disable the clocks and cause an underflow in the Comm=
on
Clock Framework?

[Severity: High]
At the end of starfive_wdt_probe(), if !early_enable, the driver invokes
pm_runtime_put_sync(&pdev->dev) to drop the PM reference.

Because pm_runtime_put_sync() unconditionally decrements the usage counter
regardless of its return value, any failure still results in a decremented
count.

If that first call returns an error, the code checks if (ret) and executes
goto err_unregister_wdt;, which falls through to err_exit:

drivers/watchdog/starfive-wdt.c:starfive_wdt_probe() {
    ...
	if (!early_enable) {
		if (pm_runtime_enabled(&pdev->dev)) {
			ret =3D pm_runtime_put_sync(&pdev->dev);
			if (ret)
				goto err_unregister_wdt;
		}
	}

	return 0;

err_unregister_wdt:
	watchdog_unregister_device(&wdt->wdd);
err_exit:
    ...
}

Could falling through to err_exit drop the usage counter below zero and sev=
erely
corrupt the runtime PM state, because the patch adds a second
pm_runtime_put_sync() call in err_exit?

>  	pm_runtime_disable(&pdev->dev);
> =20
>  	return ret;

[Severity: High]
This is a pre-existing issue, but if pm_runtime_resume_and_get() or
starfive_wdt_enable_clock() fail early in starfive_wdt_probe(), the function
immediately executes return ret;, bypassing the err_exit cleanup block:

drivers/watchdog/starfive-wdt.c:starfive_wdt_probe() {
    ...
	pm_runtime_enable(&pdev->dev);
	if (pm_runtime_enabled(&pdev->dev)) {
		ret =3D pm_runtime_resume_and_get(&pdev->dev);
		if (ret < 0)
			return ret;
    ...
}

Because pm_runtime_disable(&pdev->dev) is skipped on these paths, the disab=
le
depth remains unbalanced.

Will this leak the PM enablement state and cause an
"Unbalanced pm_runtime_enable!" warning upon a subsequent re-probe?

[Severity: High]
This is a pre-existing issue, but starfive_wdt_set_timeout() unconditionally
calls starfive_wdt_enable() after updating the reload count:

drivers/watchdog/starfive-wdt.c:starfive_wdt_set_timeout() {
    ...
	starfive_wdt_disable(wdt);
	starfive_wdt_set_reload_count(wdt, wdt->count);
	starfive_wdt_enable(wdt);
    ...
}

If a user explicitly stops the watchdog (using WDIOC_SETOPTIONS with
WDIOS_DISABLECARD) and then sets a new timeout, this will silently turn the
hardware back on.

Can this break the watchdog core's state tracking and result in an
unexpected system reboot when the hardware watchdog times out?

[Severity: Medium]
This isn't a bug introduced by this patch, but according to the Power
Management subsystem guidelines, pm_runtime_put_sync() returns 1 when the
device is already suspended.

This is a success condition, not an error.

drivers/watchdog/starfive-wdt.c:starfive_wdt_probe() {
    ...
			ret =3D pm_runtime_put_sync(&pdev->dev);
			if (ret)
				goto err_unregister_wdt;
    ...
}

Does treating any non-zero value as a failure violate the API contract and
potentially trigger the error rollback path incorrectly?

[Severity: Medium]
This is a pre-existing issue, but if early_enable is true,
starfive_wdt_probe() intentionally skips pm_runtime_put_sync(), leaving
the device's PM usage_count incremented by 1.

When starfive_wdt_remove() unregisters the device and disables PM, it fails
to drop this initial reference:

drivers/watchdog/starfive-wdt.c:starfive_wdt_remove() {
    ...
	if (pm_runtime_enabled(&pdev->dev))
		pm_runtime_disable(&pdev->dev);
    ...
}

Because the platform device structure is not destroyed on unbind, its
usage_count is not reset.

Will a subsequent driver bind start with usage_count >=3D 1 and leak another
reference?

[Severity: High]
This isn't a bug introduced by this patch, but starfive_wdt_shutdown()
unconditionally calls starfive_wdt_pm_stop(&wdt->wdd), which calls
pm_runtime_put_sync().

If the watchdog was not running (e.g., userspace closed it, or it was never
started and early_enable was false), the PM usage count is already 0.

Because watchdog_stop_on_reboot() was called during probe, the watchdog core
may have already stopped the watchdog via a reboot notifier before the driv=
er
core calls shutdown.

Will this unconditional decrement drop the usage count to -1 and cause a PM
core warning and state corruption?

[Severity: High]
This is a pre-existing issue, but if the watchdog device enters RPM_SUSPEND=
ED
state, its clocks are disabled.

In starfive_wdt_remove() and starfive_wdt_shutdown(), starfive_wdt_stop() is
called directly without ensuring the device is active.

In starfive_wdt_suspend(), the driver unconditionally calls
starfive_wdt_get_count() and starfive_wdt_stop():

drivers/watchdog/starfive-wdt.c:starfive_wdt_suspend() {
    ...
	wdt->reload =3D starfive_wdt_get_count(wdt);
    ...
}

Accessing peripheral registers while the APB and core clocks are disabled
triggers a bus fault and hangs the system on many platforms.

Does the driver need to check watchdog_active() or resume the device first
before accessing these registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914165022.1698=
77-1-skunkolee@gmail.com?part=3D1
