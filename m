Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5B36A37F
	for <linux-watchdog@vger.kernel.org>; Sat,  5 Sep 2026 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788571493; cv=pass; b=lDOGf0H1+bbkt9WjoDoAVpkqDtcG5MiqykvuAlvFxfJZgpzUxttdlDQZ7e14Fz+JzekwA/s9vhk+CNevUdRDXzFsnHwM99iCI+NR86E5DYwR5Hvk0weiQq62C/QXibbYx2dPImWNrc+AO0DvzPUsTolwLy7vuPttZ4soJDxyMAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788571493; c=relaxed/simple;
	bh=+vdy2c9vm4YqTwvKBGcrmA/YMw3xm+oXmp2FVkweGNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CevYRDzsvzcQchZy8FMUIFXH+/FLOGbUISSQBu5CMzgbzcgcMr6u3X24vhh44u0ouj69cKX7A8UN1tA55XJGP31HY4mU2u+8SleH1HCY94AGNv43sryZeha6eCOczhF0C2OnYL3Yzs3UFpoGf7h4n/mp+41HODXL8t8KVutJBbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=demCRwIR; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="demCRwIR"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4650773fa99so762858fac.2
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 18:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788571490; cv=none;
        d=google.com; s=arc-20260327;
        b=p7SyNzymovr79BAZioKmp4hEE4u1JBGTL+3NqLJLUVWsSzjxt0Schj4rmm7MbZIseV
         dtqRfq7R0XFP+7ElPCMqXJDKSjyBh+nO0dk9tBUAmnu53dCfk4Rq/8rNcs83U6wLkiDv
         I3Czrmm/y7zhXH/ATbzwAkJracarvAEfNIUDFbn57EXI5dKC/1/mYFrxJpPzf0Lm7mJY
         YvgtxGm4r2bh0RU2rEOX+jTR43V2atN16tTEgEStPwMVoFJIThrWPGUXetMHEmDi/0tj
         a18QB0i0GY1u5bRUAd1WLAPQG99FL0FpOenGnMoX8Ugh+pU5yhyxC82dZAmTL2k5HPwI
         T5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EC+UoLptGl/DJ04FYVu43bGMcolD/XF55vuVsaKJN2o=;
        fh=O1UntaV8K4S/pEMh783K6TB2EJYY0kJ1nPH48KvZCl4=;
        b=Wya5D7NTrXeqZyZmC24QGsh5UOKb6dyCjgI1xqIxN/rYZZIpc4ovbcPp3AknW0jPAw
         LLvYOJYwkWABqOKGUvHMTcyeps6Yy1Brupov+HGtijN1GSCWu9XjjpkpG35ACmQ92ojl
         yn0MCuzDsU6PV4mGSEWsBunJ5gBOik/827dtWeccDmMHDcPq6ojMSaes3CHCF8NO413P
         ykJ0wKnm8iKm/SB3HZQ07mVzkrlUUyY0453pOekpHV76jM5hCLtPb6LVx/IX0VWzSCQX
         P6/ooJrwOx9we7BEg5TQb/VPB6FsYbCzmz4yOzleURl/QX3CzmCsnySnIV8BDXEssOG7
         ZDqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788571490; x=1789176290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EC+UoLptGl/DJ04FYVu43bGMcolD/XF55vuVsaKJN2o=;
        b=demCRwIRGi9rOX0cF44e5OpuO0Tfm2gfwstvJhqmDpTHXgFQtT0x8KVctgyfa4xWAV
         NVZr/quQ1985u0pRvEBDFt5bqaMaOj9AVBKj/JwQGSRGG4eguCg0JHg4Z/Z/mqeua/ii
         HU7A1ub/Zn8amwTyd3aFWGNJewPCKEE+PHTzZeULpXvzczjTiSa7Wo5U3Ksizns7PCSr
         poJlwpKkDJtrPyp8Q/K8bEcS0mG/gCjECNdudB5MLWBu15nvu5/e/z9U8GI8ipOsYZ8P
         IblLb413Hh1bDM3kxWXCa0ftric3ix40vHq5mZHSp+X/bKqbZdD8HjQ4cJ0qweCnHWhU
         OfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788571490; x=1789176290;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EC+UoLptGl/DJ04FYVu43bGMcolD/XF55vuVsaKJN2o=;
        b=fZLhPCeyQMpSv62T2oMrkfDwgJyraIMNbnpfBDOD+QPH9Tge7FlZiRa9M0teerdOb7
         kwHV9GQQxynHptEjV+hRiyM+kFy5a9gULMVWZuWEzNcRtyxqT9dDSBhPkVwK0Ax2ZCiB
         aSG0hUJM5CMDO+KKkyHtpISpmpP64t7TlYKcbsQ7DZDURuZ6F6cDvXyWIefIcOJHOc8D
         utbesPc+agdLf9Gj7buelZFb77FS30K/laO67dUDdWm/iqtzidfMUd0dSeHSXQKFU+0+
         wIpq29AiNG4F1nCXsNxPRAYHn23CnpuZoO4JnPxe5CaEAHXtw/FISCcx3ZAKuSzoMwnO
         xypw==
X-Forwarded-Encrypted: i=1; AKwUvBzdaEuFhr0DdDJ0ZD4E7X7JocieDOvKLtf5yt2FAS0E3XovOwhUIj8O84Scs4uOUMbOH4gUUXwJX4z9NlS7Ng==@vger.kernel.org
X-Gm-Message-State: AFuF++l6FKF7nHMTro2r7hb2gQ3D9pxd+ssVpLPp/Fg+cQh7PZEy2Vo/
	arHeOEOLKna7ipNKjCrke6ObjxRNDkxtwCOMsHy+O5LhEeBb2lnkihe8cbcBN5lvQznB2NIysNt
	j/5n0Jd7RYqqoRWlYFfM4tTA1ysbBzSEfq/nqAZZK
X-Gm-Gg: AYBFou0d2RbLoTnxyqLpo5ybw3fUWcP/t6obPwkInphuq/m5yItQMDeadSmlWGDG+9E
	v04Fgsi7ctiwJhQlqDSKcfCllhPGrzYoPcwg3cTD5NM8W4CPM3mvOQiQTdi8IZ8/sJUcblSI9Vp
	k/SqLy6tQdFi+6Sb80TFBmmUjz/FrwKGOmQbSTRp2X5feiOoXtkDG2fkt7DlmwQS+Wc7EoM5hR2
	Sb/uIZcPCHTBcdvft5cTxOY9cToq3nPhVcYgf8NRVG2syvc65XIrIowIlpSkcuDC1rnpHX6sbib
	RdTAWD9k3CmtCdvpltOUrsOYXWDQx/ZaSHtS1wuunl1amNATGOysPEVKpAdKGPauxr+xFuapP+C
	IcA==
X-Received: by 2002:a05:6870:3210:b0:43a:19fb:8b99 with SMTP id
 586e51a60fabf-4755135290emr10118051fac.9.1788571489932; Fri, 04 Sep 2026
 18:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-5-f3999362a9ea@google.com>
 <3de593de-6851-4a53-8309-a6bf13e9a8f7@oss.qualcomm.com> <CABz7rdBv74pZe6jDRifTKRAKzGZB6L08n81_0gCqF0g=s+FEcw@mail.gmail.com>
 <CAD=FV=VUyQ4F-HC=cmD9Ay-JHcWJCVDc5BSWRax7a6FRJ_v0bQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VUyQ4F-HC=cmD9Ay-JHcWJCVDc5BSWRax7a6FRJ_v0bQ@mail.gmail.com>
From: Mayank Rungta <mrungta@google.com>
Date: Fri, 4 Sep 2026 18:24:38 -0700
X-Gm-Features: AcwNN1UgUWUz9WtwuFEEhnVuIouQDiYsXTySw9wJv4xfiAtNyBiJ4oOHMGl1lrs
Message-ID: <CABz7rdBHLYy4V70SvbAFNs36YtAizc_4HfBxP+LeHL5zWAhuYQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] watchdog: qcom: Register pretimeout interrupt as NMI
To: Doug Anderson <dianders@chromium.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 7:38=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Thu, Sep 3, 2026 at 1:58=E2=80=AFPM Mayank Rungta <mrungta@google.com>=
 wrote:
> >
> > Hi,
> >
> > > > When a system is completely unresponsive due to an interrupt storm =
or
> > > > deadlocked CPU cores with standard interrupts disabled, a standard
> > > > watchdog pretimeout bark interrupt will fail to execute, preventing=
 the
> > > > pretimeout governor from capturing CPU backtraces before the hardwa=
re
> > > > reset bite.
> > >
> > > [...]
> > >
> > > > -                     ret =3D devm_request_irq(dev, irq, qcom_wdt_i=
sr, 0,
> > > > -                                            "wdt_bark", &wdt->wdd)=
;
> > > > -                     if (ret)
> > > > -                             return ret;
> > > > +                     wdt->irq =3D irq;
> > > > +                     irq_flags =3D IRQF_PERCPU | IRQF_NOBALANCING =
|
> > > > +                                 IRQF_NO_AUTOEN | IRQF_NO_THREAD;
> > > > +
> > > > +                     ret =3D request_nmi(irq, qcom_wdt_isr, irq_fl=
ags,
> > > > +                                       "wdt_bark", &wdt->wdd);
> > > > +                     if (ret) {
> > > > +                             /* Fallback to normal interrupt if NM=
I not supported */
> > > > +                             ret =3D devm_request_irq(dev, irq, qc=
om_wdt_isr, 0,
> > > > +                                                    "wdt_bark", &w=
dt->wdd);
> > >
> > > GPT noticed this IRQ is requested but never enabled (NO_AUTOEN)
> >
> > For the NMI path: request_nmi() requires IRQF_NO_AUTOEN. To balance
> > this, enable_nmi(irq) is called immediately upon successful
> > registration in the probe function:
> >
> > For the IRQ fallback: devm_request_irq() passes 0 (not irq_flags). In
> > __setup_irq(), when IRQF_NO_AUTOEN is absent, the core calls
> > irq_startup(), automatically enabling the interrupt line as it has
> > always done in mainline.
> >
> > Both paths are therefore enabled upon probe.
>
> I wonder if it would make sense to either:
>
> 1. Rename the variable to 'nmi_flags'?
>
> 2. Get rid of the variable and just directly pass the flags to the reques=
t_nmi()
>
> That would avoid the confusion. While I agree that your code now is
> correct, I can understand why GPT (and humans) would get confused...
>
>
> -Doug

Agreed, renaming `irq_flags` to `nmi_flags` is a nice readability improveme=
nt.

However, since the way NMIs are requested is likely going to change
based on the ongoing discussion in patch 1, specifically regarding the
`IRQF_PERCPU` flag, I'll hold off on making changes here until we have
an agreement in place.

Thanks,
Mayank
