Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A403E49DD;
	Mon, 17 Aug 2026 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786962419; cv=none; b=OjrTB/zPKBEQpfeuu8eI66bzpxM4TMlCnwrJxVtrrhzhq+lEdeRr/fFPfIUE4kUq53k3xL1dSgOoJtu0VOhBo7gSOkmiJAJcTMte3S2J2mRkKtTy1jCR5djm55H7gw/LsbkHNtw6wuIuIc+e3GuWHFY1Yd4uKYACoqhmJhrEPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786962419; c=relaxed/simple;
	bh=zfj984efq5hcM2LcaLf5+kayJKN093mFj+P/r//ljWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hdmbGOYXc4dyj+gLfddNiE837eoWT5MRVjyzcbWoWZhzIW79rRbG3lN0em6RMp3rIp1vC+zaW4vgIKb3AWk2Bsw+oWaxKijL8b45/l9m1vhjTZPAKZWCZEQs2HQDipV3Q3/QB0b2afI3hb2cjX0BhJh7EL17jL70+hVBEeGTIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvcg9h9u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvcg9h9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EAC1F000E9;
	Mon, 17 Aug 2026 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786962418;
	bh=C2zyTrS6HTbeCgwr8E3UsMNzkdUoSlPkQe2lp/GSPQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xvcg9h9ucWD7Ty7++qzUtmPPTI3yIhvwebPQYXCn/KAay9AEIdaIL8zS6IS31E2si
	 aRHLBHXHJTZqQMkQZeROZDnazycWpm2CnntWwXnBg6eEerMJJxHWxl3kBULZMpsoxJ
	 UUHT+ZSo6flel//o7rx61DyDXTR615N/buUpG4/8Ds97ezZ4NJN361u6BxRwPlgEo8
	 tEa8VimSuM5ah64/h78wY8gkHoIY+BLtwD7NtBC/v+QHS0glgcGKgfCBocqZykIxJv
	 d4ULRPPK9O2wX0bsQ8QeJ+TicBchSJUJ7sUXSWET3c0Ujq1baC2ygM5BjFRY9c9O4Y
	 RpUckMc4FJW/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: samsung-wdt: Add
 exynos5515-wdt compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aiden Isik" <aidenisik@member.fsf.org>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260817-for-next-lucky7-watchdog-v1-1-a14370e20b92@member.fsf.org>
References: <20260817-for-next-lucky7-watchdog-v1-0-a14370e20b92@member.fsf.org>
 <20260817-for-next-lucky7-watchdog-v1-1-a14370e20b92@member.fsf.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 10:26:57 +0000
Message-Id: <20260817102657.C0EAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The dt-binding fails to explicitly forbid the `samsung,cluster-i=
ndex` property for `samsung,exynos5515-wdt`, contradicting the commit messa=
ge.
--

--- Patch [1]: [PATCH 1/2] dt-bindings: watchdog: samsung-wdt: Add exynos55=
15-wdt compatible ---
commit 63eda32b0d2c9ec15d915ccf3b6c34aae569838f
Author: Aiden Isik <aidenisik@member.fsf.org>

dt-bindings: watchdog: samsung-wdt: Add exynos5515-wdt compatible

This commit adds a device tree binding compatible string for the Exynos5515
watchdog timer. It requires a syscon phandle and specifies that the cluster
index should not be used since the SoC has a single core cluster.

> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml =
b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> index 41aee1655b0c2..9e754404848b9 100644
> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
[ ... ]
> @@ -93,6 +94,25 @@ allOf:
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
> +      required:
> +        - samsung,syscon-phandle

[Severity: Medium]
The commit message mentions that the cluster index should not be specified
for this SoC. In the allOf conditional block for samsung,exynos5515-wdt,
does this need to explicitly forbid the property by adding
samsung,cluster-index: false under the properties section?

Without this constraint, will dt_binding_check silently allow device trees
for Exynos5515 that erroneously include the samsung,cluster-index property,
since it is defined in the top-level properties block and thus valid under
unevaluatedProperties: false?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-for-next-l=
ucky7-watchdog-v1-0-a14370e20b92@member.fsf.org?part=3D1
