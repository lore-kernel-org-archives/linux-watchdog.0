Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811766;
	b=x7Q6l5PswQ43VsyFQ8fqijsD9+rUeZUsxRINKuPdTIlwJ/MzkQS66LjAp6hutpMWSVCw
	 dznUqYYvcXuQcdwfF+emTG2NT9bO9AmaK70irgD4tV5ulEIOlWGAHgTtcHXND7uNa/Gw6
	 5IbcMbIdh8W4Nbl9z3fMe08LfSx8hgjhfFHxkgGw3SgGUl8wdRjXlr4q8hp9xKcTugDml
	 CILCgYjSCpFvfhhF8ENJI6eFQe7J8WILYSiqqIDfg+Mx2KhLYSEm2QgUnQDgeDSuYwX9l
	 2zvQmcsBQvx06GxXEAWp/xAeoB5QPEy+tB7Tj3l8aalmhwtQPBf98VT4LSirCmmUMXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811766;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hcUR1X5qDMSef+rov0HP+Oo/3h2uAYyQ/6/RKquiaJc=;
	b=LDinwmmePFLDMGBZ1Y9e67b0pHUn8qTnfcLxFqsfozHuaDYmdNKZvEdh5NB2VUyT9ioZ
	 JPs6WkzSAxh0YpNojUzAZQVrn/xv78cWQmRT7T3Z3F0JQoIsNTOjpQpZLb4Zs+pj6KCSg
	 TQSw0ZjcAJivD/79CC6zzafVucbrJ9Du7kGU04N1TGxSA4qsFb8KELT4f6PuSaHUzCWSA
	 ANrdmdc62V+xisHCfeSwK/nK2gNhi27Z07zVeSwlYimv7cdLmi93roB140+kby/Pjq4e2
	 cD/dYAivsngMB9P+WIX9uVvXjrr2NfnWCIRQksyzC5Jv5SOJS1fIM/INvaQyqOlbTrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wl1m1lRu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDBF606A326
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wl1m1lRu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9209D1F000C1;
	Wed,  4 Nov 2026 17:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793811765;
	bh=hcUR1X5qDMSef+rov0HP+Oo/3h2uAYyQ/6/RKquiaJc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Wl1m1lRuHiaSQ0k/7s+FeybybxgenftBB7/ElrSejEesJsqoRBzSXWsSCeNnGypEZ
	 a1tGf+l5+Zko8imQ4ywyY+rIM34aeXukZ0sEd5VbW+Gb+DLToHFvw8nwKtEUnsuN/q
	 UR5c1cFClHVYSj/4QBrqiygVtCQGMSRLyvi6uf/U3rE/mDB31pPD7MIQJD6gX4E5Xm
	 hh6/3zl7/gNBGt5xr5sqkXEEAOs7uW8L8PX4wUKMrEf+E1mPtTPKuFSLGDm5omFRok
	 BaB8T1nGhCcGGkHftH75rMja83EDxbxREmDVlZIjf47p1yiT1k/tBkdXOEATCMiLQK
	 90rcCn3lGr+Ow==
Message-ID: <sashiko-outbox-197706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] watchdog: starfive-wdt: Avoid unclocked register
 access in remove and PM paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guenter Roeck" <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
In-Reply-To: <20261104164445.3209560-4-linux@roeck-us.net>
References: <20261104164445.3209560-1-linux@roeck-us.net>
 <20261104164445.3209560-4-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 17:02:45 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] watchdog: starfive-wdt: unbalanced runtime PM put in starfive_wd=
t_shutdown()
--

commit 79e745d33ef2e011dcb21c8530361f6c5a3a1d9a
Author: Guenter Roeck <linux@roeck-us.net>

watchdog: starfive-wdt: Avoid unclocked register access in remove and PM pa=
ths

This commit avoids unclocked MMIO register accesses in the remove, shutdown,
suspend, and resume paths when the StarFive watchdog device is runtime
suspended with its clocks gated off. It also ignores non-zero return codes
from pm_runtime_put_sync() in starfive_wdt_pm_stop().

> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-=
wdt.c
> index 4724fccbfe637..18301f5d1144c 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c

[ ... ]

> @@ -540,18 +545,21 @@ static void starfive_wdt_shutdown(struct platform_d=
evice *pdev)
>  {
>  	struct starfive_wdt *wdt =3D platform_get_drvdata(pdev);
> =20
> -	starfive_wdt_pm_stop(&wdt->wdd);
> +	if (!pm_runtime_suspended(&pdev->dev))
> +		starfive_wdt_pm_stop(&wdt->wdd);
>  }

[Severity: Medium]
Can calling starfive_wdt_pm_stop() here cause an unbalanced
pm_runtime_put_sync() or an unclocked register access?

In starfive_wdt_probe(), the driver registers a reboot notifier via
watchdog_stop_on_reboot(&wdt->wdd):

drivers/watchdog/starfive-wdt.c:starfive_wdt_probe()
	watchdog_set_nowayout(&wdt->wdd, nowayout);
	watchdog_stop_on_reboot(&wdt->wdd);
	watchdog_stop_on_unregister(&wdt->wdd);

During system reboot, halt, or power-off, kernel_restart_prepare() and
kernel_shutdown_prepare() run reboot_notifier_list before device_shutdown().
When the watchdog is running, watchdog_reboot_notifier() in
drivers/watchdog/watchdog_core.c already calls wdd->ops->stop(wdd), which is
starfive_wdt_pm_stop():

drivers/watchdog/starfive-wdt.c:starfive_wdt_pm_stop()
	starfive_wdt_stop(wdt);
	if (pm_runtime_enabled(wdd->parent))
		pm_runtime_put_sync(wdd->parent);

That call stops the hardware and drops the runtime PM reference acquired by
starfive_wdt_pm_start().

When device_shutdown() subsequently calls starfive_wdt_shutdown(), if the
device is not in RPM_SUSPENDED state (for example, if runtime suspend was
forbidden via sysfs power/control or blocked by a PM QoS constraint, either
when the watchdog was never started or after watchdog_reboot_notifier()
already stopped it), !pm_runtime_suspended(&pdev->dev) is true and
starfive_wdt_pm_stop() is called without a matching runtime PM reference he=
ld
by the driver.

Also, because pm_runtime_suspended(dev) checks both
dev->power.runtime_status =3D=3D RPM_SUSPENDED and !dev->power.disable_dept=
h, if
runtime PM is disabled while the device is suspended with core_clk and
apb_clk gated off (such as after pm_runtime_force_suspend() during
hibernation shutdown), !pm_runtime_suspended(&pdev->dev) evaluates to true
and starfive_wdt_stop() will access unclocked registers.

Since watchdog_stop_on_reboot() is already set in starfive_wdt_probe(),
should starfive_wdt_shutdown() check watchdog_hw_running(&wdt->wdd) (or be
removed so it also respects the watchdog.stop_on_reboot=3D0 module paramete=
r)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104164445.3209=
560-1-linux@roeck-us.net?part=3D3
