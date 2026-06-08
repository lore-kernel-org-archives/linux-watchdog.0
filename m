Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6634517A2FC
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950139; cv=none; b=CDMoXqUEG672k1VUtBtlAM2arcRjWN5xU+L66ofKCZcYom1kb8/jsoKNLJH3gzaHTY1zL0rDmMPuioPfEwuOshLmmDlGLww+wX/9aGy5mRpQ5gLrk1OZh2fyvM1E1Pn4wUsckb5ZQsK2tVJ+KQ4HsPqkAthh3KSlX/EeRiLQrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950139; c=relaxed/simple;
	bh=dPhW5zJRZU3XrMWgyfu6nkwvHgSeaJ8JV0rRDEJYFqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F0ChTcZCNbHJKgC2r7F2L98tmqx6eVmva0goYNRxoQ8xKwzEjIRQnX/hiWtiIxhD3k0lfl6ZvoZp61HAru7eBXeorCpP+ZPawgRuatbdSII1jjIsw6/Tg7WY/04c+z///pCeCuUVkH8crQJO0hgJqTJ7/P3838jaPPNymMC9+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI2rgLQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI2rgLQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB5E1F00893;
	Mon,  8 Jun 2026 20:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780950138;
	bh=KC3kBHnxt6yVFUqb5quUcm+R+k00nJ2Vg9Nv21RpkaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OI2rgLQZ8AAdVD0j3cd92C+leWNgrO9UMnTLA7lK56hU5PMQOdZKO9uQL+NBTB4Rc
	 fJebd2LEwkd6s7tPZ4wQ1lXJh3inlxT/YDVc9nHqSwAvFMUc1O1Bqg26WiAM2ueGtm
	 3xPr/e2Rvvm4+sjKR60rzOU/rwRZmH6WLaL4P/9eB5y5+fm1nsVJy4cWHvjZN8X4O8
	 qIn+BcM2+aY9H5ck4U8tu8P4c51g14Y2c6x6JiN3lsMPwDt+fvcbC4VISIcmLFFYaC
	 fm6RslpsFw3Z18cPZdE7+2Wbk3gd+Ltz/QwDIVYw5GNqErCJdRO4zGLYUMWH96QGV6
	 Qmg2ocUwi81Aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 1/3] watchdog: sama5d4: fix shared IRQ and hardcoded
 timeout issues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260608200933.18669-2-rosenp@gmail.com>
References: <20260608200933.18669-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:22:17 +0000
Message-Id: <20260608202218.2FB5E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race Condition / NULL Pointer Dereference in IRQ Handler
- [High] Broken hardware running detection silently disables SAM9X60 watchd=
og
- [Medium] Missing Implementation of Claimed Fix
--

commit d317329a0ae0943570eba30cfe121c30d31561b9
Author: Rosen Penev <rosenp@gmail.com>

watchdog: sama5d4: fix shared IRQ and hardcoded timeout issues

This commit aims to fix three issues in the sama5d4 watchdog driver: an
unsafe IRQF_SHARED combination, unconditional IRQ_HANDLED returns on shared
lines, and a hardcoded timeout. It modifies the IRQ handler to return
IRQ_NONE for spurious interrupts and passes the configured timeout to the
init function.

>     1. Unsafe IRQF_SHARED | IRQF_NO_SUSPEND combination: The watchdog
>        interrupt is a dedicated peripheral line, not shared with other
>        devices.

[Severity: Medium]
This is a pre-existing issue, but the commit message states this
combination is being removed, yet the patch does not appear to change the
devm_request_irq() flags in the driver.

Was the code change for this specific item accidentally omitted from the
patch?

> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wd=
t.c
> index 13e72918338a2..c7d6f877537c3 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c

[ ... ]

> @@ -311,7 +312,7 @@ static int sama5d4_wdt_probe(struct platform_device *=
pdev)
>  		set_bit(WDOG_HW_RUNNING, &wdd->status);
>  	}

[Severity: High]
This is a pre-existing issue, but does this hardware running check use the
correct bit for SAM9X60 devices?

In sama5d4_wdt_probe(), the code hardcodes AT91_WDT_WDDIS when reading the
status:

drivers/watchdog/sama5d4_wdt.c:sama5d4_wdt_probe() {
	...
	reg =3D wdt_read(wdt, AT91_WDT_MR);
	if (!(reg & AT91_WDT_WDDIS)) {
		wdt->mr &=3D ~AT91_WDT_WDDIS;
		set_bit(WDOG_HW_RUNNING, &wdd->status);
	}
	...
}

For SAM9X60, shouldn't this check AT91_SAM9X60_WDDIS instead?

Additionally, the wdt_enabled macro is hardcoded to check AT91_WDT_WDDIS
against wdt->mr. Since wdt->mr is initialized with AT91_SAM9X60_WDDIS for
SAM9X60 devices, the macro evaluates to true.

When wdt_enabled evaluates to true in sama5d4_wdt_init(), the block intended
to preserve the running state is skipped. The driver then writes wdt->mr
(which has the disable bit set) to the hardware.=20

Does this silently disable the watchdog on SAM9X60 while leaving the core
believing it is running?

> -	ret =3D sama5d4_wdt_init(wdt);
> +	ret =3D sama5d4_wdt_init(wdt, wdd->timeout);
>  	if (ret)
>  		return ret;

[Severity: High]
This is also a pre-existing issue, but is there a race condition between
devm_request_irq() and platform_set_drvdata() in this probe function?

Earlier in sama5d4_wdt_probe(), devm_request_irq() is called with
IRQF_SHARED to register sama5d4_wdt_irq_handler():

drivers/watchdog/sama5d4_wdt.c:sama5d4_wdt_probe() {
	...
	if (wdt->need_irq) {
		ret =3D devm_request_irq(dev, irq, sama5d4_wdt_irq_handler,
				       IRQF_SHARED | IRQF_IRQPOLL |
				       IRQF_NO_SUSPEND, pdev->name, pdev);
	...
}

If the line is shared and active, or if a spurious interrupt fires before
probe finishes, sama5d4_wdt_irq_handler() will be invoked:

drivers/watchdog/sama5d4_wdt.c:sama5d4_wdt_irq_handler() {
	struct sama5d4_wdt *wdt =3D platform_get_drvdata(dev_id);
	u32 reg;

	if (wdt->sam9x60_support)
	...
}

However, platform_set_drvdata(pdev, wdt) is not called until the very
end of sama5d4_wdt_probe(). If the interrupt handler fires before this,
platform_get_drvdata() will return NULL, causing an immediate NULL pointer
dereference when accessing wdt->sam9x60_support.

Could platform_set_drvdata() be moved earlier in the probe sequence,
or devm_request_irq() moved later?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608200933.1866=
9-2-rosenp@gmail.com?part=3D1
