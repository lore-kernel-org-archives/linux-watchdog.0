Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9460355F46;
	Thu,  2 Jul 2026 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995917; cv=none; b=dd4e3sJY2Fa4meU2FuZlaF8ecU9kkjVgOre6HMO9W4+nCL6LB0L9efirrTxNR36FZ6j93Vpovt+gZr0p/VAPCsVgiJxWyCnB621QHsvTcqNjCWRZb4ANg8pDiW1Y1gSWVc7TkvRkeGNopONL8VOHaGG+1c2ggTLhBvAFwRZH2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995917; c=relaxed/simple;
	bh=o4Bl5i/NFX5eGBIZoJYwpablEiOeQxneaG+7wdxFWEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RF+gM2eSE548M+SKwTSXcdnigX1jXn6h4hvLT3E8SkL2TRcCqL7TDbwP7nWRTq6pcw61OeE4jEqtac7UCtb5HuctCQbyr3YQBKQ27tl1Ns6XWBszvYCQNb2vzHvN/v7yht+o7ytgTQ5eQIFsftrS9Iiwh/s+xsit4eS2oxLeYXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNzkhy2E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNzkhy2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6801F000E9;
	Thu,  2 Jul 2026 12:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782995916;
	bh=ReZ++DXulMO9R1ndGOQKk48dpQquKICYLIRzoKuOwxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dNzkhy2EQlWS3S4dWVjQudL/sG7ermVoT+gzeirkUDiu4enDnGlrjTdTt6EYfguqi
	 ymi1lhq52rDWmknO/syhG7AorANZ8fPB8Ictgq6q2HAB+6fDgdzYEW/vsseTt59VXc
	 PVQszoLxpOHR6jfL26QBD+jATcfJ9+tVIcyBLwziJTuP6OXyVYdZ5WQfEAJHm6mhTz
	 mfTqt1XrSa6vERt5WFKnrWmLNJanZvNqDb0jVCcAgi7d+RssOOt+Jg1HI6zf647PJj
	 Ugkk/nw+jcNryFGaxA6GjRDzGZWnX3LSMcT7SwEwt80IbecdYY8kpkNULjAtj0kp7D
	 70ClyrX1Ej8jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 5/9] dt-bindings: watchdog:
 renesas,r9a09g057-wdt: Add SYS syscon support
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, linux-watchdog@vger.kernel.org
In-Reply-To: <20260702123112.161160-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702123112.161160-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:38:34 +0000
Message-Id: <20260702123836.3F6801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The deprecation warning message instructs users to pass a register =
offset via 'renesas,sys', contradicting the schema which restricts it to an=
 IP instance index.
--

commit dd09e9278d1657dcf283ff0886c7ec9901f648a4
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

dt-bindings: watchdog: renesas,r9a09g057-wdt: Add SYS syscon support

This commit introduces a renesas,sys phandle-array property to allow the WD=
T=20
driver to access its control register via the system controller. It also=20
deprecates the second reg entry in favor of this new approach.

> diff --git a/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057=
-wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wd=
t.yaml
> --- a/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.ya=
ml
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.ya=
ml
> @@ -48,6 +48,17 @@ properties:
>    resets:
>      maxItems: 1
> =20
> +  renesas,sys:
> +    description:
> +      System controller registers control the start/stop of the WDT, and=
 halt debug.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to system controller
> +          - description: watchdog IP instance index
> +            minimum: 0
> +            maximum: 5
> +

[ ... ]

> +          else:
> +            properties:
> +              reg:
> +                description: Deprecated. Use renesas,sys to pass the off=
set
> +                             of WDTDCR register instead.

[Severity: Low]
Is this deprecation message accurate regarding passing an offset?

Looking at the renesas,sys property definition added above, it expects a
watchdog IP instance index with a maximum value of 5, rather than a register
offset.

Could this description mislead device tree authors into providing a raw
register offset instead of an index, leading to schema validation failures?

> +                minItems: 2
> +                deprecated: true
> =20
>  additionalProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702123112.1611=
60-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D5
