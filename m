Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3345DF44
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790323030; cv=none; b=V8pV7i3uhs5tyJ9UVMnlzW4pXyDqvBblX8rbcPoxFJjTbViQ8LsrR5AE5iqecuiKH2+65Ouqo0qkVNIImvoFR9v45/0oiJCrW5s/jIMWTCipjN1Vw3Qfb4ztPVzLrPpW41VEcdF/l3K2D/nbd859G5+mpu/f9AfF9qpsCvofk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790323030; c=relaxed/simple;
	bh=40tTu2rNWDvPveyAdQ03wLRFI1iW84mi+HGorZDml6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W7xr4uwVdj2ikC8OvyKw4wSLyEwGpz8DA1jJCaEgTN2452ixnL8ygSyHsQuDPsvP3BedRX7ll9+74TOKA3/0f0hdhcXJI2nGWlOZ4Hba+m+5+12RCEXbwnFCwy41uNVwD7HSgVW6raG0ZnMrscmhVGbjrT/PUGD21ZjsSN3DUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPAEoh3K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPAEoh3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38861F000FF;
	Fri, 25 Sep 2026 07:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790323026;
	bh=ivj7ExhzzT0CThPtvOh5Mf8u4052pQ2pwK6VDbH+NUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mPAEoh3KrrzB/90SFRnoEZef0IeOqDhzsrBAk1v7Gpi56JULs5QDX2aKTfVc71gZh
	 ytx/Gpb1yb5fPZKtzi8fQ6gWw9SLRGCue7FQ2+hlETMZRh3ifcG1k0IXoibtoBXuhV
	 b0hGpiJa1QxkZbv5/f3w10+wdQS5tOQPqYv0nobpzf3Jmt1LlbSd+bEiDl4eJufk63
	 ZEThfnD8BL2JzQ3vUunb0RhXweGiAniWIgkfS4/YKekNaNz5c6Jcgafd2tXToS0PTT
	 FbAyM//twcro3QlqZNXQ2poqLW7BI8Hk7NBL6bbDp7JsqJLfAEk/4p0zMfPqRwrITZ
	 grx6BSJqG1PIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/11] iommu/arm-smmu: Add arm-smmu IRQ mapping
 -EPROBE_DEFER handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Pieralisi" <lpieralisi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-9-2c62125d0085@kernel.org>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-9-2c62125d0085@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 07:57:05 +0000
Message-Id: <20260925075705.E38861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] arm-smmu: double error logging via dev_err_probe() on platform_get_=
irq()
--

commit 6a3f1d6f12231474463a3b68ee6dc2b63bbcba7f
Author: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: iommu/arm-smmu: Add arm-smmu IRQ mapping -EPROBE_DEFER handling

This commit adds EPROBE_DEFER handling to the arm-smmu IRQ mapping code
to address cases where the interrupt controller is not yet probed when
the SMMU driver initializes.

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/ar=
m-smmu/arm-smmu.c
> index 889a0966d36cd..a111b80553dae 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
[ ... ]
> @@ -2171,7 +2173,7 @@ static int arm_smmu_device_probe(struct platform_de=
vice *pdev)
>  		int irq =3D platform_get_irq(pdev, global_irqs + pmu_irqs + i);
> =20
>  		if (irq < 0)
> -			return irq;
> +			return dev_err_probe(dev, irq, "failed to get context IRQ\n");

[Severity: Low]
Does wrapping platform_get_irq() with dev_err_probe() result in duplicate
error log messages?

Looking at platform_get_irq(), it already logs failures via dev_err_probe()
internally:

drivers/base/platform.c:platform_get_irq()
    ...
    ret =3D platform_get_irq_optional(dev, num);
    if (ret < 0)
        return dev_err_probe(&dev->dev, ret,
                             "IRQ index %u not found\n", num);

Returning the error directly might avoid redundant error strings.

>  		smmu->irqs[i] =3D irq;
>  	}
> =20
> @@ -2211,7 +2213,7 @@ static int arm_smmu_device_probe(struct platform_de=
vice *pdev)
>  		int irq =3D platform_get_irq(pdev, i);
> =20
>  		if (irq < 0)
> -			return irq;
> +			return dev_err_probe(dev, irq, "failed to get global IRQ\n");

[Severity: Low]
Similarly here, does this result in a duplicate error message when
platform_get_irq() fails?

> =20
>  		err =3D devm_request_irq(dev, irq, global_fault, IRQF_SHARED,
>  				       "arm-smmu global fault", smmu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-acpi-stati=
c-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org?part=3D9
