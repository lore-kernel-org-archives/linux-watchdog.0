Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E02305047
	for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958139; cv=none; b=D73DS7yD8W77N5x6fpMteiV8eOfPLkMqE2zF4gCq1pLC8M5xr0/obzTvCn9fs3Gp1rPkTZk5QStWo19UixM9FMFL7bVwtGt80GKqtGqbso7IMyJHeaiW3G1xeJV8kbQOo9F6WuLliF5KA+Ivz8GF51QldBCJ1EAnDV1+WTvAOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958139; c=relaxed/simple;
	bh=SJLknyw1I7ZFIFDDTxB/kCFRzM1gjizB92r2iOvY5U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lezvWjkwMj03Y2dVyw7jtSBmxZgPgVz22knVOY+ZL9mt1KEDcf2zH+vwGRYUSivdCW1HDkYzaXq0tfcG484I2df3Dr9TxRsmoKawEaLwap7fI6V90Mu/jN5+UbhdYK25qe/1mKRam6g6HX90BhS0+ZZzUs7bs5K2aiMbI9hEbkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso3425092b3a.2
        for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 08:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783958137; x=1784562937;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KSAbD3g9v/Qpert4xOPXdfLiWxHZNX0hf2rnp4eCCEU=;
        b=fRRoqxGK8361b4D8bjySk+7tD2HSzQmgN33aa/l9i2JhT/fvybTo90QfcRgu+TMHeb
         CUnNom0h6UftkUcnWKWixTaWjzNV8oEXWaWFCPhhiBBw924Gwz2MlbX5v5GcXzu+Dz+p
         Xl/kr8oQs8/wqUESAL/kwkBZlzODxLuCVuYQphGR/naAbKlkQGb3B41Th7Msjg3IyFCF
         OlkTwkWeCQl/nP6ivre+bYVpCOlVbSpDklcQqBzhJwPFsiZPAmIcBITZvHpvXGJqXJ1x
         6npagJTjptmeYVBbbjrXpMd9i3q2RWKLi13sTX73SRhDAtClXGCrK7sKW45EhONuAh9N
         vDug==
X-Forwarded-Encrypted: i=1; AHgh+Rqv6PcEw+mIrL//6/N+eU6FnpO/2i41QK1JrZ7/Kqlo+qcM1G/Q9raIxpaEdnekzzemnvdDNDBcPlaX7yHZUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGoD3T7ag3Il4q4a1mEp1fUByOHw+3v4rpetSUKWFo4hZgQ0v
	Wo2bHjjhsldJBknWwVK0WAhR322LhtxksvsnJE+xW0JK1W2hhgl9iJFtb2iEM5oLMDY=
X-Gm-Gg: AfdE7ckJQpqJhezOuicrnCYEfhymC1vDhdK/jmQZ91zO3UnQXSRca/7gohZA5Mae1c2
	RP9RnNa7zGjyENydxiL/vLxjkqHg9QL9O2cstmCwcY1DebWmfjDGjZdPj6rYfqBKaeh7wJGR9MU
	LmULOmvvcFXdpd2Rw9EVqmWUcjKsWyDQiuBKQgime2MMkGTrivHgHdJE++nkYoCW5LGY//GCGL6
	uD5Dq4jNZ8hEEs28wxuruXgbZ4ToB88tZvvtw8mL9SZF3KdznSPZAl+gMy6b9v/j0WbrPB6KrZs
	YawHCV864zAMD/g1qAHHJRvsJFz8XgONoNxrIW2tRiZvBgwH9l4Fz1e3dtTVrG/ZA2EdjT2BlPc
	Y9jtK2RUXOWG13TpWd+AByjbXWYSak5iW8yKyWFel+5ZE4/b4frcUd9sGcAvZbpiv5SsPoFv0OX
	V70Uc8q6spDWqM3O2dq0k7ucil7odsf3NcOoxIvpHf24uJXzbf3Ib3aEHnJOJz
X-Received: by 2002:a05:6a00:c84:b0:847:7ece:3426 with SMTP id d2e1a72fcca58-8488979782emr8605130b3a.58.1783958137265;
        Mon, 13 Jul 2026 08:55:37 -0700 (PDT)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com. [209.85.216.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dc7ffsm52035b3a.40.2026.07.13.08.55.36
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 08:55:36 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e041ea211so845837a91.0
        for <linux-watchdog@vger.kernel.org>; Mon, 13 Jul 2026 08:55:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RriXpOwHRX+MFfEFQm3zeCM9TaP+9m8fr7LezI4OMxyzQttnRo479ft3s7qhBwH2czXIlFlTF/CF0VRzQm9Pw==@vger.kernel.org
X-Received: by 2002:a05:6102:5605:b0:737:bfe6:3b03 with SMTP id
 ada2fe7eead31-74533bc9032mr5400397137.7.1783957799562; Mon, 13 Jul 2026
 08:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260702123112.161160-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260702123112.161160-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2026 17:49:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU62updtKeBBk-vO3YP+qaWTGqHQnzKvFJbrz4J5eEPMQ@mail.gmail.com>
X-Gm-Features: AUfX_mzILeHyjNiTkrmAQtVDJZX8rJj_P5qd9dfYE_6VlS_CSrZ4h4vly_PscUA
Message-ID: <CAMuHMdU62updtKeBBk-vO3YP+qaWTGqHQnzKvFJbrz4J5eEPMQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/9] dt-bindings: clock: renesas,cpg-mssr: Support
 RZ/T2H system controllers
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
> The RZ/T2H and RZ/N2H SoCs features system controller blocks for low-power
> management and access control that reside within the CPG/MSSR address
> space. To properly represent these hardware modules, allow them to be
> defined as child nodes of the CPG/MSSR controller.
>
> Update the CPG/MSSR binding to support child nodes by adding
> system-controller child nodes using a patternProperty, requiring a reg
> property and a renesas,sys-block property to identify the controller
> instance.
>
> Restrict these new properties to the RZ/T2H and RZ/N2H SoCs to ensure
> existing bindings for other Renesas SoCs remain unaffected.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Updated commit message.

Thanks for the update!

> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
> @@ -99,6 +99,41 @@ properties:
>        the datasheet.
>      const: 1
>
> +  '#address-cells':
> +    description:
> +      Required for the RZ/T2H SoC to define the address space for child
> +      system-controller nodes.
> +    const: 2
> +
> +  '#size-cells':
> +    description:
> +      Required for the RZ/T2H SoC to define the size of the register
> +      blocks for child system-controller nodes.
> +    const: 2
> +
> +  ranges:
> +    description:
> +      Required for the RZ/T2H SoC to provide 1:1 address translation
> +      from the child system-controller nodes to the CPU address space.
> +
> +patternProperties:
> +  "^system-controller@[0-9a-f]+$":
> +    type: object
> +    description:
> +      System controller child nodes representing sub-blocks for
> +      Low Power Management (LPM) and Access Control.

According to the documentation for the PRCi bit in Section 11.3.1
("PRCRN : Non_Safety Area Protect Register"), the low power consumption
bits are in the xx28_xxxx blocks?

> +    properties:
> +      reg:
> +        maxItems: 1
> +      renesas,sys-block:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Index of the system controller instance.
> +        enum: [0, 1]

I am not so fond of such "index" properties.
And of subnodes ;-)

> +    required:
> +      - reg
> +      - renesas,sys-block
> +    additionalProperties: false
> +
>  required:
>    - compatible
>    - reg
> @@ -126,6 +161,10 @@ allOf:
>        properties:
>          reg:
>            maxItems: 1
> +        '#address-cells': false
> +        '#size-cells': false
> +      patternProperties:
> +        "^system-controller@[0-9a-f]+$": false
>    - if:
>        not:
>          properties:

As RZ/T2H and RZ/N2H are rather different than the other (mostly
R-Car) variants, perhaps it makes sense to spin them off to a separate
bindings document?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
