Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504DF38AC9A
	for <linux-watchdog@vger.kernel.org>; Fri,  4 Sep 2026 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532475; cv=none; b=BRPvJEMwqNiWKAqBYSnDTlZZc/u3S+Ccopp0mzadlPDxyiN/g12jUgkE6Yjt9lK4tiIvg2UZfeaBJxcc4xIpqz38mT735wzN0PwA9xMVpBBMt8rDlw6zFucJ/E43jtlkWkbrpFQfu81e9J4yWoYMZLnYp2hw46qX0PbAWs0W1iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532475; c=relaxed/simple;
	bh=iwANdAqzga+zM/yuSu0exzs6VE5a7yEytpMIJzjLBcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIhKWUfd9IELKZrFYO+5T3iDO5l9sr1bDnH4J1vmelLIPdauk3uVbWhQ08eElhrV2tCs1AYrkSWEIxWGQ15i7e6/T0NYjVTaZJzdaJ/XaHWQRxnlADCrV+YUxfqWIKRHlHQfd8bQDlzisANZT0UGr8PNAJWghI50Lnw0YCmUc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oXRqdZEO; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oXRqdZEO"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2531f453eeso142179566b.3
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 07:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788532471; x=1789137271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ck7BSWkkXwWvroZN1jbW0sU0ReXY/y4Y6ENpLqokqE=;
        b=oXRqdZEOfYyYPi2iKjTa4er9gO4ge2Og0W6LYjns9thRKGBFYkSxp2fYL0ns239gAc
         URPTTb0FIuR08wioB4QUj6AfVZlUqUHpN6A2P6VxWT9Gk+c7FEK3+I/2mExILpYGz12h
         v1iGZh6aD6pQHjMo5xe3u2bhLSQS8mXPW/YXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788532471; x=1789137271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ck7BSWkkXwWvroZN1jbW0sU0ReXY/y4Y6ENpLqokqE=;
        b=a6v6H/bSYM3+51l0Moz484fkihToHBqpKwARUQdZlBzfyUaX3P4tr9ov/pSl7cWJsy
         VKDjMv7LgaP7ziXL0Jxoy0hVLrAfPGVKrpjGahdkfkUw9PaLmvxcyqS1+z+IShs/mUvP
         C9SfzGR8QJOv6F8MsA6IgptP9gpTqtfhK44dwh9IJ/ZllZZfso5AedR8PUkz996fExNL
         I2byKVawp5wGLsGsJcfKrkWdVkz/5xdBhVO+LZrTTkXkvCJvkAyYsuHSQjyhvvwN75ta
         OmgxXsiqH01DHeT89bjkXqeB52ksQbyw4zzc/ApHzZl2cTDtvcLvaDC2FLINa1m4j4Ek
         J0bQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNkjlLJP6CRor1i29Gu05DT2OrQex3GOT/N9PuMbZbJAmX/Ksq3FSeTy3jqq00hXbk7PFqyKNYqwCm+4wR4Q==@vger.kernel.org
X-Gm-Message-State: AFuF++l80Wk570hs+T2GGW/MH5vrNPwg41M5Gu5pmMNbYZ0lEHZNXiFX
	o7tMkRTNUhyo+5+0NLx5EUO5E3jtH7ryCf201No8+x5h8taTsLgNdp/Tp72Ek9IhcoLgpB7Jg8P
	uhxI=
X-Gm-Gg: AYBFou3/EAWtfaLn75NBgSq1+CyiZwjYSDI4r0ylNtyTebo+hMzsDazLUzCXhSdkwv1
	7BE/qoputUCJpgp+pCF7kQPk0QeHX9IAlQhTDbOLlmS4n1pibSqOdEQUs5SYM6SgHKgGZ6Ye3Qu
	+KHslueTQ+AYMu1FLR9OUqf18dkV45+WFNoUcHdVk+Nl7fChh/M3L2xY/Dpan/1C4mMFEc6nmVO
	kEoHPQ4f/pcGc3aTJCsGhcnxxicbz1Xl6qshJMemEpYQTDCCEnFbPFejbNLD0Dd+vLo+dot3n3y
	06XX4q9s5zIWmz5OZ7dUdwatEhYQGiFJaPq2Y3bHIHxwO4VDZ4GZLp+ljj2K9PQIj5cEmxeK96a
	OReIQHt+ExA7DqJxL6bAx9KWnd51CT+WWlsr2ZxZNs5m7ADGxoZlMX5dfBsBXMuObkNF9M9jMgX
	K74QOXi4LfM5aFiWZG01X4LQjhN7JcHLFcWVnhYKMfDjt87Q8dVPaU4I4D43GmkhO6PsCT8s9+F
	2po1tpGl++hh85cUxnXp7iKQUU=
X-Received: by 2002:a17:906:c116:b0:c24:b11a:470f with SMTP id a640c23a62f3a-c260c4494f2mr399798466b.0.1788532471342;
        Fri, 04 Sep 2026 07:34:31 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c261f673000sm39910766b.24.2026.09.04.07.34.29
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 07:34:30 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49cdc81f40eso7452055e9.2
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 07:34:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwaRTs1LR5RW6K13+jTeBg7/v5Jr5KxODGlOoaQlcQgzNdKtA6O3fyCuIp8ZuDvGB73O5Qra8q8PJdbIUCO2Q==@vger.kernel.org
X-Received: by 2002:a05:600c:6087:b0:49c:d52e:d0ea with SMTP id
 5b1f17b1804b1-49cf81e3454mr116251535e9.4.1788532464702; Fri, 04 Sep 2026
 07:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-1-f3999362a9ea@google.com>
 <87fqzp8jex.ffs@fw13> <87wlt13zj1.wl-maz@kernel.org>
In-Reply-To: <87wlt13zj1.wl-maz@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 4 Sep 2026 07:34:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ULeHqEZE-a9vV9F6vVMLVBPDTeXTgnmU_Bqui8sc1ZZA@mail.gmail.com>
X-Gm-Features: AcwNN1VrCYtMK0FuxIEwY-YB8TuqCWsz3J5Ntif2-4hFkWwShLrXdtkOdhxnO4s
Message-ID: <CAD=FV=ULeHqEZE-a9vV9F6vVMLVBPDTeXTgnmU_Bqui8sc1ZZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] genirq: Synchronize in-flight handlers during NMI teardown
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Mayank Rungta <mrungta@google.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 4, 2026 at 6:38=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 04 Sep 2026 10:17:42 +0100,
> Thomas Gleixner <tglx@kernel.org> wrote:
> >
> > On Wed, Sep 02 2026 at 18:54, Mayank Rungta wrote:
> > > diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> > > index 2fbff2618a1e..a9973b61163a 100644
> > > --- a/kernel/irq/manage.c
> > > +++ b/kernel/irq/manage.c
> > > @@ -1379,6 +1379,14 @@ static bool irq_supports_nmi(struct irq_desc *=
desc)
> > >     if (d->chip->irq_bus_lock || d->chip->irq_bus_sync_unlock)
> > >             return false;
> > >
> > > +   /*
> > > +    * NMIs cannot set IRQD_IRQ_INPROGRESS because they cannot acquir=
e
> > > +    * spinlocks. Synchronous disable and teardown require querying t=
he
> > > +    * hardware state via ->irq_get_irqchip_state().
> > > +    */
> > > +   if (!d->chip->irq_get_irqchip_state)
> > > +           return false;
> > > +
> > >     return d->chip->flags & IRQCHIP_SUPPORTS_NMI;
> > >  }
> > >
> > > @@ -2034,11 +2042,20 @@ static const void *__cleanup_nmi(unsigned int=
 irq, struct irq_desc *desc)
> > >     struct irqaction *action =3D NULL;
> > >     const char *devname =3D NULL;
> > >
> > > +   guard(mutex)(&desc->request_mutex);
> > > +
> > >     scoped_guard(raw_spinlock_irqsave, &desc->lock) {
> > > -           irq_nmi_teardown(desc);
> > > +           irq_settings_clr_disable_unlazy(desc);
> > > +           irq_shutdown(desc);
> > > +   }
> > >
> > > -           desc->istate &=3D ~IRQS_NMI;
> > > +   /*
> > > +    * Ensure all in-flight NMI handlers on other CPUs complete befor=
e
> > > +    * clearing desc->action or tearing down NMI state.
> > > +    */
> > > +   __synchronize_hardirq(desc, true);
> >
> > NMIs are strictly per CPU interrupts. So how is this supposed to work
> > correctly when looking at irqchip_state(ACTIVE) ?
> >
> > Marc?
>
> I have no idea what this is trying to achieve.
>
> This can only work for a global interrupt, not for a CPU-private
> interrupt, since in general you can't observe the state of the
> interrupt on another CPU.
>
> My guess is that the OP is trying to trigger an NMI using a global
> interrupt, which we never intended to be supported. That's not to say
> that it cannot be supported, but this patch seems to be breaking the
> core use case...

The overall goal is to take the watchdog bark interrupt (which is a
GIC Shared Peripheral Interrupt) and promote it to NMI. An example of
that interrupt in the device tree for one Qualcomm board:

interrupts =3D <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;

The patches in this series seem to accomplish that. With the current
arm64 pseudo-NMI implemnttion, requesting as NMI just bumps up the
priority of an interrupt to "NMI" level and that works fine on SPIs as
well. On arm64/GIC interrupts are routed to a single CPU anyway, so
requesting it with `IRQF_PERCPU | IRQF_NOBALANCING` didn't seem
absurd.

The biggest problem we had was properly cleaning up the NMI at module
"unload" time. To make that work, we needed a way to synchronize the
NMIs to ensure they were quiescent before the module was unloaded.
That's what this patch is attempting, and is mostly attempting to
respond to Sashiko feedback on earlier patches.

I don't think Mayank is tied to any particular implementation and the
overall goal here is to allow the watchdog bark interrupt to run at an
elevated level so it can produce good backtraces even if all the CPUs
in the system are locked up and the buddy lockup detector doesn't
fire. Is this something you think should be doable? If so, what's the
best way for Mayank to go about doing it?


-Doug
