Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01397366DA5;
	Wed, 13 May 2026 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636691; cv=none; b=dt8KztVb4MKoqGzUdLJwU7aBOu45Iu0YlstwmFPj0hZ00fZeR3E3Sfcyb3UApz80cJf67RMjgYITyGm/QG0E5kSQthITH54iehnctgFj7MSNzsEmJ0RQoKS4GTjCeMvhWoeu0aJX60+cuPauu1n4DwJPnsKLKEgmZDNUXasX4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636691; c=relaxed/simple;
	bh=RMhb3yHkMQFJJunCJPj9YVI0WlZpMkzSiGN5yuUglBQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GI1fZf0hDxQ6w7RYAtJLMBnYBAPPx5p64ktRKDAWZO5hsI/zyd/rJQYMSfFX8wodZC6KXWB1KhpcmBpUO46eyuxNEJ+q2Dg4yK3FkFmn7yEnwcRfS9H63xiZVXeylRcms2pV8xCK4VKJABQf8ei9D/bOC314FNJVkqW0BRJEkF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfSKJytZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfSKJytZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DB9C2BCB0;
	Wed, 13 May 2026 01:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778636690;
	bh=RMhb3yHkMQFJJunCJPj9YVI0WlZpMkzSiGN5yuUglBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TfSKJytZfIGA0GpweuqeAMBsoXESK3La61SqNdjjopprIGsgQvCKeWSnVGtB9DQho
	 g1XGXdxsMLJoHNtCDdU0C+Ln/6r9HNlIPcIR1vOmQgVLwARW2U+uDZovqMGBxbSM11
	 g7Zeb2ot/h1Zyj+kO+laSVcwgjUsA4SSlnbAGXCUJbl8hwP7gnM+XFBRMjPqo+2iOe
	 5cuNkp9zXz6PMJ0FkJ5mCG+7AHBTONs22Zs3xKcNZmkBbaqK8aGe9ARS+qibMntEJL
	 ic27Glm3frJt3OTOHzK8I1eBSmp/LPaSZs8n/fX6GeT6phwYIw6kZUh2j/dluyThSa
	 YgTzSHDlHBiRQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/9] dt-bindings: watchdog: renesas,r9a09g057-wdt:
 Add SYS syscon support
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260511185058.1926869-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260511185058.1926869-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 01:44:49 +0000
Message-Id: <20260513014449.C7DB9C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The deprecation message instructs users to pass a register offset v=
ia the `renesas,sys` property, which directly contradicts the property's de=
finition that explicitly expects an IP instance index.
--

commit 2f7ddc85a4b879b8b32b8404088f4fafc9c07fd0
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

dt-bindings: watchdog: renesas,r9a09g057-wdt: Add SYS syscon support

On the Renesas RZ/T2H SoC, the Watchdog Timer Control Register (WDTDCR) res=
ides
within the System Controller (SYS) block rather than the WDT address space
itself. This commit introduces the renesas,sys phandle-array property to al=
low
the WDT driver to access its control register via the system controller and
deprecates the use of a second reg entry.

> diff --git a/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057=
-wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wd=
t.yaml
> index 099200c4f1364..2f32c7401def0 100644
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
> +                description: Deprecated. Use renesas,sys to pass the off=
set
> +                             of WDTDCR register instead.

Is this description accurate?

The description instructs users to use renesas,sys to pass the offset of the
WDTDCR register, but the definition of renesas,sys above explicitly expects=
 the
watchdog IP instance index, bounded between 0 and 5.

Does this conflicting information need to be updated so users do not mistak=
enly
pass register offsets and cause device tree schema validation failures?

> +                minItems: 2
> +                deprecated: true
> =20
>  additionalProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511185058.1926=
869-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D5
