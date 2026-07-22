Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1D481A89
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710315; cv=none; b=tNZCrqf2lfSmDSK0UEKccCJ6bf3UbPlZzSJ8nASgJZB89bE96vcW9Kn5ODRCss8JGWhbFjYvL60O3zMLaWOEKJ/qRWXetQn+AcrGsHuuIS8VJ+mXH8muOmoQeloc3sBDPkAv5wG0ozJlYpmTjSGCE6bCZXu3cE2EPn0QKTpIu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710315; c=relaxed/simple;
	bh=Y1tC9n428+gJkT+g1/mL2c9z8KoZ1rYZ9oAhsubRv04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i8yGae6o92ZIycCRXX4PBKu1SxxVkUCIbqGaSJKAFyj4TLTh9Gpv5tWhzglt+jh1+DllAaEvZlSHbM0hkEmYshw8K9rVgitkdU2HRhhY5uO4H/3MnTQOcWH3yTZaXlmaUXd2swTjZn3BPkZvRzdAQIiXmSYghplhezf7AoCHPDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqIfRJXL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqIfRJXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D9A1F000E9;
	Wed, 22 Jul 2026 08:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710313;
	bh=FMUM3pzlDPmJi9ZBKwHLQqrGAX234ZzzlPjQ3aoMzPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lqIfRJXLm3w1o3Tj+DXq3q52eqrkrrArMhT1qckm0e74m6hhLePkJSQwvReZL0Gzo
	 m0z0BksK8GWZv9tR0i2u9dEU7IBUIfaKncLfcKEnhbVsNrxPjH2+dA3nASD92UJbOQ
	 b8KUw0hg60ZOCRRIHb0xn8sNodz0ERFTT17rs1/yeCF1y7ZjpoAlzP8VDr/nmJ9Ht9
	 4XKtV4hplgLaJVxyTsanAkAzyykjQ8oybWB++55kc2fM+ytKhj0qPd/8bA/KWG3GR3
	 poK6IWN9Nl7B21gdO0FrERSaHY9Zfsz2xCIz6a6OE/f4VWyzXVPO9EEAB1jah/0La2
	 6gUSJ8Nt0LJww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] watchdog: sprd: Remove redundant dev_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260722084218.79073-10-panchuang@vivo.com>
References: <20260722084218.79073-1-panchuang@vivo.com>
 <20260722084218.79073-10-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:51:53 +0000
Message-Id: <20260722085153.94D9A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect devres ordering leaves the IRQ handler active while devi=
ce clocks are disabled, risking a Data Abort (kernel panic).
--

--- Patch [9]: [PATCH 9/9] watchdog: sprd: Remove redundant dev_err() ---
commit a68eda5f5b396a6d33ede72c1a4cc217df36d52f
Author: Pan Chuang <panchuang@vivo.com>

watchdog: sprd: Remove redundant dev_err()

This commit removes a redundant driver-specific dev_err() call after
devm_request_irq(). The core already logs detailed error messages on
failure.

> diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
> index aacf04616fefe..616b4d7f21d78 100644
> --- a/drivers/watchdog/sprd_wdt.c
> +++ b/drivers/watchdog/sprd_wdt.c
> @@ -293,10 +293,8 @@ static int sprd_wdt_probe(struct platform_device *pd=
ev)
> =20
>  	ret =3D devm_request_irq(dev, wdt->irq, sprd_wdt_isr, IRQF_NO_SUSPEND,
>  			       "sprd-wdt", (void *)wdt);

[Severity: High]
This is a pre-existing issue, but I noticed a potential race condition
with the devres ordering.

Since devm_request_irq() is called before sprd_wdt_enable(), could a pending
interrupt (e.g., from the bootloader) trigger sprd_wdt_isr() while the devi=
ce
clocks are still disabled?

Also, since devres teardown is LIFO, sprd_wdt_disable() (registered further
down via devm_add_action_or_reset()) will execute before the IRQ is freed
on probe failure or device removal. This leaves a window where the ISR could
fire and access registers with clocks disabled:

sprd_wdt_isr() {
	...
	sprd_wdt_unlock(wdt->base);
	writel_relaxed(SPRD_WDT_INT_CLEAR_BIT, wdt->base + SPRD_WDT_INT_CLR);
	...
}

Would it be safer to request the IRQ after the clocks are enabled and the
disable action is registered, to prevent a potential Data Abort?

> -	if (ret) {
> -		dev_err(dev, "failed to register irq\n");
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	wdt->wdd.info =3D &sprd_wdt_info;
>  	wdt->wdd.ops =3D &sprd_wdt_ops;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722084218.7907=
3-1-panchuang@vivo.com?part=3D9
