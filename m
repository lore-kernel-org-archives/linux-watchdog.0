Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570173E92BB
	for <linux-watchdog@vger.kernel.org>; Fri,  4 Sep 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535602; cv=none; b=RdilkYNrGGIaKs1iJBjgsmEy4AN1SKoO0Tf0DrqMMtaZCKxdFWPF1zdgfzRtK4GB1HaFPJq3IpJ+VGB9lK1nXBk4RpE0nzcmh+W2pIxTZYGiakBex12KRcuvNWBju2AJ8vA5C1SzpB1mVs8MUiMm1bjf37t0bfXHSge0oT9fAD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535602; c=relaxed/simple;
	bh=qNnNX/36mqoUdlV2+0R6ltbvZcLwzDeDWBL5FNc5Cio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEJpti9A2Ao9XaoZQoCeXyHP+ngJDi/H3fvwbr5P5lgVctJFmRsvU4fCreRhhtYeAX393hNtugjFAnZ92+WHNh2fyfXIkrCs56ciDT8Wt9Z6dvNdrhfVqMwP1lNEQ83H/P6iAW6mDnDTortQEk2C4IQioSGWWhYLZ80VoQxNe/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VxhmsXUl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxhmsXUl"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so111020466b.1
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788535599; x=1789140399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kxdc8UCOdo2zUrsNltwRqDpZNcgqltscYU0aNpNuXNI=;
        b=VxhmsXUlZpFtw4BfcahxcJaeAsDY/T82jq8lX2duuVqBVhup0qcYp3ebX2GH8yL7G8
         ZUz+mNTzruzwtOMBQGOKGM3rQGv+Ni7BZC27qvmObik9IqS0goH/WsuurewOPqiSx6OF
         Z7bT9aRRjNFpX8BRcy10FpVN8eO9Yp3PlmQC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535599; x=1789140399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kxdc8UCOdo2zUrsNltwRqDpZNcgqltscYU0aNpNuXNI=;
        b=OliodjhxDQ4NLO4SoDvheID8Bm/M7ACHOcbcR7fwTzIQEPnv1KNzyHYozfY3A3kkts
         v1Y2H+59fiKR13hfsZMJnQEdasQrkmNBEOarsw/TLAVRrmw5rDJnhmx+mV50SvvBTY6s
         dNKZ7jEQBh+b246ac9AOhPIjZDgIt0ausx3rMU1PJ7tFgeFgzimT1Ppb5+JMXqX9w9kC
         wPvwwA1/zqKWWS9Gwk4RL6VgQF5DTaMNMNYwXWemj0k030IMwCOUSMobYW+rV9bQhzS1
         nGFi2eTMyzfQ13WMGEGV6jp9hDP9kOlGyT6fFqO4Sh+GOAfa2EPClZJCp14oeC2SsVEN
         xf5w==
X-Forwarded-Encrypted: i=1; AKwUvBwgcoMdFWpsN6qjIMGBtQXqi6kFVVat6DG88VRRhyAS9jhEfP4Ejoefb1f4ILMDLr5rJerO0Wuyrx8fio0o7A==@vger.kernel.org
X-Gm-Message-State: AFuF++m3oXDDXLaTz/T7yt1IX+4xZrXshfdi4aa3HWDc8ILh7r8Jlcya
	HEXB2IrBTok4hQiNJY+kmt2dHoSSmztEWdlTMAmAvYlvir9z3pPgnkgrZt6yo5uj8iWRjBE0FK/
	qrI8=
X-Gm-Gg: AYBFou3Y94fa1v197kfG+lJa7b1WP64oOCGUsu4HLTdCd4Xgh0UK9p3COcWMfbNcx6i
	ig9r6OKQ7DXuzhi298ahEc8+k5JogYUNVy2wrv+w9P0/6VIJJnWcz840xQGUe3ce9XLaw5u4R4y
	HXUtXjXC/2+/k9SJAA1sEbIigEN67PfOICX7Txse4ree78syR6NoReRpApH26RVMmytn6dSn0cY
	Dw4PLT7psyyMzFJEbCm3UNi4ZGSMupGgFurSmurJAlIOXB5gxJfcFvY1nPITS/awIuijkidh4Km
	jIHyx7i5dxRd9wcHhm6npt7mUDfy13GQnP5wZ8VdXxXZC4Y9GyscSZF7t238xqzOTKSUK4DS4xR
	SPbID3ctrH+YTsrwJtmqnqve6dGz4aKVo2LRWEj4QTuNa4Qx+cyX9roA5HXg9Gvwn3gDXo2mJHR
	P0+Kt1EMMRTaZJ4I0O1o7DcsCuLQfKZYdk4d25ew2WywvV1S5BBFCRQgk+WFaQkop/hu8CRX91w
	DycoDHou6hc/ZXIFF39CtURwcQ=
X-Received: by 2002:a17:907:9405:b0:c25:5344:43cd with SMTP id a640c23a62f3a-c260c7aaa69mr294398366b.7.1788535599450;
        Fri, 04 Sep 2026 08:26:39 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4aa01dsm126224166b.15.2026.09.04.08.26.34
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:26:36 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4858303de5dso1422130f8f.2
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 08:26:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzNYszgN/cgmQdsUgrqgr3/rcrkxSP0wcwi1C3kpI43WE/97fq7CexJZrlz06d+yl8nDqumTY80r7TUsGRA2Q==@vger.kernel.org
X-Received: by 2002:a05:6000:471a:b0:484:3311:3176 with SMTP id
 ffacd0b85a97d-485872899a7mr10104340f8f.23.1788535593276; Fri, 04 Sep 2026
 08:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-1-f3999362a9ea@google.com>
 <87fqzp8jex.ffs@fw13> <87wlt13zj1.wl-maz@kernel.org> <87v78l6oha.ffs@fw13>
In-Reply-To: <87v78l6oha.ffs@fw13>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 4 Sep 2026 08:26:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wdqn7UiuRy1VY-qH+JYChLTEQgmj2q6Q=FBjCZ+5eo1A@mail.gmail.com>
X-Gm-Features: AcwNN1UDO0a-WZIN6LFn5huqxNCHPkaPn__17lQp2Fu-mhl0U14skIaSjsZ2sL0
Message-ID: <CAD=FV=Wdqn7UiuRy1VY-qH+JYChLTEQgmj2q6Q=FBjCZ+5eo1A@mail.gmail.com>
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

On Fri, Sep 4, 2026 at 8:11=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> The driver change is here:
>
>    [1] https://lore.kernel.org/all/20260902-qcom-wdt-nmi-series-v3-5-f399=
9362a9ea@google.com/
>
> >  @@ -311,10 +321,25 @@ static int qcom_wdt_probe(struct platform_device=
 *pdev)
> >                if (irq < 0 && irq !=3D -ENXIO)
> >                        return irq;
> >                if (irq > 0) {
> >  -                    ret =3D devm_request_irq(dev, irq, qcom_wdt_isr, =
0,
> >  -                                           "wdt_bark", &wdt->wdd);
> >  -                    if (ret)
> >  -                            return ret;
> >  +                    wdt->irq =3D irq;
> >  +                    irq_flags =3D IRQF_PERCPU | IRQF_NOBALANCING |
> >  +                                IRQF_NO_AUTOEN | IRQF_NO_THREAD;
> >  +
> >  +                    ret =3D request_nmi(irq, qcom_wdt_isr, irq_flags,
> >  +                                      "wdt_bark", &wdt->wdd);
>
> Of course this is a regular global interrupt otherwise it couldn't be
> requested normally. So this sets IRQF_PERCPU (it has to otherwise
> request_nmi() would fail), but that looks like a hack to me.

At least on GIC, promoting a regular global interrupt to NMI (or
pseudo-NMI) level is possible, and Mayank's use case here seems
legitimate. Any suggestions you have for making this look less like a
hack are appreciated! :-)

-Doug
