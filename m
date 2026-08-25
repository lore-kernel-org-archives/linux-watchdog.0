Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9763F7A9F
	for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661779; cv=none; b=D3SRQdTOhQYMl6ktK8FHR2e50xFXnAD4GB8SDsTEmpUmPhr5bLPTCIRZr5R7VNt1VD1KXDIcIFLMpqf6TzW/fmHE+QrYDJwXhfpsyA4GAOSCu5WxN32vnkoxc0ErVtFMLX+OBvSPusvtgHaUls5e6XvLzVzfTR4knoKqTwqw7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661779; c=relaxed/simple;
	bh=BcysfHHMDstXivbjZE4dC1w6FzsNC+WZrmqLRhvz6SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqJlsNGF9DzM6o0b+p85eHoVcT+QvI2ow1samFK34sQGzWH9fEdODjTYOI6DrNq9oFirn1zqXgw9hRcDbZA20I1V5A4AdkQY+DBRTSWGxHdos1OoWeXXeJmZEs35Qd8BnmmYDlBUlSQMo+6omHptMlTnFnbYJr+rTgCWKOSvV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-74ab99038afso3122143137.3
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661777; x=1788266577;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FAuCi43bXWigOjfK7f2CuiM69Vlx8oB8xWxV6AGHKlM=;
        b=PwhPxrv1sQ/kcVwNjzuERMYGa2kJJkTtOZnzaFsm0wAk5H8om0VkysXn42Fsg6wT8o
         PIptVJ24XkTdhXN7wbUxDtE0FtFst2ypLT/bPC4vnWMf6EDp2+ZOtKLwMlpup3DGSaOw
         GCI4jdjUQDXHw1wGloK+Ld54AReDHoLaDBN0ncWQtInbMk91q+zK6xzhsDl9e1KjgDYr
         IFl6UMlxTiESfqsv9X98XYisULQ9oN7guxa5O4sbwlFrgqLwoT/gWWgz5oWFALIxUV40
         yz+dtkj02DaNHlRx+rb4mxjSf/vnWokq0pLNOKlYDwuU4/T+dpKPE280bgaj9fbf0OgC
         0T9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpjodRKdSzhcbSmJ5HmST4T4SMT0AGWGvTxqtWJ1EKDK/Rj1NFFdnbrywSuMKEqJhLd63yCTYMxLbWgbkBvEg==@vger.kernel.org
X-Gm-Message-State: AFuF++mskVunAUkphV1qUyqYKEgYjXj0IlS1dXvBZBbmCkAyfq2AOcam
	7G8a/AEayeI3PrkZeCjjs5sEcmS8yXuJNe4G6mdj0Z8/T2Djms1jTiJWMCvjaVfrwlI=
X-Gm-Gg: AR+sD102Ru0eyxrMY9ERBl8XD6x/NqDBDeGKVQE+Bj9XOYVocYJZabc8yk0fZXnNdZh
	//DK9lH54/1xnZzpRRV8lIqxSBYKkKin0OyD5i3xmgvBd7xm87JmiPPOD1T3F09TooQ5JZh0+KN
	8JCa5mldCMM45wCvbGDgqSKRNKpT3CdWWNQk96MflE1PFIFqipb1w/SKQ0q0rnIcdq+IDgS6vAc
	gjUua9mtalKWS033ef7ZBjiefH3C2T/5DoYDe68SJAM8Y2esHlfGMNGEHiwwBARaN6nNPYe+R6W
	iOW/g1mN9bpR4YRQz2R5Y12f+MTk+mFGJsZlHvAPT6dPx/aJEwHRhJ0ugTsGLU1llOnwPJ5LVkb
	Gh4WJCrjuNjOK4Ej9bwHiQm35mmJqDMo9zJ93N3oZYkjNhDwL04zRdihmYYMdcG7KUotbrkgYqU
	cF7XEuN0/BodBzHg0508m9BkxihU4cXhYwQCLbOvg3nrXihfwYhnxcNzAyX0dGDG7G3MSty87bP
	FTq9UoNUwbiRjRzhKIjPeP5Khn0uw==
X-Received: by 2002:a05:6102:3f9f:b0:778:9429:d51f with SMTP id ada2fe7eead31-77a64a6ab62mr12593089137.14.1787661776767;
        Tue, 25 Aug 2026 05:42:56 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-77d8357da32sm5244397137.5.2026.08.25.05.42.56
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:42:56 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bfb3347dc4so3563488e0c.0
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:42:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrxchRcbj4i5ebqMKENXZwrNeI4dQ0JdW3wWn7glUYv5Vxr3cbQKcejVmLDwGCoP/ZDfaqjw9XOY4GAMBPBoA==@vger.kernel.org
X-Received: by 2002:a05:6102:3c9d:b0:77b:b14e:b6c5 with SMTP id
 ada2fe7eead31-77bb14ec487mr9899299137.9.1787661286517; Tue, 25 Aug 2026
 05:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260817192540.423994-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260817192540.423994-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 14:34:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWL1xCSQn4RxL0ZMbu-AK0LiYqE6auPte=JMjW7V9-Arw@mail.gmail.com>
X-Gm-Features: AcwNN1UVUdruDxPmpux1ubwC61QQoEBBzyg7nu52qu_lQAz246VJGDaKtvYgKE0
Message-ID: <CAMuHMdWL1xCSQn4RxL0ZMbu-AK0LiYqE6auPte=JMjW7V9-Arw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] watchdog: rzv2h: Add syscon support for WDTDCR
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
> On RZ/T2H and RZ/N2H SoCs, the WDTDCR (WDT Debug Control Register) resides
> in the second register region of the CPG/MSSR block. Since this
> multi-function block is shared with other peripherals, it is exposed via a
> syscon regmap interface.
>
> Look up the SYSC regmap using the optional "renesas,sysc" property and
> derive the WDTDCR offset from the watchdog instance index.
>
> Retain the existing MMIO-based access method when the "renesas,sysc"
> property is absent to preserve compatibility with existing DT's.
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
