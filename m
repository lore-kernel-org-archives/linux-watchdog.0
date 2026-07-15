Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416903F788F;
	Wed, 15 Jul 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107458; cv=none; b=VwQ4tKeBG2NuEC5sITK2ZiT4vl1BqhSFy4I3sjmEhsEcUkKqJHmbDTFcCQ0araZXSmg4cbthWvlYyRslD1PKBJSWJUBPsJG33qtWyMzwdmY4z9atsEGerjFvzOCdzRSsDjS1KTOzBb6p2ZcaOZ3tZRZG/JHenbPICbijacU7MuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107458; c=relaxed/simple;
	bh=MYoiz8eUQa23PwG+R06wyA3S/Krtag8ksmRqpdm6gGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NsuYyigIAmU7dgPSKAA8dYvBE/sCUtug9a1/Fq7tFRh4aoN+RUvGMWkfFb5QbBZipffaNBVrizhYQfAYROhB5S6dmL/Pgpn5SyYSVEqk8bXM1L5AHEb5v0/ASWIyukRiR1EhTM4Vu8rXiYmHLnrRA/NJZlOMv6dgAm8dq+/iURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVLxiUnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVLxiUnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD311F000E9;
	Wed, 15 Jul 2026 09:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784107456;
	bh=rJN1D0xuEl1zCEcTEacvhks5gJcHMbV4sHcPvIerHRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AVLxiUnqpsx6AICZ+2YTNrk4xgmfjO49pZYS1LPOy7TIlhAdgVyVsZtqnmI/cAHQ6
	 YV+aCcYssfqBeoh1Rri1suAmQGD6ceLJxPdL4QAVqbwKyva5xqmAP9SnLpfR7OgcEx
	 G3nF4sZgMMjAgh2Z053dOCjz2KC2gYXqnlWq6Yae1ohzMaNvghe+oGSuCNN6pJRSlJ
	 920NOccKrqTn2yEGiglEod3hvQgf68wiF3bkoFP4sMaEWILaHgvLYPGVAIDbzZSwth
	 A+2a5o1mGxNknlzlmTEvSgy6e2/DCuZB8djbaVFOMOhgd7UFt9xmvFVcgVYfpA7qPY
	 rcfkWBMgxjqrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/10] dt-bindings: interrupt-controller: apple,aic2:
 Invert #interrupt-cells condition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260715-apple-t603x-initial-devices-v2-2-df65b2485710@jannau.net>
References: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
 <20260715-apple-t603x-initial-devices-v2-2-df65b2485710@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 09:24:16 +0000
Message-Id: <20260715092416.8BD311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The inverted conditional block intended to enforce `#interrupt-cel=
ls: 4` for multi-die SoCs omits the new M3 multi-die compatible (`apple,t60=
31-aic3`), causing it to incorrectly receive a `const: 3` constraint.
- [High] The new `apple,t6031-aic3` compatible string is completely missing=
 from the top-level `compatible` property definition.
--

--- Patch [2]: [PATCH v2 02/10] dt-bindings: interrupt-controller: apple,ai=
c2: Invert #interrupt-cells condition ---
commit c6c471e4280adaa7e66dba52b531c34594c8ccfa
Author: Janne Grunau <j@jannau.net>

dt-bindings: interrupt-controller: apple,aic2: Invert #interrupt-cells cond=
ition

The commit inverts the condition for #interrupt-cells in the apple,aic2
binding. It lists compatibles used for multi-die SoCs explicitly and uses
4 #interrupt-cells for them, while defaulting to 3 for others. The commit
message mentions this accommodates M3 Max and Ultra based devices.

>     The condition for 3 or 4 #interrupt-cells list compatibles for the 3
>     cells variant (not used in SoCs consisting out of multiple dies). This
>     includes the AICv3 base compatible "apple,t8122-aic3". This will match
>         compatible =3D "apple,t6031-aic3", "apple,t8122-aic3";
>     shared for M3 Max and Ultra based devices which require the additional

[Severity: High]
Is apple,t6031-aic3 missing from the top-level compatible definition?

Looking at the top-level definition in this file, apple,t6031-aic3 is not
listed as a valid compatible string:

properties:
  compatible:
    oneOf:
      - items:
          - enum:
              - apple,t6000-aic
              - apple,t6020-aic
              - apple,t8112-aic
...
      - items:
          - enum:
              - apple,t6030-aic3
          - const: apple,t8122-aic3

Will this cause dt_binding_check to fail for any device tree node using
the apple,t6031-aic3 compatible string, as the string is not recognized as
a valid value?

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple=
,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,a=
ic2.yaml
> index d0d9a90e96e7b..a94787939d345 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.y=
aml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.y=
aml
> @@ -128,16 +128,16 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - apple,t8112-aic
> -              - apple,t8122-aic3
> +              - apple,t6000-aic
> +              - apple,t6020-aic

[Severity: High]
Should apple,t6031-aic3 be included in this enumerated list of multi-die
SoCs?

Because it is omitted here, won't it fall into the else block which enforces
const: 3 instead of the intended const: 4?

This seems like it will cause device tree nodes for M3 Max and Ultra to fail
schema validation when they specify the correct 4 interrupt cells.

>      then:
>        properties:
>          '#interrupt-cells':
> -          const: 3
> +          const: 4
>      else:
>        properties:
>          '#interrupt-cells':
> -          const: 4
> +          const: 3
> =20
>  examples:
>    - |

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-apple-t603=
x-initial-devices-v2-0-df65b2485710@jannau.net?part=3D2
