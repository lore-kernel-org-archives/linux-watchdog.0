Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7947DD6B
	for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2026 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043740; cv=pass; b=RqVfTpAEMIZPcahFn4ZfrwErkF1Dt+7keCgrl8hMwDEOIl9igk+63e2emLjqAdCgKR62Ggn502bnrOJjDZzw+GfiZNAYZUzB4Q6dEuViQepHUGIuS1LaPgh8hPSkSB83OMlevZBHGCL1L/FozXb2W2rOC3gkdapTazs7xmANqrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043740; c=relaxed/simple;
	bh=sWqGyIl3Sy36dtoEqyN8K9IVF8mS5l6W67D4MCNUCJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKmwZJXhQHp9rrb+tqGMPXjsRUdsRwpRUrGK1RZmFFuWolG8Pj+P6wEeeloshowaXr8PzH/udJrhKC5ggVblQFwQoN6452+5AnhXOqw249QoOqiOGnIQZBbBN3CTEj9HcLwAruN9ZNOMzgDrVxBqMe70ZUHgjSXWi9rmfvo7xgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoBF+bPu; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoBF+bPu"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-474560436c3so860070f8f.0
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2026 08:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784043736; cv=none;
        d=google.com; s=arc-20260327;
        b=XioW7DgbT9sSpvg79qhd25zZ87Tgbm0OrqHS4+WWRInun/+npp9HkIjDvQ/LecFoSm
         nC4l5p5AP6mPJ/YIBunABOO7FHCOQecZRT1RiUXLPOir2fyyKWS0ZtIvbaxfRUnZcFQV
         SIVidlTaP9KS/N81D5fdmfDRBfH59iJJfaUN4V/yCv62hRy2P0TmiC5HMSpe+p2QqHr4
         A7vWAGS6oAFfnJcbJbsW6gyLS2UBswnMaTXd48Mk+jcBGHWbKW6GVZI40P8NF00f1Hnu
         9IA+fc0YlXf0gypkUoCl08x33r6Ze2KE3JciFLU+l5dD3JnVmstuvf3iMExBQdcQkIUe
         azJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bFMwMWLTvMmruDXHajLVVzBdjpUaW16nai1w7KarYv0=;
        fh=EZlXgrGmzUMN+RsL0WDA2CM9cdhTf+VVZVyUnhTLmpc=;
        b=pEglp4/IMvlxxwjA31x7hR9tLsKQNBwrosVvW4Ew2PZzwBL34l/Re60MRKlZxzOhAS
         0KASB6BxIkMXDnqJ7/9V349Wvj0Rk6C22pRcDDYheoMTi91fgWaxkEGGAnOFYPss2M+H
         /HOWdNHBwdg+jHGj1rhcMuZYWnqnlkADUkaca++2mE+CmUCG9yODsD4EMlMWHPOewZ0N
         rpBLUsjC8AhpefZe9bnM7XkP4bcXStL1DevJTdOU3N4B8rgFG5/FFS9/XfJn/v7IHKr1
         3LSzWjp6nflQCoipP3Eaf+88f8TC+XUTjYAPXCFEXrOQyFu7bF2LiNDhY4la53LvJy08
         C4pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784043736; x=1784648536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bFMwMWLTvMmruDXHajLVVzBdjpUaW16nai1w7KarYv0=;
        b=IoBF+bPua6+u9KqI4AgZGFAoautr7lOViMlTn/lj3EKnMIvkczf8wve8jB/4xq7hTd
         k6g3YLbSpCKtUo7VbcXidr+1bcyO93JJpT2pHudYAIGYHB+sVgzoF0+3hlbsx9WjSR3L
         xPn2H4NL0XjnJyafQXzCovZTE0LZ8mHlB6YKhF5Lw2KtDwYYmuVjvroUZ0prtQpmDN87
         eV5nH0qO1sUOCmrf1YEYDtI1Apm3kwOBatkDWEnWgd5xdUPrzRLUXd9Hr0ravlpxBAdb
         XNmohH8t+XvX7rDOpO2Jf68ER4yVpzb4qSQHjexXDb3CG+4bCwOxGcv6GFKKCwunyMkr
         l96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784043736; x=1784648536;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bFMwMWLTvMmruDXHajLVVzBdjpUaW16nai1w7KarYv0=;
        b=ptcPKrbr/jT/8V3DeP+e8jya/xNISDCnGMlDBn5ambXBa07/52y5KDnh3h2D0KiiPF
         DOmm8dC3f/EUxVzHRE9Y2SwIVXjLCmJJcDxO76RJ11OldWxkoivRPie9NdbjbJqhzT42
         8EQBgK8AzFBaSkD8zL6d6KtkeyKgv9qv3f7JLJ6Vc2bK3TGDcw7JQIo1aruXsOPmSltL
         tLkBYZjStDyH2pPTSQuo2TW6ni9FX3qkSVwE3ye0qPWBXiWxZZyHYE27kU9uae/hWqbX
         R9NqRLniLWqgAqtacatCGg5W1lnyVS+ohx0Qi897wjxW9eeTPfr8O3uUVa8+yWm+YfkX
         gyJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnWXe+MJNDenQa0m4ZBoe5for29J0P2t6aMnvStojom0KOBhNGXJ7Baww+RC6ifsxsdlOobiQkTUZht0g05Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyv5j0fAMW6Lvr/N2BgTPlT2Ygd7BMvzwExe7XN/4GDwbqoTpH
	kK+Ko43KE1BjJ3TLjDWkcXPXRhG4s/rWPCXdKDlBQQ3CUjjRipu7TkPSRkD6XRhOOUL8q+R5hfP
	7VnHLdbqtdSSMNrJ7Npt82IzdbolVR+w=
X-Gm-Gg: AfdE7cmc9U97He3TmvVnKni4Sr5XP4LGkFK+rFZLTIYMfAL/gCTFwvrB+wIA/jJkm2x
	olTEeL2MTl/6WrKIZNZ43GZqHX9KAeKiSQl++P5F3APAalMEK7UA77ng/6I+HBWaokfCFy5fMTR
	NKbBqzI3vuippYUbFWZzgPBJWq+gz6tOKUHc8IYmp9atDzI+emdLSWY8otVP0vSE/1v5tpw4EDR
	WqkU+GBjmLUtlsDeDNSbFZow8P9Wc7luKW0arIH2cvsHN4FkdeheamOHhwDU/g6Iwe3nHMbAuoE
	8R6mhV8//1aWp2FZonxdDOjs5fOQ/HcSkP9TAXPyTcpxF/qcWhk/0Vn0IUA=
X-Received: by 2002:a05:6000:2601:b0:473:1ccc:15be with SMTP id
 ffacd0b85a97d-47f2dcf8b2bmr16217773f8f.39.1784043735618; Tue, 14 Jul 2026
 08:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702160457.1884345-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702160457.1884345-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <46cfa874bd2ce4b6189606ae391e24833c802391.camel@pengutronix.de>
In-Reply-To: <46cfa874bd2ce4b6189606ae391e24833c802391.camel@pengutronix.de>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 14 Jul 2026 16:41:49 +0100
X-Gm-Features: AUfX_myzFRk5zyRcC-DRg9lzaLxRzPGGbIhkzzOcp4mfT2S7yAzLBGupnIfXxos
Message-ID: <CA+V-a8sBuKRDKDWzwzzofLY6mTAWFHiGJvyaLq865BZuR6r6-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] watchdog: rzv2h: Convert WDTDCR handling to regmap
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-watchdog@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

Thank you for the review.

On Fri, Jul 3, 2026 at 8:35=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix.d=
e> wrote:
>
> On Do, 2026-07-02 at 17:04 +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Convert the WDTDCR register access from raw readl/writel variants over =
to
> > the regmap framework using devm_regmap_init_mmio().
> >
> > This conversion serves as a preparatory refactoring step. It allows the
> > driver to subsequently support syscon-based system controllers natively
> > by passing along alternative regmap handles without forcing messy
> > architectural branching at runtime.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/watchdog/rzv2h_wdt.c | 83 +++++++++++++++++++++++++-----------
> >  1 file changed, 57 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.=
c
> > index e9545b8f5fd0..d0b38450cc32 100644
> > --- a/drivers/watchdog/rzv2h_wdt.c
> > +++ b/drivers/watchdog/rzv2h_wdt.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> >  #include <linux/reset.h>
> >  #include <linux/units.h>
> >  #include <linux/watchdog.h>
> > @@ -67,7 +68,7 @@ struct rzv2h_of_data {
> >
> >  struct rzv2h_wdt_priv {
> >       void __iomem *base;
> > -     void __iomem *wdtdcr;
> > +     struct regmap *wdtdcr_regmap;
> >       struct clk *pclk;
> >       struct clk *oscclk;
> >       struct reset_control *rstc;
> > @@ -89,26 +90,20 @@ static int rzv2h_wdt_ping(struct watchdog_device *w=
dev)
> >       return 0;
> >  }
> >
> > -static void rzt2h_wdt_wdtdcr_count_ctrl(struct rzv2h_wdt_priv *priv, b=
ool start)
> > +static int rzt2h_wdt_wdtdcr_count_ctrl(struct rzv2h_wdt_priv *priv, bo=
ol start)
> >  {
> > -     u32 reg =3D readl(priv->wdtdcr + WDTDCR);
> > -
> > -     if (start)
> > -             reg &=3D ~WDTDCR_WDTSTOPCTRL;
> > -     else
> > -             reg |=3D WDTDCR_WDTSTOPCTRL;
> > -
> > -     writel(reg, priv->wdtdcr + WDTDCR);
> > +     return regmap_update_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDT=
STOPCTRL,
> > +                               start ? 0 : WDTDCR_WDTSTOPCTRL);
> >  }
>
> I would drop this helper function and just call regmap_set/clear_bits()
> directly in rzt2h_wdt_wdtdcr_count_stop/start().
>
Ok, I will update as suggested and send a v2.

Cheers,
Prabhakar
