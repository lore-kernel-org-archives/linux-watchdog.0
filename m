Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1A19A288;
	Sun,  5 Jul 2026 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783258028; cv=none; b=M+4HSFCp3yob89f2Afd4GKhntwNzoJPTUlZL2xSJXRizOZc1CDA+W3eIPFLk/0xwHWHLhFELbKjT9+mTmNhfpCnHVVx+SOKHL2rcdEWuxTm3ZNrpp5BN63h1cc6p5cE214A4hNqv9nHKf/UnoLjNgMVdxga++E1awCd6u/ApvOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783258028; c=relaxed/simple;
	bh=WCJjX+C5sdNbDRHB8t4J2IwcLoHaJ26paLR7rlvb8L0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oPdyu23kuV3ODjzTVFyO6ExuaNZWedLyuIrdH+STmAVxIqoseXr27Ehtq0Vcq6BZKGpe2oCTOQyW3Ed+nj3rahesxdtR3ZkJ1RePXe1tQsghq8NVONKfRCr6247YIEikkOSLYIOL4/fpm2HFuHNV7D4r4UwaysG9USnR5TgFhJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWYmdbTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWYmdbTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9751F000E9;
	Sun,  5 Jul 2026 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783258026;
	bh=LXgPbXIG7kSO/pb2hwVb8cpO2Ol64ywWGdFVWNuE5jU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MWYmdbTWf4t0BiKrOzdX9RlScj+6yQTD8A4vJurrxkgk6A5GxuEYKB3PvFh3tkqwK
	 26LcaCO2NkbuHAGA8eaDVxByNv7YHSzkKliyFqm8RWj1RMdnrUxsXdX0g4bjmRt+EL
	 gOyos3ZgxM1qCAgGCNyJuk5EcYmXJtQqP5ShNYbE1I3YQrn4Nw/QQUl44HM1kR3cXS
	 9UnQnnhDSngYSq/0itEvidz8HENOduPkGKv6/h0Z1W2yQOT4kdVDn4Guf1OWdnrtnB
	 4MTk1EDUsPTFNYWaITFb1Lbjofx7mRCRB26i/NU/jUof9MQwRqGIq5eRiQ5cogjyWa
	 8N1kNl45AeSug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] dt-bindings: arm: apple: apple,pmgr: Add t8132
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-4-e5655ee56523@cyberchaos.dev>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-4-e5655ee56523@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 13:27:05 +0000
Message-Id: <20260705132705.CF9751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new 'apple,t8132-aic3' compatible was omitted from the condi=
tional block enforcing the '#interrupt-cells' constraint.
--

commit 4be0e67c14a594eec020638f7ba5290c4bf05496
Author: Yureka Lilian <yureka@cyberchaos.dev>

dt-bindings: interrupt-controller: apple,aic2: Add apple,t8132 compatible

The Apple t8132 (M4) SoC uses an AIC3 as interrupt controller, same as
the M3 predecessor.

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple=
,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,a=
ic2.yaml
> index d0d9a90e96e7b..7171c8c09feaf 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.y=
aml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.y=
aml
> @@ -44,6 +44,7 @@ properties:
>        - items:
>            - enum:
>                - apple,t6030-aic3
> +              - apple,t8132-aic3

[Severity: Medium]
Does this new compatible string also need to be added to the conditional bl=
ock
that enforces the '#interrupt-cells' constraint?

According to the dt-bindings subsystem guide, omitting a generational
compatible string from an existing 'if' block when the hardware shares the
same constraints is a regression that allows invalid configurations to
silently pass schema validation.

Without updating the block, a device tree using 'apple,t8132-aic3' could
potentially provide the wrong number of interrupts or miss properties and
still pass validation:

Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml:
allOf:
  - $ref: /schemas/interrupt-controller.yaml#
  - if:
      properties:
        compatible:
          contains:
            enum:
              - apple,t8112-aic
              - apple,t8122-aic3
    then:
      properties:
        '#interrupt-cells':
          const: 3

Are we missing an update in this if-block for apple,t8132-aic3?

>            - const: apple,t8122-aic3
>        - const: apple,t8122-aic3
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-apple-m4-i=
nitial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev?part=3D4
