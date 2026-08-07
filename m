Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFBB3AE197
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092523; cv=none; b=HQqnpxpQPSQl5Cl/dt/nW9dw37WCqvS9opEST8OY/B/F2WAW+xRzkO/Q3wRX3NgVTlQ8QT6AHxPWqAZt2u322aGb7N/k9TM2nzGMpYbbAahLH+eFRlvioBsZ0pImcxjvJJ6iCZG3N6jbvQxvBhjUx7FcSP9N4dyPUHWcr+wD2Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092523; c=relaxed/simple;
	bh=aFaO/+xBOBLd6GeRtzL+lmLWj13teP0TwjQF1A6WC5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OVkHyKcbhior4evhakRG7en4f9qt+RBldBJ8+D/9/SaY3LMSSf9SpF5rJqw3yNnzIVKaRMdUg54IMDQp+STIG1bxz0zu/1yjDbd/Cn4nt47LxegLCFE9da2w5eUZgKzPxbDyU4xa45nG88j+IM77rkzzqzDeXOrF9c1rFwCUg64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAT9ERuh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAT9ERuh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF1C1F000E9;
	Fri,  7 Aug 2026 08:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092522;
	bh=kSiB3sCkv08gYoTOkl+zsT5SOeGEJXw6Snq3JXGUrc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hAT9ERuhy48nvBNkGgIP+03u3FzXgFXZkVe1taVWfULSlEs+Ni6bQ94NdXsHCJGRT
	 H+fZKP+saIwEeof2tLPmTT3T6c6eW1RnKRxx6FYFzcGmFOxMOM5tql0Hy7KuLWo1Ot
	 j5vqKgs+t186v+zkMZpW8DXos29o4F8SSq07uiobGpFPUCMeBn0pLohGyhD6gMZ/x+
	 brV1UCPGNuu3r0SevtlEeNre1vO8rCClFgy+TRJrSXoBYEV39pE9fE6ySROM48wpkG
	 FbzM70G/ZKO8ORKW712YxXsZmAGZdiMRZSwvkQlEeDoJedCayhpdkKizmvNKaJEnof
	 C0Xwvu3Z6Cs8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] watchdog: dw_wdt: Propagate errors from optional
 IRQ lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260807081652.38692-3-phucduc.bui@gmail.com>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <20260807081652.38692-3-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:48:40 +0000
Message-Id: <20260807084841.CBF1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware register access and shared IRQ registration occur before =
device is taken out of reset, which can cause an external abort or bus stal=
l. This problem wasn't introduced by this patch, but it is a critical hardw=
are lifecycle violation.
--

--- Patch [3]: [PATCH 3/4] watchdog: dw_wdt: Propagate errors from optional=
 IRQ lookup ---
commit 415108e73d198e9211e81c51098b9fd10a005104
Author: bui duc phuc <phucduc.bui@gmail.com>

watchdog: dw_wdt: Propagate errors from optional IRQ lookup

This commit modifies dw_wdt_drv_probe() to propagate all error codes
returned by platform_get_irq_optional() other than -ENXIO. This ensures
failures are properly reported to the caller instead of only checking
for -EPROBE_DEFER.

> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index c3fbb6068c520..39031445d754b 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -611,7 +611,7 @@ static int dw_wdt_drv_probe(struct platform_device *p=
dev)
> =20
>  		dw_wdt->wdd.info =3D &dw_wdt_pt_ident;
>  	} else {
> -		if (ret =3D=3D -EPROBE_DEFER)
> +		if (ret !=3D -ENXIO)
>  			return ret;
> =20
>  		dw_wdt->wdd.info =3D &dw_wdt_ident;

[Severity: High]
This is a pre-existing issue, but does this function perform register acces=
ses
and register a shared interrupt before the device is taken out of reset?

Looking at the sequence of operations in dw_wdt_drv_probe():

dw_wdt_drv_probe() {
        ...
        /* Enable normal reset without pre-timeout by default. */
        dw_wdt_update_mode(dw_wdt, DW_WDT_RMOD_RESET);
        ...
        ret =3D devm_request_irq(dev, ret, dw_wdt_irq, IRQF_SHARED ...);
        ...
        reset_control_deassert(dw_wdt->rst);
        ...
}

If the hardware starts in a reset state, could the register I/O inside
dw_wdt_update_mode() trigger a synchronous external abort or system hang
because it occurs before reset_control_deassert() is called?

Additionally, since devm_request_irq() is called with IRQF_SHARED before
the reset is deasserted, if another device on the same IRQ line triggers
an interrupt, would dw_wdt_irq() execute and attempt to read the watchdog
interrupt status register while the device is still held in reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807081652.3869=
2-1-phucduc.bui@gmail.com?part=3D3
