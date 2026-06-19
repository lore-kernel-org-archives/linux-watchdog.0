Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3813C09E4
	for <linux-watchdog@vger.kernel.org>; Fri, 19 Jun 2026 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901643; cv=none; b=ger7zNPsCuB7QdR9BEI/qQ8QLv/GJ7PE2RH/7RzlO7slgsMQkh8NVy1MQLOHaWZVAiIOYHwXJVutXqIRZ1EnoyyZblzuGALVf+CLrBifbOlMdEsdCke2K/R7C81292TFjF3Ge8jv8+JJ3gcC960yG1JHYRQQpX+95jS+gFRphOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901643; c=relaxed/simple;
	bh=o/kd305bSJoy4baRPPzkqcmUpuPdgFENsgCQjiTtwXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LfumRpAj4SnHCL9jrBDdM+nbGF5L4sxyG95LBtmOx8ovoy5vNy0hKBlRQDVNz1bEZyDeRv8M6CwGt8Rszw+VF74snVnTMntjkMt7M5RPc4cPK9wlKcdpPcP5GVfhJM2AyKlwJe36+CXaFLRB89JN2Kbbx3ELb8o5vevgOSTY+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfbmsYJd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfbmsYJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040D71F000E9;
	Fri, 19 Jun 2026 20:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781901641;
	bh=RLOWYzDrLzNxsH8hSZQMf6IuF8o+/k9Y190XoGkn5vY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IfbmsYJdtWAxAACIXvEcFed1sOAilmM00NxwsM+IiKGu4w3IX7jBGkCP1KqrAWI/V
	 Wi7IqgFLBG+NF7swYBJyVqQ8gTe+k8tDG05AgLFmeeIfI30xKK3JSh3dwvp+vlMlyK
	 0nbpYfy6M6tvDilz5/BEQznlzrt8+LrksOzY8aUy1tQnJs2cVXeLsxGb5rBHvJmxUQ
	 tj1mpZ8ZHm01h72eKYYwycexI+bvrND4clc1uuu40iDHt774oE0Gmhf5zy5iMRKP2H
	 j+fUu5TZWTpDd+AkUkLRJt4FfBSZIJoKSzlRn5XcvoYxwP0m72zQckPQS6dwi3HALq
	 zW1NzjJRZOu/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mfd: db8500-prcmu: Fold dbx500 header into db8500
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Walleij" <linusw@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260619-mfd-prcmu-merge-headers-v1-1-8ea0ee23b4d6@kernel.org>
References: <20260619-mfd-prcmu-merge-headers-v1-1-8ea0ee23b4d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 20:40:40 +0000
Message-Id: <20260619204041.040D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Threaded IRQ handlers `prcmu_low_irq_handler` and `prcmu_high_irq_=
handler` race to update the shared thermal state without locking.
- [High] Software and hardware state desynchronization due to missing rollb=
ack of the `requests` counter on error in `db8500_prcmu_request_ape_opp_100=
_voltage()`.
- [High] Acquiring a standard `spinlock_t` in the cpuidle execution path vi=
olates RT locking constraints, triggering a 'sleeping in atomic' BUG.
- [High] Uninitialized memory usage if `of_address_to_resource()` fails, le=
ading to potential memory corruption.
--

commit 1bc97b6d782cf042ebf6637161e4381c27ecc920
Author: Linus Walleij <linusw@kernel.org>

mfd: db8500-prcmu: Fold dbx500 header into db8500
   =20
Move the DBx500 PRCMU definitions into the DB8500 PRCMU header and delete t=
he
wrapper header. Convert users of simple PRCMU wrappers to call the DB8500
helpers directly, and change the stub code error returns from -ENOSYS to
-EINVAL.

Link: https://lore.kernel.org/oe-kbuild-all/202606180825.vUSQntkJ-lkp@intel=
.com/

> diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-d=
b8500.c
> index b1a70f203372b..0d7530fb6ad07 100644
> --- a/arch/arm/mach-ux500/cpu-db8500.c
> +++ b/arch/arm/mach-ux500/cpu-db8500.c
[ ... ]
> @@ -81,7 +81,7 @@ static void __init ux500_init_irq(void)
>  	struct resource r;
> =20
>  	irqchip_init();
> -	prcmu_early_init();
> +	db8500_prcmu_early_init();
>  	np =3D of_find_compatible_node(NULL, NULL, "stericsson,db8500-prcmu");
>  	of_address_to_resource(np, 0, &r);
>  	of_node_put(np);

[Severity: High]
This isn't a bug introduced by this patch, but does this code use an
uninitialized resource if of_address_to_resource() fails?

In ux500_init_irq(), struct resource r is declared on the stack without
initialization. If of_address_to_resource() returns an error (for example, =
if
the device tree node is missing a reg property), it does not populate r.

The return value of of_address_to_resource() is ignored, and the code later
checks:
    if (!r.start) {

Because r.start contains uninitialized stack memory, could it evaluate to a
non-zero value, causing the kernel to call ux500_pm_init() with garbage
physical memory addresses?

[ ... ]
> diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
> index ddc86551bf574..ac96c46bd1bbf 100644
> --- a/drivers/clk/ux500/clk-prcmu.c
> +++ b/drivers/clk/ux500/clk-prcmu.c
[ ... ]
> @@ -120,7 +120,7 @@ static int clk_prcmu_opp_volt_prepare(struct clk_hw *=
hw)
>  	struct clk_prcmu *clk =3D to_clk_prcmu(hw);
> =20
>  	if (!clk->opp_requested) {
> -		err =3D prcmu_request_ape_opp_100_voltage(true);
> +		err =3D db8500_prcmu_request_ape_opp_100_voltage(true);

[Severity: High]
This is a pre-existing issue, but does db8500_prcmu_request_ape_opp_100_vol=
tage()
fail to rollback the requests counter on error?

When enable is true and requests is 0, the static requests counter is
incremented to 1 before sending the hardware mailbox request:

drivers/mfd/db8500-prcmu.c:db8500_prcmu_request_ape_opp_100_voltage() {
    if (enable) {
        if (0 !=3D requests++)
            goto unlock_and_return;
    ...
    if ((mb1_transfer.ack.header !=3D header) ||
        ((mb1_transfer.ack.ape_voltage_status & BIT(0)) !=3D 0))
        r =3D -EIO;

    unlock_and_return:

If the hardware responds with an error, the function returns -EIO but appea=
rs
to fail to decrement the requests counter back to 0.

On subsequent calls, if (0 !=3D requests++) will evaluate to true, skipping=
 the
hardware request entirely and returning success (0). Could this leave the
software clock framework assuming the voltage requirement is fulfilled when=
 the
hardware is unconfigured, potentially crashing the system when CPU frequency
scales up?

>  		if (err) {
>  			pr_err("clk_prcmu: %s fail req APE OPP VOLT for %s.\n",
>  				__func__, clk_hw_get_name(hw));
[ ... ]
> diff --git a/drivers/cpuidle/cpuidle-ux500.c b/drivers/cpuidle/cpuidle-ux=
500.c
> index f7d778580e9be..6d6c52c0bcc2d 100644
> --- a/drivers/cpuidle/cpuidle-ux500.c
> +++ b/drivers/cpuidle/cpuidle-ux500.c
[ ... ]
> @@ -66,7 +66,7 @@ static inline int ux500_enter_idle(struct cpuidle_devic=
e *dev,
>  		/* Go to the retention state, the prcmu will wait for the
>  		 * cpu to go WFI and this is what happens after exiting this
>  		 * 'master' critical section */
> -		if (prcmu_set_power_state(PRCMU_AP_IDLE, true, true))
> +		if (db8500_prcmu_set_power_state(PRCMU_AP_IDLE, true, true))
>  			goto out;

[Severity: High]
This isn't a bug introduced by this patch, but does calling this function
acquire a standard spinlock in the cpuidle execution path?

The cpuidle callback ux500_enter_idle() executes with local hardware interr=
upts
disabled. It calls db8500_prcmu_set_power_state(), which acquires a spinloc=
k:

drivers/mfd/db8500-prcmu.c:db8500_prcmu_set_power_state() {
    ...
    spin_lock_irqsave(&mb0_transfer.lock, flags);

On CONFIG_PREEMPT_RT kernels, spinlock_t is mapped to a sleepable rt_mutex.
Could attempting to acquire a sleepable lock while interrupts are explicitly
disabled cause a sleeping in atomic kernel splat?

[ ... ]
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_th=
ermal.c
> index 576f88b6a1b35..cf1706569e6d7 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
[ ... ]
> @@ -91,8 +91,8 @@ static void db8500_thermal_update_config(struct db8500_=
thermal_zone *th,
>  	 * The PRCMU accept absolute temperatures in celsius so divide
>  	 * down the millicelsius with 1000
>  	 */
> -	prcmu_config_hotmon((u8)(next_low/1000), (u8)(next_high/1000));
> -	prcmu_start_temp_sense(PRCMU_DEFAULT_MEASURE_TIME);
> +	db8500_prcmu_config_hotmon((u8)(next_low / 1000), (u8)(next_high / 1000=
));
> +	db8500_prcmu_start_temp_sense(PRCMU_DEFAULT_MEASURE_TIME);
>  }
> =20
>  static irqreturn_t prcmu_low_irq_handler(int irq, void *irq_data)

[Severity: High]
This is a pre-existing issue, but do prcmu_low_irq_handler() and
prcmu_high_irq_handler() race to update the shared thermal state without
locking?

These two threaded IRQ handlers are registered for separate interrupt lines=
 and
can be scheduled concurrently on different CPUs. Both handlers read and mod=
ify
th->cur_index and invoke hardware configuration functions without any
synchronization:

drivers/thermal/db8500_thermal.c:prcmu_low_irq_handler() {
    struct db8500_thermal_zone *th =3D irq_data;
    unsigned int idx =3D th->cur_index;
    ...
    db8500_thermal_update_config(th, idx, next_low, next_high);

drivers/thermal/db8500_thermal.c:prcmu_high_irq_handler() {
    struct db8500_thermal_zone *th =3D irq_data;
    unsigned int idx =3D th->cur_index;
    ...
    db8500_thermal_update_config(th, idx, next_low, next_high);

Could this data race corrupt the thermal zone state machine, leading to
incorrect temperature thresholds being programmed and out-of-sync
software/hardware states?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-mfd-prcmu-=
merge-headers-v1-1-8ea0ee23b4d6@kernel.org?part=3D1
