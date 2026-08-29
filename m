Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB2224B05
	for <linux-watchdog@vger.kernel.org>; Sat, 29 Aug 2026 01:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787966090; cv=none; b=uwwkV9tN9szbeKmOwyGYq0Fo8pQdtn9WdJ7hW9YWArO5RJvt5K95h7xkSVztEoXJWlT+CkziFeNSk9HChdQK5orLX+uBgHXFOEnazf8RHpXpVg0BG9kuydR3ds93DxDwPdpMJF6srgMgpKMxx1/lX68YIm1clZpRQCD1T8A/NBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787966090; c=relaxed/simple;
	bh=/2OBXN9BDmaMRJ5h/XGX6749Pax99eLzxkr2N6+PSpg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TISpYPZ1AbNmqy9io6lCz80Ymj18FKybMcsMw36OUms2ll644AlFMDop0GK7UiwYDbWCFo9MYJzvfqCpDvgTNgana4VPM4xzCUxJIOMR0LTLpHJw2ZPwtGPUNTWkSiY5PmkVuNnafPstTTkDmGFR0Jr2GYRE8vJMlkNrPnf6/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNLYvWdx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNLYvWdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AF11F000E9;
	Sat, 29 Aug 2026 01:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787966089;
	bh=evjyY1bkf02XjtJTFcRkZxyaGpEMBvgihhDiHKTuT+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iNLYvWdxNuNEBuHCVxFL/6COev2bMBBtLW0TGyC6RaGYUGKejiCwSP8S+Z9ejcS92
	 TEpWlGbepigN10hkD/8U10SYYsC1t1vBT9lTYHPW+PhHYs3fRMiKurs6VJLiwjRgnt
	 iyPDN1Z/LUsQTa7NFanN90KybBrdUMPlDozwpjFUWeDa+Wl+CWJZ2qbuJR0ftQC8JM
	 B64VMI+ea6nk0YbnYFxLVJWn7xEiZ4ti71aak6JYp5owk6E3BffnrmD2NzkoDeLLYN
	 KP5TAVgmZfifBc6fYN+3aRfMJdr4JYdXsqF7HDQ0tzPbHHgnoNLloP3gyrxcNFX/Qf
	 ZitDlxFXY4/WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] genirq: Synchronize in-flight handlers during
 NMI teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayank Rungta" <mrungta@google.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260828-qcom-wdt-nmi-series-v2-1-363979fe6b6b@google.com>
References: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com>
 <20260828-qcom-wdt-nmi-series-v2-1-363979fe6b6b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 01:14:49 +0000
Message-Id: <20260829011449.87AF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Splitting the atomic NMI teardown in `__cleanup_nmi()` without hol=
ding `desc->request_mutex` introduces a critical race condition with concur=
rent `request_nmi()` calls.

Pre-existing issues:
- [Critical] Setting `desc->action =3D NULL` before synchronizing in-flight=
 NMIs creates a fatal race window where concurrent NMIs dereference a NULL =
pointer.
--

commit c7c9e712a226c1915918d074d948b4cf1845990f
Author: Mayank Rungta <mrungta@google.com>

genirq: Synchronize in-flight handlers during NMI teardown

This patch modifies __cleanup_nmi() to wait for in-flight handlers using
__synchronize_hardirq() before tearing down the NMI configuration and
deactivating the domain. It also enforces that interrupt controllers claimi=
ng
NMI support must implement ->irq_get_irqchip_state().

> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 2fbff2618a1e2..61384925b921a 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c

[ ... ]

> @@ -2047,11 +2051,20 @@ static const void *__cleanup_nmi(unsigned int irq=
, struct irq_desc *desc)
>  		desc->action =3D NULL;
> =20
>  		irq_settings_clr_disable_unlazy(desc);
> -		irq_shutdown_and_deactivate(desc);
> +		irq_shutdown(desc);
>  	}
> =20
>  	irq_proc_update_valid(desc);
> =20
> +	/* Ensure all in-flight NMI handlers on other CPUs complete before free=
ing action */
> +	__synchronize_hardirq(desc, true);

[Severity: Critical]
This is a pre-existing issue, but does setting desc->action to NULL before
synchronizing in-flight NMIs expose a fatal race window?

If an NMI is delivered to a CPU after desc->action is set to NULL, but befo=
re
the hardware line is disabled (or if an NMI is already in flight), the NMI
handler could unconditionally dereference the nullified action pointer.

Unlike normal IRQ handlers, handle_fasteoi_nmi() assumes the action is
always valid:

kernel/irq/chip.c:handle_fasteoi_nmi() {
    ...
    /*
     * NMIs cannot be shared, there is only one action.
     */
    res =3D action->handler(irq, action->dev_id);
    ...
}

The attempt to fix the use-after-free via __synchronize_hardirq() appears
ineffective here because the pointer is nullified before the synchronization
barrier.

> +
> +	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
> +		irq_nmi_teardown(desc);
> +		desc->istate &=3D ~IRQS_NMI;
> +		irq_domain_deactivate_irq(&desc->irq_data);
> +	}

[Severity: High]
Does splitting the atomic NMI teardown without holding desc->request_mutex
introduce a race condition with concurrent request_nmi() calls?

Since the lock is yielded to wait in __synchronize_hardirq(), a concurrent
request_nmi() could execute. Unlike free_irq(), __cleanup_nmi() does not ho=
ld
desc->request_mutex. This means request_nmi() could acquire the mutex,
configure the new NMI, and attach the action.

When __cleanup_nmi() resumes in this block, would it blindly execute
irq_nmi_teardown() and irq_domain_deactivate_irq(), inadvertently destroying
the newly requested hardware state and leaving the new NMI broken?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-qcom-wdt-n=
mi-series-v2-0-363979fe6b6b@google.com?part=3D1
