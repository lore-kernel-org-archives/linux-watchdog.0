Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF1481AB0
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710299; cv=none; b=reDp8BkCJHVqakvLrLG4GAfN4ytymP2gKGhKdfASLY/JqdnZkkD1sa0esVzwcaaN4reOihNXoiE4G7R/VMkfKnxWskPYcUwPph+YSZ6Gcpveo4KqLDRIReJFogPU/EfZIf1mfrxW3VGfZTKryNIpxYCRd+8LcMZ+ZlT4D5PNO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710299; c=relaxed/simple;
	bh=ENqISJvzBuwmFdE7BNyhVC0iF/+LfpjuOnuMU1xxrrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bqemuWgLFSUqI2Vkplh0eprDAXL2XHEQBOa0d7eix4jmkZJ2o1p9nkek0O1As7kB6w7u9bCwi81QOUMACQMfVmfEG3yrfZO6N/5HIzAlelBPp7ESSpyJplKX8M+08+YNsVJm2FCBTzJLaC1iQu1F29ZtCywYrcRCWONmw1r2Phc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHdExVBy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHdExVBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66A61F000E9;
	Wed, 22 Jul 2026 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710298;
	bh=2YZSfnyq9QBxXMSkBvtQ09duEVJYanPPGVJA+Hvmtu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EHdExVByLCqyxemn6X03xCEQreBNZFdHe+GeImEB2I1dE4CMid35jqeQDe4L3qsTu
	 eAoNBFFmJJvh28T6Ec+X61mKMJZSLoHfxuPqlwIUVjF34vgoZVxkHfIOlr5LSSPhU5
	 fd+nJ7CRkCwd1fVSyATEqoC+7aiIRUuIePn4LzPtYThaXw5JKLLUlrojsFTdwcHqcC
	 Rs7ExX27eCcFVuU1HCQF1ocs0z4Lr0hoaAqL5sD/IbwNt4/fZI7aaa0TdOb134ioaJ
	 tVQHuxgXOXwXCBWUk7j9hbPYToJTQFCu4SQfPvbiIMGv8M1CiMMyhPEMaFp2uqFExZ
	 sk1c9YHdobE4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] watchdog: keembay: Remove redundant dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260722084218.79073-5-panchuang@vivo.com>
References: <20260722084218.79073-1-panchuang@vivo.com>
 <20260722084218.79073-5-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:51:37 +0000
Message-Id: <20260722085137.D66A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition in probe leading to a NULL pointer dereference in t=
he interrupt handler.
- [High] Watchdog clock may be disabled by the Common Clock Framework (CCF)=
 late initcall, silently stopping the watchdog.
--

--- Patch [4]: [PATCH 4/9] watchdog: keembay: Remove redundant dev_err_prob=
e() ---
commit ae07b07078ab54b39721c2064f0c148ab624e578
Author: Pan Chuang <panchuang@vivo.com>
watchdog: keembay: Remove redundant dev_err_probe()

This commit removes redundant dev_err_probe() calls from devm_request_irq()=
=20
error paths. The core devm_request_irq() already handles logging detailed=20
error messages.

> diff --git a/drivers/watchdog/keembay_wdt.c b/drivers/watchdog/keembay_wd=
t.c
> index 2a39114dbc641..fa8c912e83aa0 100644
> --- a/drivers/watchdog/keembay_wdt.c
> +++ b/drivers/watchdog/keembay_wdt.c
> @@ -215,7 +215,7 @@ static int keembay_wdt_probe(struct platform_device *=
pdev)

[Severity: High]
This is a pre-existing issue, but does this driver safely handle the Common
Clock Framework late initcalls?

Looking at keembay_wdt_probe(), the driver fetches the clock but never
explicitly enables it:

drivers/watchdog/keembay_wdt.c:keembay_wdt_probe() {
    ...
    /* we do not need to enable the clock as it is enabled by default */
    wdt->clk =3D devm_clk_get(dev, NULL);
    ...
}

Because clk_prepare_enable() is never called, the CCF late initcall
(clk_disable_unused) will find this clock with a reference count of zero and
disable it to save power. When this happens, won't the watchdog hardware
silently stop ticking?

>  	ret =3D devm_request_irq(dev, wdt->th_irq, keembay_wdt_th_isr, 0,
>  			       "keembay-wdt", wdt);

[Severity: High]
This is a pre-existing issue, but can this early IRQ request cause a NULL
pointer dereference if the watchdog is already running?

If the bootloader has enabled the watchdog and a pre-timeout interrupt is
pending, devm_request_irq() will unmask the interrupt line and the ISR will
fire immediately.

The ISR calls keembay_wdt_set_pretimeout_reg(), which expects the watchdog
driver data to be initialized:

drivers/watchdog/keembay_wdt.c:keembay_wdt_set_pretimeout_reg() {
    ...
    struct keembay_wdt *wdt =3D watchdog_get_drvdata(wdog);
    ...
    keembay_wdt_writel(wdt, TIM_WATCHDOG_INT_THRES, th_val * wdt->rate);
    ...
}

Since watchdog_set_drvdata() is called further down in keembay_wdt_probe()
(after the IRQ is requested), watchdog_get_drvdata() would return NULL here,
leading to a crash when wdt->rate is accessed.=20

Could the IRQ requests be moved after the watchdog structure is fully
initialized?

>  	if (ret)
> -		return dev_err_probe(dev, ret, "Failed to request IRQ for threshold\n"=
);
> +		return ret;
> =20
>  	wdt->to_irq =3D platform_get_irq_byname(pdev, "timeout");
>  	if (wdt->to_irq < 0)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722084218.7907=
3-1-panchuang@vivo.com?part=3D4
