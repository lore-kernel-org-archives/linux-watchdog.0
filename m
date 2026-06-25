Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2F30566D
	for <linux-watchdog@vger.kernel.org>; Thu, 25 Jun 2026 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409957; cv=none; b=fsj02p5dLStTQwfPjC2drFzu6jXyvBc3cEq2FkqSbWLi+Frdy09mxz9DQ6J63BbVV2RUgLfMYzzO+uh+mIne/mNmIgJ3Dp2dH0YcJryV0p2RHujiottGsSDluU9kRQ4/bImm3EEoDMmA+cHPv8Yhzef2GnpQ2yVmDfY6GNigshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409957; c=relaxed/simple;
	bh=ofY2SHn1M3JEXrUc/rtZXXEKZdrDj/TWdc1jO8/fXSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JzZDIUjWLzfmmgUIFPioPCSgIhCuB4BnAahtnfLp7lYZ9UiNHkZLGNMstca/Go2zK4FHnIkkqgsmOWDqoxuFKioZJwEPU71wVM/YWD5PSCYE80yGwbFbRDxfGPF8EFyKrkQgnBAhffOzDnxad+nuYYzNw7vGCP4sqr0aBZls4hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4UMx2p5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4UMx2p5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B101F000E9;
	Thu, 25 Jun 2026 17:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782409955;
	bh=gVDOgKi8jy6DBNPcxYd6pkfPviUj6pp/FtgPXf7fcxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h4UMx2p5x1xIAnVN2zceArOYAegLYK47UbUv5bqHHa0Pbo+XPssCZnRH/IfITYJDS
	 0nymVl1SmD3gcUHQCuFZVa3Sc1NNp+8fvo6Th2Mfe6oIgLdLC3b624jihE6eaf4bKS
	 h9wIkZ405g5gO1UDKoOtf4MHWmunh+kqLrzwQCS4MfvWtKMIEXtl2hrM9d1SHCymyD
	 WH6vWtOJBnNn+M5yS+UPOzDsAb1vL2VTdbFVqR0lk/kDHxaTD3i3OYFEyUDyPtA69T
	 oj5slQ6VI4HJm+/7svO1Q7qW7dVuur4LCe8PA5CPpQPEGT6akMuQFRajMRQbMfqDn5
	 j3Da+rr1HrMhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] watchdog: lenovo_se30g2_se60_wdt: Watchdog for
 Lenovo SE30G2 and SE60
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mark Pearson" <mpearson-lenovo@squebb.ca>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260625174328.3339996-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20260625174328.3339996-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 17:52:34 +0000
Message-Id: <20260625175235.49B101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect error cleanup for a registered platform device leaves =
a zombified sysfs device.
--

commit 728400a02a11a5d2e004ae6d02e2731670483271
Author: Mark Pearson <mpearson-lenovo@squebb.ca>

watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2 and SE60

This commit adds the watchdog driver implementation for Lenovo SE30G2 and
SE60 platforms.

> diff --git a/drivers/watchdog/lenovo_se30g2_se60_wdt.c b/drivers/watchdog=
/lenovo_se30g2_se60_wdt.c
> --- /dev/null
> +++ b/drivers/watchdog/lenovo_se30g2_se60_wdt.c
[ ... ]
> +static int se_30g2_60_create_device(const struct dmi_system_id *id)
> +{
> +	int err;
> +
> +	se_30g2_60_pdev =3D platform_device_alloc("lenovo-se30g2-se60-wdt", -1);
> +	if (!se_30g2_60_pdev)
> +		return -ENOMEM;
> +
> +	err =3D platform_device_add(se_30g2_60_pdev);
> +	if (err) {
> +		platform_device_put(se_30g2_60_pdev);
> +		se_30g2_60_pdev =3D NULL;
> +	}
> +
> +	return err;
> +}
[ ... ]
> +static int __init se_30g2_60_wdt_init(void)
> +{
> +	int err;
> +
> +	if (!dmi_check_system(se_30g2_60))
> +		return -ENODEV;
> +
> +	err =3D platform_driver_register(&se_30g2_60_wdt_driver);
> +	if (err && se_30g2_60_pdev) {
> +		platform_device_put(se_30g2_60_pdev);

[Severity: Medium]
Since the device was successfully added to the system bus via
platform_device_add() in the DMI callback earlier, will calling
platform_device_put() here just drop the allocation reference without
removing the device from the sysfs hierarchy?

Should this error path use platform_device_unregister() instead to avoid
leaving a zombie device on the bus that could cause collisions on a later
module load?

> +		se_30g2_60_pdev =3D NULL;
> +	}
> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625174328.3339=
996-1-mpearson-lenovo@squebb.ca?part=3D1
