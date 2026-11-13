Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573321;
	b=qBVSPbUUK0HaJIxu1qLwlVcP5HU3F5Q/KMkQEQXsWmS45ee5d1tYrREcIq1Z1DVDTAv0
	 RSNdwy4Jo8RzAP7/nmzbC6+fX74RGqLYALLjKPFxzOUdAkxlvZmALaKfkeNLfFeKeAYVB
	 nSp2vHi4w5dQ7tfQ9Wf7TkyX5RwDPWLkV2fPdzdK5g96T4CoBxbHmdFBBURVgQNveXQTs
	 m/0NxxXx73Em+x7iL8CykHSj24fQ0yoYkcN0/akjo7CGTdao+m9cGEoSRLa6gE5ue7daA
	 wsegdmJHbhRwwWFZTSOxNQ8b96v8mUXBvTs0wLd0mdg7e3ug7F6YOkcgAjhiAznvujw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573321;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QAxv6GV21dPEtDvtQPvqnCiWLOnLmph8pg/gV3jcHDc=;
	b=vJCa9JgZNcAUgLlAy1DPfSUQgnq2TtEHGIBehPMgslTrTMMZRjNb1oU6RfqHTzm8EV9P
	 3jExDJypq8amMKBg4VdjXmt6j8BmYTjd05kfmR07iNcSiviFP35dOb2ncZAv19uLTMu4B
	 Duj3vwzu5r2zSO5HeJhJIGAbhZGu0eP1CeHvWra8T9a8ko0f5IrmAAOg/D7z2YBSt0kOG
	 SBxocXeaXodscZpPUqvY98XcbsbcmTgEZMdIW1eZ+DSuh6/f9SVBnW05L/7dPZmmphRiN
	 cJDEtivxjYb290bb3ty+78IMpJtwDjbMGwXhEfh69UmkY9RA4VsCGJvN6rDqNi75lNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYgn04xR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310B606A32D
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYgn04xR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E4C1F000C4;
	Fri, 13 Nov 2026 12:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794573321;
	bh=QAxv6GV21dPEtDvtQPvqnCiWLOnLmph8pg/gV3jcHDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KYgn04xRMco+ayWSMfSV8oQrSWjJHpl/sYUH2qjz9s7pdqkbu9RRb4jGjXAQt/PC1
	 AFOn6HYHdp9R7piubFEWqLsTrbYqpnMSnGeBeJbqZazNqf8UVsk6khfWu6Sg2xaehQ
	 i+FdDyFfFuK54WfEwzRLEXFhir7yAbTe441rTtncmhe7wSetor4zhAZEiNA9Co0NNJ
	 BSIkqsRal2sZ9TzoWWOIM7z7wyKDg+PTilf+rwJccxl+Qr3XVzhs9I/qWTAPFH2BJu
	 4cmJ6lFqgJ9wY3kQFtINIOOqPhr39Y+bINJmVNtdzZrQp8HKkbWaoQcuUneavWQc/o
	 8Wv+7+MS5xRwA==
Message-ID: <sashiko-outbox-212770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/2] drivers/watchdog: Add RISC-V SBI watchdog
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prajwal N" <prajwal.n@oss.qualcomm.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261113121857.1640918-3-prajwal.n@oss.qualcomm.com>
References: <20261113121857.1640918-1-prajwal.n@oss.qualcomm.com>
 <20261113121857.1640918-3-prajwal.n@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 12:35:20 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] watchdog: riscv_sbi_wdt: missing return on dev_err_probe() in
  sbiwdt_probe()
- [Medium] watchdog: riscv_sbi_wdt: missing select WATCHDOG_CORE in
  Kconfig
--

commit 492be02d4c062c56b2b12bb8aae92692793bfd6b
Author: Prajwal N <prajwal.n@oss.qualcomm.com>

drivers/watchdog: Add RISC-V SBI watchdog driver

This commit adds a watchdog driver for the RISC-V SBI watchdog extension
with support for MSI-based pretimeout notifications.

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c884f86be4e37..164f4b426240e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2157,6 +2157,15 @@ config STARFIVE_WATCHDOG
>  	  Say Y here to support the watchdog of StarFive JH7100 and JH7110
>  	  SoC. This driver can also be built as a module if choose M.
> =20
> +config RISCV_SBI_WATCHDOG
> +	tristate "RISC-V SBI based Watchdog support"
> +	depends on RISCV_SBI
> +	default RISCV
> +	help
> +	  Say Y here to include support for a watchdog timer
> +	  implemented by the Supervisor Binary Interface on RISCV platforms.
> +	  Requires firmware support.
> +

[Severity: Medium]
Should RISCV_SBI_WATCHDOG select WATCHDOG_CORE?

sbiwdt_probe() calls devm_watchdog_register_device(), so enabling
CONFIG_RISCV_SBI_WATCHDOG without CONFIG_WATCHDOG_CORE (or with
CONFIG_RISCV_SBI_WATCHDOG=3Dy and CONFIG_WATCHDOG_CORE=3Dm) fails to link.

> diff --git a/drivers/watchdog/riscv_sbi_wdt.c b/drivers/watchdog/riscv_sb=
i_wdt.c
> new file mode 100644
> index 0000000000000..577756f152ce8
> --- /dev/null
> +++ b/drivers/watchdog/riscv_sbi_wdt.c

[ ... ]

> +static int sbiwdt_probe(struct platform_device *pdev)
> +{
> +	struct sbiwdt *wdt;
> +	const struct imsic_global_config *imsic_global;
> +	struct irq_domain *msi_domain;
> +	struct device *dev =3D &pdev->dev;
> +	int rc;
> +
> +	/* Allocate memory for the global watchdog structure */
> +	wdt =3D devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, wdt);
> +	watchdog_set_drvdata(&wdt->wdd, wdt);
> +
> +	/* Initialiaze watchdog attributes */
> +	rc =3D sbiwdt_init_attributes(wdt);
> +	if (rc)
> +		dev_err_probe(dev, rc, "Failed to read SBI watchdog attributes\n");
> +
> +	wdt->wdd.parent =3D dev;
> +	wdt->wdd.info =3D &sbiwdt_info;
> +	wdt->wdd.ops =3D &sbiwdt_ops;
> +
> +	watchdog_stop_on_unregister(&wdt->wdd);
> +	watchdog_stop_on_reboot(&wdt->wdd);
> +
> +	/* Setup MSI if the capability is available */
> +	if (wdt->attrs.wdt_capability & SBI_WATCHDOG_CAP_MSI_SUPPORT_MASK) {
> +		imsic_global =3D imsic_get_global_config();
> +		if (!imsic_global)
> +			dev_err_probe(dev, -ENODEV, "IMSIC firmware node is unavailable\n");
> +
> +		msi_domain =3D irq_find_matching_fwnode(imsic_global->fwnode,
> +							DOMAIN_BUS_PLATFORM_MSI);
> +
> +		if (!msi_domain)
> +			dev_err_probe(dev, -ENODEV, "IMSIC platform MSI domain is unavailable=
\n");
> +
> +		dev_set_msi_domain(&pdev->dev, msi_domain);
> +
> +		/* MSI setup */
> +		rc =3D platform_device_msi_init_and_alloc_irqs(dev, 1, sbiwdt_msi_writ=
e);
> +		if (rc)
> +			dev_err_probe(dev, rc, "Failed to allocate MSIs\n");
> +
> +		/* Register with devm the MSI cleanup callback */
> +		rc =3D devm_add_action_or_reset(dev, sbiwdt_msi_free_irqs, dev);
> +		if (rc)
> +			return dev_err_probe(dev, rc, "Failed to add sbiwdt MSI cleanup\n");
> +
> +		/* Enable pretimeout only when the MSI is allocated */
> +		wdt->wdd.info =3D &sbiwdt_pretimeout_info;
> +
> +		wdt->virq =3D msi_get_virq(dev, 0);
> +		if (!wdt->virq)
> +			dev_err_probe(dev, -ENODEV, "Failed to get MSI virtual IRQ\n");
> +
> +		rc =3D devm_request_irq(dev, wdt->virq,
> +					sbiwdt_pretimeout_handler,
> +					0, "sbiwdt-pretimeout", wdt);
> +		if (rc)
> +			dev_err_probe(dev, rc, "Failed to request pretimeout IRQ\n");
> +	}
> +
> +	rc =3D devm_watchdog_register_device(dev, &wdt->wdd);
> +	if (rc)
> +		dev_err_probe(dev, rc, "Failed to register RISC-V SBI watchdog device\=
n");
> +
> +	dev_info(&pdev->dev, "RISC-V SBI Watchdog registered\n");
> +
> +	return 0;
> +}

[Severity: High]
Are seven of the eight dev_err_probe() calls in sbiwdt_probe() missing a
return statement?

Without returning, a NULL imsic_global causes an immediate NULL pointer
dereference at imsic_global->fwnode, and earlier or later failures allow
sbiwdt_probe() to continue with uninitialized attributes, broken MSI/IRQ
state, or a false 0 return that skips devres cleanup when
devm_watchdog_register_device() fails.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113121857.1640=
918-1-prajwal.n@oss.qualcomm.com?part=3D2
