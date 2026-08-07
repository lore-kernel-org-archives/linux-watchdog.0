Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA1746D575
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090274; cv=none; b=Ff8fCVAr4c+abXYAvS4sW0eFrG5wDJhgPlISpCzkZcGZt2ZOd3V7fp+A9kpOE6n/YNU9wYu+Q5Vpjy+OHzXfpMbLt/0qHmoz8FbisLtZWOjIMwjCb8bb/0a7xtrwVY4/z2N3jR6+NXX3NO3/fn6hXekcUv+o497RxSMN/xizrbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090274; c=relaxed/simple;
	bh=HWyc6GaFU5vERfSaXwSSp99YySBAr6tK/pCwLbJsaSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CPbtoJY8+K/L8IOrBqvId6fsHan++aX6ob2JgrtdaYqFLjPKiS0CqUuoJt1IHi/tV0W42igrCeu+Kc4Yz7f7ykpZK4tFII6RZgr9N4gQdSTa/MWjPYa/VwVQM2AoeqbRisR464mcUX/OJknyDAGeY6RbH6LnjSvGZYLQQNCCksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOlV3Y8P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOlV3Y8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61881F000E9;
	Fri,  7 Aug 2026 08:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786090268;
	bh=Skj+Gkl5R3ImRhKKrKsG8kLqCDGV8lhhILHgNge2ZXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VOlV3Y8Ptr/rdf3S1LgEpMgZF7GwrjeAf43eAQ29ALuaedF4N77tN+bdUfVGEuM4p
	 5yG1q0DMGJKX1P9/WXk5KUBSoKFR0OlZ+iAkXO804ajLE7OayW0jWOEl4EvF77EmuP
	 97z7ReWBmh8QvXRT/5hnxb0bm0laYtELlXR2tlcJVMdYt3wPSe3COQA2gJa+KWuz6B
	 J6WIzm1QARusxWHb/klAylW9L0Kx4AbsoI3BvekpB2wgzW5iIXDzXGqTcCYF8kKdFL
	 KYOZBqhl7n/Iw8pCLPVHKgskyd4s6txBvrVjjN3sLudvXYKpzQ8wdyVcReb0Bkdfu6
	 Yw6Af7fEj8+SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: orion_wdt: Propagate errors from
 optional IRQ lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260807080447.35479-1-phucduc.bui@gmail.com>
References: <20260807080447.35479-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:11:08 +0000
Message-Id: <20260807081108.B61881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning directly on `platform_get_irq_optional` error bypasses c=
lock cleanup, resulting in a resource leak.
--

--- Patch [1]: [PATCH v2 1/2] watchdog: orion_wdt: Propagate errors from op=
tional IRQ lookup ---
commit 2b23b971e11df73076724d1b0329016fb3313456
Author: bui duc phuc <phucduc.bui@gmail.com>

watchdog: orion_wdt: Propagate errors from optional IRQ lookup

This commit updates the optional IRQ handling in the probe function. Instead
of continuing without an IRQ on all errors, it propagates errors other than
-ENXIO (such as -EPROBE_DEFER or -EINVAL) returned by
platform_get_irq_optional().

Link: https://lore.kernel.org/all/20260806062812.26523-1-phucduc.bui@gmail.=
com/

> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -606,6 +606,8 @@ static int orion_wdt_probe(struct platform_device *pd=
ev)
> =20
>  	/* Request the IRQ only after the watchdog is disabled */
>  	irq =3D platform_get_irq_optional(pdev, 0);
> +	if (irq < 0 && irq !=3D -ENXIO)
> +		return irq;

[Severity: High]
Does this early return bypass the clock cleanup?=20

Earlier in orion_wdt_probe(), the hardware clock is initialized and enabled=
 by
dev->data->clock_init(pdev, dev). The other error paths in this function ju=
mp
to the disable_clk label to clean it up.

If we return directly here when an error like -EPROBE_DEFER occurs, it appe=
ars
we might leak the hardware clock reference and its enablement state because=
 we
bypass clk_disable_unprepare() and clk_put() in the disable_clk error path.=
=20
This could lead to repeated resource leaks if probe deferral happens multip=
le=20
times.

Should this use goto disable_clk instead of returning directly?

>  	if (irq > 0) {
>  		/*
>  		 * Not all supported platforms specify an interrupt for the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807080447.3547=
9-1-phucduc.bui@gmail.com?part=3D1
