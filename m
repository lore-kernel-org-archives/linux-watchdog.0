Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF9330D41E;
	Thu, 23 Jul 2026 06:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787632; cv=none; b=JhkniCfDCaVLABzqkeKzjGL/SPPoRwanPC3EjiffVRA6VqTiMmZ8X//+01Sve4eZlTDG694/IQnPblcw+9IRmDL8PN5abTGXNFTOj6ZpryOgL2siZdEi7Q+cS45xhWesXlKrSRttXjL1OuMF5LcDL7nwS8oErUQURpL0Iitdz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787632; c=relaxed/simple;
	bh=kNsw5BiZdubYyttopZNcV2ZslKljv/apVRdaIhMK0hA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lNUkCH/3C9xMjsodTeZ+PcxqLBo4KNREXKhFzAwI6PyskmUGYi9YgKDrQpETTbGqogAUBONpD57ZYxrOFDzuPK0XSF+dVkn8AKvrayTuv9MboeoT1bFxCMRj7U7Y0I7xk1QsJnVfpjpxuSbN3GFqpGqe4DOyfPXGnhvamhoP8Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFrLtTen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFrLtTen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20F41F000E9;
	Thu, 23 Jul 2026 06:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784787631;
	bh=giQTqNxrsPde/JxWT0BvtNASBnoNIwq4ksrb/jR76xA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gFrLtTen7Fl5IzfKgP0fRMKrVEm/id6xMNAsr1KGLe1lb33gAPom8Hy50UeO1ijgJ
	 CnjBCsJb3fO57J5aFQzrLQ+Hglgd3PIs/YT3yrpOLUitLj3b5oRdAmg3Ubkfie5ev4
	 nUfrGYHlz7g8io4K4/DSARqgWxugA7ZHX//M//QDnBE3pnIo0V1ByioeGtQ9cdeBFp
	 Jgt9SlpSn+zPX+0G37txdHNdPHhR4reBFTLrpUEFeVKvQBMmRR5/YZegfZK9mAThU3
	 AaSvZodwGWb3jkp2GcfBP3YPiNJaGLUHMhTP+zmYOYVzo88L2lkBU0WUxcIJoGSXbs
	 rJDZE1shJ0wog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] watchdog: Add Nuvoton MA35D1 watchdog driver
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zi-Yu Chen" <zychennvt@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260723060755.1596858-3-zychennvt@gmail.com>
References: <20260723060755.1596858-1-zychennvt@gmail.com>
 <20260723060755.1596858-3-zychennvt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 06:20:30 +0000
Message-Id: <20260723062030.B20F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] The `ma35d1_wdt->dev` pointer is never initialized, leading to NUL=
L pointer dereferences in logging functions.
- [High] Read-modify-write operations on REG_WDT_CTL inadvertently clear W1=
C (write-one-to-clear) status flags.
- [High] Missing clock domain synchronization (`ma35d1_wdt_wait_sync`) afte=
r writes to `REG_WDT_CTL` can lead to dropped register writes.
- [High] Driver overwrites `wdt_dev->timeout`, breaking the software heartb=
eat extension.
- [High] Missing cleanup for wake IRQ allocated by dev_pm_set_wake_irq(), l=
eading to a memory leak and permanent device unbind/bind failures.
- [High] The driver fails to check if the watchdog was already enabled by t=
he bootloader, causing unexpected system reboots during boot.
- [Medium] Unsigned integer comparison against zero renders IRQ error handl=
ing dead code.
- [Medium] Integer overflow in `target_ticks` calculation triggers unexpect=
ed system resets for large timeouts.
- [Low] Unnecessary dependency: selects `MFD_SYSCON` without using it.
--

--- Patch [2]: [PATCH 2/3] watchdog: Add Nuvoton MA35D1 watchdog driver sup=
port ---
commit 3456ece7880176f0928364babfa03dcf9243b968
Author: Zi-Yu Chen <zychennvt@gmail.com>

watchdog: Add Nuvoton MA35D1 watchdog driver support

Add driver support for the Watchdog Timer (WDT) integrated in
Nuvoton MA35D1 SoC. This driver provides standard watchdog functionality,
including timeout configuration, ping, and system reset support via
the watchdog framework.

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 08cb8612d41fe..28d8d3d12c27f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -720,6 +720,17 @@ config STMP3XXX_RTC_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stmp3xxx_rtc_wdt.
> =20
> +config MA35D1_WDT
> +	tristate "Nuvoton MA35D1 Watchdog Timer"
> +	depends on ARCH_MA35 || COMPILE_TEST
> +	select WATCHDOG_CORE
> +	select MFD_SYSCON

[Severity: Low]
Is select MFD_SYSCON necessary here?

The driver maps its MMIO region directly and doesn't appear to use MFD or
syscon APIs.

[ ... ]
> --- /dev/null
> +++ b/drivers/watchdog/ma35d1_wdt.c
[ ... ]
> +static int ma35d1_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +				  unsigned int timeout)
> +{
> +	struct ma35d1_wdt_dev *ma35d1_wdt =3D watchdog_get_drvdata(wdt_dev);
> +	unsigned long target_ticks;
> +	unsigned int val, i;
> +	static const uint8_t toutsel_shifts[] =3D { 4,  6,  8,  10, 12,
> +						  14, 16, 18, 20 };
> +
> +	target_ticks =3D (unsigned long)timeout * ma35d1_wdt->clk_rate;

[Severity: Medium]
Can this calculation overflow on 32-bit platforms where unsigned long is
32 bits?

If a user configures a large timeout, timeout * clk_rate might truncate
before it can be clamped, resulting in a tiny hardware timeout.

> +
> +	for (i =3D 0; i < ARRAY_SIZE(toutsel_shifts); i++) {
> +		if ((1UL << toutsel_shifts[i]) >=3D target_ticks)
> +			break;
> +	}
> +
> +	if (i =3D=3D ARRAY_SIZE(toutsel_shifts))
> +		i =3D ARRAY_SIZE(toutsel_shifts) - 1;
> +
> +	scoped_guard(spinlock_irqsave, &ma35d1_wdt->lock) {
> +		val =3D readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +		val &=3D ~TOUTSEL;
> +		val |=3D FIELD_PREP(TOUTSEL, i);
> +		writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +	}

[Severity: High]
Does this read-modify-write sequence accidentally clear write-one-to-clear
status flags like IF, WKF, or RSTF?

Writing back a 1 to these bits when they are concurrently set by hardware
would acknowledge and clear them.

> +
> +	/* To avoid truncation errors (0 seconds) during division. */
> +	wdt_dev->timeout =3D (1UL << toutsel_shifts[i]) / ma35d1_wdt->clk_rate;

[Severity: High]
Does overwriting wdt_dev->timeout with the truncated hardware timeout
break the software heartbeat extension?

If userspace requests a timeout larger than the hardware maximum, the core
delegates to the software ping worker. Modifying wdt_dev->timeout here
causes the core to adopt the small timeout instead.

> +	if (wdt_dev->timeout =3D=3D 0)
> +		wdt_dev->timeout =3D 1;
> +
> +	dev_dbg(ma35d1_wdt->dev, "wdt_dev->timeout =3D %d\n", wdt_dev->timeout);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_wdt_start(struct watchdog_device *wdt_dev)
> +{
> +	unsigned int val;
> +
> +	struct ma35d1_wdt_dev *ma35d1_wdt =3D watchdog_get_drvdata(wdt_dev);
> +	void __iomem *wdt_base =3D ma35d1_wdt->wdt_base;
> +	int ret;
> +
> +	ret =3D ma35d1_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
> +	if (ret < 0)
> +		return ret;
> +
> +	guard(spinlock_irqsave)
> +		(&ma35d1_wdt->lock);
> +	val =3D readl_relaxed(wdt_base + REG_WDT_CTL);
> +	val |=3D (WDTEN | RSTEN);
> +
> +	writel_relaxed(val, wdt_base + REG_WDT_CTL);

[Severity: High]
Can the back-to-back writes to REG_WDT_CTL drop register updates?

ma35d1_wdt_set_timeout() writes to REG_WDT_CTL but doesn't call
ma35d1_wdt_wait_sync() afterwards. When ma35d1_wdt_start() immediately
writes to REG_WDT_CTL again, it might happen before the synchronization
bit clears.

[ ... ]
> +static int ma35d1_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct ma35d1_wdt_dev *ma35d1_wdt;
> +	unsigned long clk_rate, val;
> +	int ret;
> +
> +	ma35d1_wdt =3D devm_kzalloc(dev, sizeof(*ma35d1_wdt), GFP_KERNEL);
> +	if (!ma35d1_wdt)
> +		return -ENOMEM;

[Severity: High]
It looks like ma35d1_wdt->dev is never assigned to dev during probe.

If a synchronization timeout occurs later in ma35d1_wdt_stop(), will
dev_err(ma35d1_wdt->dev, ...) dereference this uninitialized pointer?

[ ... ]
> +	ma35d1_wdt->irq =3D platform_get_irq(pdev, 0);
> +	if (ma35d1_wdt->irq < 0)
> +		return dev_err_probe(dev, ma35d1_wdt->irq,
> +				     "failed to get irq\n");

[Severity: Medium]
Since the irq field in struct ma35d1_wdt_dev is declared as an unsigned u32,
will this < 0 check ever evaluate to true?

If platform_get_irq() returns a negative error code like -ENXIO, the error
handling would be skipped and proceed to devm_request_irq() with a huge
positive IRQ number.

[ ... ]
> +	if (device_property_read_bool(dev, "wakeup-source")) {
> +		ret =3D devm_device_init_wakeup(dev);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D dev_pm_set_wake_irq(dev, ma35d1_wdt->irq);
> +		if (ret)
> +			return ret;
> +	}

[Severity: High]
Because the driver uses dev_pm_set_wake_irq() without a devm_ wrapper and
lacks a remove function, does this leak the PM wake IRQ structure?

If the driver is unbound and rebound via sysfs, the attached wake IRQ is
never cleaned up, which could cause subsequent binds to fail.

[ ... ]
> +	val =3D readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +	if (val & RSTF) {
> +		ma35d1_wdt->wdt_dev.bootstatus =3D WDIOF_CARDRESET;
> +		writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +	}
> +
> +	watchdog_set_drvdata(&ma35d1_wdt->wdt_dev, ma35d1_wdt);

[Severity: High]
Does this code need to check the WDTEN bit to handle a running watchdog
handed off by the bootloader?

If the hardware is already ticking and WDOG_HW_RUNNING is not set, the
watchdog core won't know to ping the hardware before userspace connects,
which could lead to spurious resets during boot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723060755.1596=
858-1-zychennvt@gmail.com?part=3D2
