Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF6B37A845
	for <linux-watchdog@vger.kernel.org>; Sat, 29 Aug 2026 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787966334; cv=none; b=IByFh8AcZ9K6NqGXnmTAmcyMwsl/aRSjD1ZNC7pabAPVwAY3Nh4YOb5aPlHyq1rq9FcNnBH2CTxEjI9u5Za8MYXTzqBAQ20kaCAnTUfo3ux2VaF4fskDvUbJTSNyHKqlP6oGCqYl8VrsIqv0RWOpEvOwTObGOwSmMsl6rGSP/PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787966334; c=relaxed/simple;
	bh=um2XiBD5xllLWSz4dgY0kEbRE6BFox5lfi+6URpM2hQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PdbxOIhgWtKlt9sBulkgLFDpDyV+Gb2WBmK4w+9H9+f1qHrZ2+0eN2T6Zust52SB5AdMQrujzbpDvNAXSrZfDhvDBG+hRdpEEGhD1j7ITZbw8oDrfAWwfFdMgSme2x2dWg4u0MIdN2QKLy2YBZHtrdslo/oFMKSVsrWifKt5WLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOXcRX6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOXcRX6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9A41F000E9;
	Sat, 29 Aug 2026 01:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787966333;
	bh=rR1jFO++qLeI5zzJ0ud2gaGJaiOBiUpz1kcYWfY4kE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VOXcRX6z7OZwbhCICRiLdCq6e7BZcWRqILBtriugDR4bUir/biroZPCdbQ5KZgpRo
	 up8S22CeBkK3efIdP834kbyGXkTI74q5KBX38ZNcNuyObSiCkVRmYzR8kQh7wDaADb
	 qqfQvmIBywBSYltfJzYJAkxP/86uh1gXOqDn0uHz40QKY+TDEUFAW/CROpJQoYeee1
	 3Rq6eOd1gLW9e4I/EO+hDVjWSYaHuWfxE+t0aTk0IxSLnL2N3hqbgrghRvVqsfAE70
	 mpt66cS4w3te2r34TSNiTojKhWkpQKVdHDM7vJHPXZ/6+D3IoEDV4+nJfOOU+jzi+i
	 YBRYhPeZ1xs1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] genirq: Implement synchronous disable_nmi()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayank Rungta" <mrungta@google.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260828-qcom-wdt-nmi-series-v2-2-363979fe6b6b@google.com>
References: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com>
 <20260828-qcom-wdt-nmi-series-v2-2-363979fe6b6b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 01:18:52 +0000
Message-Id: <20260829011853.0B9A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Because NMIs do not set the IRQD_IRQ_INPROGRESS flag, __synchroniz=
e_hardirq() skips its cpu_relax() yield loop and tightly polls the hardware=
 state, causing severe bus and lock contention.
--

commit 3611450f7345bc1611ae9b9599bb6e44ba2b6477
Author: Mayank Rungta <mrungta@google.com>

genirq: Implement synchronous disable_nmi()

This patch introduces a synchronous disable_nmi() interface. Drivers can use
this in process context to disable an NMI line and ensure running handlers
have completed on other CPUs by wrapping disable_irq().

> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 3bf969ad8fe07..f13b3ab3829af 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h

[ ... ]

> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 61384925b921a..40013aa94481e 100644
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
This is a pre-existing issue, but does wrapping disable_irq() here create a
severe hardware polling loop when synchronizing NMIs?

Because disable_irq() delegates to __synchronize_hardirq(), it expects to w=
ait
for the IRQD_IRQ_INPROGRESS flag using a cpu_relax() loop:

kernel/irq/manage.c:__synchronize_hardirq() {
    ...
		while (irqd_irq_inprogress(&desc->irq_data))
			cpu_relax();

		/* Ok, that indicated we're done: double-check carefully. */
		guard(raw_spinlock_irqsave)(&desc->lock);
		inprogress =3D irqd_irq_inprogress(&desc->irq_data);
    ...
}

However, NMI flow handlers (such as handle_fasteoi_nmi() in kernel/irq/chip=
.c)
execute locklessly and never set the IRQD_IRQ_INPROGRESS flag.

Since the flag is false, the cpu_relax() yield is skipped entirely. When an=
 NMI
is executing concurrently, __synchronize_hardirq() will repeatedly acquire
desc->lock and query the hardware state via __irq_get_irqchip_state().

Will this cause a tight MMIO polling loop on the IRQ controller without
yielding, generating severe bus contention and potentially delaying the NMI
handler it is waiting for?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-qcom-wdt-n=
mi-series-v2-0-363979fe6b6b@google.com?part=3D2
