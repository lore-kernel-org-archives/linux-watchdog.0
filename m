Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBDE4E80B0
	for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612094; cv=none; b=RrREja/h7IPnu7BUznYPMs+F5ALXYvQCJd0CDuMlXfLpAGCiqfJSLIoDqN7QQLzf7fHCHZlT12/58oxh0sjwoPnYcCLSnFEnjrTrjybhaRnn5zkpr/qDMe1NbADKGNJuJRRgEYCR6GAl2mKzqL4JE6QY02R1jahbmW9aZMZrVAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612094; c=relaxed/simple;
	bh=HGCq3zgoP0saYvNcEo4pPaH65XFLhzGyGOi+d0Mq0XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwcnUtVBuiA845pWbLsgIkKbHRpuDLWIxDxBZh2ATYyXiiaY2onIZAeAp8p5zOPvRaWhRUpZfxOxKcnbnYOEuay05EAgz1+3E3NiHa0Ccmi5MNrsVdHHWZtn5uKRCDnu/UsoFuNwUJ8eUyFs5OR3RgA8Xq9FlnisuezdNbr1VZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ICgcKtH4; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ICgcKtH4"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af7721e4aso414022166b.1
        for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790612087; x=1791216887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5i0eNwNQJ7C+ZbxkaslWCixtSKQcLs6enIs7bxdCR/o=;
        b=ICgcKtH4lgbQifBU/GlEw+4yOZS+qmSp6fhJCs2f4aFuobfpVIYwQiwTwM458JqqNm
         1YOBxIVqfruDBpdGiRntaAC/Z2nrcu5n+srMwZAyxPxrGQzXeKUIsftRTs0JNBKdcD9V
         SFOcGgOTGPRyce/UioMqnTvqz4/TRqN++2QBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612087; x=1791216887;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5i0eNwNQJ7C+ZbxkaslWCixtSKQcLs6enIs7bxdCR/o=;
        b=hnKeN+8DJuNo/4hotiJ8Lrf0JrSVLf5s2FQ+OHbeYI05BUiNX5XjO8iV/bGs7N5AXw
         rDlujPVbbYM3WX3ZoUfe6qZhn61WFxtbSH5VNE1mOYiARD6V4nyVSGHlPtPqGPKpgkFd
         ElBxFsUGG1sFTMpv7ruBwTQrz3ZM8mfa0/pYe1418yPrGmH/Uzx5G9Pd/rPLdO0pXG2d
         apTayHlQFFPJZg5zbLbYjkssLPa7I/Nvvx0PfArt7Lfm8lnwapOdsNAfqOCvYuoWWuRQ
         fwo6cBnK9JxUU4ruNKZzs4ySJlGmv19Ibfmjp2k9N41PEGT0X0bPLc3acq3CHrCD+oOG
         OBcw==
X-Forwarded-Encrypted: i=1; AKwUvBwieqRm7YDwoj7XG67X7+zeVqfDp7pVAhL9VRX/RqjM3kO1tXhVUoIz9E2OtIWXpIbTn5pRClnZ+EEDYjSkEg==@vger.kernel.org
X-Gm-Message-State: AFuF++m4zvbVvUNhFB1BcTBff9XWZXjixtJOaVQeftdwNjrP3JukRqRm
	45Hcw4Y3gP1v1n9abTwO6seu+OaPhYyQnE53QmfRhKZrvUuxPRWNmT7dc86LBaNY9BgI5MHOp/G
	74Y4=
X-Gm-Gg: AYBFou1TL1yWJ8uRsxZLqcYRvDgR08rWDQ5Yto+lisdx8A4STru4jSDpKmNcEu7xA+x
	XZWkrvX7XbniVRTgCeHngnyA3jwgniH7AwYv8+qms4wnnyzOAv7U79ufjdkF9Sq8fUPiBe4dVq4
	Hwn9Sqg3GFrQaXY7Zf7fExR1T/OQ1t0UpgXr8xwJWzYqKb+E6xD9Szlc/l+9uobYg4zvt3gA3D3
	4T6kWEBqUJ+eybsTa5FLfmrgpHaaFkZYW2JwIcuYL+rewnVLRmmJlbm/oLsdcU7evD6c88rE1yL
	e0veL4Zwx7nzR0a35rfzpQPPFCGDThBUiUR3vn/trBwt/On7MzuEsNjNaPlzKvvjlCVAQ7qVsOO
	ZuJKqm1UVwkHpanEFR2ebtrACrzEI2KDef2TXfG6VITLUo7PW9x1nbudGIyFA8VgnG5xD1nzaJE
	V0enaYCA2j+MAp95PxsncC2s2A4Ed8fuODqUX9hqpEOfqJxklcfbtomOwkNU9UNdoaWwELA+ksY
	KygvTFrpI3IgU5+sTQVkjQpByE1/iko1y4+aIk=
X-Received: by 2002:a17:907:e8f:b0:c29:63f2:99bb with SMTP id a640c23a62f3a-c2ac26820b5mr1280939266b.47.1790612087487;
        Mon, 28 Sep 2026 09:14:47 -0700 (PDT)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com. [74.125.225.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76a68aasm482856766b.35.2026.09.28.09.14.45
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 09:14:45 -0700 (PDT)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff23af865so25722465e9.2
        for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 09:14:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzuXt1FoHwJuqL+xBipiy3qUzL/zBSx1szX40Z5Equinx2+1R470Z4AlI+xuTMk+KBOG9If9q/wCBvgYy9xqQ==@vger.kernel.org
X-Received: by 2002:a05:600c:c090:b0:49f:fd33:ac4e with SMTP id
 5b1f17b1804b1-49ffd33af46mr85097415e9.9.1790612084535; Mon, 28 Sep 2026
 09:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-1-f3999362a9ea@google.com>
 <87fqzp8jex.ffs@fw13> <87wlt13zj1.wl-maz@kernel.org> <87v78l6oha.ffs@fw13> <CAD=FV=Wdqn7UiuRy1VY-qH+JYChLTEQgmj2q6Q=FBjCZ+5eo1A@mail.gmail.com>
In-Reply-To: <CAD=FV=Wdqn7UiuRy1VY-qH+JYChLTEQgmj2q6Q=FBjCZ+5eo1A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 28 Sep 2026 09:14:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WE-Wn60zTn=nsq4qLis_zjncrS37fND6ehtpuvxYp+DA@mail.gmail.com>
X-Gm-Features: AclHuK9ETuB5rRqTFzisUXaxD45TKAx4fN5yt-CUafFgLF-sfb5ypJ_KbGWMJDU
Message-ID: <CAD=FV=WE-Wn60zTn=nsq4qLis_zjncrS37fND6ehtpuvxYp+DA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] genirq: Synchronize in-flight handlers during NMI teardown
To: Thomas Gleixner <tglx@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Mayank Rungta <mrungta@google.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 4, 2026 at 8:26=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Fri, Sep 4, 2026 at 8:11=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> =
wrote:
> >
> > The driver change is here:
> >
> >    [1] https://lore.kernel.org/all/20260902-qcom-wdt-nmi-series-v3-5-f3=
999362a9ea@google.com/
> >
> > >  @@ -311,10 +321,25 @@ static int qcom_wdt_probe(struct platform_devi=
ce *pdev)
> > >                if (irq < 0 && irq !=3D -ENXIO)
> > >                        return irq;
> > >                if (irq > 0) {
> > >  -                    ret =3D devm_request_irq(dev, irq, qcom_wdt_isr=
, 0,
> > >  -                                           "wdt_bark", &wdt->wdd);
> > >  -                    if (ret)
> > >  -                            return ret;
> > >  +                    wdt->irq =3D irq;
> > >  +                    irq_flags =3D IRQF_PERCPU | IRQF_NOBALANCING |
> > >  +                                IRQF_NO_AUTOEN | IRQF_NO_THREAD;
> > >  +
> > >  +                    ret =3D request_nmi(irq, qcom_wdt_isr, irq_flag=
s,
> > >  +                                      "wdt_bark", &wdt->wdd);
> >
> > Of course this is a regular global interrupt otherwise it couldn't be
> > requested normally. So this sets IRQF_PERCPU (it has to otherwise
> > request_nmi() would fail), but that looks like a hack to me.
>
> At least on GIC, promoting a regular global interrupt to NMI (or
> pseudo-NMI) level is possible, and Mayank's use case here seems
> legitimate. Any suggestions you have for making this look less like a
> hack are appreciated! :-)

Throwing an extra plea out here to see if we can make forward
progress. IMO being able to make watchdog driver "bark" interrupts run
at NMI (or pseudo-NMI) level is an important thing to do for
debuggability of the kernel. It sounds as if there are no general
objections to the idea. I guess the next step is to make this look
less hacky. Is that something we could send patches for? Any hints for
what you'd like this to look like would be greatly appreciated.

I'll also be in Prague next week for both Plumbers and ELCE, so I'd be
happy to discuss this in person if that helps.

-Doug
