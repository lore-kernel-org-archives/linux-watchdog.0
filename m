Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794454292;
	b=wxw+NAaHFmzMrqLPRdBsr9plKtLB9Kte9alo6htAYboOEaOplz2BfwGgkjH464yuNe6V
	 jGO7kN6ZVljbpEPsS/F0w/binAmvtWIUiNUR4jlaB+ET4AD6XVUTPC5FFB2wkgn8yZd7E
	 YcUsWx3UW6QMsX6qGt9/FAwSs2jlOhcXVbNvNG66YKLJOEMau9dUjiIxMKRo6Gh0n2TOw
	 EQnE5TW1codGOf3TUEIIxUjEw6XRGdHR9Ece+c8gxHx0bCnm74+1sEQXIHjlUOVFDchPy
	 Q5y0emC1E2+CDeKGdZBAks16arb4Z9z0BWvNe9xRbM2KmLLLAarJ5caR6KSfvbvdHsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794454292;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OJPXC1WFUGM7sheAwBrhGXm34Nt3M7lguaoVhMRZUkQ=;
	b=TgyMl5y7caZ4ZE2r0te3M0fEmIQiVy73xRZib/7e6DGjhMB2mBA5NtErOU++ijPopjuI
	 OWm+Dx+PHLefH6qE/C6f1zf3Td3kguOJ3Tkh7RR3cU+doQDXnO+PP7G5PeUE7PDIJH2h1
	 wGJ+lajsCvKcN8WIbU3Q/aWEWZb7RoJvho0eMtjVvnVoqSta26WxETuV7AW5ZQ0BtY9Jh
	 uDCsDoTlnBrZQBi3E54kAHUPAHQZcdCfKxci1k80TySv3N2ySzAhLKzy9VXldaDfISuZP
	 XLpYGsypbmwSRh8Y3G+8Kvlo8dH8WfE41RIDg4SUf0J3KL/riJIrQ9qsEWhngUxsb7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOwQzDeY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21931606A324
	for <linux-watchdog@vger.kernel.org>; Thu, 12 Nov 2026 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOwQzDeY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A225C1F00A05;
	Thu, 12 Nov 2026 03:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794454291;
	bh=OJPXC1WFUGM7sheAwBrhGXm34Nt3M7lguaoVhMRZUkQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XOwQzDeY83Pb4P/Jp3PK40qTnwtawhfMtZWnYo9fzA/zsP1IAfIMpNCWHzkx41zK6
	 sjJhpPOD8nuVsmFYoAWepwbT+rvVBmWym6D5RnQHluTcZ1emeQ38TOhZFVp4sAGz6h
	 SsXffcDViOhsxh23hG3E/ozqRFNC8D2af691v/BvsnrR+gM1hSgMd5azV2WRjCZhsN
	 LWB0UOZXWKUpkxUdQcwCDQlwg4vvJgib9/L/zkdlS6DTyXsHlfQwFNzFITxOK1937Z
	 N7iKUDIP8qF5Ni1ZsG45ErZwSfS/uB4jTmFM0iOEVLJz2yr+P7t4ZUnf+S9xJk5uE1
	 /B9v4kiR8PFCA==
Message-ID: <sashiko-outbox-210280@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] genirq: Synchronize in-flight handlers during
 NMI teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayank Rungta" <mrungta@google.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261112031629.396819-2-mrungta@google.com>
References: <20261112031629.396819-1-mrungta@google.com>
 <20261112031629.396819-2-mrungta@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:31:31 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] genirq: inverted active state check order in
  __synchronize_nmi()
--

commit 67837136291d1dffe0f2c9d32d24bdb5ba4846f1
Author: Mayank Rungta <mrungta@google.com>

genirq: Synchronize in-flight handlers during NMI teardown

This commit tracks in-flight NMI handlers with an atomic counter and adds
__synchronize_nmi() to wait for running NMI handlers during NMI teardown
and synchronization.

> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index ec3ecb0e48cec..3fb77a2d954d9 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -48,11 +48,72 @@ static inline void synchronize_irqwork(struct irq_des=
c *desc) { }
> =20
>  static int __irq_get_irqchip_state(struct irq_data *d, enum irqchip_irq_=
state which, bool *state);
> =20
> +static void __synchronize_nmi(struct irq_desc *desc, bool sync_chip)
> +{
> +	struct irq_data *irqd =3D irq_desc_get_irq_data(desc);
> +	bool inprogress;
> +
> +	do {
> +		/*
> +		 * Wait until we're out of the NMI handler before taking
> +		 * desc->lock or polling the irqchip. This might give the
> +		 * wrong answer due to the lack of memory barriers.
> +		 */
> +		while (atomic_read(&desc->nmi_active))
> +			cpu_relax();
> +
> +		guard(raw_spinlock_irqsave)(&desc->lock);
> +		/*
> +		 * Ok, that indicated we're done: double-check carefully.
> +		 *
> +		 * Holding desc->lock serializes with prior state updates (e.g.
> +		 * IRQD_IRQ_DISABLED set under desc->lock) and protects
> +		 * __irq_get_irqchip_state(). Together with
> +		 * smp_mb__after_spinlock(), this provides a full memory
> +		 * barrier pairing with smp_mb__after_atomic() in
> +		 * handle_fasteoi_nmi() so those updates are visible before
> +		 * reading nmi_active.
> +		 */
> +		smp_mb__after_spinlock();
> +
> +		/*
> +		 * Pair with smp_mb__before_atomic() + atomic_dec() in
> +		 * handle_fasteoi_nmi() so all handler memory accesses complete
> +		 * before __synchronize_nmi() returns.
> +		 */
> +		inprogress =3D atomic_read_acquire(&desc->nmi_active);
> +
> +		/*
> +		 * Also check hardware active state when supported to bridge the
> +		 * window between hardware acknowledge and atomic_inc() in
> +		 * handle_fasteoi_nmi() on non-percpu_devid SPIs. Ignore the
> +		 * return code; inprogress is only updated when the chip
> +		 * supports it. Note that if a chip does not implement this,
> +		 * disable_nmi() is still safe, and free_nmi() is as safe as we
> +		 * can make it (though an NMI acknowledged just before masking
> +		 * that has not yet entered handle_fasteoi_nmi() could race with
> +		 * irq_nmi_teardown() resetting desc->handle_irq).
> +		 */
> +		if (!inprogress && sync_chip)
> +			__irq_get_irqchip_state(irqd, IRQCHIP_STATE_ACTIVE,
> +						&inprogress);
> +	} while (inprogress);
> +}

[Severity: Medium]
Can __synchronize_nmi() return while handle_fasteoi_nmi() is still running
on another CPU because it checks desc->nmi_active before querying
IRQCHIP_STATE_ACTIVE?

Unlike regular IRQ flow handlers, which acquire desc->lock before setting
IRQD_IRQ_INPROGRESS and calling chip->irq_eoi(), handle_fasteoi_nmi() runs
without desc->lock.  On the NMI CPU, hardware acknowledge sets
IRQCHIP_STATE_ACTIVE first, then handle_fasteoi_nmi() increments
desc->nmi_active, then chip->irq_eoi() clears IRQCHIP_STATE_ACTIVE, and
finally desc->nmi_active is decremented:

CPU0 (NMI)                        CPU1
<NMI acknowledged in hw>
  (IRQCHIP_STATE_ACTIVE =3D true)
                                  __synchronize_nmi()
                                    inprogress =3D
                                      atomic_read_acquire(&desc->nmi_active=
);
                                      -> 0
  handle_fasteoi_nmi()
    atomic_inc(&desc->nmi_active)
    action->handler(...)
    chip->irq_eoi()
      (IRQCHIP_STATE_ACTIVE =3D false)
                                    __irq_get_irqchip_state(...,
                                      IRQCHIP_STATE_ACTIVE, &inprogress);
                                      -> false
                                  /* __synchronize_nmi() returns */
                                  __cleanup_nmi()
                                    irq_nmi_teardown()
    atomic_dec(&desc->nmi_active)  <-- NMI handler still in flight

Querying IRQCHIP_STATE_ACTIVE before reading desc->nmi_active (or
re-checking desc->nmi_active after observing IRQCHIP_STATE_ACTIVE is
false) would prevent missing the handover between hardware-active and
software-active states.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112031629.3968=
19-1-mrungta@google.com?part=3D1
