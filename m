Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667134;
	b=tJD20RJD9XE6wDEgaEOb9w6/Qdmq5pdobYs2XUEuqsByA4RulbnIbwhvGk5Zw6yMqpLS
	 NnE4vzG6YFzr9l8B7LoZsbdH+JqcZOopNWv/E6JgY7bZxF4ogKZirxeLiLAn/K6dot9OF
	 3JhQW5iiJkSSZS1WfVd6MyCBFO1uIT+MMU8BkTD0jqHYtUt7VBoHU32RrDF3MwCNh2Wcp
	 kMzGYjxfJl6B6CG/CnzqxdVXhltAz7vGpEYJQ5UUW5ICFV13si12AtJmjPUpn6/smEP9B
	 0K9TInG4Q6uIy6TwJxYXoaxCCkRTBhpJ9HSDYLg/bQxERd76mMZ5PAmpxcf1WUClq5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667134;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=inxRtPDoKW6HBWSaGQKU9Zm3wRj+CHvePjBAwRXvJyQ=;
	b=1YkcuE/ZEYgThXXmbQHNOx5YGrpjYZpilOdCuhlpQ17nGUfEjX009SMBE1ykYACBnR4+
	 jtBMEMh4fW4rQDYm3NJySCKrTfC5Tl8WKeYldJUjtFRuUPe9up/9aK/KfexAxJQrclTnx
	 mxG6KwfbQ4keUCqsuCriC5olmWkzUoBqZpI7aReZ4wdoBrS2RFB+GNMJu5f7KCCFqtmGS
	 4glPvYDJT0ZqARpr3/sdqIcqIYxCgglSlbJuAelMyyv1UpMW/EwkrHSjBLGtzsgbJLf2O
	 0ASna1ez+aNvf97yKt0Eog0PoegD5R/KOPig4HpGmir75sgd3f2PhEb/nw9w8uWMvIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCbqwJeS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D9606A329
	for <linux-watchdog@vger.kernel.org>; Sat, 14 Nov 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCbqwJeS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6691F000C4;
	Sat, 14 Nov 2026 14:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794667133;
	bh=inxRtPDoKW6HBWSaGQKU9Zm3wRj+CHvePjBAwRXvJyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GCbqwJeSKLplD9HdVqRlLGlwfXDOogmpVi6ZYB5L9f4wm/qiZ88HHxttvUSbbFUwg
	 jLw1VApqRcKmxw8J67s/yF8fE6yk4+YeN//jD/Yw6RRK1HcdpSf54FGxy0urwgZvtQ
	 PubIPhc5eLwkUYTac2HSkTumexbVMp1aX1oXN1cJvDaNgalHAabi3vBlZhkinSqg2+
	 PNSc1r36SKde7SQ/30sbRXXIr8nYEzwYoQ4zjXIPLZGayaVhLIb2vSS/12cBjR1bRb
	 Ozhrr2d3h9/wUMwsuJgdawYHf/KvzmRrVhjarN985Z7gcBlmEfSxvI2+rH973ab0mm
	 R1nnmtRlaZu3w==
Message-ID: <sashiko-outbox-214641@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] watchdog: Add ARM TWD (MPCore private) watchdog
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261114-arm-twd-wdt-v4-1-5a3104b36331@gmail.com>
References: <20261114-arm-twd-wdt-v4-1-5a3104b36331@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 14:38:53 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [Medium] watchdog: arm_twd_wdt: CPU hotplug race in
  twd_wdt_set_armed()
- [Medium] watchdog: arm_twd_wdt: IRQ race in twd_wdt_cpu_online() and
  offline()
- [Medium] watchdog: arm_twd_wdt: watchdog left armed on probe error or
  unbind
- [Medium] watchdog: arm_twd_wdt: twd_wdt_clk_notify() resets full
  timeout on rate change
- [Low] watchdog: arm_twd_wdt: inaccurate suspend comment on CPU
  watchdog restore
- [Low] watchdog: arm_twd_wdt: full timeout reload on CPU_PM_EXIT in
  twd_wdt_cpu_pm_notify()
--

commit e14841698f0a4aae63c19877ba002e8fa6489c92
Author: Fil Dunsky <filipp.dunsky@gmail.com>

watchdog: Add ARM TWD (MPCore private) watchdog driver

This commit adds a watchdog driver for the banked per-CPU private watchdog
on ARM11 MPCore, Cortex-A5 and Cortex-A9 MPCore systems, managing all
online CPUs together across CPU hotplug, clock rate changes, CPU PM and
suspend/resume.

> diff --git a/drivers/watchdog/arm_twd_wdt.c b/drivers/watchdog/arm_twd_wd=
t.c
> new file mode 100644
> index 0000000000000..1549e2b0fbbbf
> --- /dev/null
> +++ b/drivers/watchdog/arm_twd_wdt.c
> @@ -0,0 +1,508 @@

[ ... ]

> +/* The following run on the CPU whose watchdog they access */
> +static void twd_wdt_cpu_stop(void *data)
> +{
> +	struct twd_wdt *wdt =3D data;
> +
> +	writel(TWD_WDT_DISABLE_KEY1, wdt->base + TWD_WDT_DISABLE);
> +	writel(TWD_WDT_DISABLE_KEY2, wdt->base + TWD_WDT_DISABLE);
> +	writel(0, wdt->base + TWD_WDT_CONTROL);
> +}
> +
> +static void twd_wdt_cpu_start(void *data)
> +{
> +	struct twd_wdt *wdt =3D data;
> +	u32 ctrl =3D readl(wdt->base + TWD_WDT_CONTROL);
> +
> +	/*
> +	 * In watchdog mode the prescaler cannot be changed, so a watchdog
> +	 * started by the bootloader with a different one is stopped first.
> +	 */
> +	if ((ctrl & TWD_WDT_CTRL_WD_MODE) &&
> +	    FIELD_GET(TWD_WDT_CTRL_PRESCALER, ctrl) !=3D TWD_WDT_PRESCALE)
> +		twd_wdt_cpu_stop(wdt);
> +
> +	/*
> +	 * Load the counter before enabling, it may still be zero. A watchdog
> +	 * that is already running is reloaded and keeps running, the mode bit
> +	 * cannot be cleared by writing the control register.
> +	 */
> +	writel(twd_wdt_ticks(wdt, wdt->wdd.timeout), wdt->base + TWD_WDT_LOAD);
> +	writel(FIELD_PREP(TWD_WDT_CTRL_PRESCALER, TWD_WDT_PRESCALE) |
> +	       TWD_WDT_CTRL_WD_MODE | TWD_WDT_CTRL_ENABLE,
> +	       wdt->base + TWD_WDT_CONTROL);
> +}
> +
> +static void twd_wdt_cpu_ping(void *data)
> +{
> +	struct twd_wdt *wdt =3D data;
> +
> +	/* In watchdog mode a write to the load register reloads the counter */
> +	writel(twd_wdt_ticks(wdt, wdt->wdd.timeout), wdt->base + TWD_WDT_LOAD);
> +}

[ ... ]

> +static void twd_wdt_set_armed(struct twd_wdt *wdt, bool armed)
> +{
> +	WRITE_ONCE(wdt->armed, armed);
> +	/* Pairs with the barrier in twd_wdt_clk_notify() */
> +	smp_mb();
> +
> +	on_each_cpu(armed ? twd_wdt_cpu_start : twd_wdt_cpu_stop, wdt, 1);
> +}
> +
> +static int twd_wdt_start(struct watchdog_device *wdd)
> +{
> +	twd_wdt_set_armed(watchdog_get_drvdata(wdd), true);
> +
> +	return 0;
> +}
> +
> +static int twd_wdt_stop(struct watchdog_device *wdd)
> +{
> +	twd_wdt_set_armed(watchdog_get_drvdata(wdd), false);
> +
> +	return 0;
> +}
> +
> +static int twd_wdt_ping(struct watchdog_device *wdd)
> +{
> +	on_each_cpu(twd_wdt_cpu_ping, watchdog_get_drvdata(wdd), 1);
> +
> +	return 0;
> +}
> +
> +static int twd_wdt_set_timeout(struct watchdog_device *wdd, unsigned int=
 t)
> +{
> +	wdd->timeout =3D t;
> +	if (watchdog_active(wdd) || watchdog_hw_running(wdd))
> +		twd_wdt_ping(wdd);
> +
> +	return 0;
> +}
> +
> +static unsigned int twd_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct twd_wdt *wdt =3D watchdog_get_drvdata(wdd);
> +	u64 ticks;
> +
> +	wdt->counter_min =3D U32_MAX;
> +	on_each_cpu(twd_wdt_cpu_counter, wdt, 1);
> +	ticks =3D (u64)wdt->counter_min * (TWD_WDT_PRESCALE + 1);
> +
> +	return div_u64(ticks, READ_ONCE(wdt->rate));
> +}

[Severity: Medium]
Can twd_wdt_set_armed() race with CPU hotplug without cpus_read_lock() and
leave a watchdog armed on an offline CPU?

twd_wdt_cpu_online() and twd_wdt_cpu_offline() run at CPUHP_AP_ONLINE_DYN
in the per-CPU cpuhp/%u thread while the CPU is already or still in
cpu_online_mask with local interrupts enabled:

CPU0                              CPU1 (cpuhp/1)
                                  _cpu_down()
                                    twd_wdt_cpu_offline()
                                      twd_wdt_cpu_stop(wdt)
twd_wdt_start()
  twd_wdt_set_armed(wdt, true)
    WRITE_ONCE(wdt->armed, true)
    on_each_cpu(twd_wdt_cpu_start, ...)
                                    <IPI>
                                      twd_wdt_cpu_start(wdt)
                                    take_cpu_down()
                                      __cpu_disable()  <-- offline & armed

CPU1 finishes going offline with its watchdog running; because it is no
longer in cpu_online_mask, subsequent pings or stops never reach it and the
system resets when the counter expires.  During bringup, an on_each_cpu()
IPI from twd_wdt_set_armed() can likewise arrive on the target CPU between
READ_ONCE(wdt->armed) and twd_wdt_cpu_start()/twd_wdt_cpu_stop() in
twd_wdt_cpu_online(), and twd_wdt_get_timeleft() can read TWD_WDT_COUNTER
as 0 from an online CPU before twd_wdt_cpu_online() or after
twd_wdt_cpu_offline().

Unlike twd_wdt_clk_notify(), twd_wdt_set_armed() and twd_wdt_get_timeleft()
are only called from watchdog ops and PM callbacks in task context, so they
can guard their operations with cpus_read_lock().

> +
> +/*
> + * The TWD runs from the peripheral clock, which follows the CPU clock. =
While
> + * the rate goes up, count with the new rate already: the watchdog then =
just
> + * fires later than asked until the change is done.
> + */
> +static int twd_wdt_clk_notify(struct notifier_block *nb, unsigned long e=
vent,
> +			      void *data)
> +{
> +	struct twd_wdt *wdt =3D container_of(nb, struct twd_wdt, clk_nb);
> +	struct clk_notifier_data *cnd =3D data;
> +	unsigned long rate;
> +
> +	switch (event) {
> +	case PRE_RATE_CHANGE:
> +		if (cnd->new_rate <=3D cnd->old_rate)
> +			return NOTIFY_OK;
> +		rate =3D cnd->new_rate;
> +		break;
> +	case POST_RATE_CHANGE:
> +		rate =3D cnd->new_rate;
> +		break;
> +	case ABORT_RATE_CHANGE:
> +		rate =3D cnd->old_rate;
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	if (!rate)
> +		return NOTIFY_OK;
> +
> +	WRITE_ONCE(wdt->rate, rate);
> +	/*
> +	 * Pairs with the barrier in twd_wdt_set_armed(): either the watchdog
> +	 * is started with the new rate or it is seen armed here and pinged.
> +	 */
> +	smp_mb();
> +
> +	if (READ_ONCE(wdt->armed))
> +		on_each_cpu(twd_wdt_cpu_ping, wdt, 1);
> +
> +	return NOTIFY_OK;
> +}

[Severity: Medium]
Does calling twd_wdt_cpu_ping() on every clock rate change reset the
watchdog countdown to the full wdd.timeout instead of scaling the remaining
time in TWD_WDT_COUNTER?  On systems where cpufreq scales the CPU and TWD
clocks during normal activity, frequent rate changes will continually
reload TWD_WDT_LOAD and prevent the watchdog from expiring when userspace
stops pinging it.  Also, when cnd->new_rate > cnd->old_rate,
PRE_RATE_CHANGE already updates wdt->rate to cnd->new_rate and pings all
CPUs, and POST_RATE_CHANGE then repeats the same update and IPIs.

> +
> +/*
> + * A CPU whose power domain was turned off in idle comes back with its
> + * watchdog stopped. Only then set it up again: reloading a watchdog that
> + * kept running would ping it on every idle exit.
> + */
> +static int twd_wdt_cpu_pm_notify(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct twd_wdt *wdt =3D container_of(nb, struct twd_wdt, pm_nb);
> +
> +	if (action !=3D CPU_PM_EXIT && action !=3D CPU_PM_ENTER_FAILED)
> +		return NOTIFY_DONE;
> +
> +	if (READ_ONCE(wdt->armed) &&
> +	    !(readl(wdt->base + TWD_WDT_CONTROL) & TWD_WDT_CTRL_WD_MODE))
> +		twd_wdt_cpu_start(wdt);
> +
> +	return NOTIFY_OK;
> +}

[Severity: Low]
When a CPU wakes from a power-off idle state that reset its TWD block, does
calling twd_wdt_cpu_start() reload the full wdd.timeout instead of
restoring the remaining counter value from CPU_PM_ENTER?  If CPUs
repeatedly enter and exit deep idle on timer or device interrupts before
wdd.timeout elapses, each wakeup resets the countdown and keeps the
watchdog from firing even if userspace is hung.

[ ... ]

> +static int twd_wdt_cpu_online(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct twd_wdt *wdt =3D hlist_entry(node, struct twd_wdt, node);
> +
> +	/*
> +	 * Also called for every online CPU at probe time. A watchdog that is
> +	 * running while the device is not active would not be pinged.
> +	 */
> +	if (READ_ONCE(wdt->armed))
> +		twd_wdt_cpu_start(wdt);
> +	else
> +		twd_wdt_cpu_stop(wdt);
> +
> +	return 0;
> +}
> +
> +static int twd_wdt_cpu_offline(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct twd_wdt *wdt =3D hlist_entry(node, struct twd_wdt, node);
> +
> +	/* Nobody pings the watchdog of an offline CPU */
> +	twd_wdt_cpu_stop(wdt);
> +
> +	return 0;
> +}

[Severity: Medium]
Can an IPI from twd_wdt_clk_notify() or twd_wdt_ping() interrupt
twd_wdt_cpu_stop() or twd_wdt_cpu_start() when called from
twd_wdt_cpu_online() and twd_wdt_cpu_offline()?

Unlike on_each_cpu(), CPUHP_AP_ONLINE_DYN callbacks run in task context
with local interrupts enabled while the CPU is in cpu_online_mask:

twd_wdt_cpu_offline()
  twd_wdt_cpu_stop()
    writel(TWD_WDT_DISABLE_KEY1, wdt->base + TWD_WDT_DISABLE)
    <IPI: twd_wdt_cpu_ping()>
      writel(..., wdt->base + TWD_WDT_LOAD)
    writel(TWD_WDT_DISABLE_KEY2, wdt->base + TWD_WDT_DISABLE)
    writel(0, wdt->base + TWD_WDT_CONTROL)  <-- stays in watchdog mode

Writing TWD_WDT_LOAD between TWD_WDT_DISABLE_KEY1 and TWD_WDT_DISABLE_KEY2
breaks the hardware unlock sequence, leaving the watchdog armed when the
CPU goes offline or when twd_wdt_cpu_start() tries to change the prescaler.
In twd_wdt_cpu_start(), an IPI from twd_wdt_clk_notify() arriving after
twd_wdt_ticks() reads the old wdt->rate is also overwritten when
twd_wdt_cpu_start() resumes and writes the stale tick count to
TWD_WDT_LOAD.  Disabling local IRQs around the register accesses in
twd_wdt_cpu_online() and twd_wdt_cpu_offline() avoids both races.

> +
> +static void twd_wdt_remove_instance(void *data)
> +{
> +	struct twd_wdt *wdt =3D data;
> +
> +	cpuhp_state_remove_instance_nocalls(twd_wdt_hp_state, &wdt->node);
> +}

[ ... ]

> +	on_each_cpu(twd_wdt_cpu_probe, wdt, 1);
> +	if (!cpumask_empty(&wdt->running)) {
> +		/*
> +		 * Left running by the bootloader: the online callback takes it
> +		 * over with our settings on every CPU without stopping it.
> +		 */
> +		wdt->armed =3D true;
> +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> +	}
> +
> +	ret =3D cpuhp_state_add_instance(twd_wdt_hp_state, &wdt->node);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev, twd_wdt_remove_instance, wdt);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Does using cpuhp_state_remove_instance_nocalls() in
twd_wdt_remove_instance() leave the hardware watchdogs armed if probe fails
after cpuhp_state_add_instance() or if the device is unbound before
/dev/watchdog is opened?

When a bootloader leaves a watchdog running, cpuhp_state_add_instance()
arms all online CPUs with wdt->wdd.timeout and sets WDOG_HW_RUNNING.  If a
later step in twd_wdt_probe() fails, or if the device is unbound while
WDOG_ACTIVE is still clear (where watchdog_cdev_unregister() stops the
keepalive worker without calling watchdog_stop()),
cpuhp_state_remove_instance_nocalls() skips twd_wdt_cpu_offline() and
leaves all CPUs counting down to a system reset.  Using
cpuhp_state_remove_instance() runs twd_wdt_cpu_offline() on each online CPU
during teardown.

[ ... ]

> +/*
> + * The watchdogs lose their state in suspend. The secondary CPUs get the=
irs
> + * back through the hotplug state, the boot CPU through resume.
> + */
> +static int twd_wdt_suspend(struct device *dev)
> +{
> +	struct twd_wdt *wdt =3D dev_get_drvdata(dev);
> +
> +	wdt->resume_armed =3D READ_ONCE(wdt->armed);
> +	if (wdt->resume_armed)
> +		twd_wdt_stop(&wdt->wdd);
> +
> +	return 0;
> +}

[Severity: Low]
Is the comment above twd_wdt_suspend() accurate about how secondary CPUs
have their watchdogs restored?  twd_wdt_suspend() runs before
pm_sleep_disable_secondary_cpus() and clears wdt->armed via twd_wdt_stop(),
so when pm_sleep_enable_secondary_cpus() brings secondary CPUs back online
before twd_wdt_resume(), twd_wdt_cpu_online() sees wdt->armed as false and
twd_wdt_resume() -> twd_wdt_start() is what restarts the watchdog on all
online CPUs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-arm-twd-wd=
t-v4-1-5a3104b36331@gmail.com?part=3D1
