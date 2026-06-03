Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7A242D65
	for <linux-watchdog@vger.kernel.org>; Wed,  3 Jun 2026 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448465; cv=none; b=RjLLnrlmpHZDP/t13cbsrtIDdFJI026UMoueUzs8NdyebaXxCiK2rZkvuzsvbRGrBTYw4shsZUMenobk6wE0LjfZJQGTsMp5B0u0nhABvbjvQeAND9Psk13CO8chem3n5cn7a7j+VVhC1CjsnzT37GNFgWfG/i+LInr4R4is/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448465; c=relaxed/simple;
	bh=ghE9Z0wUokYQtgWV8KGJ1SDcltfA0fHrIO0rJkV/86c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tMtRn0rIIe5yFPOyGgJWPZDNd8cxOBh5vYpSXI9erhI2rvDrnZTG9TpqiDYV+qHAuDBY/uTlvW//AdfMrNZYihC9DJqiDVmnQVCYMi0lN2EK8TfH1CS4r4jUIjc95aDbe81VhCBaOjYi8nLASguwhWYZ/UlTojES0zuWvUglS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKXF9b0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKXF9b0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C0C1F00893;
	Wed,  3 Jun 2026 01:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780448464;
	bh=Nl5EsrwOMpdJj1Z0AGi8yHNOd/Or53oFZ51LGnF/Ng0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MKXF9b0pEMRz4+5+TkRJD20JvDYqLBynILsQQCCw8SMsAh3cmFeRgHYNLUJCZfdKL
	 gmyQIxofAkRVWEUHmibsB0SggJzYh0ZZls+EsOSwH/fzEk6dfoGCRoZCW/R1qWEPut
	 txDLZMuvW5tGp+GwHMvwzIr3DubPy3gM1DHWVRBLyq+E87p9YERMFxzEDVxgCP0xfe
	 y9bUjAvqkZzY6EtYJMfChNbEEU2lGms105aoUtakJZxf7UND+1bC0b4pOIhZdj1PkU
	 /dks0geZ7XbJWib2l+8/D24a+tAenTp56upAKvIolkEnahL7qXxbRSu9CvCbXo9ADb
	 m3z4Z9WHTArSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: sama5d4_wdt: use platform_get_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260603005409.226774-1-rosenp@gmail.com>
References: <20260603005409.226774-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 01:01:03 +0000
Message-Id: <20260603010104.56C0C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Assigning the signed result of `platform_get_irq()` to an unsigned=
 `u32` variable causes the `irq < 0` error check to always evaluate to fals=
e, breaking the driver's fallback mechanism.
- [Medium] Using `platform_get_irq()` instead of `platform_get_irq_optional=
()` for an optional IRQ causes spurious error messages to be logged.

Pre-existing issues:
- [High] The driver registers a shared interrupt handler (`IRQF_SHARED`) be=
fore setting the platform driver data, creating a race condition that can l=
ead to a NULL pointer dereference.
--

commit 7ff7f2de154616b7a42f6e5710f322b20ff6152e
Author: Rosen Penev <rosenp@gmail.com>

watchdog: sama5d4_wdt: use platform_get_irq()

irq_of_parse_and_map() requires irq_dispose_mapping() on failure. Don't
bother with it as platform_get_irq doesn't need it.

> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wd=
t.c
> index 13e72918338a2..d9b212557ce36 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -286,8 +286,8 @@ static int sama5d4_wdt_probe(struct platform_device *=
pdev)
>  		return ret;
> =20
>  	if (wdt->need_irq) {
> -		irq =3D irq_of_parse_and_map(dev->of_node, 0);
> -		if (!irq) {
> +		irq =3D platform_get_irq(pdev, 0);
> +		if (irq < 0) {

[Severity: High]
Since irq is declared as an unsigned u32 earlier in sama5d4_wdt_probe(), wo=
n't
this irq < 0 check always evaluate to false?

platform_get_irq() returns a negative error code (like -ENXIO) on failure,
which will be implicitly cast to a large positive integer. Instead of
gracefully falling back by setting wdt->need_irq =3D false, won't the driver
proceed to call devm_request_irq() with an invalid IRQ number and fail the
probe?

[Severity: Medium]
Will this log spurious error messages when the IRQ is genuinely absent?

The driver treats the IRQ as optional and handles its absence gracefully.
However, platform_get_irq() internally calls dev_err_probe(), printing a
core-level error message to the kernel log when an IRQ is not found. Should
this use platform_get_irq_optional() instead to avoid confusing user-visible
error logs during boot?

>  			dev_warn(dev, "failed to get IRQ from DT\n");
>  			wdt->need_irq =3D false;
>  		}

[Severity: High]
This is a pre-existing issue, but does requesting a shared IRQ before setti=
ng
the platform driver data create a race condition?

A few lines later in sama5d4_wdt_probe(), the driver requests the IRQ:

	if (wdt->need_irq) {
		ret =3D devm_request_irq(dev, irq, sama5d4_wdt_irq_handler,
				       IRQF_SHARED | IRQF_IRQPOLL |
				       IRQF_NO_SUSPEND, pdev->name, pdev);

Because the IRQ is requested with IRQF_SHARED, another device sharing the l=
ine
or a spurious interrupt could cause sama5d4_wdt_irq_handler() to execute
immediately.

The interrupt handler calls platform_get_drvdata() and dereferences it:

drivers/watchdog/sama5d4_wdt.c:sama5d4_wdt_irq_handler() {
	struct sama5d4_wdt *wdt =3D platform_get_drvdata(dev_id);
	...
	if (wdt->sam9x60_support)
	...
}

However, platform_set_drvdata(pdev, wdt) is only called at the very end of
sama5d4_wdt_probe(). If the interrupt fires within this window, won't
platform_get_drvdata() return NULL and cause a NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603005409.2267=
74-1-rosenp@gmail.com?part=3D1
