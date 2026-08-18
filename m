Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCFC484232;
	Tue, 18 Aug 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787077401; cv=none; b=YWIPBDB3OzbxJh2e7lv2DGIa6tMtv6iAIRZIJxVPcI6nEZMRXVGw8Ikw37Lq9KctFhk+9LR2lBAyY2kyluQbBBK/7gpaZe+lXbfD5yKYnxIS7XFL0oyaK+h0EcGpzOHViDpOo8ggKPsE3Eglm5aMjx2rsw1elH/XEmwUMBxYw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787077401; c=relaxed/simple;
	bh=oT5orWIlGf1F8/jO50rS0VTGoIJsqPDGSYL9Riz7b4A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pN5RegLRelSCseVE80c97yIbfpSr7CiBb0CIr7tjPEgRW6HAmvMq0aAh/2FtaYpyQxpcnkwc7rwZZh0SFGqhGQ4w834g1XswzzyMuFG6L65QcdySX1l5ecR/03UmHYIsFMKfjb/Y2QvZHA2FPMh8PjFUmtn+3M80f8QE56/WIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=mrsQBZtP; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="mrsQBZtP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1787077397; x=1787336597;
	bh=HsbYxvAgY02/uiPmLFBmjKCaDF6DtWmYIgcGandjMwk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mrsQBZtP70Vqn392j2W6s+umKqGOFQfSDTE9lsk6rC+AXfs4XBpl2+fL0M0sgo5/C
	 aGyTNfoJA7VzBwwY0mkL9myqqykiofvLxePUsC16v7vsxf69CYnowC3xP9V3onAmST
	 XzpbVqL/qJtg/HD19C5JXfp2GUUil0U2SyH9ngBL4sPacD9IhKiEb/s6gua25syV1w
	 W2v567Y/LoecfLdagx7g5LQsKZRVBuhGQuEW9OQ8ngbRe6XaOxw32oREnmcqdqZCxR
	 gIVU7fuMrO6p4UKNLTfgb+EIqY+qGjQ2LiB1xUeBuVYNGLz/cHCfVT+2wMFgL8dOy5
	 oIbkezupObzNA==
Date: Tue, 18 Aug 2026 18:23:14 +0000
To: sashiko-reviews@lists.linux.dev
From: Aiden Isik <aidenisik@protonmail.com>
Cc: Aiden Isik <aidenisik@member.fsf.org>, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: watchdog: samsung-wdt: Add exynos5515-wdt compatible
Message-ID: <W7Q9YguMsBgZQ46ixXv8YeDElsxoiS1wVQpGo3rfJUAhCkZbIp1orAnYQkQ4Z-7v5poBAQU29e1GXZ0K_CkSlTPVIdQuMuuPc5yLiIZriJQ=@protonmail.com>
In-Reply-To: <20260818181430.3B7E91F000E9@smtp.kernel.org>
References: <20260818-for-next-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org> <20260818-for-next-lucky7-watchdog-v3-1-2912bd122c57@member.fsf.org> <20260818181430.3B7E91F000E9@smtp.kernel.org>
Feedback-ID: 46524699:user:proton
X-Pm-Message-ID: a2ad14f68aaa700b24307f89b72a646badcb3c3e
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
> - [Medium] The new `samsung,exynos5515-wdt` conditional block may incorre=
ctly enforce a 2-clock constraint, potentially violating the subsystem gene=
ration grouping rule.
> --
>
> --- Patch [1]: [PATCH v3 1/2] dt-bindings: watchdog: samsung-wdt: Add exy=
nos5515-wdt compatible ---
> commit 751ef37a6e709e26029d210213d732f6299f833b
> Author: Aiden Isik <aidenisik@member.fsf.org>
>
> dt-bindings: watchdog: samsung-wdt: Add exynos5515-wdt compatible
>
> Add a dt-binding compatible for the Exynos5515 watchdog timer.
>
> This watchdog requires a syscon phandle, and the cluster index should
> *not* be specified, as that does not make sense on the Exynos5515 SoC
> (due to it only having a single core cluster).
>
> > diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yam=
l b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> > index 41aee1655b0c2..a32c478315779 100644
> > --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
>
> [ ... ]
>
> > @@ -93,6 +94,26 @@ allOf:
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
>
> [Severity: Medium]
> Does the Exynos 5515 hardware actually require two clocks?
>
> Other Exynos 5 hardware, like the exynos5250 and exynos5420, typically
> use a single clock constraint.
>
> If the Exynos 5515 only has a single clock, this two-clock constraint wil=
l
> unintentionally force device tree authors to provide a non-existent secon=
d
> clock to pass schema validation.

Exynos5515 is more similar to Exynos990 and Exynos2200 than Exynos5.
Two clocks is correct.

>
> > +        samsung,cluster-index: false
> > +      required:
> > +        - samsung,syscon-phandle
> > +
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-for-next=
-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org?part=3D1
>
