Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794240054;
	b=hg2pB8LHhKnJ0/yIQxZghEKBoXVfbo0B072359EbC+iVFlhR6jtlNKmKssi7+npqk4Zb
	 rDhP86tZintNofefQgV0Wfztg5vgfe1s4PQxOq+wFFRatP+cCPIU2+sgjM8H12ivqLL7w
	 dkU0LkuKmCRAkRigX9v7qITqQQRvg0P8Eu/BL43ybJD3e/mc00Sog3izVL8EryJJbqz6s
	 CHlFCqsy9MUTWwiitgYUv/tBJQHxi5qS0pPgiteza2iyQNrkW+pqFoMKzEDv5msc/fnhC
	 br+VTa31cDKF0DDtQfoYxWFQ2QSL1wZG8UImVbbMB0MMem/4VwaeYiUPKOWFz6zDw+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zUAAWlNbR6q9k12Xva7G11dNMgLZ5tfgag11tYRdXFs=;
	b=2OKugNwQ0bWxEWMwAzRd17EcRh5DrUFc+4Iscj0lA9Svogp6QHO0SZkwelwT7884NDLx
	 ffDJgXnlVBV0pqBNhH6jmKhD2efooC6AOpYtgMpuKiD8bFcW4OAyZSLX9uV6QtQrSDoYz
	 tqERIhWMsyO7Najusyvmd5nVKdyuKMLoFLQqb4wF/zBDIFEQ+m7C3Bhs3QYFX6QnDNxMz
	 yEqC5hWIQtS6TIF42PewX+htgdKRKNnUBBJ7sQ6T76hmkHZ8oLEcj86tIftJBdVytvLv1
	 rNjDiw7hHG0BjySTHGfZwQRtSxy8qRao+Fv6AxNL5r2KI5drYuda37a6saDQAGF/IaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XsshOqMz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF260A262D
	for <linux-watchdog@vger.kernel.org>; Mon,  9 Nov 2026 16:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BDF260A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XsshOqMz
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b581b6b0e9so1156045a12.2
        for <linux-watchdog@vger.kernel.org>; Mon, 09 Nov 2026 08:00:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794240052; cv=none;
        d=google.com; s=arc-20260327;
        b=E3GD0kg2Vf+aJw6A5iGsQDdek5SJdFy6mBrr9koI5CKOTBySWqlE1z/E1r9KQkzVbI
         eBjr+R3PylFNuvk48pWSwfLyqxchLJSaq9/FwzbZHc47m5lIQHjo81QfhYw/m7VnA01t
         Mqq910R0YoG7k2dT8ypjrnx6d/g19902JkGxYBRjZhAOTsxSv6zdfk9BKjr7htCyJpL5
         fmDePvClVZaxqhkyVwQp7uOunZ8SyvWpYk/STBMYRJrUlFY5FV86We8BwWIQUMmlLy3p
         2GH1xq5Kt5ZY9Z6UT1E1D7OUCXGx6LyD/2//mi+FiGP6LxqHq9bYtLKhk8VoI2f1iGas
         wc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zUAAWlNbR6q9k12Xva7G11dNMgLZ5tfgag11tYRdXFs=;
        fh=lheXYQJh7Jfrd/c7UUGeha9VtcRQiTMl4qq5PxEybtI=;
        b=CQGatGwzs47YyVV2k9KcWCH7XEGNSG+xfXWzwha0QCCFfmn/NVCzMxkDshvYGA6uye
         kgOifJAjJz6MV6Ctab/xAI6t+xjiU08JcVmUa3nVdeHjBwwvZ5xJ0zprDkJRvxcDY0tQ
         XLVi1mFRrrNLebWutKUrImPsO/BSyf42IBEtQBHR+OkEjAmiJbPxqphiFNfJFttaatA9
         reVUxHgSkbJtdu+KcytdR9cxb6fZIOCPSTKgtxRMHiiQqy1Ttfh5B8NlohV5AhSjUNYv
         wsNjy4Q5rbaJ/SXHbY+R+hMgJU0zEmrJVRdP0C00lJuRvyQPXgMHyyr2Io/RbFUM7zsF
         ZfbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794240052; x=1794844852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zUAAWlNbR6q9k12Xva7G11dNMgLZ5tfgag11tYRdXFs=;
        b=XsshOqMzA4g7VkUFJSMBdIgw+TyNKoOTeZcdXvA2/JueLosVVFf1C1anFVPFqzsdm/
         +il24/vmlBaJ+7GEebvhk8L6xeucLXfjMgk4BCtasOETmK2ilY0mnGPZJiMUCECbmIOT
         qh5NN0+nRWZcTbaiPUHeRJDKjbLLCNKGkgeHK/ulASwD+SBj0PafYUVdA+gU/Zk9PmDe
         sKkXNPtxtGoHTWYE2OJRyc/+zykR19F3iaUdLi/Zy78CpfTt4Q6And+Wj4tufyBodwVc
         ctKxYkiw3BSI0Tx+qZwpeeuCXN5Fwat8kOF+OWPx7UHHKkU9mMIV0n+rYKpkal3eyCj/
         71Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240052; x=1794844852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zUAAWlNbR6q9k12Xva7G11dNMgLZ5tfgag11tYRdXFs=;
        b=jJYd6hDpyqwuduhrkipFmMAywo+nQ0hJ4YCWUVvybGv5569ckoyRu7gqbnCA/K41mN
         0dOn+FGDblZ/EgQWj8x/YXrl8FGOc0bruetA3W1xDYMuhzw+SFndEuMiKlyPWuhL2xbX
         CUwv6vy3KwVM9GfHsKIQ5FWqlhZgSYXNBD+ng7wBllNmlquTzmET0Ia3kUlvX7RVHj/L
         /IhzUiBa741/YVzlT7ubcvu6WQ39vXIQh9h4bDkJ9Oiwg5cNOZbwg2bmUZZAQ8mHWfYY
         zBubrzaTUTwg8EdRrJvv/ASTiREt63eRkVQPg7hnHGAZenQBMso38o1Q/ktHhk6FzM4k
         ZmUw==
X-Forwarded-Encrypted: i=1; AL+hErHs0ngcAIAFqkO4NoRqws+rVxtqNf5PoDCFlclRT6jw3D+a1iqrQPx17RXC2pW7GTSwKt6tNpjC9j9PkdKeUg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+vCLq40Cnz2ESLLctjwHyLmZ9799d2xUCrHBgmwVHvbVZuyHbU
	Gmz0nF9g6f8xYVZIPKNG7lGdGPRo+uFuSbXD8xmpvZJ/+gIw6wUpgXFYkyJigTQgwjwKPUqswSy
	rVKrkRvFFjIXY3ckGN9tzbuhldonHp54=
X-Gm-Gg: AYBFou1PCyQwmqgkVDy2e88OU0i45eRfKte97t4pQM20IrnNgHxo844y16YFNwz3jeG
	f8j6bx0D7kIw0QPDhkfFMTzOwy7vp3e+uGqgvp7YSO8toAEEUqd41MhWrkcvBbgkw449G66SSa9
	CxcAxeTTHAp34sE8BBLB6lUwrplEnv9S1TDOf5s3jRbuFACx+TrfqTTeuD7JqRsOzMxqlyxtgm6
	MvQEI8vACOrcAajBQxc8AR3E6oeldhr9k+6PM0Sxbnvorow/mh5EggLd5T1aaQgcGqGj2e7bUlO
	qD1Z8E5nOX8bviX/g6jIL/bu0lyKALGaUQLPWRf7kszwceglbVnLRi1OA0uODAI8+x4sYdBZnva
	tJqaBzK41EYW6fXDTqpFStCVB7ImyhtVWjCOhtrOxZz/XXnDT+juhqVtsve+i7D2gBe7l7MFz7x
	x08D7vjT86bne/HfVpCB5P1WA3BMfevAQJQ2oxP01uEfDDYma5EwJQN7rewA==
X-Received: by 2002:a05:6402:3908:b0:6b5:47d6:a8b0 with SMTP id
 4fb4d7f45d1cf-6b756afd795mr8207a12.37.1794240052060; Mon, 09 Nov 2026
 08:00:52 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261001165201.763882-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8u-3NFryZA_8GN=fR09+fcyvNGLMV-09z-mPXTePxkgvg@mail.gmail.com> <744d20c9-9aa2-4f3b-b42f-cfdd0a17da65@roeck-us.net>
In-Reply-To: <744d20c9-9aa2-4f3b-b42f-cfdd0a17da65@roeck-us.net>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 9 Nov 2026 16:00:25 +0000
X-Gm-Features: AclHuK9DoJ0CyffK9_ibsQ9MndPimemnqbVSvRuC8icXaKh7HkxYXoo5YAyMhM8
Message-ID: <CA+V-a8uHLK4-GFhWQO96yHBDzXYXQ+aggbWfskzXsK_17dAKCw@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] Add syscon support for Renesas WDT driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Brian Masney <bmasney+clk@redhat.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Mon, Nov 9, 2026 at 3:28=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 11/9/26 04:27, Lad, Prabhakar wrote:
> > Hi all,
> >
> > On Thu, Oct 1, 2026 at 5:52=E2=80=AFPM Prabhakar <prabhakar.csengg@gmai=
l.com> wrote:
> >>
> >> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>
> >> Hi all,
> >>
> >> This series adds syscon support for the Renesas RZ/T2H and RZ/N2H SoCs=
 in
> >> the WDT driver. The WDTDCR register is part of the CPG/MSSR block for
> >> which the CPG driver registers SYSC regmap. WDT driver now uses this
> >> syscon to access the WDTDCR register.
> >>
> >> These patches were part of two seprate series [0] and [1], out of whic=
h
> >> certain patches have been queued separately, so I have included rest o=
f
> >> the patches into this single series.
> >>
> >> Merge strategy, as the WDT driver now includes renesas.h header file,
> >> the driver patches can go via renesas-soc.
> >>
> >> Note, patches have been rebased on top of next-20260930.
> >>
> >> v7->v8:
> >> - Dropped patch "watchdog: rzv2h: Drop enabling clocks in the
> >>    restart handler" addressing Sashiko's comments
> >>
> >> v6->v7:
> >> - Added a new patch to introduce rzt2h_cpg_wdtdcr_count_start() functi=
on
> >> - Added new patch to drop pm_runtime_resume_and_get() &
> >>    pm_runtime_put_sync() calls while accessing the WDTDCR register.
> >> - Dropped propagating WDTDCR access errors.
> >> - Dropped converting WDTDCR handling to regmap as this would require
> >>    resource address comparison to get WDT index to call
> >>    rzt2h_cpg_wdtdcr_count_start().
> >> - Made use of rzt2h_cpg_wdtdcr_count_start() in restart handler
> >> - Added if regmap is available, use it for WDTDCR access
> >> - Updated commit message
> >>
> >> v5->v6:
> >> - Used pm_runtime_put_sync() in rzv2h_wdt_stop() function.
> >> - rebased on top of next-20260922
> >>
> >> v4->v5:
> >> - patch #1 is new addressing Sashiko's comments to avoid potential dea=
dlock
> >> - patch #4 is new addressing Sashiko's comments
> >> - Dropped checking rzt2h_wdt_wdtdcr_count_start() return value in
> >>    restart path.
> >> - Handled the regmap locking in the driver and introduced nolock
> >>    version to be used in the restart path.
> >> - Added review-by tag.
> >>
> >> [0] https://lore.kernel.org/all/20260817192540.423994-1-prabhakar.maha=
dev-lad.rj@bp.renesas.com/
> >> [1] https://lore.kernel.org/all/20260814191415.2110732-1-prabhakar.mah=
adev-lad.rj@bp.renesas.com/
> >>
> >> Cheers,
> >> Prabhakar
> >>
> >> Lad Prabhakar (7):
> >>    clk: renesas: r9a09g077: Add helper to start WDTDCR counter
> >>    watchdog: rzv2h: Use pm_runtime_put_sync()
> >>    watchdog: rzv2h: Drop WDTRCR_RSTIRQS define
> >>    watchdog: rzv2h: Drop runtime PM handling from WDTDCR init
> >>    watchdog: rzv2h_wdt: Add syscon based WDTDCR access
> >>    arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR acce=
ss
> >>    arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR acce=
ss
> >>
> > Gentle ping.
> >
>
> No feedback on the first patch of the series. If you let me know which pa=
tches
> don't depend on it, I'll be happy to apply them. AFAICS that would be pat=
ches
> 2-4 ?
>
Yes, that's right. Patches 2-4 can be applied without the dependency patch =
#1.

Cheers,
Prabhakar
