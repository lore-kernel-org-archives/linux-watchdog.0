Received: from mail-24425.protonmail.ch (mail-24425.protonmail.ch [109.224.244.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F973F8899
	for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964823; cv=none; b=GWjEhTAnJG+ZGIvfppy3BDS2hEZ9NDbc13yRMlZuHEOqH3PrMDJpVrNgMM37/3YrsMDr4EQDaPSE+UZF5YyF5WOGJqpx6r/e3gZCfWaG0Sf3KF9ue0Xfoj/ic3CgcBHwg//EggGxITGPajE3tdx56DIsALeA461iq2ysZnEsw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964823; c=relaxed/simple;
	bh=olB7tn1QN+03y2fPPImqX2pF09yxLXV3gpqgx/rX/FA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcTkcpYF0rBqcAungsSq0qIInX+eoJAe6MI8hJ4iunCqxyg6YV4z2SgUCbnXra+zZ1001RZuTSeb0nx3g3ZESuJM5ennt7XPbUzJ2O5jd/GIzBc2VQkiOkRf4A/bDqtduxPNM8xFCuPiWxfqQb63bZUyEcB7M1yvmwVz/QV0YxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=l/7o6RHD; arc=none smtp.client-ip=109.224.244.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="l/7o6RHD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1786964812; x=1787224012;
	bh=uQtIF5mRa8im+qF8639pOrqAdTkynIuPHZV/HoaRR90=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=l/7o6RHDvr5vX+oVTU1oFmfDkF5TJUKErP3kBH4Ky/sm8GHf0Ju+poqFYZQPW8EE4
	 aeO3b3d3MyPw2msNmFXYGTmSSpa3evWqlWGaoD1YA7kWpwP6rlVgbNpKXq3Vx+pVXg
	 F/fofrBDSxQnM6elUODAUaXt24pGosOhh/XZe0msK5y94ALRjorQuDCy98sxOmyuj2
	 OZjPtBcoWlyx8f0pgOGD/Gtuv+QrJPSYwfIM4VhCmrJVVEM0VL6xiXFy7BZ9BeD2ya
	 vqeUpGLgfRX2iTP+i4M5bIFHqS97xTg5+SvELie5fSRy3bFZPHP/7ud/fnf01c3Zwb
	 KNaLbfRc82mRw==
Date: Mon, 17 Aug 2026 11:06:47 +0000
To: sashiko-reviews@lists.linux.dev
From: Aiden Isik <aidenisik@protonmail.com>
Cc: Aiden Isik <aidenisik@member.fsf.org>, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: samsung-wdt: Add exynos5515-wdt compatible
Message-ID: <Y99yVgeuV_yJc77kx7_wK92573GiF6Nm4_7MP1JYM-vXfzYRdq5fjOGkS7LhdrIVe869x74MMRgGFfl5E_4KwOD-Z-OkG3XTEhd-CExeB3w=@protonmail.com>
In-Reply-To: <20260817102657.C0EAC1F000E9@smtp.kernel.org>
References: <20260817-for-next-lucky7-watchdog-v1-0-a14370e20b92@member.fsf.org> <20260817-for-next-lucky7-watchdog-v1-1-a14370e20b92@member.fsf.org> <20260817102657.C0EAC1F000E9@smtp.kernel.org>
Feedback-ID: 46524699:user:proton
X-Pm-Message-ID: 85bbd80766d2a542f86c9cfa9a11e127f137255a
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The dt-binding fails to explicitly forbid the `samsung,cluster=
-index` property for `samsung,exynos5515-wdt`, contradicting the commit mes=
sage.
> --
>=20
> --- Patch [1]: [PATCH 1/2] dt-bindings: watchdog: samsung-wdt: Add exynos=
5515-wdt compatible ---
> commit 63eda32b0d2c9ec15d915ccf3b6c34aae569838f
> Author: Aiden Isik <aidenisik@member.fsf.org>
>=20
> dt-bindings: watchdog: samsung-wdt: Add exynos5515-wdt compatible
>=20
> This commit adds a device tree binding compatible string for the Exynos55=
15
> watchdog timer. It requires a syscon phandle and specifies that the clust=
er
> index should not be used since the SoC has a single core cluster.
>=20
> > diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yam=
l b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> > index 41aee1655b0c2..9e754404848b9 100644
> > --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> [ ... ]
> > @@ -93,6 +94,25 @@ allOf:
> >          - samsung,cluster-index
> >          - samsung,syscon-phandle
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - samsung,exynos5515-wdt
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: Bus clock, used for register interface
> > +            - description: Source clock (driving watchdog counter)
> > +        clock-names:
> > +          items:
> > +            - const: watchdog
> > +            - const: watchdog_src
> > +      required:
> > +        - samsung,syscon-phandle
>=20
> [Severity: Medium]
> The commit message mentions that the cluster index should not be specifie=
d
> for this SoC. In the allOf conditional block for samsung,exynos5515-wdt,
> does this need to explicitly forbid the property by adding
> samsung,cluster-index: false under the properties section?
>=20
> Without this constraint, will dt_binding_check silently allow device tree=
s
> for Exynos5515 that erroneously include the samsung,cluster-index propert=
y,
> since it is defined in the top-level properties block and thus valid unde=
r
> unevaluatedProperties: false?
>=20
> --

Will fix in v2.

> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-for-next=
-lucky7-watchdog-v1-0-a14370e20b92@member.fsf.org?part=3D1
> 
