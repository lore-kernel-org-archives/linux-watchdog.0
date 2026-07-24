Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4523947B0;
	Fri, 24 Jul 2026 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885103; cv=none; b=psw919pEbzIrIiiUHS9a8TLduVEeEj86nxKNO4TktMUkKTWanonQunn2bE1wZ8r+98dgFy4Xq6H8M2JsDGWGBUwyo39dHyLjSusHXX6fXIYVJDtCaZ33LCsPjcFaxN4YvVZF2G4vGsvdgYreiKEHx7kGT+rlD1h07jUOZ8rUt3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885103; c=relaxed/simple;
	bh=7Bm0t80SamFHwUXpsalPMzu3HqDLTpOZr3zj4axc7BM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oe5yJVBeymRBmB7lkKzbaER8SsCRlhpyp13hNUyK2QeA7s3Fan0EAKT0sEx2fv4hhjz2yqA+Zh+lIClYZDYiX1vx3JmqHVhGp76ofj/MUHSAhT/VckCSbQWf6t5DeSrbKd4nS6h6+zw0DFbgHhhYAJZv4gzEb31iI1SczsTu/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHxzAgUz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHxzAgUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE24D1F00A3A;
	Fri, 24 Jul 2026 09:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784885095;
	bh=InMJgdsWFASkYwB7YOaTdM2Vtu/qM05ZPawLxWMFsKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KHxzAgUzOhaeqbBd7HbMi/Q4DItnFnZc8QVnktSZtopj69K5okNaZw+ueaQdzCEMM
	 JrBzqk4sX3f1FC8MavKGOdU5XyH88uBm32h6Slf4QmKpFXwVAxJJTKPK4RPaXNcNwx
	 4Rsd3LZ6Ycjd3CHYX/aKcEUwm/0DKwwiYKFvBCxAqwR7CgN/LE5l21oHIj7wSzvOv2
	 GZxkGrBC6zKcx25YEe+9JUZEscSeuv/VHwinWLCWJlHaB9HycvMUaLvRsmzTpxUgAl
	 3I1hIsvV8dGAG+0GkbiSCmdM2Aw0jpLn07QyB37NH3pacWJ5JhjpgX9YdXzXMpj4wV
	 LwmBPLZuQGGbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] watchdog: Add Nuvoton MA35D1 watchdog driver
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zi-Yu Chen" <zychennvt@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260724091427.1689980-3-zychennvt@gmail.com>
References: <20260724091427.1689980-1-zychennvt@gmail.com>
 <20260724091427.1689980-3-zychennvt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 09:24:54 +0000
Message-Id: <20260724092454.EE24D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Writes to REG_WDT_CTL are missing required hardware synchronizatio=
n waits (SYNC bit), risking dropped writes and hardware state corruption.
- [High] The watchdog timer is not paused during system suspend if it was r=
unning from the bootloader but not yet opened by userspace, leading to unin=
tended system resets.
- [High] Driver fails to synchronize the hardware timeout with the software=
 configuration when inheriting a running watchdog during probe.
- [High] Read-modify-write operations on REG_WDT_CTL inadvertently clear W1=
C (Write-1-to-Clear) status flags, leading to lost interrupts and wakeup ev=
ents.
- [Medium] In ma35d1_wdt_resume(), the driver writes to REG_WDT_RSTCNT befo=
re ensuring the control register changes have synchronized.
- [Low] Spelling mistake in Kconfig help text.
--

--- Patch [2]: [PATCH v2 2/3] watchdog: Add Nuvoton MA35D1 watchdog driver =
support ---
commit 31ed5d4971c74d4f75935b7f98c40e226cdc3521
Author: Zi-Yu Chen <zychennvt@gmail.com>

watchdog: Add Nuvoton MA35D1 watchdog driver support
   =20
This commit adds a new watchdog driver for the Nuvoton MA35D1 SoC. It provi=
des
support for timeout configuration, ping, and system reset functionality via
the standard watchdog framework.

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 08cb8612d41fe..972740fd36a69 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -720,6 +720,16 @@ config STMP3XXX_RTC_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stmp3xxx_rtc_wdt.
> =20
> +config MA35D1_WDT
> +	tristate "Nuvoton MA35D1 Watchdog Timer"
> +	depends on ARCH_MA35 || COMPILE_TEST
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the watchdog timer
> +	  for the Nuvoton MA35D1 series microprosser.

[Severity: Low]
Is "microprosser" a typo here? Did you mean "microprocessor"?

> diff --git a/drivers/watchdog/ma35d1_wdt.c b/drivers/watchdog/ma35d1_wdt.c
> new file mode 100644
> index 0000000000000..e5247e55dfee4
> --- /dev/null
> +++ b/drivers/watchdog/ma35d1_wdt.c

[ ... ]

> +static int ma35d1_wdt_stop(struct watchdog_device *wdt_dev)
> +{
> +	struct ma35d1_wdt_dev *ma35d1_wdt =3D watchdog_get_drvdata(wdt_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	guard(spinlock_irqsave)(&ma35d1_wdt->lock);
> +	val =3D readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +	val &=3D ~WDTEN;
> +	writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);

[Severity: High]
Will this read-modify-write inadvertently clear Write-1-to-Clear (W1C) flags
like IF, WKF, or RSTF?=20

Looking at ma35d1_wdt_isr(), it appears that reading a 1 and writing it back
clears the flag. Should these W1C flags be explicitly masked out when doing
read-modify-write operations on REG_WDT_CTL here, and similarly in other
functions like ma35d1_wdt_set_timeout(), ma35d1_wdt_start(), and
ma35d1_wdt_suspend()?

[ ... ]

> +static int ma35d1_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +				  unsigned int timeout)
> +{
> +	struct ma35d1_wdt_dev *ma35d1_wdt =3D watchdog_get_drvdata(wdt_dev);
> +	unsigned long target_ticks;
> +	unsigned int val, i;

[ ... ]

> +	guard(spinlock_irqsave)(&ma35d1_wdt->lock);
> +	val =3D readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +	val &=3D ~TOUTSEL;
> +	val |=3D FIELD_PREP(TOUTSEL, i);
> +	writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +
> +	ma35d1_wdt_ping(wdt_dev);
> +	return 0;
> +}

[Severity: High]
Does this writel_relaxed() require a call to ma35d1_wdt_wait_sync() before
proceeding?=20

Without waiting for the SYNC bit, could the immediate ping command be ignor=
ed
by the hardware or cause hardware state corruption?

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
Because ma35d1_wdt_set_timeout() writes to REG_WDT_CTL without waiting for
sync, and then ma35d1_wdt_start() immediately performs another read-modify-=
write
on the same register, could this back-to-back unsynchronized access cause
dropped writes and prevent the watchdog from starting properly?

[ ... ]

> +static int ma35d1_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct ma35d1_wdt_dev *ma35d1_wdt;

[ ... ]

> +	val =3D readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +	if (val & RSTF) {
> +		ma35d1_wdt->wdt_dev.bootstatus =3D WDIOF_CARDRESET;
> +		writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +	}

[Severity: High]
Should there be a wait for hardware synchronization after this write clears
the RSTF bit?

> +
> +	if (val & WDTEN)
> +		set_bit(WDOG_HW_RUNNING, &ma35d1_wdt->wdt_dev.status);

[Severity: High]
If the bootloader left the watchdog running with a very short timeout, could
the system reset before the core's ping worker can keep it alive?

Should this also call ma35d1_wdt_set_timeout() to ensure the hardware's
timeout matches the software configuration when taking over a running watch=
dog?

[ ... ]

> +static int ma35d1_wdt_suspend(struct device *dev)
> +{
> +	struct ma35d1_wdt_dev *ma35d1_wdt =3D dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&ma35d1_wdt->wdt_dev)) {

[Severity: High]
Does this need to check watchdog_hw_running() as well?

If the bootloader started the watchdog (WDOG_HW_RUNNING is set) but userspa=
ce
hasn't opened the device yet (WDOG_ACTIVE is false), this check will skip
pausing the hardware. Could the timer then expire and unexpectedly reset the
system during sleep?

[ ... ]

> +static int ma35d1_wdt_resume(struct device *dev)
> +{
> +	struct ma35d1_wdt_dev *ma35d1_wdt =3D dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&ma35d1_wdt->wdt_dev)) {

[Severity: High]
Similar to suspend, should this also check watchdog_hw_running() to ensure
a hardware-running watchdog is properly resumed?

> +		u32 val;
> +		int ret;
> +
> +		guard(spinlock_irqsave)(&ma35d1_wdt->lock);
> +		val =3D readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +
> +		if (device_may_wakeup(dev)) {
> +			val |=3D RSTEN;
> +			val &=3D ~(INTEN | WKEN);
> +		} else {
> +			val |=3D (WDTEN | RSTEN);
> +		}
> +		writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
> +		writel_relaxed(RESET_COUNTER,
> +			       ma35d1_wdt->wdt_base + REG_WDT_RSTCNT);
> +		ret =3D ma35d1_wdt_wait_sync(ma35d1_wdt);

[Severity: Medium]
Is it safe to issue the ping command (writing to REG_WDT_RSTCNT) before
waiting for the control register changes to synchronize?

In ma35d1_wdt_start(), the ping happens after ma35d1_wdt_wait_sync(). Could
doing it before sync here cause the ping to be ignored by the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724091427.1689=
980-1-zychennvt@gmail.com?part=3D2
