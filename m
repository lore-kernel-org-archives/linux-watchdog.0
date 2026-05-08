Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C61917FB
	for <linux-watchdog@vger.kernel.org>; Fri,  8 May 2026 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778199822; cv=none; b=IALc5ynBDNly5nMEZWAfSvb1D/lHrOuqlWf/6LbyNsDs+48xgIqxqjnIx56ErW+fMlKxeNkFvfs3Lnwr7Kt18K/3VdlwUj7cHahnwaN+9kzDxYiFlq2Qp+Dxmar5IeHb49WspZuPsWNFVGo44R6foggROSIzwm8sy7D+dAupRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778199822; c=relaxed/simple;
	bh=JOqQFhThiPdcFXux46ZyB4XajBPwC1x1LMGjkaqPSsE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y6dWwoxAyOzrYZ5l0P4GFV5aqJNceJtclP1Se5HaB5pJAbK0d+wqDaBC+3rMNgJ1o5WPgXIkhEn9bV/bcNgqlNrHPOYLDIyq+Dq4ZuWu7uB5YmpghUG94uWkb82XpX24bBD1vjalnShmKdBMBMg+3vdtsMbmuE23ZwxGwh8Sz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0Ac/yqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0Ac/yqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED38AC2BCB2;
	Fri,  8 May 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778199822;
	bh=JOqQFhThiPdcFXux46ZyB4XajBPwC1x1LMGjkaqPSsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=E0Ac/yqeL5EyW0N8l0uA22xFMw/Z9fMUSZVU5Ygg2LoAko7KBhYnKtbVnx2a4/qUj
	 2WRgXSM3H3wtYHmB1xKoTXKwVGYYXSW/05KjCJgaqlPLA3Xav2xAWW6pcd8ut0D86s
	 HO5DwEDfRJVGiSPdy5BMP+NoJj+mnbd5R8RRusoZ4q75aODMfcCjeg4TgScQabGSLS
	 rg6MQPre1Cqx1Q/8OFAxxuWOVDdvXTaJLguulyaJft7RN3t9JQZCArZTgaKIHXfcW0
	 7AfsWEX4FrT4loiesKx2oBgVVzGyklnTExMnev8vjFXdaDBUySogHbdzYUQ7M9I1rZ
	 zT+mg2tRW7s9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] clocksource/drivers/timer-tegra186: Reserve and
 service a kernel watchdog
Reply-To: sashiko@lists.linux.dev
To: "Kartik Rajput" <kkartik@nvidia.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260507154557.2082697-5-kkartik@nvidia.com>
References: <20260507154557.2082697-5-kkartik@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 00:23:41 +0000
Message-Id: <20260508002341.ED38AC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] The interrupt handler fails to clear shared interrupts from us=
erspace watchdogs, causing an infinite IRQ storm.
- [High] Pinging the kernel watchdog from a hardware interrupt handler defe=
ats the purpose of detecting software hangs.
- [High] Missing teardown of the kernel watchdog on driver unbind causes an=
 unintended system reset.
- [High] Race condition between system suspend and the watchdog IRQ handler=
 can leave the watchdog incorrectly armed during sleep.
--

commit 8065750aadbeb77247fd706790ed9368ba7e0064
Author: Kartik Rajput <kkartik@nvidia.com>

clocksource/drivers/timer-tegra186: Reserve and service a kernel watchdog

Tegra SoCs supports multiple watchdog timers. Reserve first available watch=
dog
as a kernel-only watchdog for Tegra186 and Tegra234. Arm it during probe (1=
20s
timeout) and keep it alive in the driver IRQ handler.

> diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/t=
imer-tegra186.c
> index dd1d1a0dd63eb..78600ddeb1c61 100644
> --- a/drivers/clocksource/timer-tegra186.c
> +++ b/drivers/clocksource/timer-tegra186.c
[ ... ]
> @@ -219,6 +226,16 @@ static int tegra186_wdt_ping(struct watchdog_device =
*wdd)
>  	return 0;
>  }
> =20
> +static irqreturn_t tegra186_wdt_irq(int irq, void *data)
> +{
> +	struct tegra186_wdt *wdt =3D data;
> +
> +	tegra186_wdt_disable(wdt);
> +	tegra186_wdt_enable(wdt);
> +
> +	return IRQ_HANDLED;
> +}

The commit message states the kernel watchdog is intended to recover the sy=
stem
if "the kernel crashes or hangs before userspace enables a watchdog" and
handles cases where "userspace never starts".

Because this handler runs as a hardirq, won't it continue to execute and fe=
ed
the watchdog even if the kernel deadlocks in task context, enters an infini=
te
loop, or userspace completely freezes? As long as local interrupts are enab=
led,
it seems the watchdog will silently ping itself indefinitely without resett=
ing
the system.

Also, if userspace enables a different watchdog on the system, will this
handler cause an infinite IRQ storm?

Looking at tegra186_timer_probe(), the single shared hardware interrupt is
requested but only passed the kernel_wdt as data:

	err =3D platform_get_irq(pdev, 0);
	irq =3D err;
	...
	err =3D devm_request_irq(dev, irq, tegra186_wdt_irq, 0,
			       dev_name(dev), kernel_wdt);

When a userspace watchdog is enabled, its interrupt is unmasked. If it expi=
res
and asserts the shared IRQ line, this handler will only clear the interrupt
status for kernel_wdt. Since the userspace watchdog's interrupt remains
asserted, won't the CPU immediately re-enter this handler after it returns
IRQ_HANDLED?

[ ... ]
> @@ -501,8 +529,22 @@ static int tegra186_timer_probe(struct platform_devi=
ce *pdev)
>  		goto unregister_osc;
>  	}
> =20
> +	if (kernel_wdt) {
> +		err =3D devm_request_irq(dev, irq, tegra186_wdt_irq, 0,
> +				       dev_name(dev), kernel_wdt);
> +		if (err < 0) {
> +			dev_err(dev, "failed to request kernel WDT IRQ: %d\n", err);
> +			goto unregister_usec;
> +		}
> +
> +		tegra186_wdt_set_timeout(&kernel_wdt->base, TEGRA186_KERNEL_WDT_TIMEOU=
T);
> +		tegra186_wdt_enable(kernel_wdt);
> +	}
> +

When the driver is unbound (e.g., via sysfs or module unloading), devres
automatically frees the IRQ handler, but there doesn't appear to be any
teardown of the hardware timer itself.

Will the hardware timer continue to tick unserviced and forcefully hard-res=
et
the system within 120 seconds of driver removal?

[ ... ]
> @@ -525,8 +567,10 @@ static int __maybe_unused tegra186_timer_suspend(str=
uct device *dev)
>  	unsigned int i;
> =20
>  	for (i =3D 0; i < tegra->soc->num_wdts; i++) {
> -		if (tegra->wdts[i] && watchdog_active(&tegra->wdts[i]->base))
> -			tegra186_wdt_disable(tegra->wdts[i]);
> +		struct tegra186_wdt *wdt =3D tegra->wdts[i];
> +
> +		if (wdt && (wdt->is_kernel_wdt || watchdog_active(&wdt->base)))
> +			tegra186_wdt_disable(wdt);
>  	}
> =20
>  	return 0;

If the watchdog's timer expires concurrently with suspend, can the
tegra186_wdt_irq handler execute on another CPU or immediately after suspend
unmasks interrupts?

Since the IRQ handler unconditionally calls tegra186_wdt_enable() without
checking any suspend state flags, it seems it could re-arm the watchdog aft=
er
this suspend callback has paused it, leading to a spurious hardware reset
during suspend.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507154557.2082=
697-1-kkartik@nvidia.com?part=3D4
