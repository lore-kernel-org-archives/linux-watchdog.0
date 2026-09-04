Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E004E66DE
	for <linux-watchdog@vger.kernel.org>; Fri,  4 Sep 2026 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534023; cv=none; b=FCfW/Giob/kSSY8pAJXfkP+nYg+Yakhcr/UI5nQ/Azji7fwpuLyBWGFGK6KYHBD26nFcOFss4VQBYYGn+QEjaktgoDTVz/daqRBvG7+RRLA0mElDBoCKTAeyT9EI6v9Bk0omp/Aoegl/wHq/wFJQhkjbYBEHjSbThrT0xWD52ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534023; c=relaxed/simple;
	bh=m6woJE35uAQXcaorYQsjjoNm1tJ3wemg4GwQSTR1U+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5poTerO7+2TWYpeF35f19GKsvYRAQWuQV9q/0LTEBVcDZAXI5BvL6ruvootfAXiuTi1drw/HAPFxEe6EmgGh62VjbViM2xoZ0rfnR/wrkyBKhEA9Dqq16WwF/ZTZDm/Ama9XD43DSojXpdbWaG0NjME0MqyJr33yeq83MkHkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NZ29+Kr+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NZ29+Kr+"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a68aaf4840so2546094a12.0
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788534020; x=1789138820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m6woJE35uAQXcaorYQsjjoNm1tJ3wemg4GwQSTR1U+M=;
        b=NZ29+Kr+KVMCcIcWfnK/uuym8tlNSnEgJI/y74kZS2zKkurP8rY3HC0vfBFQzU72lg
         fvlfcfupqbuVn12Xe0SsiYusNx4my78KMyzlQ9Gz6uc/yC2yE3K56RF2AmMof03kBMss
         gzXSWVBVhToeCZr+O53G1M/7zBeq8gN1ovpCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534020; x=1789138820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m6woJE35uAQXcaorYQsjjoNm1tJ3wemg4GwQSTR1U+M=;
        b=bzYPwMSNIadRmZMSC6PB97o45yOsmnAPg94NMAisnXJQ2CjNime0CZ1fsmrsH3vghw
         zmHWbeQM7zidEpmgg0a5YkEDIqURHBaMyVsSXEueVOhxCzU87oTxzQXKpo+cv6QvjZZo
         iIU5swY+uaDPAggY1xOIcMd9yd8xmnD9j7zAnJQEg+AVXLig2LrWuOBRbeKvhKZKXBpM
         GR/Tflt3BiIRu1ovLw0w7TfbyKGEQ3lyzHcp48qbVrOpl57+IBfwHiYAxhGi16UyGiC8
         2j+LfjUgeIJFOfhcMZVHzIXPBmj4fBos9SKVhfRdf+vzsXkTmIswZ2iIQdlS4wP2cRXR
         7lvA==
X-Forwarded-Encrypted: i=1; AKwUvByGVGheSxQgbpzmlQaC9wgL8DP+ggxRoxyagffDv9PxW4/j2X9bHlZ00A2Q6PBkD3RFK3PRPQ8bb0xTJZAO4g==@vger.kernel.org
X-Gm-Message-State: AFuF++kLvb4girZTgQdsnIsLm8ADif2t+ThRx09/ZR1rpjw1URBbgXvA
	EOTvOjXveM8mPzeANG9qfytCIh87QIKI0KCgiyBjFeErgVebQvLG8MnBZJDgAe/d+xodbw1zLxh
	6w1M=
X-Gm-Gg: AYBFou2F7XRBi90K0bCPVJh5+pxVb24RSta9ac8nm0QolHnwF3hCHBV9VHCpSZjYqmH
	VfCwZUwn9b6P+JhyE/Wv15UeYzNi7jNfIcS00viyhx0196ZLIK3e/Vus+QLt3NbAb5y94sxdIB/
	4EVzCmP81vPQ21sstRsd++2eksNFkWrAx0xBYxw3YPNUdxhMuiZA0j0AyUxX/t1gwJlOnonoqUn
	5f8T0u+tWlXEc3xve0rd0WyDM/xWxD8qqvag2tE4hw7H/xYYjo0jL+vHzu1BkDdRduqKtAZhXFs
	YFptCnG1qxhH/3FrGkvRK464BqrAfVPg9jgmxqmxn5knephZUhVatbJFPDJFxdI4z0u90yV/BgT
	E6AtdSbJ7tmvgWFdpb7eRCj2n00XPKzU0MMYNhoC8SEAz3FtwRTjNYU6iHGlqv5qnQ/8W1matQY
	F6LnMuNXVtEpUi/9gYmDXkSQ2Q2TphMdRFXMs6kYI0AQ2VqKx4vk8GcXlER7eXpY1PtBv9aLYD3
	J8PwuESOjDFDKCM5p/jsCceQhM=
X-Received: by 2002:a05:6402:a252:20b0:6a6:9368:73a0 with SMTP id 4fb4d7f45d1cf-6a696a73aa1mr4092163a12.6.1788534019819;
        Fri, 04 Sep 2026 08:00:19 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68e9679sm1248453a12.20.2026.09.04.08.00.11
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:00:12 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4843e397f74so1363687f8f.1
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 08:00:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxQ3d6VrUtfEq+cksf1aQ6e91WMQRX/vhSFBVgO5n3OeqHzykHFiu6Rmm7EU3eTcd+Mku07CN9b0MxcvvWWCw==@vger.kernel.org
X-Received: by 2002:a05:6000:4543:b0:485:8ee0:dfd0 with SMTP id
 ffacd0b85a97d-4858ee0e180mr574723f8f.6.1788534009667; Fri, 04 Sep 2026
 08:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-1-f3999362a9ea@google.com>
 <87fqzp8jex.ffs@fw13> <87wlt13zj1.wl-maz@kernel.org> <CAD=FV=ULeHqEZE-a9vV9F6vVMLVBPDTeXTgnmU_Bqui8sc1ZZA@mail.gmail.com>
 <87se3p3vzs.wl-maz@kernel.org>
In-Reply-To: <87se3p3vzs.wl-maz@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 4 Sep 2026 07:59:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WSpwYJ5=xTA7qWh+iwp-PdSXn0Ucboejq8yF5buyH4-Q@mail.gmail.com>
X-Gm-Features: AcwNN1UNb-ET4q9cT4xesT3CWAaiu4cvwQTslKfaw_0TzhZI43afTLmag298Cu0
Message-ID: <CAD=FV=WSpwYJ5=xTA7qWh+iwp-PdSXn0Ucboejq8yF5buyH4-Q@mail.gmail.com>
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

On Fri, Sep 4, 2026 at 7:54=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote:
>
> Hey Doug,
>
> On Fri, 04 Sep 2026 15:34:12 +0100,
> Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Fri, Sep 4, 2026 at 6:38=E2=80=AFAM Marc Zyngier <maz@kernel.org> wr=
ote:
> > >
> > > On Fri, 04 Sep 2026 10:17:42 +0100,
> > > Thomas Gleixner <tglx@kernel.org> wrote:
> > > >
> > > > NMIs are strictly per CPU interrupts. So how is this supposed to wo=
rk
> > > > correctly when looking at irqchip_state(ACTIVE) ?
> > > >
> > > > Marc?
> > >
> > > I have no idea what this is trying to achieve.
> > >
> > > This can only work for a global interrupt, not for a CPU-private
> > > interrupt, since in general you can't observe the state of the
> > > interrupt on another CPU.
> > >
> > > My guess is that the OP is trying to trigger an NMI using a global
> > > interrupt, which we never intended to be supported. That's not to say
> > > that it cannot be supported, but this patch seems to be breaking the
> > > core use case...
> >
> > The overall goal is to take the watchdog bark interrupt (which is a
> > GIC Shared Peripheral Interrupt) and promote it to NMI. An example of
> > that interrupt in the device tree for one Qualcomm board:
> >
> > interrupts =3D <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
> >
> > The patches in this series seem to accomplish that. With the current
> > arm64 pseudo-NMI implemnttion, requesting as NMI just bumps up the
> > priority of an interrupt to "NMI" level and that works fine on SPIs as
> > well. On arm64/GIC interrupts are routed to a single CPU anyway, so
> > requesting it with `IRQF_PERCPU | IRQF_NOBALANCING` didn't seem
> > absurd.
>
> Not absurd, but the implementation as suggested has the potential to
> break per-CPU NMIs if you check for the active state on the wrong CPU.

Ah, got it. So if someone decides to call the synchronous version of
disable_nmi() for an actual per-CPU NMI then it would go boom. That
makes sense.


> Also, checking for that state doesn't mean the kernel is free of
> reference on this interrupt, as you look at the HW state, not the
> kernel's.

OK, fair enough.


> > The biggest problem we had was properly cleaning up the NMI at module
> > "unload" time. To make that work, we needed a way to synchronize the
> > NMIs to ensure they were quiescent before the module was unloaded.
> > That's what this patch is attempting, and is mostly attempting to
> > respond to Sashiko feedback on earlier patches.
> >
> > I don't think Mayank is tied to any particular implementation and the
> > overall goal here is to allow the watchdog bark interrupt to run at an
> > elevated level so it can produce good backtraces even if all the CPUs
> > in the system are locked up and the buddy lockup detector doesn't
> > fire. Is this something you think should be doable? If so, what's the
> > best way for Mayank to go about doing it?
>
> The only thing I can think of right now is some equivalent to
> IRQD_IRQ_INPROGRESS done in a lockless manner. It doesn't have to be
> atomic if you can guarantee that it is checked on the target CPU only,
> after having disabled the interrupt.
>
> But this is rather ugly, and I'm pretty sure Thomas will haete this
> just as much.

Thanks for your insights! Hmmm, maybe it makes sense for Thomas to
weigh in before attempting this. ...or perhaps he has some other great
idea that would make this work.

-Doug
