Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142231A682E
	for <linux-watchdog@vger.kernel.org>; Sun, 28 Jun 2026 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782630970; cv=pass; b=j7nLZm3RNBD8y1aJd3JaF3+wXo1jnl17ZFw81Rpz+hqWlTkeNILCphpoTwG0uECxQcd1bR4KstDNHISENaZbQocVm9OWICYXmpatvt240Zf+ckAZYI+lemv30wqjRa1tsAmrRYVVYx89J3CdUGM7Hwtys1jrWMUhxSvpa1A9nIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782630970; c=relaxed/simple;
	bh=Clnfi/kv4cLVv5dhNS8JGOOv22pyEAHj1VloGHzKTnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+p0yQ4E2KJYH7mtZc5cJzbIgzDdLRYZthmOTktVXWYC9kxfcfA9VrT8Ujls9+80C4mF7sL5xekYxL+bzbBZNlL7UpcduKrPOaTaSEurPVMM+aeLNzfBa71uCe/upXZMzmOyA4SpaPVVjjOf6r9Z02hEn145Ta34C8JeP/iJGmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvgTQ8Vn; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvgTQ8Vn"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7fe36f1be74so28370937b3.2
        for <linux-watchdog@vger.kernel.org>; Sun, 28 Jun 2026 00:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782630968; cv=none;
        d=google.com; s=arc-20260327;
        b=FQL9jM+kSPQV8r1uFt4diiSQWZT+Agt/R8vgZ7YOkCW1MEcERUCjv+xNx0nfNIP8SV
         E8Q88yCtba6KhP9izdi857B3zGUSnC5HrGfZv/wYnu838WtO4T+2vWM6PvurLLfLfZte
         ThxVsyWp+VgxSsN+pDkg+YXpgQLFioWlantInHMyF+tTNfj1j8i/2QoRY5GXbhYD6vuS
         jVRSjKGqldQw09s604FDmwCAR6AMwvTfGP3aN00kzZ7Uj6qzIhuPx+9R4Awaz+/y0TBO
         zVMHZnl8L1riYQrqPqspozRarshqlNq64dqelMJXqfAEogyubDjNKl+KW6IHt2qrnNjA
         xUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VYkMilNx7ZRv+pY9kOiaVDU1vZlVNUL8U5Tb17+D99Y=;
        fh=GxuHEwNuK0zPJMg+/rE0o/t5nYVzsNdBHsMB7f+zlVY=;
        b=mNXN2zo+4J6K0rVKVksQNL3KE/xxyx+Q1COupha6TD3ppMcdqIjaO5qyCO26jPyxej
         m1xu00Ck0IEVekqnYer06mhfrtjvwkDMvbdTXegB5DePrWuUuulSc4e+U8XPkASMwOc/
         xrPsDt+NmWYIY2gaTQNdJvFJYpG8fcp66c+Qgx/laf6fNhCIeljt8DFPTgPzlmDKFRKP
         oQgQ8qhfU4zEudimn58dv4JDx/GhQV278+MxGrldJvF71pwEnNAjDdGONutgVd0LgX4A
         FZwK+/CrIJj5BHGlR1JB+YikeRwDpU7BCWDArieoaRlrylJwol1wISaLcVHu1Q2zfgbI
         1q5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782630968; x=1783235768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYkMilNx7ZRv+pY9kOiaVDU1vZlVNUL8U5Tb17+D99Y=;
        b=MvgTQ8VnZkfYJnspd9Q55a+i9zhmPZcZrczGz5XDGKwmdamvtWz34yhhCqSBFs6jHu
         IoLgE8SCNiXjqXcnkZQQ3Q5KENUNccNzkcca7UA76PFzd5UrpQr6zEVdvkJk/g13B/jx
         6qSGZto+2yzgq+cvho/ivCbqzz6NKoiEvMg4isnJoESaoedHbYlAdlRrnHYetYd6iKa2
         uL+MXBIa9VsJNaWzdw9uCenqYLbbZCpznonTA1QwP43HPDhtUHPfeGgm7ruAaAVJRym3
         EcKRNCOnNDObZOoCjBTuufHXHTCTPFf4sWER4FUBdTTrbp/Pz3dEqZtw0aB55Z8FrUna
         vOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782630968; x=1783235768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VYkMilNx7ZRv+pY9kOiaVDU1vZlVNUL8U5Tb17+D99Y=;
        b=b5N7yKRnt8Dsk24MeyuQr9yPPYfHiuxTobTmntsLVwSmidABu4ygvzpxkBOE+3Qn5p
         Cv+qPxL4VpU6vjmVk2Et1YJ5N4QNYeoT8kkFoyzacCD7Dw/zb7LH9G/Dq48NdR07UiCD
         B5CewfWnZIBlxnELXygeLpe5Vg4+EG8BKt8UXB4ziKZH2klV1quB3pFWccHB9Uk330xQ
         s+p8SdtVSWn2nnE90k/bYd89HO4AiT2/Z2/fLia+Td9zsX3oo16AEvG7g08M8oRbWMqS
         n1ZQV0ynoR9Q311sTL8LXC5xvEAnvvjdo7fl8gwRiBbXj0oK3KT0VFFgFlnsK1J0ohG8
         W1lQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/C3dhc2+zUWWHeK+ZF6Nwaoi1r7mZy1rDc+nRpi6AynKHJKDUdHw4Xc0Op/RwTgtokMCtGhuva+NOgK9YqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrbbfcRYt0nk/z/4E4CHBdHVA4KOtPmk570tsXPi2RAS3SQ/LP
	ogVIoZjSRk2NQbw4VAqg04J5N9jdboo9rfacvLcx80iXdHIztdT8UkBe4aWomtftGF0KiOeVlHt
	d9eGgc3VSRnaEgnbhZ1Yg3/8SheKKujMgVA==
X-Gm-Gg: AfdE7cl7TssJ10ykJXLa24Ra4sc2olPUMJmLbyHQVcGPLw0i6oApt1wdtoFNR2vI4oc
	XKBIeptIU7nx2piHTq2swwDQfsewOARNO8ZWRAU90f5YxDLrq7LTvch3FcBQeCEdwcOC/mQvnmL
	ZhJEcXlIxtIVkjjGPbtN3o9UNHrw6CYVtioRUn0Hk6yv6PU4UWepwv/etLS8+oJxmKUJgivSS/u
	Hym+drqC8l6n/vxUiJDGTiPij/cvsovDn/v61C4oAwp5XLsk+p2sqs92W8upHH9MF679dW3MA==
X-Received: by 2002:a05:690c:6ac6:b0:7fe:bd7:9cae with SMTP id
 00721157ae682-80a6a496acamr120226927b3.44.1782630967897; Sun, 28 Jun 2026
 00:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622083046.3189603-1-tmaimon77@gmail.com> <20260622083046.3189603-4-tmaimon77@gmail.com>
 <20260622084246.D01A91F00ADF@smtp.kernel.org>
In-Reply-To: <20260622084246.D01A91F00ADF@smtp.kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Sun, 28 Jun 2026 10:15:55 +0300
X-Gm-Features: AVVi8CfnmkRHCHwHniRXRzrKmmVWuj6G6RgacnVW4_rojVzgCVFn156J9Mj_5vA
Message-ID: <CAP6Zq1iD2GA2Aae2Vz0UvNG5RSv2N_H-jAnfDy4Kjm6Pn1htxg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] watchdog: npcm: add bootstatus support
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the comments.

On Mon, 22 Jun 2026 at 11:42, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] The first watchdog instance on NPCM750 clears the global RESSR r=
egister without caching it, causing subsequent watchdog instances to perman=
ently lose their reset status.
> - [High] Non-atomic read-modify-write of the shared INTCR2 register clobb=
ers concurrent modifications and incorrectly handles W1C semantics.
> --
>
> commit dafe1267618ef0158376caf5f3acee9d7fe7b1b7
> Author: Tomer Maimon <tmaimon77@gmail.com>
>
> watchdog: npcm: add bootstatus support
>
> The NPCM750 uses RESSR and the NPCM845 uses INTCR2 to latch reset
> indications. Read those bits during probe and map them into watchdog
> bootstatus flags.
>
> > diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> > index e62ea054bc618..98660419ec3f0 100644
> > --- a/drivers/watchdog/npcm_wdt.c
> > +++ b/drivers/watchdog/npcm_wdt.c
> [ ... ]
> > @@ -169,6 +250,92 @@ static bool npcm_is_running(struct watchdog_device=
 *wdd)
> >       return readl(wdt->reg) & NPCM_WTE;
> >  }
> >
> > +static void npcm_get_reset_status(struct npcm_wdt *wdt, struct device =
*dev,
> > +                               const struct npcm_wdt_data *data,
> > +                               resource_size_t start)
> > +{
> [ ... ]
> > +     if (of_device_is_compatible(dev->of_node, "nuvoton,npcm845-wdt"))=
 {
> > +             ret =3D regmap_read(gcr_regmap, NPCM_INTCR2_OFFSET, &rstv=
al);
> > +             if (ret) {
> > +                     dev_warn(dev, "Failed to read INTCR2 reset status=
: %d\n",
> > +                              ret);
> > +                     return;
> > +             }
> > +
> > +             if (rstval & NPCM8XX_RST) {
> > +                     ret =3D regmap_write(gcr_regmap, NPCM_INTCR2_OFFS=
ET,
> > +                                        rstval & ~NPCM8XX_RST);
>
> [Severity: High]
> Does this non-atomic read-modify-write risk clobbering concurrent modific=
ations
> to the shared INTCR2 register?
No, the INTCR2 is accessed only by the WD driver, and reads occur only
during the WD probe.
>
> Since INTCR2 is a shared global control register accessed by multiple dri=
vers,
> using regmap_read() followed by regmap_write() drops the regmap lock betw=
een
> operations. Any concurrent modifications to INTCR2 by other drivers could=
 be
> overwritten.
>
> Also, if INTCR2 contains Write-1-to-Clear (W1C) status bits, writing
> `rstval & ~NPCM8XX_RST` might incorrectly write 1s to all other active bi=
ts
> (clearing them) and 0s to the watchdog bits.
the INTCR2 is not contains Write-1-to-Clear (W1C) status bits.
>
> Could regmap_update_bits() or a W1C-safe write be used here instead?
It is not needed here.
>
> > +                     if (ret) {
> > +                             dev_warn(dev,
> > +                                      "Failed to clear INTCR2 reset st=
atus: %d\n",
> > +                                      ret);
> > +                             return;
> > +                     }
> [ ... ]
> > +             }
> > +     } else if (of_device_is_compatible(dev->of_node, "nuvoton,npcm750=
-wdt")) {
> > +             ret =3D regmap_read(gcr_regmap, NPCM_RESSR_OFFSET, &rstva=
l);
> > +             if (ret) {
> > +                     dev_warn(dev, "Failed to read RESSR reset status:=
 %d\n",
> > +                              ret);
> > +                     return;
> > +             }
> > +
> > +             ret =3D regmap_write(gcr_regmap, NPCM_RESSR_OFFSET, rstva=
l);
>
> [Severity: High]
> Will the first watchdog instance on NPCM750 clear the global RESSR regist=
er
> without caching it, causing subsequent instances to lose their reset stat=
us?
>
> The NPCM750 SoC has three watchdog instances that share the global RESSR
> register. When the first watchdog probes, it reads RESSR and immediately
> clears it by writing the value back. Because the value is not cached
> (unlike the SCRPAD10 mechanism used for NPCM845), when the remaining
> watchdogs probe, they will read 0 from RESSR and permanently lose their
> boot status indications.
Will be change in V3
>
> > +             if (ret) {
> > +                     dev_warn(dev, "Failed to clear RESSR reset status=
: %d\n",
> > +                              ret);
> > +                     return;
> > +             }
> > +     }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622083046.31=
89603-1-tmaimon77@gmail.com?part=3D3

Thanks,

Tomer
