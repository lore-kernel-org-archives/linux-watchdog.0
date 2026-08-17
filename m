Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0643D50E
	for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786978692; cv=pass; b=KgOmHV3/G3m+boAMl5goxFWjuQRgoqli8mKhSOjE7n5464kdrvdsgtaJyjcL33c3ipIyNMxOkoFNNf4TZhQ8i4xtrsrOLU7GrTqbwu1cTOzHwpW9ceZeGjulntEK8DgipJ+e5FLNRTApdMFd5eNdry8i8VthIdEevXT21kIE0EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786978692; c=relaxed/simple;
	bh=gIi+I19Q7XnPhr3NypbxThTLH682pcRQjzGXRDJm87Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gN8dkEgJPD47nglutFSx+l7eyI+KQicrsqhDP8XQKv2E5RcHB2AoMR50Z1A93+F+4EMGg3IvbWfvBX076Stilsu5diS2zBX8sJfAJpN7kMC8czAeNRr2gZgwOGAye1Q2BtPmPvJTZmTat+wNy9xb8dNkDxvn4qaNKYFN1MWs+xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Np0TILjm; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np0TILjm"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fecbb7000so1870775f8f.2
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 07:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786978689; cv=none;
        d=google.com; s=arc-20260327;
        b=lh07qb8EicUQRI221orcuCK/B1vL3MONjzNy03Tj8OEyOvThWnAnYt/IxlWsUrpz18
         2SeOKxe/cUZKzFGCoi99e8pQIVQb0w9KtfP7z45qWEoKjI7Z4FeLjVSyYuRAiHuruwFx
         b/FXdERtxGSSBq/XWJwOAZz2ZqZLf9ZIhMxeQTiEhFUUQrz+9joxU2dI0dLggzu4/AqZ
         vxBTEXtZiade1Gh02gfOD4xmOmDabbhuUonPynC/Z1EpCKnWPMmeAMfa3I8YDwkwImq+
         56uhQvA2Oqo+RC0mrA1+tgfrHeTNQvM2M96r2NeZHA4OnhmK1sj5ktE2kDgFUD9x+E4o
         pqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yg844Qi5SZrdGikIefqLd2LapEU10ih29HLHILYEwIM=;
        fh=o0XsGcrIopPI51/pfdQ3wUSoiCo0tOkeJIhogmp2RC8=;
        b=oWe4202/CHqNMbUrYQbvECac8qbXGAAs1X7gXEJKW3XhyRMFnZCrmKky4Bk2jHKAek
         cXR4AdxqqXiboPbngjr7zMyfWS7IGc0BKo5qK22PyeF1OskHxQP4hIF8dmGmkkymI75f
         XOV+Cc4uW7gSE8mG6mhk29iXv471mZM+EQvplHaEqP6LWFZRc2IxMOhw56r7NwScBFnb
         ZW9v82SBavRmLbGTRdnNHLH0DCqPMxsL9gagh1giOGcreclda+xkJtHs8diQ5t3cDY11
         dtvpD5U3EOJosITGB8OnJQtpaEou+lhfig2SJe+PbdiGUkjRIB1sqaRvpgF5HSqkbz5b
         CpsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786978689; x=1787583489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yg844Qi5SZrdGikIefqLd2LapEU10ih29HLHILYEwIM=;
        b=Np0TILjm50tJQ2QuLvbdcOBxS+9qO9LaueKKKurxu+/yPGBSN8ubmmD7NxH32RgpKV
         CLYk1zUatYr2q0fplDYhIO1cLQ2aHzJkSAbYkvwbdGmXvp6Jr8MA5zWa/QoEbdUfR14l
         XMRuounhRFFWZyVb1YBov8G3PrWo62/jkbWwoY7fNp5VDJqSgiECQzdfUqr6h3BKubT1
         ThrZ71iJUHz6zfE1LmuzIiB3Qd4KOzq9HnJAe2EqavwLlzAJ4zOokrs2c+i3Lsso+v8O
         KlFu0P5TGLnV2bx9KAIScmSw3i7fo1bUePx9nzUNyEPpKo8m7d0aEb2VMnWumSS435Xh
         5mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786978689; x=1787583489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yg844Qi5SZrdGikIefqLd2LapEU10ih29HLHILYEwIM=;
        b=PzEa3kzAzcK41W1dyBB1sWQXJVC+EzBaih/0mtO3KdfJbSNo/rEiUR2K2+RgZgX/va
         R9I2YANfa0m0HDVWmUA0iAzz/5eAPNRkmzlCNbfeSul97iY/p8eWSKkEi0mdxUdthtjE
         ADbLjZvDtLJHnep0ezIBQLLe403qVH+YMR5hY34SO7KdGzU1nXFQwodyfssHspq8pBX0
         JRHDfB/w3EKmM118bDA3WkpUCyn6pMrsUejxgMZ+wtmhTIDSD3nnmGoJDNF4i4HzeE0j
         UXINCxbqNnkbJoA3ybO5Cy3UM36p9FCDtl3QuZb1sxfXQq6J9JIYacGWUTvwDx3rAu7c
         d6iA==
X-Forwarded-Encrypted: i=1; AHgh+RqBiIf78Us/qRyui5XHFhUSHMIim9gwm+RiI+MPUgumQCkeJ5mLNriQ0wC6Co/l7oiXFu/IWAa6FJegvokMuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmvSzVgtbYkmfWdHGG4QGV6HW67q2AwVMiojnfrmJN4AF8J3g
	dd/cVC4/MCBr3IeAu8UJPrSk2gmXdIR5RJMe5daZWEBt58j7z0fJFrc36uys5r6c4H0K9t3K3yB
	faWKZ/z5pxZ22EwV/nI4DXxDNHhzOtqc=
X-Gm-Gg: AR+sD12zFITsOopLnMxvsJsSD/crJ9XOYpN/FY+3AZGg3uuF67irL5cVX4BODN1oKJn
	ZJH+qSSB2zTmZHK0np2v4HtDw+/t54Y2WPt/ltos8FD3DeDkNsuGsBjNev8DloGLntCwIYr3T8h
	Bpt9N5aXGaFEpRDFhWOrdxN3rmV31r5n2bjbJoj6DlgKGD8MfepCtb9gqJ8cWgT9X0Jt///7Imn
	U+hL3o7t61XfXiP5hHfZJ8UU+bg2UuHixLrrxJKgIbOqTOBBaRwioXjP/9eFStISyU3PQ5JGxcl
	oxmvhtLt5PMi8MChCP3pEmpEX+IC0BOW4WuQT66xW4/s4v+51nYil0lKoAVTiQ5slvTIhuIujv4
	yIhJoMZJTSRp1aEYGtwqJrfJCOBsaxps+9mxgyd6jlP2BqbSLmEUDk2kEUvNQZdNW
X-Received: by 2002:a05:600c:c165:b0:499:4892:d022 with SMTP id
 5b1f17b1804b1-4998795bca6mr451259735e9.8.1786978688439; Mon, 17 Aug 2026
 07:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260814191415.2110732-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVKy1QOh6vBGf8xFGTw0c_htgF8JYA-VnDH=muL1G03EA@mail.gmail.com>
In-Reply-To: <CAMuHMdVKy1QOh6vBGf8xFGTw0c_htgF8JYA-VnDH=muL1G03EA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 17 Aug 2026 15:57:41 +0100
X-Gm-Features: AcwNN1XxcpNUj11e1rVVokPqDeZDP7fjvNUGfNBKKU3O8MMkJSpQ_tZbFi19yCE
Message-ID: <CA+V-a8uBo=A40LRYgO47OMwaiT-U9EUXaEbHRxw_hgW+wn1E9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] watchdog: rzv2h_wdt: Propagate WDTDCR access errors
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Mon, Aug 17, 2026 at 10:46=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, 14 Aug 2026 at 21:15, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The WDTDCR helpers currently access the register directly using
> > `readl()`/`writel()` and therefore cannot report failures to their call=
ers.
> > WDTDCR is located in a shared syscon region and will be accessed throug=
h
> > regmap in a subsequent change, where register accesses can fail.
> >
> > Make `rzt2h_wdt_wdtdcr_count_start()` and `rzt2h_wdt_wdtdcr_count_stop(=
)`
> > return an error so their callers can propagate failures.
> >
> > Handle these errors in the watchdog start, stop and restart paths and
> > unwind resources acquired before the WDTDCR access. In particular, rest=
ore
> > the reset and clock state and release the runtime PM reference as
> > appropriate when an access fails.
> >
> > The helpers still return zero with the current `readl()`/`writel()`
> > implementation, so this change does not alter the driver's behaviour by
> > itself. It prepares the error handling required for the subsequent regm=
ap
> > conversion of WDTDCR access.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v2->v3:
> > - New patch, split from v2 patch #1 to make thing easier to review.
>
> Thanks for the update!
>
> > --- a/drivers/watchdog/rzv2h_wdt.c
> > +++ b/drivers/watchdog/rzv2h_wdt.c
>
> > @@ -234,8 +250,19 @@ static int rzv2h_wdt_restart(struct watchdog_devic=
e *wdev,
> >         rzv2h_wdt_setup(wdev, priv->of_data->cks_min | WDTCR_RPSS_25 |
> >                         WDTCR_RPES_75 | WDTCR_TOPS_1024);
> >
> > -       if (priv->of_data->wdtdcr)
> > -               rzt2h_wdt_wdtdcr_count_start(priv);
> > +       if (priv->of_data->wdtdcr) {
> > +               ret =3D rzt2h_wdt_wdtdcr_count_start(priv);
> > +               if (ret) {
> > +                       if (!active) {
> > +                               reset_control_assert(priv->rstc);
> > +                               clk_disable(priv->oscclk);
> > +                               clk_disable(priv->pclk);
> > +                       } else {
> > +                               reset_control_reset(priv->rstc);
> > +                       }
>
> FTR, this else-branch is also new in v3.
>
Thanks for pointing that out.

Cheers,
Prabhakar

> > +                       return ret;
> > +               }
> > +       }
> >
> >         rzv2h_wdt_ping(wdev);
> >
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
