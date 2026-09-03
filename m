Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68005211A14
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Sep 2026 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401202; cv=none; b=BsKI+EXvkLWUfPOOnA2lbRimCUuBl0Dzc9Wu5G888u4h7Hz0lRQvGJpxnB2Jf6IdpVI85emxJLN4vqlyDen+vyRXNTmDOtiQ1GEVptMJJow7oGFu2CJIXr3Pmnu2HFxAQrE67GYRkdt6WD+y3M5+Bg0tbMWNiVcvlUuxLjTwGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401202; c=relaxed/simple;
	bh=zYnJGVxD0t2tRR/MIh0RrOKS0TpDRwHet/8p6pOMU4I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WM6gL4GWwbqrskdGm9fVqEscHJ9MuENtz3h/4T8cnddGB91GzcU+ThyT84bF6Lt5/txI5iY1OmoqH4OmRkYUXbPEnPxtV1qSWg32Cen+RZ2XCiEk+VJI3YKsH/2u8JODEm2w3tk103M5i25OIqTvZOOTUYGT4UarYOvsQbHoJ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUd8mNQw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUd8mNQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1901F000E9;
	Thu,  3 Sep 2026 02:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788401200;
	bh=ivWa+0NVeOpT+d91mZ0brX0xCriN17x2Yy/YYNp/ZWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JUd8mNQwq2iJTElp/Xc0S+wAjF+IZ87sFGpoWTfzrYP+puUdanDf9JliF7RJGiiZj
	 a4i+RSB6rfl3MN7Vw0ccwqNtmVrDhb4bz0gfUD6FCEeyu7vwnqqtEtOYB+GZChhLYl
	 bhtObN/JetDpqZHpWWN8rswDmbb06W0y3vKzaVoCq0SLKJdrdXvWlooj84zOzg1KvS
	 WWzdmtACs/dm7nR2XeEgVvLCherkGflkYuvGSLbUjAe7rN7rnc5oEBLRdPG1CzrXfD
	 cYK1W/dxs7QaQ4/MavVn7tXZgp77998tGjpVTjwvMh2DjksUHhpOjj0spH0F8s5Wiq
	 dOBaGO+o5uX2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] genirq: Synchronize in-flight handlers during
 NMI teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayank Rungta" <mrungta@google.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260902-qcom-wdt-nmi-series-v3-1-f3999362a9ea@google.com>
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-1-f3999362a9ea@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 02:06:40 +0000
Message-Id: <20260903020640.AA1901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pending NMIs can cause a NULL pointer dereference in lockless NMI =
handlers after desc->action is cleared.
- [High] __cleanup_nmi() does not abort when desc->action is NULL, leading =
to double-free of resources and refcount underflows if invoked on an alread=
y freed NMI.
--

commit cba735e452b4b54ed5512df243c59c9e7de9a13b
Author: Mayank Rungta <mrungta@google.com>

genirq: Synchronize in-flight handlers during NMI teardown

This patch modifies __cleanup_nmi() to synchronize in-flight handlers on
other CPUs before tearing down the NMI. It serializes teardown, shuts down
the line, and queries the hardware state using __irq_get_irqchip_state().

> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 2fbff2618a1e2..a9973b61163ae 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
[ ... ]
> @@ -2034,11 +2042,20 @@ static const void *__cleanup_nmi(unsigned int irq=
, struct irq_desc *desc)
[ ... ]
> +	/*
> +	 * Ensure all in-flight NMI handlers on other CPUs complete before
> +	 * clearing desc->action or tearing down NMI state.
> +	 */
> +	__synchronize_hardirq(desc, true);
> =20
> +	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
>  		if (!WARN_ON(desc->action =3D=3D NULL)) {
>  			action =3D desc->action;
>  			irq_pm_remove_action(desc, action);
>  			devname =3D action->name;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but does this function fail to
abort when it detects that the NMI was already cleaned up?

If a race condition occurs where desc->action is already NULL, this block
issues a warning but proceeds with the rest of the teardown unconditionally.
Could this lead to double-freeing irqchip resources, unbalanced PM usage, a=
nd
module refcount underflows if invoked on an already freed NMI?

>  		desc->action =3D NULL;

[Severity: High]
This is a pre-existing issue, but does this synchronization step fail to wa=
it
for pending interrupts?

If an NMI is asserted by the hardware but the CPU has not yet taken the
exception, __synchronize_hardirq() queries IRQCHIP_STATE_ACTIVE and will
return immediately. The teardown path then clears desc->action to NULL.

Could the CPU taking the pending NMI exception then cause handle_fasteoi_nm=
i()
in kernel/irq/chip.c to locklessly dereference action->handler, resulting i=
n a
NULL pointer dereference?

> -		irq_settings_clr_disable_unlazy(desc);
> -		irq_shutdown_and_deactivate(desc);
> +		irq_nmi_teardown(desc);
> +		desc->istate &=3D ~IRQS_NMI;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-qcom-wdt-n=
mi-series-v3-0-f3999362a9ea@google.com?part=3D1
