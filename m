Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB2426D0C
	for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660821; cv=none; b=XxFn/0LukKbRiZf5xbOEOeBAvv+6XtDUjuwIgXGSWoa3AR3LeYR0SroQmJeQF7JvZWx7YtjmUoIVnmHNTL86CWALgaHVEd9FUm+kkSXcko0lh6d93iBIVCVSrgmiCKovP8/S94HHBEEnROO0EXlygdbmNCcaY4aW4/mk6Wz82KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660821; c=relaxed/simple;
	bh=gxH8SjRD1UIdTzPbcf/H8o8DZ5xZ4KITTBXh+NTJ9ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RI9I4v7tKAJKPEjqAZmG4zxFlsvTLIB/nypQwCAvD1jqsvvtgGV1zmNQXlibZLeeMlUw2tkYsjLHErKsEP+idgyP/TbnGW89SS2JmXHDX8+7MwSOSsbcRAQ1oozrWXRGm3SaWflA8fZ+R1UgqMfl4SraVGPZKknsk9AY7oGpKRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5c375a9e76cso3321621e0c.0
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787660819; x=1788265619;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3bNYZKHP963OmdqbLfjn2seFzOgtwyksbPN0UTH7ftQ=;
        b=XYv8k7YHBdceWSeukztGp82rSA1DutWUOzF609WEA6oR7EcKqMqHpHfqCh1Kg+QXA+
         113MtJhmI9aX+WA4Utvi719EG9QLzlwMHlZRwJRHZQDQv9lfER9vQoMw5OITCmxS1z7l
         1+maZKAaj4JAF/KIDs5DvuPD67vxM9FUCrAzICQx2lOJkHv6f7kvBKMOBPTEKEuu1Jy7
         wLeFxAKFWqPYmv0TSOLa4K/LqaEga6eHYSVArh4U4e3CcgfrlMYJfIkkBsSzSOxkeft+
         8j/mcD+rd2TOgPnq3OOegosiJPSTNUUs80+R1MIPIuk1KgZPFAFbNw8TF1dVjTqkuGRv
         cRiA==
X-Forwarded-Encrypted: i=1; AHgh+RqGUA3MsnxXKfXM/FRbtLb4ExAfB13WGR+s+/CRmz9rg7VA4dwlpfZYr1EE5jyJOr2v2PyluOBwWvmrJk8aHg==@vger.kernel.org
X-Gm-Message-State: AFuF++mOGIFNkkEdZ0yqsHCAqajdt/V1HWk7lR74CBTT8ira8ssBXe8t
	tjo7BNJuc+y/aW99B1Z5ysRvGTYpDiq0RffnF1uts/iMJBh0RR1xKXsdQ0gi2riRUYg=
X-Gm-Gg: AR+sD10zDKALF/hhEyTjtNfFxOlPD9Tu3Y2dpXYZZOI58oSQoFjEhAppq3qgnbshq7X
	/g9bZAI6PequBxIyxuzbVVw1/WMkktywbyGjSY0IjX+MSFoJnHUF0bJRlFtt67wjYAa0rF4Ais8
	2KapbghR7YsxfsVdFXrqHJUAV9QZAIMjoHUOdC0qnPFL+qn4nDppVChKkwJkJFfZcWurhsz2XYk
	K7x8ZdOo1T7LPQLYZYdKctg9FUO1UBWy93v0YIYdRgVPz58GZXHreOT7j9XsNa8WraDGjXBQGDM
	Snw3jj6ZBPUjMifXF8JIoqaobq4ewUnCNFPJbM9dSxi+b5Vs/fuygSHe7RucCJeXiissVT4sqcR
	yw2KTXfsPez4iXu4KK2cpHJcLf3k0e3myQOLWDzML3RwGZtlI4X//Hxgr9GGJVZpoNedhglbncA
	mfC4OyN8bTEruWFtfteZBL7UzHnms/tRbjjJuuGeM0k5BuKv0B/PKeAvxTMsxjo0yVTrfzZkQ9P
	T22YEaKzUZ+Jvc4P8tCMaXUOw==
X-Received: by 2002:a05:6122:8c8a:b0:5bd:9c71:11e with SMTP id 71dfb90a1353d-5c642dd3d89mr2571844e0c.4.1787660818655;
        Tue, 25 Aug 2026 05:26:58 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c623f1c717sm5890213e0c.16.2026.08.25.05.26.57
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:26:57 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-74d55dac06eso2679813137.3
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 05:26:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrS7cBFFC+nIHnORLEzXfnzBzutrL9e16AQpMUyif2OeOw9BkEcb6gULHDrEe4tSlvxwamNaeIKVfqE1Dopgg==@vger.kernel.org
X-Received: by 2002:a05:6102:e14:b0:77d:a23d:ae70 with SMTP id
 ada2fe7eead31-77fe9814c27mr2237403137.14.1787660817048; Tue, 25 Aug 2026
 05:26:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260817192540.423994-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260817192540.423994-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 14:26:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUtApMoHKg7v2CqNTQy4EF0sEzmSfQimGySgTcYjMwXEQ@mail.gmail.com>
X-Gm-Features: AcwNN1U4dCP-EqOtN5skyICgGBt3GttjfY4cB3WPPEIKKuOj9_pFM74mnwgkrag
Message-ID: <CAMuHMdUtApMoHKg7v2CqNTQy4EF0sEzmSfQimGySgTcYjMwXEQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] clk: renesas: r9a09g077: Register SYSC regmap
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
> Register a syscon regmap for the System Controller (SYSC) integrated into
> the RZ/T2H and RZ/N2H CPG block.
>
> Unlike traditional Renesas CPG/MSSR implementations, the RZ/T2H and RZ/N2H
> CPG block also integrates the SYSC, which provides low-power management,
> clock monitoring, write protection and peripheral configuration registers
> shared by multiple drivers.
>
> Implement the RZ/T2H-specific .post_init() callback to create and register
> a syscon regmap covering the SYSC register space using the CPG device node.
> For backward compatibility, return without registering the regmap when the
> mapped resources correspond to older Device Trees that expose only the
> legacy 64 KiB CPG register window.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3->v4:
> - Dropped RZT2H_SYSC_BASE macro
> - Added array of base pointers to the r9a09g077_sysc_reg struct to
>   support multiple SYSC regions
> - Merged r9a09g077_writeable_readable_sysc0 and
>   r9a09g077_writeable_readable_sysc1 into a single function
>   that checks the SYSC block and offset to determine if the register is
>   readable/writable.
> - Added RZT2H_CPG_REG_SIZE macro
> - Updated r9a09g077_post_init() to call of_address_to_resource() to check
>   the size of the mapped CPG register regions
> - Dropped changes from cpg_mssr_common_init

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
