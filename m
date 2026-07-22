Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8D47011D
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738809; cv=none; b=WrdrUVqF28Fqtd3CwtQI4uXVqdCtBjANeCLyNbcryPjiN8p30uyRWPAx4FLBn6tnrHUHDZDvOUikK2NXV3RTvdDBau1iZ4gK2NbPlgbIzKE/tD+nVA/OnH93S9GBZhD/21F5E+CDh8svoXxj+MwJ7rSNWqCT3Gbbb+v9JlpcTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738809; c=relaxed/simple;
	bh=VF70qTdK4u/+VVPpVC+EeueedlXJRxWvn2AlS4TL8i8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F9eEl6CiNVJQtNujoh8K/c2gLAPB+DJlG64XiS5r73fMcckThDi6CnxsElRp3QDJZTujiiLZll0WE/LDoVHeJ1uGUCE4o+zqVo9E7af/4+CfyDp4fs4Qk8n4JkczXQ47M4nMqitNHvbMn1mNrc68v2+wCGE06Y5JaakYs8WNfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiD+JCZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiD+JCZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EACF1F000E9;
	Wed, 22 Jul 2026 16:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738797;
	bh=NvfBHHTSO/QKgethdWUFG+wKU5VxEksQ/fHtnkW3ydY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KiD+JCZ+GM5tyjcAOR/kK0Sg3E7b6e09fOEgae9shmJOKFy1+k49JQqWbY9OO9hxP
	 xAKzY16VasNunBP+3O6T/41RCbkzsDFiY0DRDaNH8Bq9a4AbYp/Z1b4rbnERWMn7aQ
	 W/+of0nJcVnhseAOV2v3LW8qOUgzhNfctriKMKwa2Vm8RWznxATUGvnemitFTfkazA
	 vSN+fIgQIkb8914UOBR/iviMj44B3mQ9+20dsFU6t8ywhCeFTlkSEFh28uTjVi4NBQ
	 NLT8QHaJ+THZlFtBrsN1hEAACm/wuW1/v3FN1NqPSO8IjJ8jcIfTUVAcP38tWGMUiX
	 eE/Ari8oi1y6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: atcwdt200: fix return value when watchdog is
 enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: kr494167@gmail.com
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260722163706.14238-1-kr494167@gmail.com>
References: <20260722163706.14238-1-kr494167@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 16:46:37 +0000
Message-Id: <20260722164637.8EACF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] Setting `drv_data->int_timer_type` is useless dead code because the=
 function immediately returns a fatal error.
- [Low] Kernel-doc comment for `atcwdt_get_int_timer_type()` contradicts th=
e new code.

Pre-existing issues:
- [High] Failing driver probe when the hardware watchdog is already running=
 orphans the timer and guarantees an unhandled system reset.
- [High] The watchdog restart handler acquires a standard spinlock in atomi=
c context, causing a lockdep splat and sleep-in-atomic bug on PREEMPT_RT.
--

--- Patch [1]: [PATCH] watchdog: atcwdt200: fix return value when watchdog =
is enabled ---
commit 8139a405984f14ed6f8cead4736a58db3d02c322
Author: Surendra Singh Chouhan <kr494167@gmail.com>

watchdog: atcwdt200: fix return value when watchdog is enabled

This commit modifies atcwdt_get_int_timer_type() to return -EBUSY via
dev_err_probe() when the watchdog is already enabled, fixing an issue
where probe() incorrectly returned a positive value on failure.

> diff --git a/drivers/watchdog/atcwdt200_wdt.c b/drivers/watchdog/atcwdt20=
0_wdt.c
> --- a/drivers/watchdog/atcwdt200_wdt.c
> +++ b/drivers/watchdog/atcwdt200_wdt.c
> @@ -274,7 +274,9 @@ static int atcwdt_get_int_timer_type(struct atcwdt_dr=
v *drv_data)
>  	regmap_read(drv_data->regmap, REG_CTRL, &val);
>  	if (val & CTRL_WDT_EN) {
>  		spin_unlock(&drv_data->lock);
> -		return TMR_UNKNOWN;
> +		drv_data->int_timer_type =3D TMR_UNKNOWN;

[Severity: Low]
Is there a need to set drv_data->int_timer_type here? Since the function
immediately returns a fatal error, the driver probe will fail and free the
structure. This appears to be dead code.

> +		return dev_err_probe(dev, -EBUSY,
> +				     "Watchdog is enabled, cannot detect timer type\n");

[Severity: High]
This is a pre-existing issue, but does failing the driver probe when the
hardware watchdog is running orphan the timer?

If a bootloader leaves the watchdog enabled, refusing to bind the driver he=
re
guarantees an unhandled system reset. Should the driver adopt the running
watchdog instead and set WDOG_HW_RUNNING?

>  	}
> =20
>  	/*

[Severity: Low]
The kernel-doc comment for atcwdt_get_int_timer_type() currently states:

 * Note: This function must only be called when the ATCWDT200 watchdog is
 * disabled. If the watchdog is enabled, this function returns TMR_UNKNOWN.

Since this patch changes the return value to -EBUSY, should the documentati=
on
be updated to match the new behavior?

[Severity: High]
This is a pre-existing issue, but can the lock used in atcwdt_restart() cau=
se
a sleep-in-atomic bug on PREEMPT_RT kernels?

The watchdog restart handler acquires a standard spinlock:

drivers/watchdog/atcwdt200_wdt.c:atcwdt_restart() {
    ...
    spin_lock(&drv_data->lock);
    ...
}

Since restart handlers are invoked in atomic context with local interrupts
and preemption disabled, acquiring a standard spinlock_t blocks and can sle=
ep
on PREEMPT_RT. Should this lock be converted to a raw_spinlock_t?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722163706.1423=
8-1-kr494167@gmail.com?part=3D1
