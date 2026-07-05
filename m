Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B7037755C;
	Sun,  5 Jul 2026 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783257862; cv=none; b=nZE0aCyxKR8ZZVks5/NtrzfcBEMIlP+eIup2TaByWLh7HFG7ktLYpewUtrE23LoP2umE6K3P/QYkM5WQDfweeYK0HO1CTZazHRzaZOmSNSAgvJJZvIcYBcR65jAVhlwOId0Xs69ocDTdzgcUnmP8aafYujXWc+z1G++rg/xbtso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783257862; c=relaxed/simple;
	bh=dHq5fojsu+Fy/4sK14IKAPJyYAJ06uqfTonAHpzy+5A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SDdnR8hzhitbzvYNUc23Zvo/9+rKF8u8yMaH+xLGA1ub6rjQPIU5FLkw7y8OCOUtK6LTF9gz2cZ9E792r5DXpUCuzymRZowsbOME8UcvIzynZHBdrGhlAXHt9ceqQDkh5MAO4QOIYb99lKceT4xEGUGqOXUo5o+moO7qj1JrAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZARvKYHQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZARvKYHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233081F000E9;
	Sun,  5 Jul 2026 13:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783257861;
	bh=7Q3A/49ZGukLRVY0Iioz6jUYTmoreiMjJFdieDXTVsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZARvKYHQJuC6E8aqUdP3pHTDdFX2pPGL6YiK954MdwMNvhhvVMtvGAOCOC8E0FmcD
	 TiQZCxODz6Y7SpxaTyGemUIW91zD7ft0F+toQG8+XvPvDoCSCbi7RyNnOzzl3g8rlF
	 AGThrRL6SG1NHU+2t11vDlHfp6e7jRDl9C0RmyHAqcsEH8oYGadE7RW2Hhw2oEWIQX
	 RbegQuCM1zyeclOjJKUm8zl1waxvkisSjS7/vYj3loa4KubusFUUKYp3tgVrmSptN9
	 TRIO6Qb89tlQK7xjlF2eh39OkIoNOR484OFhJ/bfyZdnUcH8FIu6/Nx9lc7akbkxzd
	 V4ywIlatRgVAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: interrupt-controller: apple,aic2:
 Add apple,t8132 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: robh@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-2-e5655ee56523@cyberchaos.dev>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-2-e5655ee56523@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 13:24:20 +0000
Message-Id: <20260705132421.233081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added compatible string 'apple,t8132-aic3' (and the pre-e=
xisting 'apple,t6030-aic3') are missing from the `if:properties:compatible:=
contains:enum:` conditional block that enforces `#interrupt-cells` constrai=
nts.
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

[Severity: Low]
Does this new compatible string also need to be added to the allOf conditio=
nal
block further down in the schema?

Looking at the conditional block that enforces the constraints later in this
file:

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

It appears "apple,t8132-aic3" is omitted from this enum list.

If a device tree node is written with compatible =3D "apple,t8132-aic3" and=
 omits
the fallback string, the top-level schema will flag the missing fallback, b=
ut
this conditional block will silently fall through to the else branch and
incorrectly permit #interrupt-cells: 4 instead of enforcing the strict
#interrupt-cells: 3 constraint.

This is a pre-existing issue, but it looks like the "apple,t6030-aic3" stri=
ng
is also missing from this conditional block.

>            - const: apple,t8122-aic3
>        - const: apple,t8122-aic3
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-apple-m4-i=
nitial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev?part=3D2
