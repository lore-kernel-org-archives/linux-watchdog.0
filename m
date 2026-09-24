Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9348C40F
	for <linux-watchdog@vger.kernel.org>; Thu, 24 Sep 2026 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257485; cv=pass; b=mAvGl5ZBZFzgm1NCJi+8pTBxnYjSNNXoOMWTSfztPTRVSi/JpUxruaHWAuBpnuZAG8jTrJLX6VrqC0FIKMj8qu4APsTeNniwKmwAucN2XdSKNSMI6DRapO0QLa3zKYSHjkSkd0JBvy4VTzDcVFAw/gT4xkKc/vHcbHGVroT0TmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257485; c=relaxed/simple;
	bh=srpUlNZOrzAYgQzUQn9udJrV5U4zpQZLaeztMl04WB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKEPQgBf7FN27IIqcqH1euitgtzMExruWDC+bVpEBO2mq2xQ1VlQivuGu7H64kf9LcTSDYKo2k46BCFCi2fig5L/TYDpslP3VecnAStTI4fXn1uqONi3Upsko6CMlMl4xhn3lr1HlYkplMhISI5VrCpw0eSSeiZzozdq//S8/bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anxL7Pzb; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anxL7Pzb"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so1465348f8f.3
        for <linux-watchdog@vger.kernel.org>; Thu, 24 Sep 2026 06:44:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790257473; cv=none;
        d=google.com; s=arc-20260327;
        b=SILHI0VaZm3mk7AmObNBAr3YJ7TNarQAqpMop/PnLmjUKztiIs2BRkALOoISUe+6Dh
         X0C/anU4FGHFdg+mpIA5EqbVgI4xP/34gZAGTRiSwYn83IQl2xtEIhrkqE6vGAR17tsI
         fQI7tX6U5DiE4XhnGH/5/Hm4oVTln8E9mmQ7JiMUgZ4VyTnt1UD0ZrpMHNwQSCFLkpqK
         0vvwSUM4abynzLsza9KHWeXGb72hyf6QQj+yZtNks+4NiYULg9X9R8DMUcWBrczasdGx
         OlPXc6SEsci3LNF68ZTall+etBtbONyg+gVUtTw7yzjm5S/d3QlDaRCnby/ZNkPcnqGI
         Uyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1vA/7F7T4hKWXEqYJVanQp0Khdd6KmZi7BaKquhMJvs=;
        fh=DvjDFqyjqB7XMHa/P9tkX8zPDiQJjjOFdEL2cSMYzl8=;
        b=sNDFhSlx/7g+gFCR+qOpr8uIhr7ZZpHn9UKF6ZN1MDU1Qtjfrd9KGRimRv/9DrI5Ud
         MQ1dLe5TgT+nmao26rwqpsJKGzU77iJkIjLUmjdBWpIjqJNQIqLOULD9c+XwqrzZwVlM
         0+Kv34eZ89r46pTGsKTYJxaVIi4iJYQR6FmCo9cgJ7oLpYou3w9bdSBiXRg0P3Tp8vMB
         58kzdOusYL72i/BPZ74Ymp9FFaHP8MpKn5z0izRBSfVmZPycyyy5YKyonHt6XOpyDf+j
         lqOfcMSXhKegForwPFMiehLGwE8kDUjojrt3YbbDM+oZO00ZYBMe6vMDf3rtvW+pxKuY
         ekAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790257473; x=1790862273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1vA/7F7T4hKWXEqYJVanQp0Khdd6KmZi7BaKquhMJvs=;
        b=anxL7PzbC+Glj0675LuiLX2EL9/S0omdW6sjEjFXfdLxLktXdt4fRsU8E2yTvcubGL
         xx6Th8xAIppIlgHDda/ncRZXSc4pX4BFrhfyTbpBRkXHGBQJT3vTPG5ekMNBsKsq56AO
         KnfixPD1mQlvc2FrVJSKzO/4VIw/KXnRm2OhL2VMyQEx3oHehLEjtJO/R7tUVus0Kb6Z
         9tepv+ST7PoCEPjrWOOL5ddjTImeqa62ItJKB+1Or+ikMJariaU04DK8AXjLcEhq8TzG
         b55NGZFFY/iyZQxik9NF1/UXKAXUqsPk7JlolvyalrkIeJCvbBekFUeFLkVRoDD9gzUc
         q1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257473; x=1790862273;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1vA/7F7T4hKWXEqYJVanQp0Khdd6KmZi7BaKquhMJvs=;
        b=Lzq/VJ9UD+Tw/1nrGVhgCaab0Gh9IJSRF914WcAANb9gdr8m/mb9junnJ0fQ9NE5tZ
         e/8zSb0t058DC0XTvc7pN9T+q7xp7UifR2wwRXuH/wARFrbSEhjt2qGZbL1bDFYTAeWn
         TE4KctRTTlJdbliQxA/XrvcQNGUDGwYyrYMVTsUA56wdM7kESaunqpz1wsDl5bLgjd7A
         c5GT+Rr1RoV1yvKyIC8ZUffBM7yOMri5sUwHhCVd575C+QQeCwtnUtYv8HiQcq/TOa7p
         5KhJLgBrRdKcNkWBFM2ym3oSIQk1gghNb7z0fIv1ydHPOC/367AwAa+1vvRzHaaIC5qb
         7kRA==
X-Forwarded-Encrypted: i=1; AKwUvByeeH4sxcF1xgqEMBs07DBhzcNrYuEcijaFEK57CqmxZrzWkoHjG+bGMcXSpz0HJuKMd1hw0XknypolBAa5DA==@vger.kernel.org
X-Gm-Message-State: AFuF++kw6XurY4xnRATZmwWtqKEfzRVxuKAjfXbS2Rqg4EpOXYkbJlxm
	HxPev6rFdZV2MultcTpwbjVr+OnVylubUKXIx091tS+HCU/NqpwSTRz9A5RaweXI9El5dGPPI3n
	CknF7UmabkR0qcGeNet31rMOnsB8z6F0=
X-Gm-Gg: AYBFou1nzc7WgdRk9nF/W/rmvoqAn941G8eHEePmawNKkiaD58pHKBBdaqgai+KCI54
	DthC8rNGi0xbAYeWDAABgbL2iLdu7bmfqKftP0KZBO35F1l1LqN6RzyZZisAAYaGySuJDafo+ZX
	br/ELB0Yyk2qhyg/ZVyPeQr2DMpFdNEhJYgz5dE3kdhgVM7uzbkPx9avl9yRmnxMidEm5+iP3aQ
	uCviUrqMaCvBJzcrqJHOjeSSWQr1a2dzx29pt3yhjnozeoExXy4AdJV8emXja2tX5Q/Eg8PFV+V
	EFNQmKkKuDr4HUVRqy3gq7A3yNinGvM9chZXf1vCuolnJ60UwybXhjYWYnB2hcXVyt7Ppvurq4Q
	B3GtMW58fJyOVckKeLPiD8IdNsEEutBtdgORR2B68ryaLmJm/eziuEOCdrzftF25xOcVhmG8bjA
	==
X-Received: by 2002:a05:6000:41ee:b0:487:71a:be5e with SMTP id
 ffacd0b85a97d-48871751e7emr4423057f8f.28.1790257473544; Thu, 24 Sep 2026
 06:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923104054.3324830-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260923105237.7B87D1F00893@smtp.kernel.org>
In-Reply-To: <20260923105237.7B87D1F00893@smtp.kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 24 Sep 2026 14:44:07 +0100
X-Gm-Features: AclHuK8zM1ciyUvzD6y496Uq1l_AhIJFVnKp0Rhb2IMAuf1s6F4re485NR0FU3Q
Message-ID: <CA+V-a8uD16uG8cc9m7NHVZXT5bU64TYfu+_1POuXeioRAy6Z+A@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] watchdog: rzv2h: Add syscon support for WDTDCR
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-watchdog@vger.kernel.org, 
	sashiko-reviews@lists.linux.dev, devicetree@vger.kernel.org, 
	conor+dt@kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Wed, Sep 23, 2026 at 11:52=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] watchdog: rzv2h: Deadlock in restart handler via syscon regmap l=
ocking
> --
>
> commit 1e1b26069f70735a537750b22a51257bb422c2e4
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> watchdog: rzv2h: Add syscon support for WDTDCR
>
> The commit adds support for accessing the WDTDCR register via a syscon
> regmap interface for RZ/T2H and RZ/N2H SoCs. It looks up the SYSC regmap
> using the "renesas,sysc" property or falls back to MMIO access if absent.
>
> > diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.=
c
> > index 76c1d315b0e77..30b0b70fecaa9 100644
> > --- a/drivers/watchdog/rzv2h_wdt.c
> > +++ b/drivers/watchdog/rzv2h_wdt.c
>
> [ ... ]
>
> > @@ -93,18 +104,22 @@ static int rzv2h_wdt_ping(struct watchdog_device *=
wdev)
> >
> >  static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
> >  {
> > -     guard(spinlock_irqsave)(&priv->regmap_lock);
> > -     return regmap_set_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTO=
PCTRL);
> > +     struct rzv2h_sysc_wdtdcr *sysc =3D &priv->sysc;
> > +
> > +     guard(spinlock_irqsave)(&sysc->regmap_lock);
> > +     return regmap_set_bits(sysc->regmap, sysc->offset, WDTDCR_WDTSTOP=
CTRL);
> >  }
>
> [Severity: High]
> Is the external sysc->regmap_lock still necessary here?
>
> When using the syscon regmap returned by syscon_regmap_lookup_by_phandle_=
args(),
> the regmap has internal locking enabled by default. Since regmap_set_bits=
()
> already performs an atomic read-modify-write using the syscon's internal =
lock,
> this external wrapper lock appears redundant for the syscon path.
>
> >
> >  static inline int rzt2h_wdt_wdtdcr_count_start_nolock(struct rzv2h_wdt=
_priv *priv)
> >  {
> > -     return regmap_clear_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTS=
TOPCTRL);
> > +     struct rzv2h_sysc_wdtdcr *sysc =3D &priv->sysc;
> > +
> > +     return regmap_clear_bits(sysc->regmap, sysc->offset, WDTDCR_WDTST=
OPCTRL);
> >  }
>
> [Severity: High]
> Could this lead to a deadlock during a system panic or restart?
>
> This function is called by the rzv2h_wdt_restart() handler, which execute=
s in
> atomic or panic context and must remain strictly lockless to prevent dead=
locks.
>
> While bypassing the driver's local sysc->regmap_lock was safe in the lega=
cy
> MMIO fallback case (where rzv2h_wdtdcr_regmap_config disables locking), t=
he
> syscon regmap has internal locking enabled.
>
> Calling regmap_clear_bits() unconditionally attempts to acquire the sysco=
n
> regmap's internal spinlock. If the system panics while another CPU is acc=
essing
> the shared syscon block, the restart handler could hang trying to acquire=
 this
> lock, defeating the purpose of the watchdog restart recovery.
>
Agreed, the syscon regmap lock cannot be bypassed from the watchdog
driver, so the _nolock variant does not achieve anything for the
syscon case.

Rather than working around this, I think the right fix is to not
register a watchdog restart handler on RZ/T2H at all. On RZ/T2H,
system reset is implemented by TF-A through PSCI SYSTEM_RESET, which
triggers a software system reset via the SWRSYS register. The PSCI
driver registers its restart handler at priority 129, while the
watchdog restart handler is registered at the default priority of 0,
so PSCI already resets the system first and the watchdog restart
handler is never reached on this SoC.

With the restart handler gone on RZ/T2H, WDTDCR is only accessed
during probe and from the start/stop callbacks.

Is this approach OK?

Cheers,
Prabhakar
