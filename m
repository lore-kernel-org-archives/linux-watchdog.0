Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0849A4F55C0
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871031; cv=none; b=PgyVc5QOu9D4kMhvVat745++xpeKCYlw1fzIk7M9TSe3QbRYHIYECgn+/MzqHB9Xid1i1rUzeudbMx1W3G9Kh6GiHHMgPKs2SL+ZsYF2fw7kkDgXnrMvgu7f5Ya8hyWpLIMkOBi8KUsa5O2x14Wcx32dZvXin1/+Y9SD/0WswU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871031; c=relaxed/simple;
	bh=xjqICCjmH0ghryW8dOBfRncjaOxBbTFkSNvlzCO9/PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=issiqyly+v4BRyDevrAUwFSYz/nE+4AmFivL8KZ/DF3nAkcNeciNGQyadPgGoPZ0gnfnYDZl5k0Wm1TSWm3hsTzxrPWmFn2HrilVVJqYIcXAEo9aOfKg+ov0Jlw8So5FkdkPNti16QkgujprF5s9pmoWAYo+hea3AU5cEOKnnvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4b38ea4c63aso3563104b6e.1
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 05:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788871029; x=1789475829;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AvhvPfE1o8U9V0xY+ZBtjmprcW5MUShi55REbbGvMBg=;
        b=ZIr4rYLajxmzlgtgt91jda2mdTraOAEv7LQ0Dz4+OzxfQVTu4CGbyhiSs7A/rF5QW7
         2slHYXRo74mJq4vy9MxRbVVYC+BqScuSvFqDoxSrkBOrmmnz+6wgUp6ooQ4BguQa4rc6
         Yzqcg9gEVygm3ER1/qXbgKAgYy7gxfJmaoss7QApz/jbB3rw8Jwt0Qd6KOTn88ZrZoho
         Y9JHYsIbk9DJD9h3CpsRHCrrNhkgmtFmAHql0oK51XjIc/sDk9iyNrHUFBUvhupkyecS
         ZhoAdgul6QD8JoZLeEJuHMNpYF/M5F+jDvbbWW38FPYGLpQWie9k75OoAsVa5lI9TgN+
         HMAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwt51gEp0/eDy81IGQkqWyCjDS+/UXSSuVdTM7a4obQ42lN6v+bQ8JbLx3GRCPhf0S2XHUZ/MbopxSaOLi57Q==@vger.kernel.org
X-Gm-Message-State: AFuF++le6AXjjndJREEGZeKCJFO+C0O5Y/SRN9YaR5XgTrpCbWkOIU75
	gbyChzcf8f/DZCWPvz9giyH5kxGF7rKpa6PZ6BhfZdwhcUw/tjKOkoyKmMuwEDQx
X-Gm-Gg: AYBFou24HecTjhZ55k03Y8SYgciAhX4oneyEwJi8w8w+8mHzfLb3hSJ64/ZcpyOsmFR
	LAZnvkN0Y4rg4POAyanNtFT3g++jvhywV/T8EJTZrcYwEi+0ZzE+IEzwfxKwaWd/b1hfDs0b/rc
	W9jSIUDgAt6yk9Sszz89ld2Vj1BQlJKkcXtFSGDw4JdGmLLoIk4e8fjrh6Qjav7dJgMIldUO7Z7
	s4DLp20rAM2Krb2PlLPAd8YJD/3NRinQNXnwh8pHlhWZcoPJfuisru+cUQXNZwrt52cu3qVjW/5
	PXXO7JNwut/ZuJ9lTh+oq4xB6IGid/zhIsFEO/gmtjIh1I/9q7SUpcFKxnBpD0gFOb8YAmwhXMj
	hEsIHfRQoYxjS3hctYtEiTUM6exNbs/fqnZOPznmPXUAdgOiAAZKtKOrtcWLMaDfUY0R8ED/yGD
	AXy4srFu9O79W0IlUO4PUog3gE5sINSHy2JhjbGkUxJqKoIVe25jOhsZhEwmK6pbSA2AP+KwIIy
	b5OoPEFGLgM05xRGoY08f+7sA==
X-Received: by 2002:a05:6808:4f52:b0:4b3:94b0:1ad0 with SMTP id 5614622812f47-4b96047ed7cmr27502185b6e.5.1788871028635;
        Tue, 08 Sep 2026 05:37:08 -0700 (PDT)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com. [209.85.160.44])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b96eaa508asm13785441b6e.1.2026.09.08.05.37.08
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 05:37:08 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-446f87b6de1so5735237fac.3
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 05:37:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx9okIhBLUimw1MHFfyEpmKSnKtdQTjVtyFSSqkcjQlJy2rN2tu4HJJogcB2j0pRBsPZ3IAngArPB7dK9HCdQ==@vger.kernel.org
X-Received: by 2002:a05:6102:374f:b0:784:b9ec:913d with SMTP id
 ada2fe7eead31-78a4a91b281mr10556868137.8.1788870699731; Tue, 08 Sep 2026
 05:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Sep 2026 14:31:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXBFu=W1MnEA+Eu_zzUy3qMyFRbbeLgYn0waxMdr5cAnA@mail.gmail.com>
X-Gm-Features: AcwNN1VHwQtBXkE1g5B-tKWZHl1EPxPwrUnATnMeQZH1DQxtt1IMi9pdue90c-g
Message-ID: <CAMuHMdXBFu=W1MnEA+Eu_zzUy3qMyFRbbeLgYn0waxMdr5cAnA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Add syscon support for Renesas RZ/T2H & RZ/N2H in
 CPG/MSSR driver
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

Hi Prabhakar,

On Mon, 17 Aug 2026 at 21:25, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> This series adds syscon support for the Renesas RZ/T2H and RZ/N2H SoCs
> in the CPG/MSSR driver. The CPG/MSSR block on these SoCs is a
> multi-function block that integrates several system-level features beyond
> clock and reset control, including clock monitoring, write protection,
> and peripheral configuration registers.
>
> For the other IP blocks to be configured a syscon support is provided in
> the CPG/MSSR driver. This allows other drivers to access the CPG/MSSR
> registers via a regmap interface.

> Lad Prabhakar (7):
>   clk: renesas: r9a09g077: Register SYSC regmap

Thanks, will queue in renesas-clk for v7.4.

>   arm64: dts: renesas: r9a09g077: Adjust CPG register region sizes
>   arm64: dts: renesas: r9a09g087: Adjust CPG register region sizes

Thanks, will queue both in renesas-devel for v7.4.

>   dt-bindings: watchdog: renesas,r9a09g057-wdt: Add CPG/MSSR syscon
>     support

This is now in watchdog-next.

>   watchdog: rzv2h: Add syscon support for WDTDCR
>   arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access
>   arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access

These two have a hard dependency on the first five patches, so they
are postponed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
