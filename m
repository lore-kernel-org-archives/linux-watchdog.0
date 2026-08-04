Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F141D12A;
	Tue,  4 Aug 2026 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827754; cv=none; b=s653q0HHM0lTluVTrAtJFYFekWYyrZouILzEs8tY6Tx1NKFLn53yrCkZ2cACventf7CQrTmGqlIJ506VVeseL3OR0EzJFVSakPWlcf9/X1vqQoVTjATGQLC2Hu3KpOiqKtbkeRjDOh/Sqzx3anAnIMHVQSCzLCuxv8CL5lcvnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827754; c=relaxed/simple;
	bh=uO3MBo2NU1h+e3lyLZTHeZ2vUIp/C6LglbDCADMnh2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aIw7K4rwnp8i5uHQPd7s1+Lt67fril/SvJU79/in15bQyFAw1dWMGKAQGr7BfFnt/fcDVRgz7Mb/jl5xs995Xa1BazzizBdHTNk7Ea88ZaNcB7W8r07oFQm1t5s/nJK0C+KYQt+BT5vzrtdlolAMnvubZMUUMIZGkLEDeVBKqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAby3+gE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAby3+gE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BF01F000E9;
	Tue,  4 Aug 2026 07:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785827753;
	bh=ciBd2j/u6qWpx3lPYm6qY+BTeUKEwrVYQYGofs9dUBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZAby3+gER5D8UizrPfI9Hk8mPLqytJfOGc9QwNQV/j+dAYUdbu330Ov/EIPpNLPPO
	 wXfn2/mW1QgNqt2wGgStzSIkeTaraMbJ7TxiIeb+OFQn+I1pVHVGYwzI9/jsWoJMdY
	 ompwxDlEdAqLUaR1qfGZEqB0tJIH9s1sNopiREhAMm7H783TAuqf4Pi8PkEd5VmzL2
	 ySv34v5iRW4dp5mW6J+klHLIJOvgznPJeaqnRNVa1zQ38sN/D8R7RZSWrQQAG6ltNe
	 QQ/d89fjBRWNVJuiI75ZOiFBUtsRDjg9A6RNGXFG9EuHxGfwmSLc3lQnyfs6v0XH0O
	 j01ZC4UUn/rbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] watchdog: Add Nuvoton MA35D1 watchdog driver
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zi-Yu Chen" <zychennvt@gmail.com>
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260804070351.1846165-3-zychennvt@gmail.com>
References: <20260804070351.1846165-1-zychennvt@gmail.com>
 <20260804070351.1846165-3-zychennvt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 07:15:52 +0000
Message-Id: <20260804071552.E6BF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing wait for hardware synchronization (`SYNC` bit) after writi=
ng to `REG_WDT_CTL` leads to dropped writes and hardware races.
- [High] Read-modify-write operations on `REG_WDT_CTL` inadvertently clear =
Write-1-to-Clear (W1C) status flags.
- [Medium] The interrupt handler unconditionally clears all flags and retur=
ns IRQ_HANDLED without verifying the interrupt source.
--

--- Patch [2]: [PATCH v3 2/3] watchdog: Add Nuvoton MA35D1 watchdog driver =
support ---
commit b3e6fc51e35611680a67e3e8fcf506e2ac5f75cb
Author: Zi-Yu Chen <zychennvt@gmail.com>

watchdog: Add Nuvoton MA35D1 watchdog driver support

Add driver support for the Watchdog Timer (WDT) integrated in Nuvoton
MA35D1 SoC. This driver provides standard watchdog functionality,
including timeout configuration, ping, and system reset support via
the watchdog framework.

> diff --git a/drivers/watchdog/ma35d1_wdt.c b/drivers/watchdog/ma35d1_wdt.c
> new file mode 100644
> index 0000000000000..119d58f338bf0
> --- /dev/null
> +++ b/drivers/watchdog/ma35d1_wdt.c

[ ... ]

> +static int ma35d1_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +				  unsigned int timeout)
> +{

[ ... ]

> +	guard(spinlock_irqsave)(&ma35d1_wdt->lock);
> +	val =3D readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +	val &=3D ~TOUTSEL;
> +	val |=3D FIELD_PREP(TOUTSEL, i);
> +	writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);

[Severity: High]
Does this read-modify-write of REG_WDT_CTL inadvertently clear W1C flags?

If bits like IF, WKF, and RSTF are write-1-to-clear, writing back a value
that has them set will unintentionally clear pending interrupts, wakeups, or
reset status. Should these W1C bits be masked out from val before it is
written back?

Also, should there be a call to ma35d1_wdt_wait_sync() here?

When ma35d1_wdt_start() calls this function, it modifies REG_WDT_CTL, retur=
ns,
and then immediately modifies REG_WDT_CTL again. Could this second write
overlap with the clock domain synchronization of the first write and cause
hardware races?

> +
> +	ma35d1_wdt_ping(wdt_dev);
> +	return 0;
> +}
> +
> +static int ma35d1_wdt_start(struct watchdog_device *wdt_dev)
> +{
> +	struct ma35d1_wdt_dev *ma35d1_wdt =3D watchdog_get_drvdata(wdt_dev);
> +	void __iomem *wdt_base =3D ma35d1_wdt->wdt_base;
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D ma35d1_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
> +	if (ret < 0)
> +		return ret;
> +
> +	guard(spinlock_irqsave)(&ma35d1_wdt->lock);
> +	val =3D readl_relaxed(wdt_base + REG_WDT_CTL);
> +	val |=3D (WDTEN | RSTEN);
> +
> +	writel_relaxed(val, wdt_base + REG_WDT_CTL);

[Severity: High]
This read-modify-write shares the same potential W1C flag clearing issue
mentioned in ma35d1_wdt_set_timeout().

> +	ret =3D ma35d1_wdt_wait_sync(ma35d1_wdt);
> +	if (ret) {
> +		dev_err(wdt_dev->parent, "Wait for WDTEN SYNC timeout!\n");
> +		return ret;
> +	}
> +
> +	writel_relaxed(RESET_COUNTER, wdt_base + REG_WDT_RSTCNT);
> +
> +	return 0;
> +}

[ ... ]

> +static irqreturn_t ma35d1_wdt_isr(int irq, void *dev_id)
> +{
> +	struct ma35d1_wdt_dev *ma35d1_wdt =3D dev_id;
> +	unsigned int val;
> +
> +	/* Clear the flag if set */
> +	guard(spinlock)(&ma35d1_wdt->lock);
> +	val =3D readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +	writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
Does this interrupt handler need to verify the interrupt source before
returning IRQ_HANDLED?

As written, this unconditionally claims the interrupt, which bypasses the
kernel's spurious interrupt detection if the interrupt was actually
generated by another device sharing the line.

Additionally, would writing back the unmodified value of REG_WDT_CTL clear
all W1C flags at once, including RSTF, which might destroy status
information needed elsewhere?

[ ... ]

> +static int ma35d1_wdt_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	val =3D readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +	if (val & RSTF) {
> +		ma35d1_wdt->wdt_dev.bootstatus =3D WDIOF_CARDRESET;
> +		writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +	}

[Severity: High]
Does this write to clear RSTF also require a call to ma35d1_wdt_wait_sync()?

The code proceeds to call ma35d1_wdt_set_timeout() shortly after this, which
will write to REG_WDT_CTL again. Could this lead to dropped writes or hardw=
are
races if the synchronization from this first write isn't complete?

> +
> +	if (val & WDTEN)
> +		set_bit(WDOG_HW_RUNNING, &ma35d1_wdt->wdt_dev.status);
> +
> +	watchdog_set_drvdata(&ma35d1_wdt->wdt_dev, ma35d1_wdt);
> +	watchdog_set_nowayout(&ma35d1_wdt->wdt_dev, nowayout);
> +	watchdog_init_timeout(&ma35d1_wdt->wdt_dev, timeout, &pdev->dev);
> +
> +	ma35d1_wdt_set_timeout(&ma35d1_wdt->wdt_dev,
> +			       ma35d1_wdt->wdt_dev.timeout);

[ ... ]

> +static int ma35d1_wdt_suspend(struct device *dev)
> +{
> +	struct ma35d1_wdt_dev *ma35d1_wdt =3D dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&ma35d1_wdt->wdt_dev) ||
> +	    watchdog_hw_running(&ma35d1_wdt->wdt_dev)) {
> +		u32 val;
> +		int ret;
> +
> +		guard(spinlock_irqsave)(&ma35d1_wdt->lock);
> +		val =3D readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +
> +		if (device_may_wakeup(dev)) {
> +			val &=3D ~RSTEN;
> +			val |=3D (INTEN | WKEN);
> +		} else {
> +			val &=3D ~(WDTEN | RSTEN);
> +		}
> +		writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);

[Severity: High]
This read-modify-write shares the same potential W1C flag clearing issue.

If a pending wakeup flag is set during the read, could it be inadvertently
cleared right before the system sleeps?

> +		ret =3D ma35d1_wdt_wait_sync(ma35d1_wdt);
> +		if (ret) {
> +			dev_err(dev, "Wait for WDTEN SYNC timeout!\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804070351.1846=
165-1-zychennvt@gmail.com?part=3D2
