Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC46394493
	for <linux-watchdog@vger.kernel.org>; Fri,  4 Sep 2026 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532693; cv=none; b=UJDZFjx5KNfofn5aiZyaJfdsfLiMmtaHYjXkXDDWtjLcWju7B/LYJWU7QWxMmNQVuuSlyt6iMslLxu5xI+dwTYRmtaA4Y9SSVBwdMjw7Ccpm/CMaY6haXlzABkx/RiGva2RqT1MjZ66zZiktmPil32rAKmmPbIKJHObZISJeck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532693; c=relaxed/simple;
	bh=JH7KvzgDb3hj1YazwEjzQhCEGqKDsL5tuzoEKmOZ7Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bc6Ajj0D0vxBOsCHM8ECcSBnWN6RMkal9NKc8lXQVT97K9hsoht9kBgBCckJPkjYGxIFYnEU8gDKWVYlaqpnrwcLfDdS1y6TaaXEYAuEDSiHEPAzWsrYRQtp6U62dOj+SLlB5JY10Rsc/NGBxbpPJDV9CjNCNRpTn0EPNPJa8Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oF4Qok5p; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oF4Qok5p"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a623987d32so1614752a12.1
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788532690; x=1789137490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=17oI+rSj+VUBq1gOiNZqYe2TLy7jpSRVJ40pUTx77t8=;
        b=oF4Qok5pjgnBOfFC0D38//kmSrl5iV8MHKBhnx/eiP5vKb2QcEFdtJN4M7+mK7el66
         36O7HGC3UAV6IsmfNepVlnbhoyiDBS7Rr+4HaP75Fa1QsoJRC0C7YYPHQcFKet25Hxzg
         gkMjD5c3hEZZQtj1dMxoGsMpLcIbjkZgdlSjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788532690; x=1789137490;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=17oI+rSj+VUBq1gOiNZqYe2TLy7jpSRVJ40pUTx77t8=;
        b=iYxfDY1axPePapxRMRMkwp4C0ouE3Uocy65YxGFm4PXQgN1FRnbXzAEiVEcGReec4k
         TXwyPUtZCy2FVEL81mx2BQQ/9sQXEPV5NpeZn0wkj6vPD5cvwP5VdenWT8hpJEw+k62q
         MDSxdrXjOG6jpa3gC1lxp61SuvZh7B5T0SnD59L5aQNdXv8rlyqDzuPFJxdM/eghqtsA
         h3ggKK9WMPMC1kZiGuicyVq+zybeGa8Hg5idXkeCIcFyC3vWf8jje4RB1+F5xoFGxAY0
         NtVALV67U5qVxk59l91i/Y3bPfpzcz5OBwI2Z0SUSBEcMEFOHPiQK7ZG/2WMROpF8dnM
         D5pA==
X-Forwarded-Encrypted: i=1; AKwUvBw0n03FOvA3MDW+MFOVyjjz0lZDnqS77KtDdl4ObPnI7vZeL2FZucw9ip+B0M3U974WMVabSq+j8MgR0tDyRg==@vger.kernel.org
X-Gm-Message-State: AFuF++nd5voy7aBEH9XmKrR5tLtsYlMdU6cbMHy6fyHGaqbXSLrx893b
	M6XERB1kCq6EY+ucJb6ruq9Cp8QDZM85c2JxAmJwIh3IEqJ+HBvCtjVKCJiNTjXucwNxjfSTI8c
	0lPI=
X-Gm-Gg: AYBFou0X8K5TVW078NY1+jbhRHvAxxNi+0DUj+VwR25QqvKxT13cpppyPG9JYgwbdDb
	S1F9TnD3L0vfdRx7tMiv7cNvFvqSytrTFs1aS2iFZxhL8kHjgM7UPyq+7CtQsGdk1o57xm3rGMX
	Qpi0idI6RnOx5GP/45+Jah8MAE7H38KjCYdg3fYuC+yt0ioJILO7YFBks4BeqAsXoBc9wWuyPEC
	RHwgZOeaLohSZv2tbBB7NfseRK2tnFOgaQlifZ73P7XgtWy2Z7IHJoqDro02m89LK1e7AWCmcGJ
	piRgjZ9bkeIC0YVFSP5epzSQJY+KHQ5YRM/dM1ryf2OUPVyBDJGR7SzCuycG1edk0smm/+g401r
	1tO9cXkGRTebkcjgNIjn9Yx8Vay41EdbNaqcHMh2pfve6Yvuw77exFmc/ob+S6ABD52jXCqcYLl
	M+xWGk0D+36p8hYZFrSUEqi1zuFjsWjlRoabikijTGedgFTpXJnvw7aoiwmHpYoB6mEJPNWB2Se
	OTr69KKWsquHMvc3O7iylV24jI=
X-Received: by 2002:a05:6402:13cc:b0:6a0:a4ce:1b8e with SMTP id 4fb4d7f45d1cf-6a7e85e4b59mr2193597a12.0.1788532689566;
        Fri, 04 Sep 2026 07:38:09 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68e8c77sm1202613a12.17.2026.09.04.07.38.08
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 07:38:09 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4858303de5dso1347537f8f.2
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 07:38:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByj2T8rwRWGndKE6Rd9PLGwYj7T5sIYkSiCAJWZ2Fu+rbheI6qjcR2V4TpUz7lyL0yFAVrpxXff2UDa/W3sag==@vger.kernel.org
X-Received: by 2002:a05:6000:4a0b:b0:485:8c16:a32e with SMTP id
 ffacd0b85a97d-4858c16a585mr3711212f8f.35.1788532686831; Fri, 04 Sep 2026
 07:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-5-f3999362a9ea@google.com>
 <3de593de-6851-4a53-8309-a6bf13e9a8f7@oss.qualcomm.com> <CABz7rdBv74pZe6jDRifTKRAKzGZB6L08n81_0gCqF0g=s+FEcw@mail.gmail.com>
In-Reply-To: <CABz7rdBv74pZe6jDRifTKRAKzGZB6L08n81_0gCqF0g=s+FEcw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 4 Sep 2026 07:37:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUyQ4F-HC=cmD9Ay-JHcWJCVDc5BSWRax7a6FRJ_v0bQ@mail.gmail.com>
X-Gm-Features: AcwNN1Wo5IR-SJM2QYyqYIK33CmEpWmvlDIs54NEnTFP7obdj1kaNXFucZN0GAE
Message-ID: <CAD=FV=VUyQ4F-HC=cmD9Ay-JHcWJCVDc5BSWRax7a6FRJ_v0bQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] watchdog: qcom: Register pretimeout interrupt as NMI
To: Mayank Rungta <mrungta@google.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 3, 2026 at 1:58=E2=80=AFPM Mayank Rungta <mrungta@google.com> w=
rote:
>
> Hi,
>
> > > When a system is completely unresponsive due to an interrupt storm or
> > > deadlocked CPU cores with standard interrupts disabled, a standard
> > > watchdog pretimeout bark interrupt will fail to execute, preventing t=
he
> > > pretimeout governor from capturing CPU backtraces before the hardware
> > > reset bite.
> >
> > [...]
> >
> > > -                     ret =3D devm_request_irq(dev, irq, qcom_wdt_isr=
, 0,
> > > -                                            "wdt_bark", &wdt->wdd);
> > > -                     if (ret)
> > > -                             return ret;
> > > +                     wdt->irq =3D irq;
> > > +                     irq_flags =3D IRQF_PERCPU | IRQF_NOBALANCING |
> > > +                                 IRQF_NO_AUTOEN | IRQF_NO_THREAD;
> > > +
> > > +                     ret =3D request_nmi(irq, qcom_wdt_isr, irq_flag=
s,
> > > +                                       "wdt_bark", &wdt->wdd);
> > > +                     if (ret) {
> > > +                             /* Fallback to normal interrupt if NMI =
not supported */
> > > +                             ret =3D devm_request_irq(dev, irq, qcom=
_wdt_isr, 0,
> > > +                                                    "wdt_bark", &wdt=
->wdd);
> >
> > GPT noticed this IRQ is requested but never enabled (NO_AUTOEN)
>
> For the NMI path: request_nmi() requires IRQF_NO_AUTOEN. To balance
> this, enable_nmi(irq) is called immediately upon successful
> registration in the probe function:
>
> For the IRQ fallback: devm_request_irq() passes 0 (not irq_flags). In
> __setup_irq(), when IRQF_NO_AUTOEN is absent, the core calls
> irq_startup(), automatically enabling the interrupt line as it has
> always done in mainline.
>
> Both paths are therefore enabled upon probe.

I wonder if it would make sense to either:

1. Rename the variable to 'nmi_flags'?

2. Get rid of the variable and just directly pass the flags to the request_=
nmi()

That would avoid the confusion. While I agree that your code now is
correct, I can understand why GPT (and humans) would get confused...


-Doug
