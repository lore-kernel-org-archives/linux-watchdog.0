Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D042D3783A1;
	Sun,  5 Jul 2026 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783257944; cv=none; b=CCe+z/O3tn5SbsvJGfq/w+5yooZfYRfhZ6n3/qsylXWBbxCVUMOE90d7lUWcaayVfYwe0rB/9dFq+KygRW+4/falUpgkCFMKg062AlCwJVqO9xa5ujsYtVNN1NslbyIL8wFumg3YXTRyKr7M/4l58wCFNwPjJy3dLWuwRsoP5ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783257944; c=relaxed/simple;
	bh=mwFWdLgbGSkyWnsoYYv1huepmdx0tiVeDe5UiyGtyiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZjvKdFrWbKEkVxW5FjxiIrxTqzsTfCZFIe0R5jpDggGbHcp0/Y/ALDcXO7NZZipSAigc8lQfRs85vVegtrex12HWK7OGF9vyBkvlZ/XZIuVZW6huX4KJSpsZuJ1MLaE3q1Q6tzMHC05APJ2MxIYMDukwtFvgQjfJ66PIix1K4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBHam1uD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBHam1uD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373C01F000E9;
	Sun,  5 Jul 2026 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783257943;
	bh=DJu0h7BBju8UWyHeTuWeITMiHIA4tk4nJPfuTq6fbeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lBHam1uD8YgIKJfNixGVWrUrSRB5wjM/5/fOkzAqk87Mi1uDPBTQpNRnWP4HAhCcY
	 /sM6rGSqrIP4+N668kI9/5s3g2nwqVjRl6HhvC4boq547uXwthDcV8dpXJFai31Bk8
	 9FifDda4uXVqUycL821EsmGgrrCOn3ZAMwNHPpr3g4CFNtGKNR0gEYUpeO0ERARCVi
	 2pmErcJoBo90DVeRWafFk98m3Q/5iaRJyEWZEIm7x0e2jjaBQRCDvm/RA5vUwA+Gap
	 kM0L5wpsnUYdG56+oFOCUBr+pj8tIBVErerKu9jeu2KICZrSPmfpwoLC8disXBxfe8
	 9rBdrMYNfGyEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: power: apple,pmgr-pwrstate: Add
 t8132 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-5-e5655ee56523@cyberchaos.dev>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-5-e5655ee56523@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 13:25:42 +0000
Message-Id: <20260705132543.373C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The new compatible string 'apple,t8132-aic3' was not added to the c=
onditional block enforcing '#interrupt-cells'.
--

commit 4be0e67c14a594eec020638f7ba5290c4bf05496
Author: Yureka Lilian <yureka@cyberchaos.dev>

dt-bindings: interrupt-controller: apple,aic2: Add apple,t8132 compatible
   =20
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

[Severity: Low]
This isn't a bug, but should the 'apple,t8132-aic3' compatible string be ad=
ded
to the conditional block enforcing the '#interrupt-cells' constraint?

Looking at the allOf if-then block further down in the file:

allOf:
  - $ref: /schemas/interrupt-controller.yaml#
  - if:
      properties:
        compatible:
          contains:
            enum:
              - apple,t8112-aic
              - apple,t8122-aic3

This conditional block enumerates the prior generations (t8112-aic, t8122-a=
ic3)
but is missing the newly added t8132-aic3 compatible string.

While dt-validate may still enforce the constraint via the mandatory
'apple,t8122-aic3' fallback string matching in the contains clause, omitting
the new generation string from the enumeration directly violates the subsys=
tem
rules for generating consistent schema checks.

>            - const: apple,t8122-aic3
>        - const: apple,t8122-aic3
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-apple-m4-i=
nitial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev?part=3D5
