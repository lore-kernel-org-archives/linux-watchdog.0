Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5DF3385A5
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Sep 2026 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401478; cv=none; b=Yl6ZODSA9pHrYhfDAzS8h8ep+jqN/ugs4PK6JElHL7tK1rskLrIniiIEVVS4E1xzdLx0DvGwJP19hVppAO5WPQaU3VnDl6Yf6vEQLd7zqnVobwqZGttNIqmbZdNEoPRayB8sHA3h0HSJZwBEtEN6jXq4g63NW0ZHK3nhkuTD3hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401478; c=relaxed/simple;
	bh=FEy7DH+KS7qpKv1tnqLSWE8psC2j91G2lhR62tO0zwo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TXQI+SiJ1FywScrFynVR6MhmJ2qMkHqp9DK2s/OLLacxF6gD5hb+aTve2lQCItaDXA3tweYD2f5uGehyU8MAmCwMVm0IWhPh1GxJrvGrr6ydqjuQLS2ULqKkH+7ZBY/NMGq1kWF4qKge70r1IEJDuEzrfJIU0DD9aaLQcmIF678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvtiR7ch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvtiR7ch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7AC1F000E9;
	Thu,  3 Sep 2026 02:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788401473;
	bh=I1yd95qGRk8SVY4wBQzsX5M6m2tnnv8mrIkhOZ/Zg0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NvtiR7chK3+Py0z7neVAslrdAMYswUjnmBci3BPHk5Lbu2iRr2e/HTL475ANuxX4c
	 yp37byLVEQ2QQuHmZ6gcoieuKrixgwhDSY6YgtoIVx3rAeFJapx/r9WxgSBSUKY0OH
	 HeSg4txFgeitjBellgB6lTRxgKGAPg+1yLyLmjuT8KxF4U1yEr/EhsqsgZbgXryuns
	 KOrLvrswiFAYR0bFVMSYyc1e88SOtbYVy1v+SN5iFor+HuIwL2AeAw+o0SMbdlGsa1
	 HLwI7N+Y9K7S1acxVoWizWyR0/CSV9/J5aeYf/eBiVMEgWm+Tq40dXcEuTyw4qDHy8
	 yvIcAL6/kx+kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] genirq: Implement synchronous disable_nmi()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayank Rungta" <mrungta@google.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260902-qcom-wdt-nmi-series-v3-2-f3999362a9ea@google.com>
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-2-f3999362a9ea@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 02:11:12 +0000
Message-Id: <20260903021113.2F7AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] disable_nmi() fails to guarantee synchronous completion of running=
 NMI handlers, violating its primary design goal.

Pre-existing issues:
- [High] __synchronize_hardirq() unconditionally enables interrupts upon un=
locking, violating synchronize_hardirq() IRQ context safety.
--

commit 462b11bbb02ba75caa68818b765707ca5b10454d
Author: Mayank Rungta <mrungta@google.com>

genirq: Implement synchronous disable_nmi()
   =20
This commit introduces disable_nmi() to synchronously disable an NMI line,
guaranteeing any running instances of the NMI handler have completed before
returning. It implements this by wrapping disable_irq().

> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index a9973b61163ae..009633b5b6544 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -767,6 +767,21 @@ void disable_nmi_nosync(unsigned int irq)
>  	disable_irq_nosync(irq);
>  }
> =20
> +/**
> + * disable_nmi - disable an nmi and wait for any pending handlers
> + * @irq: Interrupt to disable
> + *
> + * Disable the selected interrupt line. Disables and enables are nested.
> + *
> + * The interrupt to disable must have been requested through request_nmi.
> + * This function ensures existing instances of the NMI handler have
> + * completed before returning.
> + */
> +void disable_nmi(unsigned int irq)
> +{
> +	disable_irq(irq);

[Severity: High]
Does this correctly guarantee synchronous completion of running NMI handler=
s?

This function wraps disable_irq(), which uses synchronize_irq() to wait for
completion. synchronize_irq() checks the IRQD_IRQ_INPROGRESS software flag
and the IRQCHIP_STATE_ACTIVE hardware state.=20

However, NMIs handled by functions like handle_fasteoi_nmi() bypass standard
event handling and never set IRQD_IRQ_INPROGRESS:

kernel/irq/chip.c:handle_fasteoi_nmi() {
    ...
    res =3D action->handler(irq, action->dev_id);
    ...
}

If the irqchip doesn't support reading the active state, or if the NMI is
pending but not yet active, synchronize_irq() returns immediately. The
target CPU then processes the NMI, and since handle_fasteoi_nmi() does not
check IRQD_IRQ_DISABLED, the handler blindly executes after disable_nmi()
has returned. Can this lead to use-after-free or crashes when drivers rely
on disable_nmi() before freeing resources?

[Severity: High]
This isn't a bug introduced by this patch, but __synchronize_hardirq() is
called by synchronize_irq(), which is triggered by this code. There is a
pre-existing locking violation with how it handles locking:

kernel/irq/manage.c:__synchronize_hardirq() {
    ...
    guard(raw_spinlock_irqsave)(&desc->lock);
    ...
}

The guard is defined in include/linux/spinlock.h:

DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
                    raw_spin_lock_irq_disable(_T->lock),
                    raw_spin_unlock_irq_enable(_T->lock))

This defines the guard to use raw_spin_unlock_irq_enable(), which does not
restore previously saved flags but unconditionally enables interrupts.

If a caller invokes synchronize_hardirq() (or another function using this
guard) from an IRQ handler where local interrupts are currently disabled,
it unconditionally re-enables local interrupts upon unlocking rather than
restoring the previously saved IRQ state. Could this lead to unexpected
nested interrupts or deadlocks?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-qcom-wdt-n=
mi-series-v3-0-f3999362a9ea@google.com?part=3D2
