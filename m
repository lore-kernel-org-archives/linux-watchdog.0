Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD052DA768;
	Wed, 17 Jun 2026 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781663345; cv=none; b=PGxqYoXxIfZnwLYzT1EnIao4ZAHP0+0t2z4ywd1zbu3AavnWqOV3TCMfll5oVaToUJEqx347McyPXxt0iqZXwDENvdF+aBVbY5IbhainhtoeqS0HSI6+Xk64KSZkiWkydcWnhaltSDgRBDJ6tOI/DpI8xlS7VOca3/X241xesIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781663345; c=relaxed/simple;
	bh=6j5d5la2rwvTnZt+bwfIpGj/kiSujBFMbsqEV4KIOWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fwFATe4QCvdu7lmfBxcceVIqA8mWVsT/XMwnB9lkPiAlQTVy+leAQv4RtDkQ8nVPulRlY4E3pHb7RhlLjsGSCVwBmVHAd9aUa0/AGRK5hrqDW0MeRRmA9crtx43GaWTDVS7HQqXzfsoPTOtINAS+HvebJffxRpI8e97AzAF0T+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl+IVbH5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl+IVbH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C441F000E9;
	Wed, 17 Jun 2026 02:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781663343;
	bh=F0YguWK77VkJ38kuqwWHYTYK9c6hgwggh2lStPEcovQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tl+IVbH5q1S9TvFWW+KHjDFu8awgWOuvT7dTG4/7awWML5qL3a4h3zUtSnGObd27F
	 mOunsKkLmxQokJSzx2w1qOqnJnqO/NaAOHnjrRSDZmgQ9aFKwr2XJKEDhBDSEYcp35
	 5V2w8QX6bleMmXsK+3Rbziv9kTRgKyEag57+idjZRXYUQtuYPjE/4/Ma3XdpBu5xJL
	 db9CIDkcjrt261GfK5zlTtz2XZOfH0J/JIGegCvX02ICUengd3CSoaG3/2px7iqSP/
	 Yk71mMlwmkw1ljtSQP2GcLQ2Qt+fXJm6SNU7Wf1Q7o9roL6GIIp44+d+r4bmDSG2Sf
	 T+R53hcUPXvdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: arm: mediatek: Add MT8127 Amazon ford
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zakariya Hadrami via B4 Relay" <devnull+zkh1.proton.me@kernel.org>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260617-mt8127-amazon-ford-basic-v1-4-d02ad15ac359@proton.me>
References: <20260617-mt8127-amazon-ford-basic-v1-0-d02ad15ac359@proton.me>
 <20260617-mt8127-amazon-ford-basic-v1-4-d02ad15ac359@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 02:29:02 +0000
Message-Id: <20260617022902.F2C441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The device tree compatible block for `amazon,ford` is incorrectly s=
orted. The file specifies that entries should be sorted by SoC compatible a=
nd then alphabetically by board compatible. Because `amazon,ford` and `medi=
atek,mt8127-moose` share the same SoC compatible (`mediatek,mt8127`), `amaz=
on,ford` should be placed before `mediatek,mt8127-moose`.
--

commit 5d4dd6329b44b144dcfbe78c4a1cf82524b51ef6
Author: Zakariya Hadrami <zkh1@proton.me>

dt-bindings: arm: mediatek: Add MT8127 Amazon ford

This commit adds the device tree binding for the Amazon ford tablet based
on the MediaTek MT8127 SoC.

> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 382d0eb4d0af6..5ddc79689df91 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -124,6 +124,10 @@ properties:
>            - enum:
>                - mediatek,mt8127-moose
>            - const: mediatek,mt8127
> +      - items:
> +          - enum:
> +              - amazon,ford
> +          - const: mediatek,mt8127

[Severity: Low]
This isn't a bug, but should the amazon,ford board compatible block be
inserted alphabetically before mediatek,mt8127-moose? Since both share the
mediatek,mt8127 SoC compatible, sorting alphabetically by the board
compatible would usually place amazon,ford first.

>        - items:
>            - enum:
>                - mediatek,mt8135-evbp1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-mt8127-ama=
zon-ford-basic-v1-0-d02ad15ac359@proton.me?part=3D4
