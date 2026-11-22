Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795331925;
	b=DBM38sCLse0O6/GA5fXcRkNRZ5J/Wq1CDF80sU0v+mSkgTkCPPPASO+d2welBwanokE+
	 dM3DCF1zqRcy6jWfXUyLGxR4xQ8JVQkfEi1+/VY920TaF2L3P0tE6WBgj9jgM0wbY+nz+
	 SS1VSYFG+RqblOWtd3ynaLU8Gn5tIo2TiSW8/Jkk/sOKqZzppDB2Q9UhYNXn6nuhJyvJ+
	 zVU5spu9N/WR+qlDVJiXqVK/KA3JsRPpz9GVKM4yudvlv8812QFLoaS9/a3/AAjiaW4Ho
	 6qzZz8RwjFCecDKqvpLqi0+cu+jwkHU1A7/Cz6kOGFTteU9y7A7QV+Bbj8/8WZayXgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795331925;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9BDABOO+/H7uZ6DNlj5U7OTTmHom4uvnWbbMoZ/AFpY=;
	b=5nMikj4i1wrARQP+T4tUKxI3mWPfg1YP+jZtV4pDZ88RIDeLuVy+Hwu39e28YMYZXOjf
	 gvWd8zz1gAg7I5YI3AKlJfS2Ru4g7459eJtuVLO6clhaj4uFeiWBBcFizEPq+jQYIDgAP
	 EbiRLmuuh4VuIcd+7ADHThVWArld+yGIsCjhsck2SReLV33zLq55xTfHQh/um/Yqzx3bT
	 aj3oC+MOueCPdtQqXpG/E1U7EYcmSRDvs2jG692kOjo3iJxmBvFlPBVyO3Pxuz2wiJPFA
	 lT0o+FGM1EbJvFYFRdk0YiK2nxLUp/YIcseOguyfavs25MCFmN1cRjMXhiyINEcu8uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bFo2vb+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E9606A32A;
	Sun, 22 Nov 2026 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bFo2vb+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86B01F000C0;
	Sun, 22 Nov 2026 07:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795331925;
	bh=9BDABOO+/H7uZ6DNlj5U7OTTmHom4uvnWbbMoZ/AFpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bFo2vb+P4eZ0w3s5fh5lduBwrHHGBE9bZHNiVkDNR8u36nHIjUMP5F1SnIC43ebRO
	 8Vk/LH8rsApBSOGfDHAsFEaGhae2MyGPsDw/iqd4yfQL8IkBmlpBCr/jkqmYblUOsu
	 BTU1CFNhYIbKpR8MLi7X0Y37UoNFZPPW9j+aRR4HnMB7xScGGuzk1OK9iVGxmFU1Nw
	 j3d+T8Szrv5AQF5du643RX4F/+qd75lCLeGs+VFHtPWBDnMbGESA413FyFWHoqLfGU
	 7dQG9dVENAiSCVVk7CZ2MeG/JCCVqX1Zzedxy5zNEB2txHsH+RXUZsMQLa3jLzmTy7
	 E8JU+xRVLsi0w==
Message-ID: <sashiko-outbox-227780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] watchdog: histb: Add HiSilicon STB watchdog driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Yang" <mmyangfl@gmail.com>, linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261122065549.3265519-3-mmyangfl@gmail.com>
References: <20261122065549.3265519-1-mmyangfl@gmail.com>
 <20261122065549.3265519-3-mmyangfl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 07:18:44 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] watchdog: histb: stale counter reload in histb_wdt_arm() and
  histb_wdt_ping()
- [High] watchdog: histb: unclocked MMIO reads in
  histb_wdt_get_timeleft() when stopped
- [Medium] watchdog: histb: missing watchdog_stop_on_unregister() in
  histb_wdt_probe()
- [Medium] watchdog: histb: unchecked histb_wdt_start() error in
  histb_wdt_resume()
- [Medium] watchdog: histb: deadlock and invalid wait context in
  histb_wdt_restart()
--

commit 8f21fc6b65d49db93aa95ad107c510c4d4fadce6
Author: David Yang <mmyangfl@gmail.com>

watchdog: histb: Add HiSilicon STB watchdog driver

This commit adds a platform watchdog driver for the watchdog controller
integrated on HiSilicon STB SoCs.

> diff --git a/drivers/watchdog/histb_wdt.c b/drivers/watchdog/histb_wdt.c
> new file mode 100644
> index 0000000000000..1961981f1e5d7
> --- /dev/null
> +++ b/drivers/watchdog/histb_wdt.c
> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * HiSilicon STB Watchdog Driver
> + *
> + * The watchdog controller integrated on HiSilicon STB SoCs shares regis=
ter
> + * offsets with the ARM PrimeCell SP805, but differs in several critical
> + * hardware behaviors:
> + *   - The ID registers at 0xfe0..0xffc are unimplemented and read zero,
> + *     requiring a platform device driver rather than AMBA probe;
> + *   - Writing WDTLOCK freezes the counter instead of only blocking regi=
ster
> + *     writes, so the block must remain unlocked while running;
> + *   - Writing WDTLOAD never reloads the running counter; only WDTINTCLR=
 does;

[ ... ]

> +static void histb_wdt_arm(struct histb_wdt *wdt, u32 load)
> +{
> +	void __iomem *base =3D wdt->base;
> +
> +	spin_lock(&wdt->lock);
> +	writel_relaxed(HISTB_WDT_UNLOCK_KEY, base + HISTB_WDT_LOCK);
> +	writel_relaxed(0, base + HISTB_WDT_CONTROL);
> +	writel_relaxed(HISTB_WDT_INT_MASK, base + HISTB_WDT_INTCLR);
> +	writel_relaxed(load, base + HISTB_WDT_LOAD);
> +	writel_relaxed(HISTB_WDT_INT_ENABLE | HISTB_WDT_RESET_ENABLE,
> +		       base + HISTB_WDT_CONTROL);
> +	readl_relaxed(base + HISTB_WDT_LOCK);
> +	spin_unlock(&wdt->lock);
> +}

[ ... ]

> +static int histb_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct histb_wdt *wdt =3D watchdog_get_drvdata(wdd);
> +	void __iomem *base =3D wdt->base;
> +
> +	spin_lock(&wdt->lock);
> +	writel_relaxed(HISTB_WDT_INT_MASK, base + HISTB_WDT_INTCLR);
> +	writel_relaxed(wdt->load_val, base + HISTB_WDT_LOAD);
> +	readl_relaxed(base + HISTB_WDT_LOCK);
> +	spin_unlock(&wdt->lock);
> +
> +	return 0;
> +}

[Severity: High]
Should HISTB_WDT_LOAD be written before HISTB_WDT_INTCLR in
histb_wdt_arm() and histb_wdt_ping()?

As noted in the file header comment, writing WDTLOAD does not reload the
counter and only writing WDTINTCLR triggers the reload.  Writing
HISTB_WDT_INTCLR first reloads the counter with whatever stale value was
previously in HISTB_WDT_LOAD.  In particular, when histb_wdt_restart()
calls histb_wdt_arm(wdt, 1), the counter reloads with the old timeout (or
0xffffffff if the watchdog was never started) instead of 1, so the system
fails to reset during the 1 ms delay.

[ ... ]

> +static unsigned int histb_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct histb_wdt *wdt =3D watchdog_get_drvdata(wdd);
> +	u64 value;
> +
> +	spin_lock(&wdt->lock);
> +	value =3D readl_relaxed(wdt->base + HISTB_WDT_VALUE);
> +	if (!(readl_relaxed(wdt->base + HISTB_WDT_RIS) & HISTB_WDT_INT_MASK))
> +		value +=3D (u64)wdt->load_val + 1;
> +	spin_unlock(&wdt->lock);
> +
> +	return div_u64(value, wdt->rate);
> +}

[Severity: High]
Can histb_wdt_get_timeleft() read HISTB_WDT_VALUE and HISTB_WDT_RIS while
wdt->clk is disabled?

wdt->clk is only prepared at probe time and is not enabled until
histb_wdt_start() is called, and histb_wdt_stop() disables it again.  The
watchdog core's timeleft sysfs attribute (and WDIOC_GETTIMELEFT ioctl)
invokes wdd->ops->get_timeleft(wdd) without checking
watchdog_active(wdd).  Reading /sys/class/watchdog/watchdogN/timeleft
while the watchdog is stopped accesses the device registers with the
clock gated, which can cause a synchronous external abort or bus hang.

> +static int
> +histb_wdt_restart(struct watchdog_device *wdd, unsigned long mode, void =
*cmd)
> +{
> +	struct histb_wdt *wdt =3D watchdog_get_drvdata(wdd);
> +
> +	/*
> +	 * For reset, we start the WDT clock and leave it running.
> +	 * The clock was prepared at probe time; only clk_enable() is
> +	 * safe in this atomic (restart notifier) context.
> +	 */
> +	clk_enable(wdt->clk);
> +	histb_wdt_arm(wdt, 1);
> +
> +	mdelay(1);
> +
> +	return 0;
> +}

[Severity: Medium]
Can histb_wdt_restart() deadlock on wdt->lock via histb_wdt_arm()?

Normal callers acquire wdt->lock with plain spin_lock() while local
interrupts remain enabled, whereas histb_wdt_restart() runs from the
restart notifier chain after smp_send_stop() or from emergency_restart()
in hardirq context:

CPU0                              CPU1
histb_wdt_ping()
  spin_lock(&wdt->lock)
                                  machine_restart()
                                    smp_send_stop()
  <stop IPI halts CPU0>
                                    do_kernel_restart()
                                      histb_wdt_restart()
                                        histb_wdt_arm()
                                          spin_lock(&wdt->lock)
                                            <-- spins forever

An emergency_restart() triggered from a hardirq on the same CPU while
wdt->lock is held will likewise deadlock, and taking spinlock_t from
hardirq context violates lockdep wait-context nesting on PREEMPT_RT.
Programming the registers in histb_wdt_restart() through an unlocked
helper avoids taking wdt->lock during restart.

[ ... ]

> +static int histb_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct histb_wdt *wdt;
> +	int res;
> +
> +	wdt =3D devm_kzalloc_obj(dev, *wdt);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(wdt->base))
> +		return PTR_ERR(wdt->base);
> +
> +	/*
> +	 * Keep the clock prepared for the lifetime of the driver:
> +	 * .restart() runs in atomic context and may only call clk_enable().
> +	 */
> +	wdt->clk =3D devm_clk_get_optional_prepared(dev, NULL);

[ ... ]

> +	watchdog_stop_on_reboot(&wdt->wdd);
> +	platform_set_drvdata(pdev, wdt);
> +
> +	res =3D devm_watchdog_register_device(dev, &wdt->wdd);
> +	if (res)
> +		return dev_err_probe(dev, res,
> +				     "Failed to register watchdog device\n");
> +
> +	return 0;
> +}

[Severity: Medium]
Should histb_wdt_probe() also call watchdog_stop_on_unregister(&wdt->wdd)?

If the device is unbound while the watchdog is active,
devm_watchdog_register_device() unregisters the watchdog without calling
histb_wdt_stop().  That leaves the hardware counter running to reset the
system and causes the devres cleanup for devm_clk_get_optional_prepared()
to call clk_unprepare() while wdt->clk is still enabled, triggering a
WARN in clk_core_unprepare().

> +static int __maybe_unused histb_wdt_suspend(struct device *dev)
> +{
> +	struct histb_wdt *wdt =3D dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd))
> +		histb_wdt_stop(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused histb_wdt_resume(struct device *dev)
> +{
> +	struct histb_wdt *wdt =3D dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd))
> +		histb_wdt_start(&wdt->wdd);
> +
> +	return 0;
> +}

[Severity: Medium]
Should histb_wdt_resume() propagate the return value of histb_wdt_start()?

If clk_enable() fails in histb_wdt_start() during resume, discarding the
error leaves WDOG_ACTIVE set while wdt->clk remains disabled.  Later
watchdog callbacks will then access unclocked MMIO registers and
histb_wdt_stop() will call clk_disable() on an already-disabled clock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122065549.3265=
519-1-mmyangfl@gmail.com?part=3D2
