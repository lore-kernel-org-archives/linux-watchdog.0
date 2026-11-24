Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795484160;
	b=TI/5sHdlV+i2jUnJkBlmNpQgmNEgt63zNb3E2OGm7PZopKaMmXlagYMNARaEG/4G6sHr
	 xixWPQPs1GMhPfrN1OS+Is6Y5HT1uk3QkbeqkBgrdo56E/ZRL5Lek1GndGBAGWj6nZEYz
	 iWBqp+yYRgusMbOpV/2J6AsUgMv8RLfQL7di0k5bvmSYWImmnAn1JB348lfLGisuj/hl1
	 hVNU9xue7vw6Asw/QEMIjmc5jhnpsvYRa1quWkcFAsS2xgHZPzGcHpa1DyAbLx542DF52
	 H+3Nua3lIIfPfVT6KNQ8D2bHEFJDZQ3dqEamPSvRasmcK0DJnCMFatjghWVJzP0CVDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795484160;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s0wDMHe/gV3ZM1mEdEmhpogRsEjO5xy/5nwpz9VtBjg=;
	b=Ch8m3E7/UJcfr4yRLi0HZ72PdKdh6V9XQLObYdhCRL1IyNVr15sGcwOU/+8Qgk3BkQa/
	 TMfOleBVAZxVI7Y77nNiRD0dDmsIzgQqmDzuyGAjitoGjSNo65LznaXviZB6ljqi3A6/3
	 76KjL4q0wPuFCpCSzShkxgcch6Vtoz6nagioGEwWChx6Ylxy3y2Qg7TvbqGFHj4nQXIcX
	 8ycFh8WBWfMXNV6j0bFyvmvYxzkevTOrirK2TKSIWAV7W9cVGpBW4xaLsV97O2hyx6jEZ
	 AHd2xCE2YSg9cWLPlSa+SgIAGlKCRE/MP1VNbXmIUL2sAZKV8+1ztHHRkALN6rlanzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjInn189;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80D606A321;
	Tue, 24 Nov 2026 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjInn189
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C431F000C0;
	Tue, 24 Nov 2026 01:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795484159;
	bh=s0wDMHe/gV3ZM1mEdEmhpogRsEjO5xy/5nwpz9VtBjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cjInn189zP8NKlknDne+KIyhezbmTSJjtwIMlN2nq3421peTD24/GZVhDveJ0vASk
	 Ofb8KiT1ZJggNCRGdPTfq2LiBtK4U/n6pHOgEZbKkk2tlVdYypDEB/9iadTOEKGPsA
	 kGvSFw3djKkIKo12ylbxlsghGRLD4TpZDvpvs8jqLuWsASh1HZ8ypmn04BDqLBi+92
	 HxwqOemGIr7iv+G97DPbnR4X1QuCiaT9qjgYi6hRGY3IU40Ny+6+qUY0SOHPMTpJ3M
	 gu1gs5Fo/OaYAQokEsPkht6iEYoH1Yb0MHutbRWfxL6r6esgp81O5fO/YxD+iW8CvE
	 ZXLobaneRau8g==
Message-ID: <sashiko-outbox-230349@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: watchdog: hisilicon,histb-wdt: Add
 HiSilicon STB watchdog
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Yang" <mmyangfl@gmail.com>, linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261124012755.328774-2-mmyangfl@gmail.com>
References: <20261124012755.328774-1-mmyangfl@gmail.com>
 <20261124012755.328774-2-mmyangfl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 01:35:58 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dt-bindings: watchdog: non-canonical property order in
  hisilicon,histb-wdt
--

commit cd75fa6a3636ea21f523ddd842b008cc17e1bb93
Author: David Yang <mmyangfl@gmail.com>

dt-bindings: watchdog: hisilicon,histb-wdt: Add HiSilicon STB watchdog

This commit adds the Device Tree binding schema for the watchdog controller
found on HiSilicon STB SoCs.

> diff --git a/Documentation/devicetree/bindings/watchdog/hisilicon,histb-w=
dt.yaml b/Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.ya=
ml
> new file mode 100644
> index 0000000000000..427225c9aa46e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml

[ ... ]

> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - hisilicon,hi3798cv200-wdt
> +      - const: hisilicon,histb-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description: Frequency of clock in Hz
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/histb-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    watchdog@8a2c000 {
> +        compatible =3D "hisilicon,hi3798cv200-wdt", "hisilicon,histb-wdt=
";
> +        reg =3D <0x8a2c000 0x1000>;
> +        interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&crg HISTB_OSC_CLK>;
> +    };

[Severity: Low]
Could clocks be placed before interrupts in both the properties block and
the example node to follow the standard DT binding property order
(compatible, reg, clocks, interrupts)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124012755.3287=
74-1-mmyangfl@gmail.com?part=3D1
