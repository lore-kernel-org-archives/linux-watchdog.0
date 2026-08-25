Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818033F211A
	for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661061; cv=none; b=gMhXAV0NTWC6SAVXpL7rR7R4IiE4E0SnL8CHF6yD/18W5rTn5aMYE3JU0acogJqXoXwhHAcgDO9zyqjBniQMqNDndIqLLADudmnx2rIlCa0J+ISTkzd/+VPwRmmtJFsSGEz6yh+RE74P2qs26l0pT5JU2MA3l4cnwJMfrhFOiYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661061; c=relaxed/simple;
	bh=XVZs/xqSmR+34+BrwmpxC0cd+dGU1Zxb/J9zlN0cTU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChFklvleClSaiRhy0DDQtTPnEdsnF7Xez9Qn51M7zqATl+u3vjbv/SQDZmJBhAF0efpaK+IZp1HjKNo9a19uoXFpb8531FGerbfrSYUI9iuR5G34ncDEdXMRUUPF8ainFTxMBUtw05gPT9/MqmL4Mg4ulqdzhv8UpcyqktNKZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-74aa416ebb1so1384569137.1
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661053; x=1788265853;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ILP07iJKBmCL4umuQJDRJxi/o8MvR2u5/1eDo+tc9XU=;
        b=P2E47emqOnZvK9kae8LdDDjvTQPKUMzeiisO09aqmLtfcYzX3jzBr+FzdrisEEouig
         9D/mT1g5QkLkDx3IPI05ZO4ze43cA4FQF5KoAjyPjC9sKGGIq0jcOhvj8BEzc/0lbYHF
         JLJjfzTTx2vb+U5RyvVMWOOfQqq4sBpUTDahOoYAh+7A/7Z0IOApxgLeot3oOkUX6SAC
         fsKiY1YhJmn1aqnmD/335xo2nj7cWZfH3uoWDwrhpHg0vpw9P0WNRyqLa6SXETyMuSHD
         I9kj9oUZZix/hFh43VNly5CjMxiunuSKnuV7H6dVV8wItb/lin7DcKqFBAs0TNXDJ8Cl
         4suQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1ipyzZEm06BlcQMzG16TVIdw3+LCb7aYRLdW+gv//ipEHAmE6RKOESfmFyogkN0gs5/OexPrAXefqBORpMQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l6GdVPEHdlhoBi2bxCvcAG+t9gYaAo6d270fWN2w9OKzuU0T3t
	suzuZU358/TlM/NAv9H9diA8TG4BdzwLbdIjhdpllv5y7JewIU1h1dQJqTaE7CTQTOA=
X-Gm-Gg: AR+sD13KDU3jYsXqFhSIj2EBV5vkl+/buBjZKQ+C4T9Z+urSwi4P8/MSRlRsxDbu7cB
	1eBJd6IqqcI+xImgi1notl2/LZQYGI9FaqK//Rz+oxYM6T9okhhYZz/7GCg5WgjM6y0hFlSzLG8
	Af0QmDJCnxj3gnFUUVqyd2l4/vIn2bJ2FgZwLK2jW0DIlHpNLcgGJeTcoEJjuuqF1vw7ufZHPUe
	cVH9I05edsO8CQk8yzDYZAP1awU8HBB2QBW+jUO54pO9Ig6ksUYugfZAuPo+zfcqZX61J8g4N8Q
	R0S8f9SB7M6pgqBiXo2gXUMsjNz3S6O+D3Bf3VjGPwe5xeyILOfd3wcb2GPij7Ie5oeiWEv5YV+
	LVBsr2iDsqdxdLDGCy2gJZFjT6OWRLovAOaXRJcsoSObg3mOTBi9dt9CBgFIX0J3aj+RDMUIZBO
	6QlwY4KUaLS/uJHACzvXbfcymDLprjEDb2DP4Zg/M8dbhFGAdr6rp6/9BVpp/LxmgVnCosQcTK8
	nV5jVtgZ26nBJDuTrQzuvOVjA==
X-Received: by 2002:a05:6102:5809:b0:76f:eaa2:6fa7 with SMTP id ada2fe7eead31-77a623259d3mr8804965137.2.1787661052790;
        Tue, 25 Aug 2026 05:30:52 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-77d85bedbe0sm5375794137.11.2026.08.25.05.30.51
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:30:52 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-74aa416ebb1so1384559137.1
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:30:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr7oTRwx3gQFvVbj6pBPBEr118OWwRkcvtNzn8PM5tEiqpT9aItk8btJ0+D86v+vCZcszgRdBMONXwtNMtt3g==@vger.kernel.org
X-Received: by 2002:a05:6102:5107:b0:778:4c28:6725 with SMTP id
 ada2fe7eead31-77a6434bfc4mr9788298137.10.1787661050975; Tue, 25 Aug 2026
 05:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260817192540.423994-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260817192540.423994-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 14:30:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWO8ARCZtT7m+bndN5szyzRxPwQmZ-GKQ+ho+yLgTH0bw@mail.gmail.com>
X-Gm-Features: AcwNN1XXro5QQ7iyl-KmnWQpVLzoicJmI0T4QyJFnTkTZ2UbLlORJ3tn7mvhDjA
Message-ID: <CAMuHMdWO8ARCZtT7m+bndN5szyzRxPwQmZ-GKQ+ho+yLgTH0bw@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] arm64: dts: renesas: r9a09g087: Use CPG/MSSR
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
