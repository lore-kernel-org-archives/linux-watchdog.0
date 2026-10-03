Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFBF3749F7
	for <linux-watchdog@vger.kernel.org>; Sat,  3 Oct 2026 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991200; cv=none; b=TzEaYgEHw4+rx69TBSq72eJC5mLAxpfnCN+rYY1Zi4aTGxRQmoPl8jQ1m/7Ch9KnaoslUTk+YOGa0aGWI+NDFLP+zkb5BYj9bdkfmoLTevJDmPpifSaR7gRT+SA6qpKoqL52cKeF33pazSpBP+kO82aHSh21dXjJlXlemtxxXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991200; c=relaxed/simple;
	bh=baLR+xDhTXrVXoOp9WhqDWGy3dDMIoMjtE3lt6Kt8Xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I9QpNRfhZ7Wg8WUKlcXdDK6Hmb4xt7ybPXWXVe7LJZTe9RW9LknwNm+tkhwUfEUwT4uI416Jc1NlQYWx60G61mP2OpYzmcVjSr9NdRnmzK8KEy0hx559wjgwb3iCXJGT880eYPYGyq8hD2YCzBmmHnMn75MUR3OwTYiYbDoxjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkgnbM/w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkgnbM/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74021F0089A;
	Sat,  3 Oct 2026 01:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991199;
	bh=9ao9mRo149YJIQu+iKfx6iofKINoqnMW4sbq3TDcMck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dkgnbM/wTYD6PdGvjctbCzdV0U3/k6w3etY0KPovx43+THqKgAMfCyldU2Xp80w3h
	 wJ6IjXyL0iqepUxXR+7BH2upAzrXNgvYg0BDqjlnlVlf+R2437IwP0Vg7ysnzVlWfE
	 2TxU4dMOYyrepzPOnF7oHO8J+HdMZdYGPtyjWq6PmNr5q7SpRDBuk3RjzajKkDT2LH
	 kGyVIh90DzrZerqTmF1cKidISXhVlsYvGX24P+ayDWT1GKK555rff+YxfemzZq6PTu
	 zOcrMm+taPYdoFeWQc67n2oO6p/RbzByoGKcTAQeSQPa7iTS9Wg4Q7WXcuB0LrZUIe
	 OBVNoWlHdgYyg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] drivers/watchdog: Add RISC-V SBI watchdog
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prajwal N" <prajwal.n@oss.qualcomm.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261002163758.2919372-3-prajwal.n@oss.qualcomm.com>
References: <20261002163758.2919372-1-prajwal.n@oss.qualcomm.com>
 <20261002163758.2919372-3-prajwal.n@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:18 +0000
Message-Id: <20261003013318.E74021F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] watchdog: riscv_sbi_wdt: Probe returns success on MSI virtual IRQ =
failure
- [High] watchdog: riscv_sbi_wdt: Silent u32 overflow in timeout conversion=
 allows premature resets
- [High] watchdog: riscv_sbi_wdt: MSI interrupts leak and Use-After-Free on=
 unbind
- [Medium] watchdog: riscv_sbi_wdt: Missing wdt->dev and parent initializat=
ions
- [Medium] watchdog: riscv_sbi_wdt: WDIOF_PRETIMEOUT exposed without hardwa=
re support
- [Medium] watchdog: riscv_sbi_wdt: set_timeout fails to adjust pretimeout
- [Low] watchdog: riscv_sbi_wdt: Build failure due to non-existent fwnode m=
ember
- [Low] watchdog: riscv_sbi_wdt: Missing module_exit() prevents unloading
- [Low] watchdog: riscv_sbi_wdt: Build failure on configs missing GENERIC_M=
SI_IRQ
--

commit 5a455815a87582fc7be391ea2d8512e1bd8d0b90
Author: Prajwal N <prajwal.n@oss.qualcomm.com>

drivers/watchdog: Add RISC-V SBI watchdog driver

This commit adds support for the RISC-V SBI watchdog extension, integrating
with the Linux watchdog framework. It configures and controls the watchdog
via standard SBI calls and optionally supports pretimeout MSIs.

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
[ ... ]
> +config RISCV_SBI_WATCHDOG
> +	tristate "RISC-V SBI based Watchdog support"
> +	depends on RISCV_SBI

[Severity: Low]
Does this configuration need a dependency on CONFIG_GENERIC_MSI_IRQ?

Without it, the unconditional call to
platform_device_msi_init_and_alloc_irqs() in probe will cause a build
failure when that config is disabled.

> diff --git a/drivers/watchdog/riscv_sbi_wdt.c b/drivers/watchdog/riscv_sb=
i_wdt.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/watchdog/riscv_sbi_wdt.c
[ ... ]
> +/* Convert second to microsecond */
> +static inline u32 sec_to_usec(unsigned int sec)
> +{
> +	return (u32)(sec * 1000000ULL);
> +}

[Severity: High]
Can this silently overflow if a user with privileges configures a large
timeout?

For example, setting a timeout greater than 4294 seconds overflows the u32
calculation, causing the hardware to receive an extremely short timeout
instead, potentially triggering an unexpected system reset.

[ ... ]
> +/* Set the watchdog timeout value */
> +static int sbiwdt_set_timeout(struct watchdog_device *wdd, unsigned int =
timeout)
> +{
> +	struct sbiwdt *wdt =3D watchdog_get_drvdata(wdd);
> +	u32 period_usec;
> +	int ret;
> +
> +	period_usec =3D sec_to_usec(timeout);
> +
> +	ret =3D sbiwdt_write_attribute(SBI_WDT_PERIOD, period_usec);
> +	if (ret)
> +		return ret;
> +
> +	wdt->attrs.wdt_period =3D period_usec;
> +	wdt->wdd.timeout =3D timeout;
> +
> +	return 0;
> +}

[Severity: Medium]
Does this function need to adjust or validate against wdd->pretimeout?

If a user sets a new timeout that is smaller than the current pretimeout,
the hardware could be left in an invalid state where the notification time
is greater than the period time.

[ ... ]
> +/* Get the watchdog timeleft before expiry */
> +static unsigned int sbiwdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct sbiwdt *wdt =3D watchdog_get_drvdata(wdd);
> +	unsigned int time_left_usec;
> +	int ret;
> +
> +	ret =3D sbiwdt_read_attribute(SBI_WDT_TIME_LEFT, &time_left_usec);
> +	if (ret) {
> +		dev_err(wdt->dev, "Failed to read watchdog time left: %d\n", ret);

[Severity: Medium]
Will this dereference an uninitialized wdt->dev pointer?

It appears wdt->dev is never assigned during probe, which would lead to
obscured error logs displaying "(NULL device *)".

> +		return 0;
> +	}
> +
> +	return usec_to_sec(time_left_usec);
> +}
> +
> +static const struct watchdog_info sbiwdt_info =3D {
> +	.options	=3D	WDIOF_SETTIMEOUT	|
> +				WDIOF_KEEPALIVEPING	|
> +				WDIOF_PRETIMEOUT	|
> +				WDIOF_MAGICCLOSE,

[Severity: Medium]
Should WDIOF_PRETIMEOUT only be advertised if the firmware actually
supports MSI capabilities?

Statically advertising it means userspace could configure a pretimeout that
will silently never trigger on platforms without MSI support.

[ ... ]
> +/* Initialize the watchdog attributes */
> +static int sbiwdt_init_attributes(struct sbiwdt *wdt)
> +{
[ ... ]
> +	/* Initialize the watchdog timeout to default value */
> +	timeout_usec =3D sec_to_usec(SBI_WDT_DEFAULT_TIMEOUT);
> +	ret =3D sbiwdt_write_attribute(SBI_WDT_PERIOD, timeout_usec);
> +	if (ret)
> +		return ret;
> +
> +	wdt->attrs.wdt_period =3D timeout_usec;
> +	wdt->wdd.timeout =3D SBI_WDT_DEFAULT_TIMEOUT;

[Severity: High]
Should wdt->wdd.max_timeout be explicitly initialized here?

Without an upper bound set by the driver, the watchdog core defaults to no
hardware limit, allowing large timeouts to be passed to sec_to_usec()
which then truncates them via integer overflow.

[ ... ]
> +static int sbiwdt_probe(struct platform_device *pdev)
> +{
> +	struct sbiwdt *wdt;
> +	struct imsic_global_config *imsic_global;
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

[Severity: Medium]
Are we missing assignments for wdt->dev and wdt->wdd.parent here?

Failing to set wdt->wdd.parent =3D dev breaks the sysfs hierarchy for the
watchdog device, and missing wdt->dev =3D dev leads to the uninitialized
pointer use observed in sbiwdt_get_timeleft().

[ ... ]
> +	/* Setup MSI if the capability is available */
> +	if (wdt->attrs.wdt_capability & SBI_WDT_CAP_MSI_SUPPORT_MASK) {
> +		imsic_global =3D imsic_get_global_config();
> +		if (!imsic_global) {
> +			dev_err(dev, "IMSIC firmware node is unavailable\n");
> +			return -ENODEV;
> +		}
> +
> +		msi_domain =3D irq_find_matching_fwnode(imsic_global->fwnode,
> +							DOMAIN_BUS_PLATFORM_MSI);

[Severity: Low]
Does struct imsic_global_config actually have an fwnode member?

It appears this member does not exist in the upstream struct definition,
which will cause an immediate build failure.

> +		if (!msi_domain) {
> +			dev_err(dev, "IMSIC platform MSI domain is unavailable\n");
> +			return -ENODEV;
> +		}
> +
> +		dev_set_msi_domain(&pdev->dev, msi_domain);
> +
> +		/* MSI setup*/
> +		rc =3D platform_device_msi_init_and_alloc_irqs(dev, 1, sbiwdt_msi_writ=
e);

[Severity: High]
Are these MSI allocations ever cleaned up if subsequent probe steps fail?

Since this is not a device-managed function, error paths that return early
will leak these interrupts.

> +		if (rc) {
> +			dev_err(dev, "Failed to allocate MSIs\n");
> +			return rc;
> +		}
> +
> +		wdt->virq =3D msi_get_virq(dev, 0);
> +		if (!wdt->virq) {
> +			dev_err(dev, "Failed to get MSI virtual IRQ: %d\n", wdt->virq);
> +			return wdt->virq;
> +		}

[Severity: High]
Will this return 0 (success) when it intends to return a failure?

msi_get_virq() returns 0 on failure. Returning wdt->virq here falsely
signals a successful probe to the driver core, leaving the system silently
unprotected since the watchdog never fully registers.

[ ... ]
> +static struct platform_driver sbiwdt_driver =3D {
> +	.probe  =3D sbiwdt_probe,
> +	.driver =3D {
> +			.name =3D DRV_NAME,
> +	},
> +};

[Severity: High]
Does this driver need a .remove callback to properly free the MSIs?

Without one, unbinding the driver permanently leaks the interrupts. If a
leaked MSI triggers later, it could execute sbiwdt_msi_write() causing a
use-after-free on the released driver data.

> +
> +static int __init sbiwdt_init(void)
> +{
> +	int ret;
> +	struct platform_device *pdev;
> +
> +	/* Probe for SBI WDT extension */
> +	if (sbi_spec_version < sbi_mk_version(3, 0) ||
> +		sbi_probe_extension(SBI_EXT_WDT) <=3D 0) {
> +		return -ENODEV;
> +	}
> +
> +	ret =3D platform_driver_register(&sbiwdt_driver);
> +	if (ret)
> +		return ret;
> +
> +	pdev =3D platform_device_register_simple(DRV_NAME, -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		platform_driver_unregister(&sbiwdt_driver);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
> +late_initcall(sbiwdt_init);

[Severity: Low]
Should a symmetric module_exit() routine be provided here?

Since the driver is configured as tristate, omitting an exit function
prevents it from ever being unloaded via rmmod.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002163758.2919=
372-1-prajwal.n@oss.qualcomm.com?part=3D2
