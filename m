Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68808442114
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332870; cv=none; b=dCRq1W/HtqI8jvxtLuTfmNKEex1vRRx7SP34Wt8d2+fxZgJkOCu07eOS6QOMpBth83CB+Gl0DNnDsK7PKTbRU5ioCsZon/Nab1pHUddfmcgJZcP4n4XhamOL0w8vNnwD0HR7K/kcT6pYoaiz1c87SWyWlagQ86mxNqYTJ5z2o4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332870; c=relaxed/simple;
	bh=OuqZyyZKufM5tKG1k1Tw0fhDCDN6LUhX/VwEzqtgzzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwkDorOvlsGydOdPdpioB6a4kRdRu8BUj9qndrWO4DrxduONkX0hEXbzwpr3gR6IsMdBAY50dhZz1CEMRw3w0ClTM3ucEUdD2cduusGfEpAl0Gz5zz4tHZfGdRsukFBe6BThldctZwbXJ9jRDtExs6LZw/b86I3ZK4YQVe4QFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso32679335ad.1
        for <linux-watchdog@vger.kernel.org>; Mon, 06 Jul 2026 03:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783332869; x=1783937669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Avfylhoyx5tqif2j0s7EGdPplSscPo8mEJ2UKFsFj5Y=;
        b=jO7LkJNkv3ZcWMsArjicJYp6jLb2Z9c6Zjqa/x2ZqocXghAKlpmxJvEmdA5BmnFEZw
         Nv8csnuALEjVjCnHsGixsTdRbj6+n04hKywYOyghBPkadHNln1jOcyREWV1eCy4tYWXt
         juTq4wOYeVlngE6D875UDHdwwteNQnojEPPeot/3SAdXo1D4eXqQonIzlozRmdtyzyfC
         F+jXa1FfA/3bHYl4TIMQ+vMzLhdrnLTtYcg4DTHE6tIKT3zkEOc6o7UettSoHNGSdo7S
         Anbi1Pv1QqxHgbmoo2RQgO0xU3+appZVxBg9pgTBgsGK8l6Yh79Y5QbIf+gYdeB5gb8B
         dJpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpldi2WPGkrUzOamrF0njUHYVeYCahZkwSdhtidRYQCD6glmZuwNgyJA02NMuGLj0VpD3ETWVTa3hbYKwiIsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK8RaCWAGQR5z90hBTRIeGo2dBt8eQcGVFLz5qeyOBDhze3hB7
	RLTFfOfz9o/xt+HsiZypv4RA9GKC6MsyPKwmGd0EoiDC1O1X7tOsLb1CfP6FB+OT
X-Gm-Gg: AfdE7clBF841/iqYJLYzo+fiJ4sWGtoNdStRMycnzHVfXVKWpCTnkKMtwx/hkr596Wj
	bRiQY6SUl+AQLcvTXhXfySj/uQXD65MZCYh2E9WKgrr6OQXnsVmixfvo5JqSHIr+cp+Y592i5xn
	QOF6Wfcb6QRG0ixliGm/ws1uaRT2sII/gjGDwV2C2+/vy8VlbW1aJwuwOgCMLpdw2WnDABRIUeD
	BZ3gEkhOsQ6l2Hu3Bjn0e5MRRhwIhMQqR3hVUn8ASQhOEAIxPrFvM5tzscVy5r/+fnWx9Q9Z1my
	evkHnMJlPHe8IieFUCtzyO+dnMeNBoaUMs5AyB4XZKDtkrngoGO/jqCoKfD0fuGrqLVDZTC2PdN
	MPHFjJfDK30ajaeGy+N/GO/HjoAa7OLNViWTqosyRrcFOQozPs/kRmUi1mFXUSCtdiPpoQWaiZZ
	snTmW/Z8FwcIHI1VTPu5wG0neJ0kXiVFogvBoTNCZxKpnF9ePPy0k2dw==
X-Received: by 2002:a17:903:b8f:b0:2bd:8395:fedd with SMTP id d9443c01a7336-2cbb9f03560mr96616985ad.37.1783332868710;
        Mon, 06 Jul 2026 03:14:28 -0700 (PDT)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7871190sm47573965ad.61.2026.07.06.03.14.28
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:14:28 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-847aa193d98so2293574b3a.3
        for <linux-watchdog@vger.kernel.org>; Mon, 06 Jul 2026 03:14:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrGpvcIizF1GH6lMmuByg0Iug7mv0gthL/Pjng1hlqi8nMKo/fsmmcyWRN7Sjow4ciwmhyFRVKcP8xx4MYj3Q==@vger.kernel.org
X-Received: by 2002:a05:6102:292a:b0:73e:9fae:5844 with SMTP id
 ada2fe7eead31-7427f7c09f6mr2718808137.27.1783332490185; Mon, 06 Jul 2026
 03:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260702123112.161160-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260702123112.161160-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Jul 2026 12:07:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUTDRkq-WaXNxGzBLAEY90cn1i_-UOuDkS3PBs3xKooFg@mail.gmail.com>
X-Gm-Features: AVVi8CfVUZe5-SeycxEAnrifXns0jujcFQ6mtVZEjh3x46p1vCjwJsZir-4zskQ
Message-ID: <CAMuHMdUTDRkq-WaXNxGzBLAEY90cn1i_-UOuDkS3PBs3xKooFg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/9] clk: renesas: r9a09g077: Add SYSC regmap support
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
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Thu, 2 Jul 2026 at 14:31, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add System Controller (SYSC) regmap support for the RZ/T2H SoC.
>
> The RZ/T2H SoC features two System Controller (SYSC) blocks that handle
> low-power management and access control. These blocks are defined as chil=
d
> nodes within the Clock Pulse Generator (CPG) address space in the device
> tree. Implement support for creating regmaps for these SYSC blocks.
>
> Register the regmap using of_syscon_register_regmap() against the CPG
> device node so that consumers can access SYSC registers via the existing
> syscon phandle.
>
> Add a sysc_init() callback to the CPG/MSSR core to allow SoC-specific
> initialization of the SYSC regmap.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Made use of for_each_child_of_node_scoped
> - Moved sysc_init() to the end of the probe function

Thanks for the update!

> --- a/drivers/clk/renesas/r9a09g077-cpg.c
> +++ b/drivers/clk/renesas/r9a09g077-cpg.c

> +static int r9a09g077_sysc_init(struct device *dev)
> +{
> +       struct device_node *child, *np =3D dev->of_node;

error: unused variable =E2=80=98child=E2=80=99 [-Werror=3Dunused-variable]

No need to resend yet.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
