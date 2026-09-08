Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE33CCFAE
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871231; cv=pass; b=j0kinn68EDgHgCfk3ku4fGOB3FJUBXgr+uMbEqR5Gm/fgIC1lpOmdsWj68O2kq5h82iHxgxrg11oOFBz1Fp/IHWKxx4qnLW9JWYSpE3uUqcWZGhmkvnzd2WZhIbONVcj7/5pG2kJKPpFKUuwGawg8GwcBlMqsZnSkdjD2ro7XFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871231; c=relaxed/simple;
	bh=evUbGcFID4QtYm47NxKIeUMU4pgUbDtSy0vYOfpxyuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/k/1+R14cxysksM7k7IzbBbc0XD5aFQxJ/Igt+mEp/QkTyOc2BtPWvCL/302Fo7xtd3I6oYk9c+pmtv3L/Cjq9bB7TzwEP4rBOnkuw2+ig16UzGxNC6Wd5dpfmfrYk6k5EOQ+ZLS9e8fPAxSjVdzktM8dJfx3cQjJ0YDtFSNoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdYkhG46; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdYkhG46"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4843f205a5bso2815929f8f.1
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 05:40:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788871228; cv=none;
        d=google.com; s=arc-20260327;
        b=Mkb7j5m2HQjFKrPAQeA0AaEZS5/lh4FeMBztZga/o14eAXxcdD/gHflUjR26WmOEG1
         ySmck2n/OMQXldvdUvcohEYbd6hyvBMcBl7S1sLbxGSPekjaYyrEbFfXgYipckIlaOT5
         JwE3jhYQ+DzYKr9KpAQEd1sdx0pjGSNiKvVx6ZsJNmOqTPJdOlFFEEmTpTm0ImqxQwFA
         ueLu3QGEb9K/HudJDNJI7a0rm9FGM/p2vDwL0dXG5Gz/WW9nEsrBz2OoCBv1QHHS6ngB
         pPOt+O+GA/Xzr45LpN5JWnMXz/UarnDdUmN7nX4Ci2IXUy9ryYwucw13E3PPv2nl3W9X
         4B4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NgeaoDrPPQqs3i7AVciPBqV6bEiju7BB54wKAc+G8xM=;
        fh=mk4AtRu8NzkjjFSoX3XuiUxUDGfxrF2V89TN2/v0Rlk=;
        b=IPHXghLaqkRB901sdBhMaD+I2kfyUTgYCVwro1ieVms9fb3jDjvNmPDncVYFIQihcI
         I+wcP1iRR4xMEMlP4iHaNcl0gAI+uEL3XZYTWGq5XyjHImHBiBhHsbS2e0Oj/DCG7SdB
         5EwLDoLlO6tpeJ+vp0V+XdrX9hjhjin5u54UtE79lA+2Y3M46kvZDxoPDn9t9+3COgEj
         s4dZhW6ji3ZELSQiP8b0Ydw4+YAiX+iEwYnwzXQ8UoYruRlQ88KpRu3hJyp4IErkI0zQ
         hFEpt//4p/lb6UnqXvCoRXm8zDFVP745LZHQmVpnlFL2Cj97A49xNM3EWziKhMhBUWKH
         CNzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788871228; x=1789476028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NgeaoDrPPQqs3i7AVciPBqV6bEiju7BB54wKAc+G8xM=;
        b=mdYkhG46lY+zHB45sC1DZugICmaATVR8AWQyuoaBnPlyBosQbyIYeHta03nMzzznws
         WsYYkOrbaEnCnM0KcrVFE66Hf78qVjulzTPydUmbAm9REiUm2FZdql1yeew5nce4lSwr
         qXq/iWEW+1VgwkaQPK8vLIobM7o3yl/y+vUJCUofu5eu79211eMmkP7Xndge1o1obiWr
         e1MqdaO4UbBv8xW/NQXWNUd10D8fgddfEgLbtg8JVxwU/CET0ha+Wxma9gli1r4zzBJ2
         9T+lnMEClKedpLikObLIddLQJVVNf6xYLDVREez7lYlvKkeIvab75VfkpXU4r+SNkVMh
         3Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788871228; x=1789476028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgeaoDrPPQqs3i7AVciPBqV6bEiju7BB54wKAc+G8xM=;
        b=JFQVXiGZo6yRBE6dH7pOhK44k0mq9oudSAFuSdwf2zsYha6JsOAF9b3G73RVl9lqGy
         q3BMNa/gNfigKvjw2NRIF5tr59JL3KQHzBzDq427EByIrRXPRXX7wXIKH962hyDoEwVX
         eM7EAnVJpXTMgtYhdjdO44SyckuaeNRo/H1I/pPcmQtEx17iPNPB5oRGZx+pSGfqjPOP
         rZgYaXtKEF75b5e7xubdBpT5bLjXxSGfdwbirbw0d5lSKOmStOl3+KSg6frdoABemmUF
         +GhzDh68g6l/HLTtGvc1EwnsdXMjLj0fai6hDv3uhFegiUDYs/Y5K8DGNIIoag4qkvsw
         wa+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxJfjXJcm03NyjvUHhMfm2nxrnrSNfEi/Xl2eJxcB4x9b3Xs8UgiJXGygr4ULHgQTmgAgyywse6t4s9rrUtuw==@vger.kernel.org
X-Gm-Message-State: AFuF++m7tkVXCL2Zi2hjdyRHpv+WcNeol5uQuBjzoUr3IGIlXCF7mqYS
	lWuxrtEeTb4NA8IIC2JkY9jQj7cuMZDnKMZbVsp8RHeZqqMd0ZeauOPFH5pVhxqs17m9sQViJAD
	qAHfHKxfeXXYrsGMLiAUWANSDSkH4grE=
X-Gm-Gg: AYBFou3mcjrrFP1Q5oqZX0haUsQrNgNMZL/bz2FrxtnrA+3DtPkaKPwBF9HH9dKi3Ot
	+t/r0z6KL+T28ckfwmRZGphC+M7TT7s1DmfFQ7Vc56W6/bPN2hd4pfEbBzRq2Z2zk4jCdalhWzc
	b4kjLaG75ZCzKtiPccFs2qUu6U+cquT12pd95bI04NY5U0MvSuSO4rq7ZtGsxRFVvcE+Tos++6r
	egUuNqOTr53sQvyvn9Ig2IcEGINdbQ9AG9RdKXXoJ1ewu1Bg0ZopwFsjCYm5/BhOxwMr/RKfQPD
	FOFyakcMH1hD2MPyWMRhBCi5qICiQwcYwE0t9zN+4Xc3i598xJZtUUZ0u4y5vV7aPTKdgJeKiL9
	QRaUo02ulSfcE0KZC3ujA1TnY5xILPQU=
X-Received: by 2002:adf:e19b:0:b0:485:a410:63fd with SMTP id
 ffacd0b85a97d-485a410656cmr5381472f8f.35.1788871227613; Tue, 08 Sep 2026
 05:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260814191415.2110732-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260814192638.EA99A1F000E9@smtp.kernel.org> <CA+V-a8u4_gziwgevLUWwPkhkm2TbQXJhwFMa9ug8MAss+aZcug@mail.gmail.com>
In-Reply-To: <CA+V-a8u4_gziwgevLUWwPkhkm2TbQXJhwFMa9ug8MAss+aZcug@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 8 Sep 2026 13:40:00 +0100
X-Gm-Features: AcwNN1VertBmr010y9sYBgWuN3rvRKIh5jFb3iZYSUlr3P1nhOJVBI0pBF_CfNw
Message-ID: <CA+V-a8sd8w9Lhh8vFangc7VY4_1eUtLFRQK2vvJ2kaym-9GRPw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] watchdog: rzv2h_wdt: Propagate WDTDCR access errors
To: sashiko-reviews@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>
Cc: wsa+renesas@sang-engineering.com, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 1:22=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Sashiko,
>
> On Fri, Aug 14, 2026 at 8:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 3 potential is=
sue(s) to consider:
> > - [High] Error path unwinding in `rzv2h_wdt_stop()` leaves the watchdog=
 hardware unconfigured, causing an unintended immediate system reboot.
> > - [High] Aborting the `restart` handler upon register access failure pr=
events system reboot and hangs the system.
> > - [Medium] Using asynchronous `pm_runtime_put()` on the probe error pat=
h leaves the device permanently powered on.
> > --
> >
> > --- Patch [1]: [PATCH v3 1/3] watchdog: rzv2h_wdt: Propagate WDTDCR acc=
ess errors ---
> > commit ffabc27a1b8e9074dcd4cdaba7bc802a6d661fcc
> > Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > watchdog: rzv2h_wdt: Propagate WDTDCR access errors
> >
> > The WDTDCR helpers currently access the register directly using readl()=
/writel()
> > and therefore cannot report failures to their callers. Make the helpers=
 return
> > an error so their callers can propagate failures.
> >
> > > diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wd=
t.c
> > > index 3b6abb66a1da0..b770226f785ea 100644
> > > --- a/drivers/watchdog/rzv2h_wdt.c
> > > +++ b/drivers/watchdog/rzv2h_wdt.c
> >
> > [ ... ]
> >
> > > @@ -171,8 +181,13 @@ static int rzv2h_wdt_stop(struct watchdog_device=
 *wdev)
> > >       if (ret)
> > >               return ret;
> > >
> > > -     if (priv->of_data->wdtdcr)
> > > -             rzt2h_wdt_wdtdcr_count_stop(priv);
> > > +     if (priv->of_data->wdtdcr) {
> > > +             ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
> > > +             if (ret) {
> > > +                     reset_control_deassert(priv->rstc);
> > > +                     return ret;
> > > +             }
> > > +     }
> > >
> > >       pm_runtime_put(wdev->parent);
> >
> > [Severity: High]
> > If rzt2h_wdt_wdtdcr_count_stop() fails, this unwinding leaves the hardw=
are
> > out of reset but unconfigured.
> >
> > If the stop operation returns an error, the watchdog core assumes the
> > hardware is still running and immediately issues a fallback ping. Will =
this
> > ping against zeroed, unconfigured registers start a zero-length timeout=
 and
> > cause an unintended immediate system reboot?
> >
> Agreed, I will drop deasserting the reset and add a pr_warn() message.
>
Actually, it deasserts the reset and returns early, so the pings will be fi=
ne.

Cheers,
Prabhakar

> > [ ... ]
> >
> > > @@ -234,8 +250,19 @@ static int rzv2h_wdt_restart(struct watchdog_dev=
ice *wdev,
> > >       rzv2h_wdt_setup(wdev, priv->of_data->cks_min | WDTCR_RPSS_25 |
> > >                       WDTCR_RPES_75 | WDTCR_TOPS_1024);
> > >
> > > -     if (priv->of_data->wdtdcr)
> > > -             rzt2h_wdt_wdtdcr_count_start(priv);
> > > +     if (priv->of_data->wdtdcr) {
> > > +             ret =3D rzt2h_wdt_wdtdcr_count_start(priv);
> > > +             if (ret) {
> > > +                     if (!active) {
> > > +                             reset_control_assert(priv->rstc);
> > > +                             clk_disable(priv->oscclk);
> > > +                             clk_disable(priv->pclk);
> > > +                     } else {
> > > +                             reset_control_reset(priv->rstc);
> > > +                     }
> > > +                     return ret;
> > > +             }
> > > +     }
> > >
> > >       rzv2h_wdt_ping(wdev);
> >
> > [Severity: High]
> > Does returning an error here prevent the system from resetting?
> >
> > The watchdog core's restart notifier wrapper translates an error return=
 into
> > NOTIFY_BAD. Since NOTIFY_BAD includes the NOTIFY_STOP_MASK bit, this ab=
orts
> > the restart notifier chain entirely, skipping any fallback handlers and
> > causing the system to hang indefinitely.
> >
> > Should this restart handler make a best-effort attempt (perhaps ignorin=
g the
> > WDTDCR start failure) instead of returning an error?
> >
> Since the register writes aren't succeeding, it implies a serious
> failure with no recovery path, so returning an error makes sense.
>
> > [ ... ]
> >
> > > @@ -266,11 +293,11 @@ static int rzt2h_wdt_wdtdcr_init(struct platfor=
m_device *pdev,
> > >       if (ret)
> > >               return ret;
> > >
> > > -     rzt2h_wdt_wdtdcr_count_stop(priv);
> > > +     ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
> > >
> > >       pm_runtime_put(&pdev->dev);
> > >
> > > -     return 0;
> > > +     return ret;
> > >  }
> >
> > [Severity: Medium]
> > When rzt2h_wdt_wdtdcr_count_stop() fails, this returns an error that fa=
ils
> > the probe function.
> >
> > Does using the asynchronous pm_runtime_put() here leave the device powe=
red
> > on?
> >
> > Since probe failed, devres immediately calls pm_runtime_disable(), whic=
h
> > cancels any pending asynchronous power-management work. Should this be
> > pm_runtime_put_sync() instead, to ensure the device powers down before =
the
> > disable occurs?
> >
> I'll create a patch for this.
>
> Cheers,
> Prabhakar
>
>
>
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814191415.=
2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1
