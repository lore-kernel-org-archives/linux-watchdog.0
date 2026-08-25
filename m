Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486B3E6386
	for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661323; cv=none; b=hNeG9PVlwjZdi9RG6poKWadspUtqJuW2OBfEvSJAIzwhKzuGg4qRP4oXa/wcjsw4x0oTzxiSITkIurmI3ypCf705l2IqviloC8asj5z9gP6KCKN67Wk1VTppgX9CsTzsOJcJ2j8DORogwWbOdMGKLwzMmkTb2LB0jc7TFI7tmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661323; c=relaxed/simple;
	bh=vTlIBThix6p5ACZNkCu4XDSKPza1TCok1RZWv9Vcpu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzqj0WObqSr1PVTcBwJ5622eZ55oGy00Iq7hySsYoJBXPa/J45BaQQaUbhSNgmHfxkgx1HD5dWuVNIf7i6DlDCNpwspNOvl64apWSdw1PJMU9pJ7NWDebpWqfM19GuwAkk88A73jAlIAu9Nlo9BiJcJ1l1cojFqW8fh07A/rN5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e347638adso4426868a91.0
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661308; x=1788266108;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oIDFWZS6RDEUFbtSxS2ibtPun+j6l9sII3nkgLpimSA=;
        b=dFSfptH75sEBs/ZVF30+0BY0x0ICtqnn0ipPaKB/3ereta52Gt2AKSYwHTaLAJW/9G
         J6gho55I0u4rRpuqrhjiyMtfsv2RCgJ1f8LSs2bVN9jvB191eIAOmqGb8iclqnrB2fiU
         JlivKie49UsoLAbuPuFExx09dMSVBHYAvGEcknDnTfav15hPa3ytdZDEv8tH3bZ8tbmj
         n+MBIzLqH+6YxE2e7uJb/1hUH8GYdbQ78DsVO3kxNQy1dDgwVlAOk13I2V5HSjGDDjKm
         szVVRXF/WWcSSrRAV6ckQPYZsBVQ/X5vvXND0eP8n/m+MxeYCTTTMQxZrDwbwXJ/9GbA
         VGAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpc5q0gfsPxETVSIW5onIOogOAs65abAe6vTzIXxO/BL5RJ4xTIyIMfn1Q3vNfWV8F0L4Z1ouTeYZskTumzGQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lY3578PExnvvH2vw+Sm8Rnn/ghAH4fOdeuOHl77O3Shz2soeB4
	eKnsBGLwF6RPgOYsbeYgLPnBb4xI/T3xQBxinbu1Cep6VXRcj4Kr8B9jZ2DXgN+E2Do=
X-Gm-Gg: AR+sD11Xpx9mIWd0anvrWEEPm5wQB/F/LjBi6wx253/F14jHiqoR84pCCyLjrs7uL7W
	doCiMrneqr/mK/YN8EQsf3HyaU2Lnd3vwTKDengisSRK+pSABDBBsNEjt7FGn4QvYJZddpy7wro
	QjgIE4X9tEnzOzcN7SrbBgGKQD39p8Jv066fYi/v9nWFVbpM/OnE9fa3e6wXvM8qWrVkctKP9QR
	N6QZAKyTcWHBmw+gAXz+uq5hZYWj+98rydLS/JZ0qiN35QL4tjpx1kEpBjEs7RLPHpCj54x/Ooz
	OYEeOhxpahac3zxlbjfKPJfHf4L0h+LSUO2w5KJPreFFXP3unarlBhDkxOsYxXoT097xY0OMz4L
	hWYw9uTKV1bpaYPyDqOhN7tRInB2Eyj+093Goo/OnzjxFjwvmA0FnMuliJjoqeRJeHtmmg9CLeT
	m5rclLf+x1shF4ssG7xUBC8qrFKTniSyDNEuUQxVRBJOKhzAHFbSSKcAnduIsVJ+ZUc11lyB71X
	X+5+DhYPsS0BKfi+KnuaI9HDMoIKKk=
X-Received: by 2002:a17:90b:3b48:b0:393:1cf4:d972 with SMTP id 98e67ed59e1d1-395dee55f7emr45118212a91.3.1787661307696;
        Tue, 25 Aug 2026 05:35:07 -0700 (PDT)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com. [209.85.214.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b8000bsm3778150a91.9.2026.08.25.05.35.07
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:35:07 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d6f9e2f681so3782415ad.3
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:35:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoPr8VaC03SZL3cQpsHr0xF/A8EPoljUpJGZeI4eireAW1ozZlXFkMRByW8ioMa/PMrWOwK+E350WOmrW3+Zg==@vger.kernel.org
X-Received: by 2002:a05:6102:956:b0:778:9e3c:5760 with SMTP id
 ada2fe7eead31-77bd288c901mr8408694137.11.1787660869267; Tue, 25 Aug 2026
 05:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260817192540.423994-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260817192540.423994-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 14:27:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXyq0pO-ZDMiSx6k5HoT4Y1W+Ov2KRWRr_OCE_ng8BEVA@mail.gmail.com>
X-Gm-Features: AcwNN1VVA1JsDEFfJkQvCcAZH1nZvL8L6xNDA-rPHWfx8tfe-s3NaRctdvNNt_w
Message-ID: <CAMuHMdXyq0pO-ZDMiSx6k5HoT4Y1W+Ov2KRWRr_OCE_ng8BEVA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] arm64: dts: renesas: r9a09g087: Adjust CPG
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
> On the RZ/N2H SoC, the CPG/MSSR block is a multi-function block where,
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
