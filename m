Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295371;
	b=euMk2pfrV40hPVfUm5G1IrpHwCMAHlwF+u2vwYCK5CQBSAAWqTmJcvJCx1KbeuEV6BrJ
	 YLOHPL6mqiwKJoR0cbNlTI6XeDFiLQu2dBfWv7ZkwF7kmyWnBy3lEjluM3qb2NSB/XnHa
	 l7W9mF3Gnm2YpeQFqnFIEfAXvI1oBIy+XR8UWN8PkrOC5G+D2/DDBN6nB6lMSpui0QRRE
	 XlcAb1RUyU5UIiyLlORDFNryjLZFla2Ir/kLEN2PumYDrRj5XUeN+vN8TxgzXt5ML5BAq
	 UDup5AQu+EIc0aa9ottXoBK/fskWD6QESHuerYSHNBIUKTBH2eOcj7yZeUieAr09WBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295371;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zNv4+X+sRwNEIqGyCGhnoMIq/Mm2jKZkmzH5Ad8iEq0=;
	b=F+CnZC3YD2kBvoE4qHoTp9ihZD3SGf2IU8qQI6NtZn4dPhOiXYY5M2ium+w1vjdm7ZxE
	 bR2Qf79am6Wxop2CcXqCihpiSsNolGT9mI4ltvf4W4ILezHi5ZBxc3MlL9CBpHfWLfywP
	 iqiujmV9aHoL8E3fl0vEFk2wyjgy4H8uwmp03+llcI6jU+669IkkQ0G8P0DMcKsWBjMxI
	 P5whaFDGkJvIXKXSLuf3Yq9EplIs1ziZxgw93y8reQ9nZYhOqoqtNDhxJNRjBLD1CdeDm
	 5WnSMrnI2ajr4OUtW05bdVCwlu9xfkn7EfKsKcAJ+RR0aqi181LJ7dKs+OIM1UFm2vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8qoAEpc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1DD606A337;
	Tue, 10 Nov 2026 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8qoAEpc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0601F008A1;
	Tue, 10 Nov 2026 07:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794295370;
	bh=zNv4+X+sRwNEIqGyCGhnoMIq/Mm2jKZkmzH5Ad8iEq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B8qoAEpcvye8OxCamGL5CCQ9x9LPLr51qg+vtGJIjmAaPbo6sdBe8XAIy70iTF8Np
	 DTB+iduG5HuuDgJ9sBcPbLJVvJhe4C4Nw/xqQijEwW1lkeb0YK12q8JgsoZcZ9HR37
	 FTTCHZa6CovwUL799/ku68MRrlB2SWgOeF3B5Eu3j6mroXbun3eT9EEZLCteHLIJxy
	 n6mrvNxzEzuuBaHaOg9KIxWGISQg4lWNPz09J5aOdLsQAZNS3oo0Bci1uALutguIXG
	 iPJx16QW5TlqCCc2tGj8RuVQKarUfGmfFhuGuDAkUqxstD4xqxvae0uOSUll/+yJ3j
	 kfT6NzBLVgjyg==
Message-ID: <sashiko-outbox-206480@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: watchdog: loongson,ls1x-wdt: Add
 ls7a-wdt compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Zhang" <rongrong@oss.cipunited.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261110-mips-ls7a-wdt-v1-1-968bb85122e6@oss.cipunited.com>
References: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com>
 <20261110-mips-ls7a-wdt-v1-1-968bb85122e6@oss.cipunited.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:22:49 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] dt-bindings: watchdog: loongson,ls1x-wdt: clock-frequency
  replaces clocks
- [Low] dt-bindings: watchdog: loongson,ls1x-wdt: missing ls2k0300-wdt
  fallback
- [Low] dt-bindings: watchdog: loongson,ls1x-wdt: top-level if and
  single-item enum
--

commit 7aab162e32ac784b9506b7510ce703256e2590fa
Author: Rong Zhang <rongrong@oss.cipunited.com>

dt-bindings: watchdog: loongson,ls1x-wdt: Add ls7a-wdt compatible

This commit adds the "loongson,ls7a-wdt" compatible string and a
conditionally required clock-frequency property to the Loongson-1 watchdog
binding.

> diff --git a/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt=
.yaml b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
> index 50a9b468c4a3e..cb93e9578f82a 100644
> --- a/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
> @@ -18,6 +18,7 @@ properties:
>        - loongson,ls1b-wdt
>        - loongson,ls1c-wdt
>        - loongson,ls2k0300-wdt
> +      - loongson,ls7a-wdt

[Severity: Low]
Should loongson,ls7a-wdt use loongson,ls2k0300-wdt as a fallback
compatible?

The commit message notes that the Loongson-7A watchdog is similar to the
Loongson 2K0300, and the driver uses the same register offsets and bit
definitions for both.  Defining a fallback with oneOf/items allows
existing drivers that match loongson,ls2k0300-wdt to bind without match
table updates.

>   reg:
>     maxItems: 1
> @@ -25,13 +26,34 @@ properties:
>    clocks:
>      maxItems: 1
> =20
> +  clock-frequency:
> +    description: Frequency of clock in Hz
> +
>  required:
>    - compatible
>    - reg
> -  - clocks
> =20
>  unevaluatedProperties: false
> =20
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - loongson,ls7a-wdt

[Severity: Low]
Should this if/then/else block be placed under allOf: before
unevaluatedProperties: false, and use const: loongson,ls7a-wdt instead of
a single-entry enum?

> +
> +then:
> +  properties:
> +    clocks: false
> +  required:
> +    - clock-frequency
> +
> +else:
> +  properties:
> +    clock-frequency: false
> +  required:
> +    - clocks

[Severity: Medium]
Should loongson,ls7a-wdt keep the standard clocks property instead of
replacing it with clock-frequency?

Even without a software-programmable clock controller, the watchdog timer
block still has a hardware clock input that can be represented in the DTS
with a fixed-clock provider node, matching other LS7A bindings such as
loongson,ls7a-pwm.yaml.  Forbidding clocks here creates a divergent ABI
and requires separate clock-frequency handling in loongson1_wdt.c.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-mips-ls7a-=
wdt-v1-0-968bb85122e6@oss.cipunited.com?part=3D1
