Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0F3C1D42
	for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959999; cv=none; b=lLyQapSy2eEnMS0EvuY7UC10GbrrC4JJFxcj0Qy4DkyyRmr/pNXCL9J0IKs3SJFAsmsm5jJEKUqidmGG8Y6spqDdYV5KoEuXdcux/k5IhI+rlZRaCnUXuUU8PN8/jJer8K7VeGeiWIuyN0t+Y3Uf5LTPBEHA9vgfyuXfHHbZjMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959999; c=relaxed/simple;
	bh=LCHeg9vuB3FBvkWntuAEI5uvGJN34D18AlJx8xCDtak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMDEdrHm6W+ZchNnrzepqy3e5A2B+46QC/20Hb0zPLB1PI5lGM02j0OhpGzbxP8LLZrohpj57DH+GrUAGIDZoYktFqhJkpTqt0lxP6qq1PVxn00tZPcLZMZGsRV4gVvhqnp8GcKJ1Q2u2x3i8OTueCM5MVlmE0JZh00stEl7Z5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-765c077b5c1so832979137.3
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 02:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786959995; x=1787564795;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3UFyHhdBqPN0GbhgGILHuViQXldTAJKU85xm0W0LQ/w=;
        b=J3bvjyh10eUf5nqti0g7H2ASzsxi5hLPWXpXabRmrgmQFk4nfZiQM0wkAkKFov/09A
         Kq+8vl24oioO8aCqlErRT2YTeHJYlGfXikl4hcpplpZ8I8X/hDQagvd2S2dWKUBqhxYv
         NMVOhLIjgB+lUMskcdtbRiWWrmDCBnEKe69IrqY2Mp60VkZRtrucZ0CXIMagrb25toHk
         vRC/SBwY++hobuHK9rfPydKnerUw9vc22pnrm1gH4Kvv7tf2DV7xRFA4Z8ZUwTJboNld
         IQaOgE+X65gNrHk2UAi2H7gVR3NyTK1fARHSq6vkvvMVqBltI7UxRqj6Oc0obicsGn24
         eXbw==
X-Forwarded-Encrypted: i=1; AHgh+RpRRrIt+PYjjjO92pNM7m8QV/YX8Ug7lIBd2yGFrr+1lScC0BS8KEDdQKTB+7UT1UhJ8T+EV6b5+UZ+2rpVVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzThp0Pgr6e3jndpUhXQAyB22Ruv9C2YWqfpSHngKf8ztUTGdgn
	2RZo6puTJnhf054m6mcKJjw0e+ckyPa1jFEQ/SXE5DchfWTRChmdGUZOjX3vnAlq
X-Gm-Gg: AR+sD10d9O0dmSQws9xnK5QMR8CV7ReJ+Fz80f/uYDsCtjrf6V4p2CdmAbMm2jf1+U1
	GdQuqQCHbQryI9B9RB3hA93+yJeTLebj9dsQKm87SaE501RkzAHQZxfNbgJJmp5euODNfM7I5SD
	eGq9rsIPVAzm2D3FIi3+9sqxbULEw2Jdf/lKVIi1xzWqmp2c9dOwrjneiJS48Od1vICZm4erff2
	pA7kTRqcNzbnZ18goUL22XGm+C/SSSraC10Ym/sMojKzbJmdQuoSlei5mu8fZm91uPLpmvXDxNn
	nQorwqrTiJvf+dvUQc7hLVK+6TTos6wjODFv5Rx3pc7j2T3n2L0XaCYsGj80hrTzfw+3p9MSP8k
	f77neHymlHKxJfZfe4U1F5quubChSAU5gJx4fUsDZgRYSt7oadMn/i0k55avWwza7cLRrHAs8cL
	OYJy9WoAzLmPLlxxsDFfV0KiQu+t+w7uP1nH9ouiCUh3HaK9eA41qzr24PWPXk3+N2Ar/Ps8Jwn
	PTooHZm5EC+CJqfjlTgDSC1MfpdNg==
X-Received: by 2002:a05:6102:548c:b0:740:177:f357 with SMTP id ada2fe7eead31-76f2b301b18mr3926540137.6.1786959995518;
        Mon, 17 Aug 2026 02:46:35 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c2c2fbcc9sm698854241.7.2026.08.17.02.46.34
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 02:46:35 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5c56dbc3a51so774037e0c.0
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 02:46:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpra6hE0fpPIeZUfN5lI7jiy3sYAlIP3aVGfmtFMKANz8EshqfVpAWXQY8B2OH1C/wjxXRKae2KPUeIwBVMdg==@vger.kernel.org
X-Received: by 2002:a05:6122:caa:b0:5bd:cb34:1b70 with SMTP id
 71dfb90a1353d-5c591c98081mr3829490e0c.1.1786959994433; Mon, 17 Aug 2026
 02:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260814191415.2110732-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260814191415.2110732-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Aug 2026 11:46:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKy1QOh6vBGf8xFGTw0c_htgF8JYA-VnDH=muL1G03EA@mail.gmail.com>
X-Gm-Features: AcwNN1XeWYM04fSzyWxMFlNboGEYsCueoJUOD-EEgYm_hkndon5OVe93-Hsyb5Y
Message-ID: <CAMuHMdVKy1QOh6vBGf8xFGTw0c_htgF8JYA-VnDH=muL1G03EA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] watchdog: rzv2h_wdt: Propagate WDTDCR access errors
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Fri, 14 Aug 2026 at 21:15, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The WDTDCR helpers currently access the register directly using
> `readl()`/`writel()` and therefore cannot report failures to their callers.
> WDTDCR is located in a shared syscon region and will be accessed through
> regmap in a subsequent change, where register accesses can fail.
>
> Make `rzt2h_wdt_wdtdcr_count_start()` and `rzt2h_wdt_wdtdcr_count_stop()`
> return an error so their callers can propagate failures.
>
> Handle these errors in the watchdog start, stop and restart paths and
> unwind resources acquired before the WDTDCR access. In particular, restore
> the reset and clock state and release the runtime PM reference as
> appropriate when an access fails.
>
> The helpers still return zero with the current `readl()`/`writel()`
> implementation, so this change does not alter the driver's behaviour by
> itself. It prepares the error handling required for the subsequent regmap
> conversion of WDTDCR access.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3:
> - New patch, split from v2 patch #1 to make thing easier to review.

Thanks for the update!

> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c

> @@ -234,8 +250,19 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
>         rzv2h_wdt_setup(wdev, priv->of_data->cks_min | WDTCR_RPSS_25 |
>                         WDTCR_RPES_75 | WDTCR_TOPS_1024);
>
> -       if (priv->of_data->wdtdcr)
> -               rzt2h_wdt_wdtdcr_count_start(priv);
> +       if (priv->of_data->wdtdcr) {
> +               ret = rzt2h_wdt_wdtdcr_count_start(priv);
> +               if (ret) {
> +                       if (!active) {
> +                               reset_control_assert(priv->rstc);
> +                               clk_disable(priv->oscclk);
> +                               clk_disable(priv->pclk);
> +                       } else {
> +                               reset_control_reset(priv->rstc);
> +                       }

FTR, this else-branch is also new in v3.

> +                       return ret;
> +               }
> +       }
>
>         rzv2h_wdt_ping(wdev);
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
