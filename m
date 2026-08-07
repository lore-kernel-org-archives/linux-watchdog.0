Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE063F3293
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091134; cv=none; b=ZvkKofoSpt38UGLwsIYSO+TGPJU0FGT+B7byvByqEhltMVms4hsoTOrsjsm7h/tlpNTM75Pp6idpVE+tm7SkLeIw+vbmDEpFWkSvnWRsatLHYqgwXrCjVCH2dslq0B4TDSboJmvZR+4g0pmg1Bc6a0MugYd2qy9p34wXYkzO/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091134; c=relaxed/simple;
	bh=rxDXRoFAeBAFIszQd8Ij42fpkQ5+vj5wAzDPCkp+oZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LDNtf/w/4Iikd/6eCVxrm41pnxQQsrgn1dLuDsMK8WiSLB8WYE00ZGAcmk+eQDCaWK/9yj2d5f+ZasmDNjpR/mmU/SlL7TDb2E+x3QkA/8SgkL8xDDNdiywtfhsnkmuE/pbhWui3PyKRYDSTUqOyxlNhAFSV5PbDlhHwaXZ1Wxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP7/rois; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP7/rois"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D77E1F000E9;
	Fri,  7 Aug 2026 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786091133;
	bh=ZrO87ypH2oys0ArEINVVvbjjw1VX3zGlTD0dpnhD+B8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HP7/roisxU5VSgEVnLANgxXJnTDrTjDFare+Ob8wNPguJ1dAwHEhY071M8kVaTySn
	 oPYyeaZouORRakCLaFmAQ2gVqkGmUj8wJnUjWkwsxIGeuSTe2wn0Zg2xWuI3Ld6EIt
	 n1OruBUHNYl0MSvNd1miJB2y7S8tOH6nAet1o3qIrZBdpvdByRbFaAfLz3F/fzl9+c
	 1DWfpu3YQUZTDbDi7S8wcvFuB2Q6QN64MzbP4A0EeIuawWg+60U6gT4HIybP5ps5pv
	 L09C+3P+NXZ78P8j/Nz2RK+58o7FTd4buB/xYqEsyedlOimkt4gFEk11UTIXjStdyn
	 fhhjXIBmzu8iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] watchdog: qcom: Propagate errors from optional IRQ
 lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260807081652.38692-1-phucduc.bui@gmail.com>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:25:32 +0000
Message-Id: <20260807082533.2D77E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The probe function aborts and returns an invalid positive value if=
 an optional IRQ is defined but the hardware variant does not support preti=
meout.
--

--- Patch [1]: [PATCH 1/4] watchdog: qcom: Propagate errors from optional I=
RQ lookup ---
commit 29f7b7cd8d0f4e915e9e20f6974535c663f1a3b4
Author: bui duc phuc <phucduc.bui@gmail.com>

watchdog: qcom: Propagate errors from optional IRQ lookup

This commit updates the error handling for an optional interrupt lookup
in the Qualcomm watchdog probe. Instead of only checking for -EPROBE_DEFER,
it attempts to propagate all errors except -ENXIO to better report failures.

> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index a425902b9f68d..2d9f79101b494 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -314,8 +314,8 @@ static int qcom_wdt_probe(struct platform_device *pde=
v)
>  		wdt->wdd.info =3D &qcom_wdt_pt_info;
>  		wdt->wdd.pretimeout =3D 1;
>  	} else {
> -		if (irq =3D=3D -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> +		if (irq !=3D -ENXIO)
> +			return irq;

[Severity: High]
Will this cause the probe to fail on platforms where a valid IRQ is found
but pretimeout is disabled?

If platform_get_irq_optional() successfully finds an IRQ, it returns a
positive number. If the platform (such as APQ8064 or IPQ8064) provides an
interrupt in the device tree but the match data does not support pretimeout,
qcom_wdt_probe() execution falls into this else block.

Since the positive IRQ number does not equal -ENXIO, this condition evaluat=
es
to true and the driver prematurely returns the positive IRQ number.=20

The driver core treats any non-zero return from probe as an error, which
aborts the watchdog initialization completely leaving the system without
watchdog protection.

Should this condition be scoped to only catch negative error codes, for
example by checking if (irq < 0 && irq !=3D -ENXIO) before returning?

> =20
>  		wdt->wdd.info =3D &qcom_wdt_info;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807081652.3869=
2-1-phucduc.bui@gmail.com?part=3D1
