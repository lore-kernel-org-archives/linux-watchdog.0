Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9593A339376;
	Sat, 10 Oct 2026 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791652067; cv=none; b=qe9bnXr2S0C7TnwGSBxmUaHVu9J3OTGxu7fFEqhd1ML3BepEWkPDWO0+bBHIKRW8PRkatn0K23SnJnc8Yg2DhGIW1xeXiN5+sd8QttvWu4iRJl5+ezD6CF1C2YAm40SdR1rwXb1btxckPJsdGSKHBjXWvWy2C65eoCS3Z4sziRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791652067; c=relaxed/simple;
	bh=MBhkAWxpqbEe5G3pT+7cG/Ud/jn4Ulw3JwK1BL7KO+I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FXqQ5MUhcxWxWY9ciSzm+v0U0nMvcIMALssEsBs7adsyoc8WRCI8TCbCL7rtvVU7oE7Q8N3KD4AcvcOmr0U7cn9t9n7+BHm4wdW7HQzSYB8mMqBzZVjVmQx62mLZUrgegfTKZ0ameTtfkvvBsoSOVjFbxWJCz3rDfZKXZPx7P7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mbk7mUD6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mbk7mUD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF05C1F000FF;
	Sat, 10 Oct 2026 17:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791652066;
	bh=Imw2ztXhOgThxM/G+bNVbNREe0R4PReLs9XT1rfI94U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mbk7mUD60jP54gQvhu1GiZQnSyDdt0JJAC7cOhraugofoyBo/5ZPueMdABzJY977j
	 FsjfV8WMY6iSQVVj1ZYl7TiUzjPMRxE8Dkc9GMR9b+YZzyUWAM3zdLLxQk0k2BKCQi
	 Cr3uN7pbt+8hxrhJeutrFiCkMlSKFg4nqYZkB3lQma7iqot1H1swpDNuPJioVao5sl
	 rP5blQHmwMjjiYynLf145PObPtSJSZ2Ue4z/mEMOFF82NgayFrT1LaTBlbY6jUiIQc
	 qZzNVDqW9C2VUziwCE+x5WJIh0bV0Ub6nn2fushjORGzIb2JAMt0PeFaJ5fWncKfAL
	 yenPRWdhT/ENg==
Message-ID: <sashiko-outbox-166759@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: interrupt-controller: apple,aic2:
 Add t6041 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20261010-apple-m4-pro-max-initial-devicetrees-v1-2-781fb3f2d9f6@cyberchaos.dev>
References: <20261010-apple-m4-pro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev>
 <20261010-apple-m4-pro-max-initial-devicetrees-v1-2-781fb3f2d9f6@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 17:07:45 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: missing apple,t6041-aic3 in conditional block and t=
6050-aic3 typo
- [Low] dt-bindings: aic2: apple,t6050-aic3 missing from properties compati=
ble list
--

commit a6480c7857c24d9e74933b42107084ffbaf70be7
Author: Yureka Lilian <yureka@cyberchaos.dev>

dt-bindings: interrupt-controller: apple,aic2: Add t6041 compatible

The Apple t604x (M4 Pro/Max) SoCs use an AIC3 as interrupt controller,
same as the previous M3-M4 SoCs.

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple=
,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,a=
ic2.yaml
> index e3cadc5ad39d5..fa9d89cb40b1b 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.y=
aml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.y=
aml
> @@ -45,6 +46,7 @@ properties:
>            - enum:
>                - apple,t6030-aic3
>                - apple,t6031-aic3
> +              - apple,t6041-aic3

[Severity: Medium]
This compatible string is correctly introduced here, but it appears to be
missing from the allOf conditional block at the end of the file.

Because apple,t6041-aic3 is missing from the conditional block, schema
validation for valid M4 Max device trees (which specify 4 interrupt cells)
will fall through to the else branch and incorrectly require 3 interrupt
cells.

Will this cause make dt_binding_check and make dtbs_check validation
errors for valid device trees?

>                - apple,t8132-aic3
>                - apple,t8140-aic3
>            - const: apple,t8122-aic3

[ ... ]

> @@ -134,6 +136,7 @@ allOf:
>                - apple,t6000-aic
>                - apple,t6020-aic
>                - apple,t6031-aic3
> +              - apple,t6050-aic3

[Severity: Low]
The string apple,t6050-aic3 is added to this conditional block (which
enforces 4 interrupt cells), but it is omitted from the top-level
properties: compatible list above.=20

Is this a typo for apple,t6041-aic3?

Because apple,t6050-aic3 is not declared in the top-level list, its
presence here is dead schema code, and any future device tree using it
will fail schema validation.

>      then:
>        properties:
>          '#interrupt-cells':

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010-apple-m4-p=
ro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev?part=3D2
