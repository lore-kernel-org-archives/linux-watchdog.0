Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993176;
	b=S68ETiLIuJguvOxBLwvSiQEyMGtF0BcZoM0ThgRoHnjuOAaFWntCkVhhB2rAcvlDN4/K
	 PS7IzdS4FlUhDjzhfV63hyhPtTRlK1Z4bzCtIHZqhBcx9OgYHW4TXHzVi7gKIV2KFPaGp
	 GzYWSxXLnkiS1hDBwBaPqw9vPJijHTqzNlWN/96d3XbROkaMfjvszRGBG+YjB1H4rv5OZ
	 haxRZvpuMOK3AaT0JdEkZ+Q4M4T8X69kM13il9nllTrzk0MK3o9ceg7gZHAS8/xTEWJQg
	 hDT2TZ0mZl4EVu4SJr4VEn0Zuou6MGOQVimExGoGgBltWqlQi0QeW6AOrZgzkDHReWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TYXWo3jPTRVhVyVhOjk5z8Z84lHsO0mKdmIubKgK5u4=;
	b=XJ3S5Pd1R+y3jOjbf8vpvmyvNujV7phhBchzwX6Upt+Qs85p8+TsgzUX9l4DC/RmC2Cf
	 bhA+5VtPx8HtNITu326FGDRvVxcHcl31AQsFcNSx/zNLemd1jkyioJ2b0vblQTcmTEmaq
	 idA5qxy/tkoBSNn/PqKLxKjtGv64RAiSWFQX56Hm2hn7jZCO1dXqP6oW1u54VYKEjHTVp
	 igon/FTut7bAGVeEj5haOYWZu5pzkAaV64gT1+qp3ASA3iZGtcfiQsoKvIsEs7Pnqs9Pf
	 cH+Aws+dulbgo1T+4WrLK+Wadt3Ayp2a4vtNyaTvtQ7WmZnJf3qdfmJsXh6yp5a4+sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PbWbv4If;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ECE606A33D
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PbWbv4If
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86541F0092A;
	Wed, 18 Nov 2026 09:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794993175;
	bh=TYXWo3jPTRVhVyVhOjk5z8Z84lHsO0mKdmIubKgK5u4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PbWbv4Ifdwam1g1mYhkEN8jMpN4labfDUFKk/kZH0XG8BiartLkaYE8qz0f/yGg34
	 wSYnlgsgNQYzllrVFL7bTrlGl2BVtP2yIdEuVhPOHOzM0+DqFXP//u8h8/k2yzdVIW
	 iWXRLZGR/4sLtTCpAvKAOdIy4yJkyZ5SCUntX0NAr2PAXyGCX37zQUXHIaBSLCyheh
	 avtnwX/BPDrcKu6F0v7XwVuRrKoEXQ59mEZqRxQs8ZwEPjtzmFQx9Kp5JG5vVqss23
	 XPEVyEc2OU5gZ/QJr3aPNqATzszwdJAt3yGDshVcnpRKg4FAZ2Mon4sACvfxQxcQ8v
	 d/NZbozs/aPAQ==
Message-ID: <sashiko-outbox-220535@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] watchdog: Add ARM TWD (MPCore private) watchdog
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261118-arm-twd-wdt-v5-1-886265008e78@gmail.com>
References: <20261118-arm-twd-wdt-v5-1-886265008e78@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:12:55 +0000
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
- [Medium] watchdog: arm_twd_wdt: race in twd_wdt_set_timeout() causes
  immediate reset
- [Medium] watchdog: arm_twd_wdt: twd_wdt_probe() arms watchdog before
  cleanup setup
- [Medium] watchdog: arm_twd_wdt: keepalive reset and active ping worker
  on suspend
- [Medium] watchdog: arm_twd_wdt: missing barrier between keepalive and
  armed state
- [Low] watchdog: arm_twd_wdt: use of obsolete __MODULE_STRING() macro
--

commit 2b76b6ecd425333171034f709700b36407dec65d
Author: Fil Dunsky <filipp.dunsky@gmail.com>

watchdog: Add ARM TWD (MPCore private) watchdog driver

This commit adds a watchdog driver for the ARM11 MPCore, Cortex-A5 and
Cortex-A9 private (TWD) watchdog, using CPU0's watchdog as the system
watchdog and registering a restart handler.

> diff --git a/drivers/watchdog/arm_twd_wdt.c b/drivers/watchdog/arm_twd_wd=
t.c
> new file mode 100644
> index 0000000000000..068b6483a8ac3
> --- /dev/null
> +++ b/drivers/watchdog/arm_twd_wdt.c
> @@ -0,0 +1,465 @@

[ ... ]

> +static bool nowayout =3D WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (def=
ault=3D"
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");

[Severity: Low]
__MODULE_STRING() is marked obsolete in include/linux/module.h, and commit
b152ca999c5f ("watchdog: Replace __MODULE_STRING() with __stringify()")
removed all other uses in drivers/watchdog/.  Could this include
<linux/stringify.h> and use __stringify(WATCHDOG_NOWAYOUT) instead?

[ ... ]

> +static u32 twd_wdt_ticks(struct twd_wdt *wdt)
> +{
> +	s64 expires =3D atomic64_read(&wdt->keepalive) +
> +		      (s64)wdt->wdd.timeout * NSEC_PER_SEC;
> +	s64 left =3D expires - ktime_get_ns();
> +	u64 ticks;
> +
> +	if (left <=3D 0)
> +		return 1;
> +
> +	ticks =3D mul_u64_u64_div_u64(READ_ONCE(wdt->rate), left,
> +				    (u64)NSEC_PER_SEC * (TWD_WDT_PRESCALE + 1));
> +
> +	return clamp_t(u64, ticks, 1, U32_MAX);
> +}

[ ... ]

> +static void twd_wdt_set_armed(struct twd_wdt *wdt, bool armed)
> +{
> +	guard(mutex)(&wdt->lock);
> +
> +	atomic64_set(&wdt->keepalive, ktime_get_ns());
> +	WRITE_ONCE(wdt->armed, armed);
> +	twd_wdt_call(wdt, armed ? twd_wdt_cpu_start : twd_wdt_cpu_stop);
> +}

[Severity: Medium]
Can CPU0 in twd_wdt_cpu_pm_notify() observe wdt->armed =3D=3D true before t=
he
new wdt->keepalive value and trigger an immediate reset?

On 32-bit ARM, atomic64_set() and atomic64_read() are relaxed and include
no memory barriers.  If twd_wdt_start() runs on CPU1 while CPU0 is exiting
a power-down idle state with interrupts disabled, the IPI from
twd_wdt_call() waits until CPU0 re-enables interrupts:

CPU1                              CPU0 (IRQs disabled)
twd_wdt_start()                   cpu_pm_exit()
  twd_wdt_set_armed(..., true)      twd_wdt_cpu_pm_notify()
    atomic64_set(&wdt->keepalive,     if (READ_ONCE(wdt->armed) && ...)
                 now)                   twd_wdt_cpu_start()
    WRITE_ONCE(wdt->armed, true)          twd_wdt_ticks()
    twd_wdt_call(...)                       atomic64_read(&wdt->keepalive)
                                              --> sees 0 or stale timestamp
                                            left <=3D 0 -> returns 1
                                          writel(1, TWD_WDT_LOAD)  <-- reset

Pairing smp_store_release(&wdt->armed, armed) in twd_wdt_set_armed() with
smp_load_acquire(&wdt->armed) in twd_wdt_cpu_pm_notify() would order the
keepalive store before wdt->armed becomes visible.

[ ... ]

> +static int twd_wdt_set_timeout(struct watchdog_device *wdd, unsigned int=
 t)
> +{
> +	wdd->timeout =3D t;
> +	if (watchdog_active(wdd) || watchdog_hw_running(wdd))
> +		twd_wdt_ping(wdd);
> +
> +	return 0;
> +}

[Severity: Medium]
Can decreasing wdd->timeout in twd_wdt_set_timeout() reset the board
immediately if a clock rate change or CPU0 idle exit happens before
twd_wdt_ping() updates wdt->keepalive?

watchdog_set_timeout() holds wd_data->lock, not wdt->lock.  When userspace
reduces the timeout (for example from 60s to 30s when 35s have elapsed
since the last keepalive), wdd->timeout is updated before twd_wdt_ping()
acquires wdt->lock and refreshes wdt->keepalive:

CPU0                              CPU1
twd_wdt_clk_notify()              twd_wdt_set_timeout(wdd, 30)
  guard(mutex)(&wdt->lock)          wdd->timeout =3D 30;
                                    twd_wdt_ping()
                                      guard(mutex)(&wdt->lock)  [blocks]
  twd_wdt_call(...,
               twd_wdt_cpu_ping)
    twd_wdt_ticks()
      expires =3D old_keepalive + 30s
      left =3D -5s <=3D 0 -> returns 1
    writel(1, TWD_WDT_LOAD)  <-- immediate reset

In addition, watchdog_ioctl() for WDIOC_SETTIMEOUT in
drivers/watchdog/watchdog_dev.c already calls watchdog_ping(wdd) right
after watchdog_set_timeout(), so calling twd_wdt_ping() here sends a
redundant IPI to CPU0 on every WDIOC_SETTIMEOUT ioctl.

[ ... ]

> +	if (wdt->running) {
> +		/* Left running by the bootloader: take it over without a stop */
> +		dev_info(dev, "running, taking over\n");
> +		twd_wdt_start(&wdt->wdd);
> +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> +	}
> +
> +	wdt->pm_nb.notifier_call =3D twd_wdt_cpu_pm_notify;
> +	ret =3D cpu_pm_register_notifier(&wdt->pm_nb);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev, twd_wdt_remove_pm_notifier, wdt);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev, twd_wdt_disable, wdt);
> +	if (ret)
> +		return ret;

[Severity: Medium]
If cpu_pm_register_notifier() or the first devm_add_action_or_reset()
fails when wdt->running is true, does twd_wdt_probe() return with the
reprogrammed watchdog still armed and its clock disabled by devres?

twd_wdt_start() reprograms the hardware counter to wdd.timeout (default
30s, which may be much shorter than the bootloader's timeout) before the
twd_wdt_disable cleanup action and CPU PM notifier are registered.
Registering the CPU PM notifier and twd_wdt_disable action before taking
over the running watchdog would avoid leaving it armed on error or losing
its state if CPU0 enters idle during probe.

[ ... ]

> +/* The watchdog loses its state in suspend, set it up again at resume */
> +static int twd_wdt_suspend(struct device *dev)
> +{
> +	struct twd_wdt *wdt =3D dev_get_drvdata(dev);
> +
> +	wdt->resume_armed =3D wdt->armed;
> +	if (wdt->resume_armed)
> +		twd_wdt_stop(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static int twd_wdt_resume(struct device *dev)
> +{
> +	struct twd_wdt *wdt =3D dev_get_drvdata(dev);
> +
> +	if (wdt->resume_armed)
> +		twd_wdt_start(&wdt->wdd);
> +
> +	return 0;
> +}

[Severity: Medium]
Does calling twd_wdt_stop() and twd_wdt_start() across suspend and resume
reset wdt->keepalive to ktime_get_ns(), contrary to the commit message?

The commit message notes that on resume from suspend the time of the last
keepalive is kept and the watchdog is loaded with the time left from it so
the timeout is not extended.  However, twd_wdt_stop() and twd_wdt_start()
both call twd_wdt_set_armed(), which overwrites wdt->keepalive with
ktime_get_ns() and reloads a full timeout on resume.

Also, twd_wdt_probe() does not call watchdog_stop_ping_on_suspend(), and
twd_wdt_suspend() reads wdt->armed without wdt->lock while leaving
WDOG_HW_RUNNING set, so watchdog_ping_work() can run after
twd_wdt_suspend() and write TWD_WDT_LOAD while the device is suspended.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-arm-twd-wd=
t-v5-1-886265008e78@gmail.com?part=3D1
