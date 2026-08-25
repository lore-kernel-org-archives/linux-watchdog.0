Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFEE44063D
	for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661492; cv=none; b=Leex6Ua2UXLpAUU8syCLyTBW2cDpYCgcExN3pC7qxPDbvsmhWBcKzy5sIhRpn9IQsDHAeIuDzfs1P169F0mxRCumufw9Aij7TyWa13rVzQcWidnOs2yADaV8bOngz2edT8WL2nV9tLINVJRXHezZeBjId5TjU89EOE3lqxMM1bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661492; c=relaxed/simple;
	bh=XVZs/xqSmR+34+BrwmpxC0cd+dGU1Zxb/J9zlN0cTU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=offtjuSz1Drv9nBc5PTQRdb7GSiAFHyihULunhx/XzoNIm92NZvDAt6gStJ5HY/EYOb3ACafRQQopZ+FVHeB66cTZSAwVaBKLEFL7iq9L+Vi8fl/pMKHzDk79WfbgVlm7E6Rq7X88CmGvdb1QT68dbAT6TFx8ZrAPfdXLeK9o20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81ea0b7d137so41949757b3.2
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661485; x=1788266285;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ILP07iJKBmCL4umuQJDRJxi/o8MvR2u5/1eDo+tc9XU=;
        b=jTZm0DqCXdtHlkQiWyQ4SdTRrn2GiLmMKobyD2DUWGjymDysI/NKRBky6wjIrZqB2O
         snuSa10MCbKc4iRYsfxE7fKS/ihD3bo/18d4Gzz72NekfcfdhDHqIb3FhI8RTuoznSUl
         spUL5NP9H9elCa0cPZ21CcCYPTyxe6UD2cpUlUEP5YtrQg7in7+xVj9rZgDwsJklZ/1a
         A0xkQwQM9DGtqiaHf2Y8Uixww5ui0GjOUbvCIfOM4HIU56/dtHwFOdU5+K6zqoclERj7
         fRc/KyZs4x7oNqPI0VdPb7BvaadUO6fMIHcJ6Dv8DYmGBjwOp8gMeHW+tznu3Ugh/bep
         jUZw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9+4XSSuV5V+uxXJCbHkIirbIxtGvm2IUjqUAhPRe9FcV3DjOgSofoqJWu7V7w0An4/1NcsrVHczaCkQFzrw==@vger.kernel.org
X-Gm-Message-State: AFuF++lXTE+mWiub0/V9y8W2mFPq5QkR6TRWnl9Dvy2zUBdkvN/X4g6E
	eCJY8xTdJEVUjlb7oV1Z2jjD/nF5qkQW+cDbTdWpMDvt+RnMnyvVmVZH9FxiEhbWj0w=
X-Gm-Gg: AR+sD11btjiRXyD3gpbpKF8aRiLmxzkGRcjkSCSYThuQtqZRPeMjIZFfBbryywCxFwG
	2AjOL5PxwIe+ft14r2yxzqrk3S6jgP6GKYacA052Kgy6IP5MAXb5h3s07M6nzmkoffSBlcPfTGQ
	yzHTGwlEG/dzq7XAJm6ZFKnoyf1Oe+yIkvd6M+Ou0+ucKOK/q6xFnUQLirtHuiDBmElSCEYBe8E
	wKs9FQklXhFPlR7GnCbVz/O9Cliarmbd3LnPeF3gLp4gYUmkPPWXtZ4aXZkTGve53EfTFLgMgOz
	4nZ8SbXPzdDBZKykfLmh+TPA8M+1NFGkPA4DNSSh2K+tN4j5Q6bz9S+WBFW7rc10+I3GIslDltd
	ZLhoCgfvbZGpU0OMwOyEWm8bk5GaVDCgURaXqavSF8aZX4gV6P8RD0Ybmx2U41DFcoHTyjD76D3
	e1Z9tNYSBTmzG6K8me/tmyTqCCCdIaOF78rxNRc5lTfz9oMwpwbWXjHxDMjh0Q9WGFUMEQ68H+r
	dp8POLS73yMVyh4h+dm+TLsTdegmg==
X-Received: by 2002:a05:690c:39b:b0:81f:238a:1709 with SMTP id 00721157ae682-84c9c39e156mr82035937b3.34.1787661485103;
        Tue, 25 Aug 2026 05:38:05 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85425354e5asm15882737b3.3.2026.08.25.05.38.04
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:38:04 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8565d77c277so3500567b3.0
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:38:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RongKJf1nIiDvZNJm35XAGocr7tEliS4DUQaRzk0YCpjRgKWKbv7DOx11hurALPmjrz0/IBUTSXheLfc2tU/Q==@vger.kernel.org
X-Received: by 2002:a05:6102:fa4:b0:778:9033:e337 with SMTP id
 ada2fe7eead31-77bd12c12c9mr7782019137.7.1787661031227; Tue, 25 Aug 2026
 05:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260817192540.423994-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260817192540.423994-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 14:30:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXwbEUjqxWyXFK0WSDh5B_hXj5n5iH4Nk3_EpBVQDbtMA@mail.gmail.com>
X-Gm-Features: AcwNN1VMSQ32o_cnpnsTpSPX7r0kAj3W65LFTE0SdyuxEiBV0BGPSBvqvVU8GfE
Message-ID: <CAMuHMdXwbEUjqxWyXFK0WSDh5B_hXj5n5iH4Nk3_EpBVQDbtMA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] arm64: dts: renesas: r9a09g077: Use CPG/MSSR
 syscon for WDTDCR access
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Aug 2026 at 21:26, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The WDTDCR registers for wdt0-wdt5 reside in the second register region of
> the CPG/MSSR block. This multi-function block is now exposed via a unified
> syscon regmap interface.
>
> Replace the direct mapping of the individual WDTDCR registers with the
> new "renesas,sysc" phandle property pointing to the CPG/MSSR block syscon
> node.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
