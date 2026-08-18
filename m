Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95FB485CC1;
	Tue, 18 Aug 2026 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076872; cv=none; b=jxt98cw8IXwit4BzFmvzIMI9AQqKfd6oAJz5ErrO6JQf57P32CAg0tmLHHqyZwOIv2I8F1B9ALsL4n8vU29i/wmYegz3Kp/gZno28GaH0hwS8yG9ZMMtRZYCGV9dGWQ7RctWRzpUCh6hPGrCGig+S9U0utaaCdkFFkg8fGjfJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076872; c=relaxed/simple;
	bh=zaKQAm6DaAb9s2g60/Oexin16kUsUpK+SEjF/s3Ivhw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gT4FHsl3fbCL2atV82HyqD/nPZr4kqO80D5x8GFjMAbqLCrpaSuziIZHOZJIv7lA/+zeMSnyTqcxl4sBi+lYSkp4+Fl1AL/XDzy30Obto/d7ychNvQeMWmVu9pceIY7xuOAIeNkQlt8D+rRTkHvBTRQU3eMESnpizZrq3AaNS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moeoUi2w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moeoUi2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7E91F000E9;
	Tue, 18 Aug 2026 18:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787076870;
	bh=6IbS3mw9r8NPj/oeNLJI9nt4tVuo4/IiVBuGxDrLngI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=moeoUi2waxP6vsuBi9U0sLviRfSHWuaZjCiuzkEfQRQMuDczfkMjohyvCO81Bbhv4
	 ENfubr0cfDCQ6BR9iSDSTVj84zt6Xsz6hAd4V+2pUn/CI2Mmj8Wwng5Tcl+rURQfoA
	 WD/qQSUbZAVcdY1zLuE6NFPWw+8BclAqNbje4sovmfB/cdFNguOxitbdi/32Kt8IhR
	 MZ6/lYT320R5jX54/UoDc8LDKv/Rvq0pRPGQcRJoVzcFsCQQe7R/4gxA231xWWMHP3
	 0gKHhrWaovwV9hnA+VRyR+cmqhwm8mNLUtPYCBzDDtcYOjK50568DS02SrATj13HbI
	 dCni+LIM6Ydig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: watchdog: samsung-wdt: Add
 exynos5515-wdt compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aiden Isik" <aidenisik@member.fsf.org>
Cc: linux-watchdog@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260818-for-next-lucky7-watchdog-v3-1-2912bd122c57@member.fsf.org>
References: <20260818-for-next-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org>
 <20260818-for-next-lucky7-watchdog-v3-1-2912bd122c57@member.fsf.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 18:14:29 +0000
Message-Id: <20260818181430.3B7E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new `samsung,exynos5515-wdt` conditional block may incorrect=
ly enforce a 2-clock constraint, potentially violating the subsystem genera=
tion grouping rule.
--

--- Patch [1]: [PATCH v3 1/2] dt-bindings: watchdog: samsung-wdt: Add exyno=
s5515-wdt compatible ---
commit 751ef37a6e709e26029d210213d732f6299f833b
Author: Aiden Isik <aidenisik@member.fsf.org>

dt-bindings: watchdog: samsung-wdt: Add exynos5515-wdt compatible
   =20
Add a dt-binding compatible for the Exynos5515 watchdog timer.
   =20
This watchdog requires a syscon phandle, and the cluster index should
*not* be specified, as that does not make sense on the Exynos5515 SoC
(due to it only having a single core cluster).

> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml =
b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> index 41aee1655b0c2..a32c478315779 100644
> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml

[ ... ]

> @@ -93,6 +94,26 @@ allOf:
>          - samsung,cluster-index
>          - samsung,syscon-phandle
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,exynos5515-wdt
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Bus clock, used for register interface
> +            - description: Source clock (driving watchdog counter)
> +        clock-names:
> +          items:
> +            - const: watchdog
> +            - const: watchdog_src

[Severity: Medium]
Does the Exynos 5515 hardware actually require two clocks?

Other Exynos 5 hardware, like the exynos5250 and exynos5420, typically
use a single clock constraint.

If the Exynos 5515 only has a single clock, this two-clock constraint will
unintentionally force device tree authors to provide a non-existent second
clock to pass schema validation.

> +        samsung,cluster-index: false
> +      required:
> +        - samsung,syscon-phandle
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-for-next-l=
ucky7-watchdog-v3-0-2912bd122c57@member.fsf.org?part=3D1
