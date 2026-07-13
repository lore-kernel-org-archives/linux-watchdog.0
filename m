Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85430567F
	for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958108; cv=none; b=hMRV31vqxi9UfWEc2MGMIudcVVZvYl0sbKyQ38DD163H7LRbKCrSmdSb0zaEEjexSCFuQzgWsKH7+Ei+9vUDV5tZqeoJ7wwlglkCIKAGOnpTKLJWgvW89ZO4safF7XntuU3MON91epqY8JkJYipWnzGh3CnRLqIVRbOfDprB9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958108; c=relaxed/simple;
	bh=O5pyFLw83Ql+8EIFjSrZ0kqwUIJfbEiI35BjR/8WVDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lijD7HiiRv+r8xq6GIz0p0jqbkZXP4xRYbpz1FHwAfcgaZ8SDSQiWe5viYz5i2F/5xGVpnEWW3JOwhgp7mKMQ8F/ux8dK+BYvHMQw/ztWawkSy2t+yGrSvRH/C6ezqaHqD/S4T7/ZaVpD10KP+eHsVY85CLFdEpMNreffpBYuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9696369925aso1114237241.0
        for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 08:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783958106; x=1784562906;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dGAf88p06+MskhwY7uBe/JNJCrwrqcblSzHwwgSV5+w=;
        b=AE0oDEm7/ZIet+Ntva6Iodg6Z1FTMvYBkILmvu+3htsHnKw0i+8W6f2hti9e39RCND
         TdYeON0yRvUgvldWg0AtO/PiFqH3+q72amLVJBCP5f8vClRm0dK+/K/iYMRRs5h1Znww
         +wtFRBmV5EB5J5qDBoDtcVuUzSSSMVD2FMzfJEezptmH3NDVxB/6ujPS+SmhNc92ntdQ
         FEFg0xNBah5Wxsu9NTGs/FiobjYxpiR94kCgEw0vs/+9+S+SiZlQCIrCj82gXSjo1lae
         0uCLnyg1UzlTo8vSZyhRZQiZasHx99/y7QdCU1MYI2Z+d2YdDdXLgjGa5USQ5i42yGQU
         9ZeA==
X-Forwarded-Encrypted: i=1; AHgh+RrQTlyzOqk+CkyErLYNicalaCAcZ2fyUEx4+A3KuKsq7H2ZoEbRQD00Bc6AvHqVFex2UkJtcfSEUXocX+86qA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8MRybs2g1uOV+466SiGRhC1e5e5e7O3B3Ld6OgBh3lwxub+R
	rFta8ekJqVz3GevGnp/Eww0YAIP3+ZKuXT6JEo8skiqX5wM0Y/IOwhXl70R7NTZqAhc=
X-Gm-Gg: AfdE7cnkpqfpf6e8TjV3myNne7ojeM29PGbdONqqWrnrS6whz8WYgzQYh/J8/VsnMLK
	J/BNSFqEYIBPBd8N3kWBCezNq8VRhkaofXvATHXCLt4z/LejsUz0mNQH7O3dmy6a5O17sMBx50y
	lC0wk4ER+IW2HneTLFO4R1wNWmxJocF0qHc3dtXGgPrIGP0xq4BWaMgHCuw4ABmny52e2dlmmgI
	fBaa443AiKx87Fqogvt8D7fUhJ1MNJksT9O8pK/gWenoZyopKHdG1dVG3VbwJ2fU9xFhG9L3SeC
	/saUtulacJhDjF4RxH2a9rzq+p6V7b9KfyobUTiGFdaTK+3XZer6so8Kgko+9JmMxCS+WO01zid
	Y2r5AP73GEGk+BuAMMB9u8ubJyXrMpikLhGmyFnzI4ijytzarFMvjChgvwKbd79LZ0aWEBLKxRu
	SdoPUYKEdESJsfxA318DtHHRW1KuEE7mrZg5AvX2HKXhWY5IfYWQ==
X-Received: by 2002:a05:6102:50a3:b0:722:a46b:2f2c with SMTP id ada2fe7eead31-7457e8e365emr48551137.15.1783958105851;
        Mon, 13 Jul 2026 08:55:05 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6a90d0csm9353326137.4.2026.07.13.08.55.03
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 08:55:03 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9696319e14dso1356160241.3
        for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 08:55:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqZwpMnzfxVe4QLuxASPZfb0UedFNb6Zqks/nuuluSqoCUP3+4aodE4zB2AXlk2JwvtvDpT8iT6hDLGLZK36A==@vger.kernel.org
X-Received: by 2002:a05:6102:1626:b0:739:8c52:f2b with SMTP id
 ada2fe7eead31-7457e8e369cmr48584137.18.1783958102735; Mon, 13 Jul 2026
 08:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260702123112.161160-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260702123112.161160-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2026 17:54:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXYpDfoRhgfhqeU4_acGQj7f4ivEdB3Ms6SKeeSwY5iLw@mail.gmail.com>
X-Gm-Features: AUfX_mxzgD_hAyuoiso0jWBOVR76LgHMAUSKVimBZKTOAwoA2LG95DcPvI9LrPM
Message-ID: <CAMuHMdXYpDfoRhgfhqeU4_acGQj7f4ivEdB3Ms6SKeeSwY5iLw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/9] dt-bindings: watchdog: renesas,r9a09g057-wdt:
 Add SYS syscon support
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
> On the Renesas RZ/T2H SoC, the Watchdog Timer Control Register (WDTDCR)
> resides within the System Controller (SYS) block rather than the WDT
> address space itself.
>
> Previously, this was handled by including a second register range in the
> "reg" property. However, this is architecturally incorrect as the SYS
> block consists of two distinct regions (0x80290000 and 0x81290000) that
> contain registers for multiple peripheral blocks.
>
> Now that the SYS driver provides a unified syscon regmap, introduce the
> "renesas,sys" phandle-array property to allow the WDT driver to
> access its control register via the system controller.
>
> Mark the use of a second "reg" entry as deprecated in favor of the
> new phandle-array approach for SoCs that require WDTDCR access.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - No change.

Thanks for the update!

> --- a/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml
> @@ -48,6 +48,17 @@ properties:
>    resets:
>      maxItems: 1
>
> +  renesas,sys:

In Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml,
the similar property is called "renesas,sysc".

> +    description:
> +      System controller registers control the start/stop of the WDT, and halt debug.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to system controller
> +          - description: watchdog IP instance index
> +            minimum: 0
> +            maximum: 5
> +
>    timeout-sec: true
>
>  required:
> @@ -73,15 +84,29 @@ allOf:
>            minItems: 2
>          clock-names:
>            minItems: 2
> +        renesas,sys: false
>      else:
>        properties:
>          clocks:
>            maxItems: 1
>          clock-names:
>            maxItems: 1
> -        reg:
> -          minItems: 2
>          resets: false
> +      allOf:
> +        - if:
> +            required:
> +              - renesas,sys
> +          then:
> +            properties:
> +              reg:
> +                maxItems: 1
> +          else:
> +            properties:
> +              reg:
> +                description: Deprecated. Use renesas,sys to pass the offset
> +                             of WDTDCR register instead.

the index of the watchdog IP instance?

> +                minItems: 2
> +                deprecated: true
>
>  additionalProperties: false

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
