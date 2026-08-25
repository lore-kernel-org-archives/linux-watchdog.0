Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C142D77B
	for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660854; cv=none; b=Ks7k5bpubCIHduVJtnN0mVhJj03Ii8hbOURvR03nf3WFWkx0H1MLlNilC4fgjfJrJMQJqfOxiegLgev4mhP2FzceruP/r5HedIvrRtO//FAZHnKr1XHwmpBZr3xefc/EtQmhXyseA01yUSMm4tIVJJMI2ttBjVXVK+bxh5pgVYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660854; c=relaxed/simple;
	bh=4nRcMnRQV+AnDLfqURNbts14rQ+nBGEFB4Rm66x9S30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlihBu81XxOoTcXYrN7U11WwOEX2yyJrq82RIAEShBqYQ2OuCv18ogUGfv0LzAcS7TN429srtwvCzWDtLDZKIZWdhiailX856EAF31xxrfH2oJq6SeGmWzcSQSAlBkFABnG1DMtuHCCLKFu5ReHnxv1uo6jOtDRKzHsHOm79nh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-754acc61e10so2088556137.2
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787660851; x=1788265651;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9/HktJJBeHHkHA6w8idbfeQ0ukYM1XFsMvOe4prisg8=;
        b=TvewB366om7t/1GgTZgcnhqZjirHsmipbH6G4pD4qNVbzusyg4BUp2SLGIeGxZr15j
         B8x95Rf7lhcjUhaUDJXWO3mXSI5OHilYOrysHmqMhjD9yPQljmngFgmQzcTy3NFqc5FT
         xT0O1upzRyRpemHDVA9/XnYumay5u+6YhHttJ7IMfRLI4r2kwQZPabu2R1mTbFZw8PkN
         cQ1XUkhptL/C/4zp0pPusztJyKBkSyxOKQEHt7RQEzFZS4nKJIMyljrGgJ+VWgImf0CT
         HnafX/2dYgm+RrIszPBBXqrV243Z1/hADCyV6L6xlYQYHJKT3PtAhOrsmVdkW1fxXrmS
         6u0Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro3HKeEt1svFVYWhC24A56p8FcDvHKQ6ySDG1Xb+OZpM86rZDGdaV7xrrDkVacIOpaLGbfSIx+u6zSBrpEnHA==@vger.kernel.org
X-Gm-Message-State: AFuF++l/qoen2zjsfnc4516pGPRTxvl8dnWEssxbkeb/sQ3rEk1FjLH6
	bbgGF3ehyWiKk3f8b22SyyPfQRB96oZ2j5Q8rit1zjRhpgyPOlSnVfchNqbwNcp1byM=
X-Gm-Gg: AR+sD12QDFgPnAIsNpli2j2eJe02EZdcBJ2EKfhlJ+MlHxMyBry+GSI+oHNhW5kVfsG
	vTP4BGaMFdr0IAQE8HNqLDw345cWO5yt1GQnMfoc3ZsfqtBIUWDBoFJ2CXchO3nMU6GfVbJfDRQ
	c4fea2++HWlLlkzK0+K7KojCdpcehw7y1T7/luQXt1O3Ltyjs0OYM4x70mfS8g05bqKvNU/Tlse
	OBLsS5F48fPq+lwpC02jVhs/Y2mGDRV8hCPk07YfzZhMsp/zWXYzzBnmMVDlmmShRJOfDKega9m
	1bq9GVFOpQTjS/uyIQ/QYoYPHp4jp9ybLgVwqZdanVBms8o6QJyZQXFN48H4cKotipBDmQMgV3v
	RgmWas9aUh4EzVEI9srgTE3Jm1neeqgr3unnkBhpWA41V4WtBdyPAm+wFolliI3vAMe5E8yiGjl
	Dm+mq1erEve7Z++culHufZ/8X/C+Wdg50XysddAhd7oXLGhAAKeYFb86dxlOgHJiIlHCVg5TRv3
	T1wq5ah8N7R1CS90FSJK1VF3g==
X-Received: by 2002:a05:6102:290f:b0:77b:ae7:1bba with SMTP id ada2fe7eead31-77fe779aa8fmr2197179137.3.1787660851189;
        Tue, 25 Aug 2026 05:27:31 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7804c715dfesm1021800137.3.2026.08.25.05.27.26
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:27:29 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-73a442f7cd3so2460750137.3
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:27:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr6xHhkiTIX57raQ/jsrlZrj8PCNbDouQPENRCZr+zuImoSOh8NQHCAbWwyo2RPQ9w/+Mhhe+G84xg7vJQZBA==@vger.kernel.org
X-Received: by 2002:a05:6102:f0a:b0:779:aedc:88c6 with SMTP id
 ada2fe7eead31-77fe357cf7dmr2091702137.0.1787660845781; Tue, 25 Aug 2026
 05:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260817192540.423994-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260817192540.423994-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 14:27:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUxeZ7gQiqE6VzDEF6NqgQyqO9bSnGkyyOxmT8zg62QqA@mail.gmail.com>
X-Gm-Features: AcwNN1WRL_UGP8kr-vdoVNnxkPPKW_sCIe6xHhiuRgRsERD9dSDy4YtRIX0EpTw
Message-ID: <CAMuHMdUxeZ7gQiqE6VzDEF6NqgQyqO9bSnGkyyOxmT8zg62QqA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] arm64: dts: renesas: r9a09g077: Adjust CPG
 register region sizes
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
> Increase the size of both CPG register regions from 64 KiB to 128 KiB.
>
> On the RZ/T2H SoC, the CPG/MSSR block is a multi-function block where,
> apart from clock and reset handling, it supports other features including
> clock monitoring, write protection, and peripheral configuration registers.
> Expand the mapped register regions to cover the entire register space of
> this block so these additional features can be utilized.
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
