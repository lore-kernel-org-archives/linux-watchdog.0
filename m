Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F31283FC4
	for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958519; cv=none; b=Thrx0uE1gECbdIsLI3yLFnNgg/0ORh39j6XBLJY1pB8deFYiwIMfMkmsPmMYOLVrcgM34o4Lt4tFJxbWeyN5KM7iKPndInQFljb+XckhZr59aH2UprvvXmXh8915Vp4vpr0ln3mxVVFGJikE7eMJOhDZLDQge8kD/g9BePvdYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958519; c=relaxed/simple;
	bh=m2bCXYj8AWrMF/1laWCVCT5bKqmKjFJ215Tf8K6H5u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfGerrwRjPFKOkH5MspA8DbZwSHsyn9zBsqxyQLywnyUeeLtnEhqnkrd71twPqZH4mGys1v4fOea1puofg35mATIDNFuFj1+aHjuNS0viQr+tPZq1pWhCDXOks+2D/ISgm1pJ1lSRGTShxcT6L20iLGLqcsuFo5dCz7i/HVO6Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81e6f2ee60bso346997b3.1
        for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 09:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783958517; x=1784563317;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qzEerLqOaw9Z3GkpXKkc+Ohu/zTEKX/5jHpFuADj7Ho=;
        b=QJraW6XQxTYaLc8WXw08O7T4N+/2+bEDuI+ZiHuGRcXb5Qbzc7EQYCy0QJvq+yQds5
         F6hyzKkWlXXgswNUcT5Fur+D+7d3htq8ev/k1YjXqle//YCIUNM49JkX9yPCDhkMkJDt
         G6RVwhUyapQ+vgQlzSCE5dwwvA86wJ1CdawALSLZrY2ecIVuCqg+VfqNPbd+8Q1xruc2
         3Pski8VlMGn8jdS/1j8X3Pgsf+1FQneQyZtN746clr6e7n5d0VJyxGdvMnXCG85pO6d3
         yDfQntO7St0X2E4RlRbZkJwXNI7heyrzlVPBrkHrhoNbp9HYjYquU0bgKLyiGegSWI/H
         h1iw==
X-Forwarded-Encrypted: i=1; AHgh+RowMEDgI1dbla7Vhq4EknKKmkiKfaDDbJIhyLU2pSSFFomryGvEWCoxQfcmsf27UJvNfVTVgOZCHXmDx3d8dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGa9BfnMNQTAELy+75FuMTP/gmLVoBHWE8gTdO/gwgMhal48iS
	DdLWSewD/yL1jPEbLsQ9vV6VBIlZDp9cUuDibTVk1JjKlGCnXxC1cVcIrHenKwthDwA=
X-Gm-Gg: AfdE7clRJEczF9WizyZ14JRXDoobf8hNGBJ7GgRii03mvkaQYHIbE8N7EcYrhSoWACq
	qdn9vfEJX+E94IM8DoSGohNb7Ii/PkNxJ32d2Jp2XMAgae0WA34JI65St9rwbKRuduSqCmhCQkr
	Ebpr4dtKNRL72mhxkO71BLkroYCyz3iN4FgeGT043GD8pgM8zN20zfdxmsYUgqP3DSnlW/4hQja
	MmrrFkUJ+lDUG0jjP8HOvgoiDdmCr5dNFSAELPhvQRVZKnW7DmKPirO6UxKGrTTviYNIsOIRQae
	68ufa3apKRHqm1FI6bxc5VtPnv4ADUE4CTcccISuIe9CwW8TuU6kxnlzOxs1itNlunHpIUGtRLv
	4TBze3MudKm7whOBNlfj72GDOIq/YtPY+2rmb6gjTQkBESB1JvbhwDnEq6WdVVLXqy9uQwoysAN
	P+uFPjwlmQLo+RqNVSLosOxuBwuYhhiqZypLiF3WJ/R19f4yexGyhZYO1vU6sh
X-Received: by 2002:a05:690c:e21c:10b0:7e9:ea36:f256 with SMTP id 00721157ae682-81e7bc560f1mr74509307b3.17.1783958515852;
        Mon, 13 Jul 2026 09:01:55 -0700 (PDT)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com. [74.125.224.54])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6bef1bdcsm118031597b3.12.2026.07.13.09.01.50
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:01:55 -0700 (PDT)
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664e3ed58bcso41446d50.1
        for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 09:01:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrZrfrb0fK+N9hbBBpvtXpVCD7yAk3eMixL5wW+arIXUvtfpeurIhMY3upRsVo7zf60wlz98VYg4U4xsf4BTA==@vger.kernel.org
X-Received: by 2002:a05:6102:610f:20b0:738:8b5c:a41a with SMTP id
 ada2fe7eead31-7450cb34f7dmr6282037137.18.1783958048566; Mon, 13 Jul 2026
 08:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260702123112.161160-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260702123112.161160-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2026 17:53:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdViSFTZZMe0SsC_aYmyZqTHCFNN0NxPVoNx5OBfwi4MLw@mail.gmail.com>
X-Gm-Features: AUfX_mxFOjb_ZRaEJnQ5ujkHKlta3EMpWEatCZQZcSke1bOSWzSUjDpkmkvLviw
Message-ID: <CAMuHMdViSFTZZMe0SsC_aYmyZqTHCFNN0NxPVoNx5OBfwi4MLw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/9] clk: renesas: r9a09g077: Add SYSC regmap support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Thu, 2 Jul 2026 at 14:31, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add System Controller (SYSC) regmap support for the RZ/T2H SoC.
>
> The RZ/T2H SoC features two System Controller (SYSC) blocks that handle
> low-power management and access control. These blocks are defined as child
> nodes within the Clock Pulse Generator (CPG) address space in the device
> tree. Implement support for creating regmaps for these SYSC blocks.
>
> Register the regmap using of_syscon_register_regmap() against the CPG
> device node so that consumers can access SYSC registers via the existing
> syscon phandle.
>
> Add a sysc_init() callback to the CPG/MSSR core to allow SoC-specific
> initialization of the SYSC regmap.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Made use of for_each_child_of_node_scoped
> - Moved sysc_init() to the end of the probe function

Thanks for the update!

> --- a/drivers/clk/renesas/r9a09g077-cpg.c
> +++ b/drivers/clk/renesas/r9a09g077-cpg.c

> +static bool rzt2h_writeable_readable_sysc0(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case 0x0000 ... 0x0008:
> +       case 0x1000 ... 0x1164:
> +       case 0x2000 ... 0x2024:
> +       case 0x2030 ... 0x2054:
> +       case 0x2060:
> +       case 0x3000 ... 0x300C:
> +       case 0x3100 ... 0x310C:
> +       case 0x4100:
> +       case 0x4200:
> +               return true;
> +
> +       default:
> +               return false;
> +       }
> +}
> +
> +static bool rzt2h_writeable_readable_sysc1(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case 0x000C:
> +       case 0x0034 ... 0x0038:
> +       case 0x0048 ... 0x007C:
> +       case 0x0100 ... 0x017C:
> +       case 0x0200 ... 0x027C:
> +       case 0x0308 ... 0x030C:
> +       case 0x0320 ... 0x037C:
> +       case 0x0480 ... 0x0484:
> +       case 0x0580 ... 0x0584:
> +       case 0x0680 ... 0x0684:
> +       case 0x0780 ... 0x0784:
> +       case 0x0880:
> +       case 0x0980 ... 0x098C:
> +       case 0x1100 ... 0x1118:
> +       case 0x1200 ... 0x1204:
> +       case 0x1400 ... 0x1484:
> +       case 0x1500 ... 0x1584:
> +       case 0x1600 ... 0x1680:
> +       case 0x1700 ... 0x1780:
> +       case 0x1800 ... 0x1884:
> +       case 0x1900 ... 0x1984:
> +       case 0x1A00 ... 0x1A84:
> +       case 0x1B00 ... 0x1B8C:
> +       case 0x1C00 ... 0x1C8C:
> +       case 0x1D00 ... 0x1D8C:
> +       case 0x3000:
> +       case 0x3010:
> +       case 0x3020:
> +       case 0x3030:
> +       case 0x4000:
> +       case 0x5008 ... 0x500C:
> +       case 0x5020 ... 0x503C:
> +       case 0x5100 ... 0x5114:
> +       case 0x6000:
> +               return true;
> +
> +       default:
> +               return false;
> +       }
> +}

This exposes a lot of dangerous registers.  Aren't they also exported
to userspace through drivers/base/regmap/regmap-debugfs.c?

> --- a/drivers/clk/renesas/renesas-cpg-mssr.h
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.h
> @@ -178,6 +178,7 @@ struct cpg_mssr_info {
>
>         /* Callbacks */
>         int (*init)(struct device *dev);
> +       int (*sysc_init)(struct device *dev);

I would rather call it "late_init" or "post_init", as it might become
useful for other purposes, too.

>         struct clk *(*cpg_clk_register)(struct device *dev,
>                                         const struct cpg_core_clk *core,
>                                         const struct cpg_mssr_info *info,
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
