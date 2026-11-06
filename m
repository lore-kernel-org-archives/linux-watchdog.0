Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958107;
	b=fYA9CIXK2+iu20AREmpGK3C9gCM5UHt3rDoZCIA3Ju5kWR+EXURABjmj9im5KYJuyLJy
	 9ku8653tW9Sub6gsXj9RARVcobYYu16+R3LI1k+XePxJ4mbJyJUeSply0xXVBXEmhNcvP
	 VL0K5vG3QfKnprY/lURL0iPs+c4jPDGwKMk45Dt//zsVwUj/W+CieAs22Mn8yLrvdKNvi
	 es9/7ug1MWfvvnboaFoTrc2VDbv2QFGXiAmFmvpYbdyd78pY1BWj7L6UXRFbf1oyY+j62
	 aN1UKvlHG5vTZfbKmSz9ArXMTV0DmSqAWdG6y/dazyT3Y5ZmUIpeqr4ZvxFxsjTfIPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958107;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AM1vKCc+zXXIExWJ6HBD/LmFK9wTMqFUgXGp0hz6PKM=;
	b=mV9GKu/Y0W5wFZ7/8fFSFi7m6ifQWilRg3kGh9Kp5sBjLSaCQDwiBaP2AJJ7iT7W01Fg
	 RUxf6utmH1wP4T53k6Y9UIGf+SZyavjLp3va1Uyxhp0YcfPx8p4o4xKE3hzH0PWw8JTiA
	 txnxVgIHPrZ7trOzKCdvpZydi6zI0TU+OR3NllZerQVv3gT4AXkHflTGf1o3vDj9Lfoie
	 g8LMx2X3I+0Mhd7f0Mlj3rPdLSsFU+pmfYaFHhIhppWt/dlz4ioTf4ij9cC8w+q/1dpls
	 hp3RnwEW9HDMJKyXw6RtltadthcLIcusR4W+m2jJEbF1GNsvs1dzKOeqGHD0okILdQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pl6m8RIt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11322606D821;
	Fri,  6 Nov 2026 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pl6m8RIt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F63C1F008A2;
	Fri,  6 Nov 2026 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793958106;
	bh=AM1vKCc+zXXIExWJ6HBD/LmFK9wTMqFUgXGp0hz6PKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pl6m8RItiZEJY/Tv9Y2Ht93K8UGo7plhJsogsBMSPQhvg+ZETw4MG79qvBJMCw8Vi
	 SVuvyLWyhzES41qlhLDMPMqVGH5/0MpgyA8JGSUKpTso8OEM6nqlIVCiJ5Ix/UGvac
	 qJN1RCWnLqWkOr2zjmjmnZoF5X54v/s/qg1gLvQU4N3OwvDEBlrKy+0J8E7ZGzIC3w
	 9PTFfLb9ayJ8kugGDvSQEjYs54d5FzZOOFSllj4+eek7Tu8O7U+ufif139kC55QtmA
	 Qcw1ocbDqtl9zK84IMUhzIVvWDDV+FFHzKWoryIdzuPoudr6nyZmZ92jVI5jFaeKM/
	 K2JEdhsZk1Rnw==
Message-ID: <sashiko-outbox-201141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/25] dt-bindings: reset: add Metanoia MT2824
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmVub8OudCBNb25pbg==?= <benoit.monin@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261106-mt2824-v1-3-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-3-86087eaf5af4@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:41:45 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] dt-bindings: reset: unused label and non-standard node name in
  example
- [Low] dt-bindings: reset: schema filename does not match compatible
  string
--

commit 3bb1ac6d86be7fa6908083c0f43ed9c390788baa
Author: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

dt-bindings: reset: add Metanoia MT2824

This commit adds the Devicetree binding schema for the Metanoia MT2824
reset controller.

> diff --git a/Documentation/devicetree/bindings/reset/metanoia,reset.yaml =
b/Documentation/devicetree/bindings/reset/metanoia,reset.yaml
> new file mode 100644
> index 0000000000000..f169d1fa919cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/metanoia,reset.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/metanoia,reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Metanoia Reset Controller
> +
> +maintainers:
> +  - Jun Chang <jun.chang@metanoia-comm.com>
> +
> +description:
> +  Metanoia reset controllers provide warm-reset and system reset controls
> +  via memory-mapped registers.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - metanoia,mt2824-reset

[Severity: Low]
Should this schema file and its $id be named metanoia,mt2824-reset.yaml to
match the compatible string, as required by
Documentation/devicetree/bindings/writing-bindings.rst?  With a single
compatible string, compatible can also use const rather than enum.

[ ... ]

> +examples:
> +  - |
> +    rst: rst-controller@1000000c {
> +        compatible =3D "metanoia,mt2824-reset";
> +        reg =3D <0x1000000c 0x4>;
> +        #reset-cells =3D <1>;
> +    };

[Severity: Low]
Should the unreferenced rst label be dropped and the node renamed to
reset-controller@1000000c?  The unused rst label causes
scripts/dtc/dt-check-style --mode=3Dstrict to fail with an unused-labels
error, and reset-controller is the standard generic node name for reset
controllers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-mt2824-v1-=
0-86087eaf5af4@bootlin.com?part=3D3
