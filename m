Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273542255D;
	Wed, 15 Jul 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107197; cv=none; b=cRXK5zEUe52ItYYoVicPCVduGJlgFV0QwIh5e6ui6EhVI4XAwbHgpY6kQ8CtSH4z2YqEikAGLGRl5xX2NKrACANPdV9fJtUzeU11GCg8wjK0NtVCjN9ASu2TZtrC5bgof3HoW9+BDhycQvkQdvN3v5xmCXW/BVvfFI+piEELIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107197; c=relaxed/simple;
	bh=yUQDqV+FQ1s5JVNL7DFRbgVaPUcsxAPa5AzTH0bG4YY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qd9yFL6t0eINHSzLQbDk2zh5f2lrM2UDuBMfxlG8rHyVUkzyYdLTGAvgYuF+kVs7/G0kgIJkxNbIwXYAUPV5xRVvuIPm80c1BK7krHCJpwDU6+f+2cn0ObGczVcK/9ofRcmPLe5oz1EBC5/4LDRUnoM6ascqzgsyCDxUmhy/nUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVvisbWf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVvisbWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2C41F000E9;
	Wed, 15 Jul 2026 09:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784107195;
	bh=wCTgYzO14X4SFLDPj3xDd79Y338nL/5IDEphj+CWQxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WVvisbWfxywznMzQU4SEuhH4QdbGIktBDBMCfO5E5owsg0IcwFeG7/tgWkAL3wdMr
	 y69/e3I3pVpnIPrV1WdQ64zCUogK4iKs0WHoPNYNG/pDoo1VPgoybFwYxdPKCXNE1I
	 AW7kPrCOPqlBPt0UEIfwXr+2mbeymLp/N8CxZ8fpfDU4VKzAitWAhG0p+UwPXYbQbj
	 8uQUHs9MZ30AHqfmgrVGGdFG+LU50CIdaNUPKYVsWDPVGsAmxBcQdMJ3ofaMPQyDgt
	 C2zwaZZAO6x1GvcsgQKb2LH9Bq3qFWvrdjX98bnnhN0lrkxS0GJgUA2Sdzc0SlUnKU
	 yEjNRv/qcvdlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] dt-bindings: arm: apple: apple,pmgr: Add t6030
 and t6031 compatibles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260715-apple-t603x-initial-devices-v2-4-df65b2485710@jannau.net>
References: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
 <20260715-apple-t603x-initial-devices-v2-4-df65b2485710@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 09:19:55 +0000
Message-Id: <20260715091955.9A2C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete binding schema update: missing 'apple,t6030-pmgr-pwrstat=
e' and 'apple,t6031-pmgr-pwrstate' in companion schema 'apple,pmgr-pwrstate=
.yaml'.
--

--- Patch [4]: [PATCH v2 04/10] dt-bindings: arm: apple: apple,pmgr: Add t6=
030 and t6031 compatibles ---
commit 8f34f4075b928942fd23fe22c7c37b31b25aa7ec
Author: Janne Grunau <j@jannau.net>

dt-bindings: arm: apple: apple,pmgr: Add t6030 and t6031 compatibles

This commit adds per-SoC compatibles for M3 Pro, Max, and Ultra to the
Apple PMGR block binding.

> diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml =
b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> --- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> +++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> @@ -38,6 +38,8 @@ properties:
>        - items:
>            - enum:
>                - apple,t6020-pmgr
> +              - apple,t6030-pmgr
> +              - apple,t6031-pmgr

[Severity: Low]
Should the companion schema Documentation/devicetree/bindings/power/apple,p=
mgr-pwrstate.yaml
also be updated to include apple,t6030-pmgr-pwrstate and apple,t6031-pmgr-p=
wrstate?

While this commit adds the parent PMGR compatibles, missing the correspondi=
ng
strings in the companion schema might cause make dtbs_check to be incomplete
or fail for power domain subnodes in upcoming device trees for these SoCs.

For example, looking at the companion schema:

Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml:
      - items:
          - enum:
              - apple,t6020-pmgr-pwrstate
              - apple,t8122-pmgr-pwrstate
          - const: apple,t8103-pmgr-pwrstate

Could the t6030 and t6031 generation strings be added to this enum alongside
t6020 so that power-controller subnodes validate properly?

>                - apple,t8122-pmgr
>            - const: apple,t8103-pmgr
>            - const: syscon

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-apple-t603=
x-initial-devices-v2-0-df65b2485710@jannau.net?part=3D4
