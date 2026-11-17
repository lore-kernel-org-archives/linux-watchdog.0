Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953649;
	b=2MMqdZa6Qx+aRuyyxPudK8h0tsGuovhc/IWUvvhs3OkMvTH2ext2UJowFt6CPensauTY
	 ci/z5VYzEWpirfNjwm39QgrsqlcZ3+t0yRajBsj0BQbj9F3jl3GnxaodRRwr6dZ6mFiCB
	 moDXFCXkCfbwnEP5uDHfH1ReHzBOwDNq6I3C8hVhrz8FR0xUEprm31ty6L/pSv3TV1Ua7
	 vrO5a/57q+SZ/4+CamWi0YOVVttMvyZXOQjyhFIDJ+R9CBbFrSireixBRCtZQCrhbSbSn
	 0LM/3xaJKlOu6BLbTAx9i6RG0blnp+wpaJbBvPC3SouSwS4O3RxpJYGY5J3k0ZYWtKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=kpd7hhfRhWWBKoEgTCNhAfk8GLYDUaewjNnHM0/FSkA=;
	b=zWHDLz4cF1p54zTOOfhtWsb0q2+yECH36xKsJ0ccU5wVC6pYxlAVHxHO333mVRaGJmrM
	 MNWJ/tsnOcmoFQEerh1tfJzMnyQTUlFVM3WOTzQyYznTuF4psuXQnMyMZFXoX56VUxEkI
	 G8q1x3oYXqdWbbfj43OffkjxK/eqhLoE4X06tgNejrTWeVkD93C7d8rtCRaXe1xCk8OpH
	 tn5vkwLk5e44HeQBzFnFmt6FVAeUnrN4aUcfZ6aFEJXyrgz9jO04WhRSSOguOMhnx5YWN
	 YK//gonXWMK20dKEl5sXBEpzRuO1WEIuXt4T2IlJCaays08sky3vAJGcaKqVYP40fxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OkK7Oync;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12752606A31C
	for <linux-watchdog@vger.kernel.org>; Tue, 17 Nov 2026 22:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12752606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OkK7Oync
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-5058b105df7so105222b6e.1
        for <linux-watchdog@vger.kernel.org>; Tue, 17 Nov 2026 14:14:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794953648; cv=none;
        d=google.com; s=arc-20260327;
        b=QyS91lin92T9DKzQSeL/I+7bvzm6cAPjW8NcJJ0WWQcxb4gBdSEstB6N4qdWF/fF0u
         sayQ1FAEMd9YELPVjXfmvlsGsRHRmLJNrf8ezN9zNjTLLnS3eRGwW+gIQNIM4kcxr754
         ErdiWeYzKeHmLBROc85I2NNsrZ7cXheV05552HyPteFsLKUzGUNsLMLxlBuY3514pqe7
         oHa0LTmNrWqCLGILSrBnDJB4mtJDKAjYgPxw0BXUN/Mniu4Jp7Mw0D+82oTXgppAHU66
         pKk0bL2RoTiYjavnQzWJ//nYAwwP2HrZCPf9pEl3+Pokl2m8d722cab3vPb7pJhXoKbW
         JCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kpd7hhfRhWWBKoEgTCNhAfk8GLYDUaewjNnHM0/FSkA=;
        fh=nTua2UbRSZWthxUBjoxa7bgGcZH1urAvU5eGzRoVE0I=;
        b=DDqMtyUPKKV23h9EaVI6U3Ss+WbMVNie2GnBsSwjtrhG4mE3s185YyxLnEO19d8qOO
         76kJmuCz6a8l0422UEa/c804vDcoBqMZ8mTQ7cgToDrdmtmsy1FBiArfi5b/22NlZmiU
         J1pcwk1UTOa+icEaFO7rieumKw5pXtZFx7GYroAsgGT0Pkpi6IBbP6DpWVwjlmXrmyU/
         0v83dd/4UAiSkBXEPruYHAfkN6TDTzEO/PkEHjeKWx1TukGJIXQedXc2C8Glx4aO02Lj
         uQWh+NYZ27xmuWcZ2SmEcdXL08U3+wDqfCeELdHuzN1LJbw6prZ8F4NjDebEKGdXtvns
         8fPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794953648; x=1795558448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kpd7hhfRhWWBKoEgTCNhAfk8GLYDUaewjNnHM0/FSkA=;
        b=OkK7Oync/0FMR4WGnKttZfm6jO4gY2WpTAuxMTPGGdgi9bYq6J7iIKBa8VpjHUZyO5
         usHhSBmnLWPAXbr7C6Vs10jTLGe6cLQb/ULbjlEAznvTd3S2iUX0UJGNeMWMRtYpl/h+
         +UKeSOLB1H37XnEWzPOp8L5VoUrnAYZz7NqroLlKzaTsWgueA4mg4DEkCra+oakCnwc0
         6hh6uNVuy6hTVxPJNh14dfbCGZxnBU4W8QoTST6MBNSaIvKmXb4ZjqGqzStDARn1ahUj
         6qzHVNjAWI8eUgCJkrSPt7USJefKcGjAegppKzl2HvuzY61fEW4j06rjTP+69RcQFWLF
         yZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794953648; x=1795558448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpd7hhfRhWWBKoEgTCNhAfk8GLYDUaewjNnHM0/FSkA=;
        b=TGVAzczCWC+0cDCbtZY82kGQWe1sWZgjcXgYSMwi2ecwbfqKMkCVmMiY7eL3ju+tLZ
         J9o51sLZc049XmfGNlSEVnrnlUCnJJ5cKEGozt9ivrOThZyLwpW9nJJZrTjlZ5y8lx8H
         Aes+BDOy4i+WkEvICgGoKfPsycDejujFz19bV4RR+5s8+3aPCUjrdWqZJqPzBRLn+V6T
         mxGHL7yCjbj4eXnt4NCnUYN3m5M1wsmLTzZ1QUvNIWDwuS7RFsa96rsnTtjLPorfbKHM
         RDaEKhnQB9haj8pjHCyks6z5cE0nuPEdUr/IwLYQpFwhMIN4nGOIUK0PYQ3J+dvEIzKr
         wLtQ==
X-Gm-Message-State: APuU4Z/+4NGcx7qh6+b+/BNO53MP6GXU1dQ53Ym/VJ8A1A2AcRSxvk/k
	fDsMypSoISOSW29dOqz6o0KdSwJML4qbGH/pqkYgHYFhIRaaMaVIjSZAe0xQf/tfZi/ZS6H0eKC
	cGJUd8fMVqfdMS7AeTm1lliOzLj3LClWMG5H1DmDs
X-Gm-Gg: AYBFou3bJwOtqhyQWYBzKmprAr06/HO5NQZUUu+L1nkmCiznE26IgLqWiLemRPZkIIt
	+VD0hSsNZPu2Ct2qN8dWxoz13/JjTP+RnmeiIzU3xMyeGllsegl4AbtC1gYbIwA6OEA54DEPNmm
	fFjvWaqg6xem+3shrHakkqyNwcDnchrLgPEDLmCkR5Vo1gbgykKd1MjPRURX8DP4n9142bhz7i2
	c3ZF3uQp71fA3ZBL2bvRP9/np6Zxc+A7QLPMFLQ2jj3fr7p8J329UkFvtTG4QZX+UThoxgKYSlj
	5kOGnfmGj/hzqS3G74ncGO3P8SvWmdIchGckpI8yzNJIYIiFlYgp0faZYpa2K4O5tEYjq9Iq1Ai
	tX5pW/RCssUKkzeksSjdnCZzl42TAUDjG1TC0VVkzmY5cKiibFyiSoCFyQjsWZcKuJjw=
X-Received: by 2002:a05:6808:30a9:b0:4b9:a88b:888b with SMTP id
 5614622812f47-5774162054dmr1516905b6e.33.1794953647357; Tue, 17 Nov 2026
 14:14:07 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112031629.396819-1-mrungta@google.com> <20261112031629.396819-2-mrungta@google.com>
 <sashiko-outbox-210280@kernel.org>
In-Reply-To: <sashiko-outbox-210280@kernel.org>
From: Mayank Rungta <mrungta@google.com>
Date: Tue, 17 Nov 2026 14:13:55 -0800
X-Gm-Features: AclHuK-gfyGRgfHP6b95c4djqnr6JWB02JWcunq_dlapBgDtO9GdRA_nY1E9eCw
Message-ID: <CABz7rdC2Q1qtUdhiXDpEydbhCnSaNSuS5jzcUK+cZFdNZmULgw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] genirq: Synchronize in-flight handlers during NMI teardown
To: sashiko-reviews@lists.linux.dev, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: linux-watchdog@vger.kernel.org, Marc Zyngier <maz@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "Kirill A . Shutemov" <kas@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sashiko has found one potential issue:

> [Severity: Medium]
> Can __synchronize_nmi() return while handle_fasteoi_nmi() is still runnin=
g
> on another CPU because it checks desc->nmi_active before querying
> IRQCHIP_STATE_ACTIVE?
>
> Unlike regular IRQ flow handlers, which acquire desc->lock before setting
> IRQD_IRQ_INPROGRESS and calling chip->irq_eoi(), handle_fasteoi_nmi() run=
s
> without desc->lock.  On the NMI CPU, hardware acknowledge sets
> IRQCHIP_STATE_ACTIVE first, then handle_fasteoi_nmi() increments
> desc->nmi_active, then chip->irq_eoi() clears IRQCHIP_STATE_ACTIVE, and
> finally desc->nmi_active is decremented:
>
> CPU0 (NMI)                        CPU1
> <NMI acknowledged in hw>
>   (IRQCHIP_STATE_ACTIVE =3D true)
>                                   __synchronize_nmi()
>                                     inprogress =3D
>                                       atomic_read_acquire(&desc->nmi_acti=
ve);
>                                       -> 0
>   handle_fasteoi_nmi()
>     atomic_inc(&desc->nmi_active)
>     action->handler(...)
>     chip->irq_eoi()
>       (IRQCHIP_STATE_ACTIVE =3D false)
>                                     __irq_get_irqchip_state(...,
>                                       IRQCHIP_STATE_ACTIVE, &inprogress);
>                                       -> false
>                                   /* __synchronize_nmi() returns */
>                                   __cleanup_nmi()
>                                     irq_nmi_teardown()
>     atomic_dec(&desc->nmi_active)  <-- NMI handler still in flight
>
> Querying IRQCHIP_STATE_ACTIVE before reading desc->nmi_active (or
> re-checking desc->nmi_active after observing IRQCHIP_STATE_ACTIVE is
> false) would prevent missing the handover between hardware-active and
> software-active states.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112031629.39=
6819-1-mrungta@google.com?part=3D1

The observation is valid in theory, though practically benign for
disable_nmi() and free_nmi():

In that window, IRQD_IRQ_DISABLED is already set by __irq_disable() or
irq_shutdown() before __synchronize_nmi() is called. If
__synchronize_nmi() reads desc->nmi_active =3D=3D 0 after
smp_mb__after_spinlock(), then the NMI CPU's
atomic_inc(&desc->nmi_active) occurred after IRQD_IRQ_DISABLED was
set, so handle_fasteoi_nmi() is guaranteed to observe
irqd_irq_disabled() =3D=3D true and skip action->handler().

By the time __synchronize_nmi() reads IRQCHIP_STATE_ACTIVE as false,
chip->irq_eoi() has also completed, leaving only
atomic_dec(&desc->nmi_active) in handle_fasteoi_nmi(). The IRQ mapping
is not torn down in disable_nmi() or free_nmi(), and even if it were
torn down immediately after free_nmi(), free_desc() frees struct
irq_desc via call_rcu(&desc->rcu, delayed_free_desc), which cannot
complete until the NMI CPU exits NMI context (nmi_enter() /
ct_nmi_enter()), so no use-after-free can occur.

Human review feedback on v4 as-is would still be very much
appreciated. I plan to hold off on spinning a v5 just for this and
will swap the check order in __synchronize_nmi() alongside any
maintainer feedback.
