Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11143FD0E
	for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661238; cv=none; b=HKo0D4oSApDgRTO/YyB2ts8TYHIhKw4tOo0BYbOOOjIoJZTbMNKy0Yhb9lfeSgexgjf3UaC4WgSLqGrDiCRA6uR6qU5xMYm6ybUoOT15CGMwEDN36avGQrYIcJclyXd70sJK5T2Gf1WBGATLGiUmVupFuggIyMKV4/LyWGPYJq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661238; c=relaxed/simple;
	bh=ok07ERH/NwgqhzqDl0baL8HLrodhlClduOLX6Z5TrNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gfw9ok8VE4OC0e202fLkyGIbrfVvxnP+opvARXwplJfU36VU7r8chfdLj7I0kPRlqlNnQgG8MeQw3YauRwnEy/7b3tBkSEACf4zXzHhtC1I5Gf9htopNg98tMPbiXuDz0igomsTJgmzU9A0Eo+0kMthZ9NusVyGvAsltJ+M1aKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836ce6cbe1eso67578077b3.1
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661232; x=1788266032;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PcH15y8twR6KC4dsUQbRnnIWb4o2clyuM/4NKdId/5Y=;
        b=lNUnBuohHVf9HP7hXQYSzbtcjtzocY6uotjGdlKkwqtgc7fpJM9ATveTgF26FXegXA
         mQ4TQAw6XDMrQXdwAyrP1wBpaXDzxWb2eS8CYvlU4gVPWqinxx2tlZiLcdP5J0JXDJqz
         /wpTSD1N8Ty77+orCRR0d+iV2g5tLIA/AWb47QbdYM5B6zu1T7x6qJMnNMWPtvPTjuSd
         ijLxEdJfedt/3J8RalCZVKj4Q0p3NkEhs8/42AYkToFT+3teSJIlb/XLM+aomvNC2PXO
         kiLcB92xWVz74dRaszH4RRuyCmIwNHMU2NWOabKpkTXtIPFYb5FJpfhCTPCIBZF+BsZ2
         CDbw==
X-Forwarded-Encrypted: i=1; AHgh+Rr569xnvuGl7JoAwcH+J+JnhaIAWeZubk/U4sIfakZycQkwKzXStXlLPvVegwVmlRSV0OqMo/EgYR+sIIqqdQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l/RLxFFhU4hGnZ6lxCdHyFYv0ePvMAsBecM9iOOwEqvrsX/aFP
	eD3PPNi6bg+qUehksXEEpiy8BU7FB+ADpVD8QhubdjgjSddNrxLWocOwUo4ibqFSpj8=
X-Gm-Gg: AR+sD11HV1cz/a61xQB5DbPaeRn4fVMjIn07+nHGzHhpB+NPhjGcswawZ6Lh4m0nMRK
	6WFdeqpMxmkLVSKZ2u9IDCl8B4fGmk3OrE0C+2i/ucQ4G7JWcDQnucNWw5qVdBy8g+LC6V0JmrL
	tVpr5kgpVZtEFNwxOTGSVFlTvw+Q9kcymm+/kjkKOVbMq9O88GpDptLC87KEQC5hf1V1Gsy8Wr5
	rjZ6iYokxdKSNvYv5oFZmlI2xKJB/z/skxf5ebCp5SD0vmvS0d+29Rhd8gQ9i0OHclL2qTT7UWD
	JxZLh5YeokxcB6fDaAycHbg6+wvHfvqLNk0aA3u47LJYRsBeD/6nwZK7P3/UgDCmtIRa43MexHt
	3IHYAld9KP8JqFN9cAxWLYPpIkBexky+0wy42hoI8FeSt2IlrUcVg/IK+C888USQW9Pgnc9O/hA
	YuMdsaEgQg3lopSB/kn0F5/ocH1hmuLwlXu+trSuse8j8tLuaFP0P7pX2tf6L2xeJD2QNPIWP8L
	Dsf24npbjevW0Yadm3+AD/8pQ==
X-Received: by 2002:a05:690c:9b02:b0:81f:2403:9e70 with SMTP id 00721157ae682-849f4e5fe5bmr143102167b3.19.1787661232346;
        Tue, 25 Aug 2026 05:33:52 -0700 (PDT)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com. [74.125.224.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cacacb78fsm47402317b3.49.2026.08.25.05.33.52
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:33:52 -0700 (PDT)
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66d1442b24eso1637975d50.1
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:33:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpVPBoLx3j3dk+lYt/RWzy63Eax+HR1e4mLFCYVstnS7qflCl5R/wXN5d1T9goz6E1E78fMATYPzZ8qnsSR3w==@vger.kernel.org
X-Received: by 2002:a05:6102:5094:b0:781:7ce2:1896 with SMTP id
 ada2fe7eead31-7817ce23603mr428191137.6.1787660899827; Tue, 25 Aug 2026
 05:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260817192540.423994-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260817192540.423994-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 14:28:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmoHO2BETYFrKT68D8+Ma_t4NYiFZ=DyXnT-HeCJq8yQ@mail.gmail.com>
X-Gm-Features: AcwNN1UWpDCFj0N_VaU-Rs-_PsGCZWtHQVesPIowDRB6pC65FgGL5i3thBl2XoE
Message-ID: <CAMuHMdWmoHO2BETYFrKT68D8+Ma_t4NYiFZ=DyXnT-HeCJq8yQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] dt-bindings: watchdog: renesas,r9a09g057-wdt: Add
 CPG/MSSR syscon support
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
> On the Renesas RZ/T2H SoC, the Watchdog Timer Control Register (WDTDCR)
> resides within the CPG/MSSR block rather than the WDT address space
> itself.
>
> Previously, this was handled by including a second register range in the
> "reg" property. However, this is architecturally incorrect as the CPG/MSSR
> block consists of two distinct regions (0x80280000 and 0x81280000) that
> contain registers for multiple peripheral blocks.
>
> Since the CPG/MSSR block is a multi-function block, introduce the
> "renesas,sysc" phandle-array property to allow the WDT driver to access
> its control register via this shared regmap.
>
> Mark the use of a second "reg" entry as deprecated in favor of the
> new phandle-array approach for SoCs that require WDTDCR access.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
