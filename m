Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ECC2356D9
	for <linux-watchdog@vger.kernel.org>; Thu,  4 Jun 2026 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536010; cv=none; b=alBnb6SUKVvTKOvVSszjSxyxI9H3DubjhAoXNW6Puha02bK2eH7wCexkd2xIHgcJTGBlNfLOuk/gEBSJ6DxkrP0X3pb+NbWq7cERIaNJRkX8FRAGFFTuJhJXlybZ6C9AZokyAIDJC/na5Rl6xIjvjOhMGiqSm3dIbMk0lDxzS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536010; c=relaxed/simple;
	bh=PIcAGAwl2QkHOXpo7iO86OY1XCflfvToUBKkfJoXWdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DQA38065yU+nFqzEZCWp+RomUD9ohN0nkINeWqGzxqZKSdgAkwk78m8mnVTbzZ7bc84eoTe9icszispG1CIKe4BnpwrIaOPh5BIuxRBDik5fH/js2Ua9plSTn02R8YBKgvbbAffivBN9+tad7/E3XW3TneTsegMRQcejaGVMH20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQGA6UDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQGA6UDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DBC1F00893;
	Thu,  4 Jun 2026 01:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780536008;
	bh=MXuZH7K4jbWS9LIMhsbSzVWmX3LzrqgzlTUm07S7bQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YQGA6UDOqVntQZuEzI9MtFmvB2ph/FP3tarz6BSOlgv5W7ahnE4Lb5xJDM+yfA4ke
	 aItgZBHB8YpSPNq7mM70aIJtbYr26nMpKSppK8jRgnYcugxGBzXOsOPrkUwK2PUKD6
	 bPwL252fsOE0zfAuZTuUUKChFvW4KNspMYI8WYNrujwRRBSfyE30xGREG0yZWyrnSE
	 IH98/VuQVwMc10j9zTcrvzYbV+MKStjEWWNUxI7udqafFzebRjjSBWL42c++DsE9YL
	 OSyVnBgbV5tqZ9z11LtyFZwwyA0NUDza/LdtzfOn1pLvOMffLR97acJIopP00ewM1S
	 3wtwvnsF5Ae6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] watchdog: sama5d4: fix shared IRQ and hardcoded
 timeout issues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260604010542.23177-2-rosenp@gmail.com>
References: <20260604010542.23177-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 01:20:08 +0000
Message-Id: <20260604012008.76DBC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Dropping IRQF_SHARED causes a probe regression on SAM9X60 and SAM9=
X7 platforms where the watchdog IRQ is genuinely shared.

Pre-existing issues:
- [High] A race condition during probe can cause a NULL pointer dereference=
 in the IRQ handler because the IRQ is requested before the platform drvdat=
a is set.
- [High] The driver incorrectly uses the SAMA5D4 watchdog disable bit (`AT9=
1_WDT_WDDIS`) instead of the SAM9X60 watchdog disable bit (`AT91_SAM9X60_WD=
DIS`) when checking if the hardware is running.
--

commit 10beb96fcac3b8fc975881a372fcfe158d7e1630
Author: Rosen Penev <rosenp@gmail.com>

watchdog: sama5d4: fix shared IRQ and hardcoded timeout issues

This commit modifies the sama5d4 watchdog driver to drop the shared IRQ
flag, handle spurious interrupts appropriately by returning IRQ_NONE, and
use the configured timeout during initialization instead of a hardcoded
16-second default.

> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wd=
t.c
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c

[ ... ]

>  	if (wdt->need_irq) {
>  		ret =3D devm_request_irq(dev, irq, sama5d4_wdt_irq_handler,
> -				       IRQF_SHARED | IRQF_IRQPOLL |
> -				       IRQF_NO_SUSPEND, pdev->name, pdev);
> +				       IRQF_IRQPOLL | IRQF_NO_SUSPEND,
> +				       pdev->name, pdev);

[Severity: High]
Will dropping IRQF_SHARED cause probe failures on SAM9X60 and SAM9X7
platforms?  On these devices, the watchdog uses the System IRQ, which is
shared with other critical peripherals like the RTC, RTT, PMC, and PIT.  If
another driver has already requested the shared line, won't
devm_request_irq() fail with -EBUSY and disable the watchdog entirely?

[Severity: High]
This is a pre-existing issue, but can this sequence lead to a NULL pointer
dereference?

The IRQ is requested and enabled here, but platform_set_drvdata() isn't
called until the end of sama5d4_wdt_probe().  If an interrupt fires
immediately (for instance, from a shared device like the RTC on SAM9X60),
sama5d4_wdt_irq_handler() will execute:

sama5d4_wdt_irq_handler() {
        struct sama5d4_wdt *wdt =3D platform_get_drvdata(dev_id);
        u32 reg;

        if (wdt->sam9x60_support)
        ...
}

Since platform_get_drvdata() returns NULL before the driver data is set,
won't this crash when attempting to access wdt->sam9x60_support?

>  		if (ret) {
>  			dev_err(dev, "cannot register interrupt handler\n");
>  			return ret;

[ ... ]

>  	reg =3D wdt_read(wdt, AT91_WDT_MR);
>  	if (!(reg & AT91_WDT_WDDIS)) {
>  		wdt->mr &=3D ~AT91_WDT_WDDIS;
>  		set_bit(WDOG_HW_RUNNING, &wdd->status);
>  	}
> =20
> -	ret =3D sama5d4_wdt_init(wdt);
> +	ret =3D sama5d4_wdt_init(wdt, wdd->timeout);

[Severity: High]
This is a pre-existing issue, but does this logic correctly identify if the
hardware is running on SAM9X60 platforms?

The driver checks AT91_WDT_WDDIS (which is bit 15) unconditionally here and
in the wdt_enabled macro.  However, SAM9X60 uses AT91_SAM9X60_WDDIS=20
(which is bit 12).

Since the SAM9X60 initial wdt->mr only has bit 12 set, won't this check
always evaluate to true, bypassing the safe watchdog initialization block
inside sama5d4_wdt_init() and potentially leaving the system exposed to
spurious resets?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604010542.2317=
7-1-rosenp@gmail.com?part=3D1
