Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7620B38332F;
	Thu, 16 Jul 2026 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220438; cv=none; b=lmRfxHnlU84NfBH/5n/0AHvSRAXkXchS7q1RCtLdc7HVUdFzUBlh6fcMEcES1Ao8KYZAYvYAsRNFB6gmOk6OOO/N150emjgB3eXjnLu7oVdsAIdzKeoo6PZSrvtXwxOO3c1hWFfbMGp39P4XZpOVtqzeZqrSJnMs+BAvepyyUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220438; c=relaxed/simple;
	bh=AY6HCUK+id26GeNM0B8n2uO5e2NGlNGfSVW7DnlxkTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VnJdb3orivtw1+CFT09XATHJ1DiGWsFNhpzEiIX0NZe88h4lgKzlWQUE7VEXlERTG0Ngmi2rKoMb0Pi+tXlXUO5ckDagxuW8KXEDCzVCpVTgxW59/mQrTNZJE5CiLq2XQsHk+YjuyfffUSDjaLbm1iRdOn6aaEJU42aFDF0Rpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHBPjvYt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHBPjvYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990E11F000E9;
	Thu, 16 Jul 2026 16:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220429;
	bh=tNxx9JyiPadK6H/+psbWviiU+vG791vjcCFYe9aI17o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EHBPjvYtCx9aVlAuf+arBv2Ub4ImAIBDHs1xnjxOdfSybgufrUmKXUnAsc6E2Boho
	 5a2zC2cb2MQ0weSHMltNJrneTWFmpdty9qQjTuUk+wxgNz2c65N171Y7/JELP2Ws4u
	 PJs4eZ7HlfYbG92UDzUpUsk2xza2dVc6F629AknzADRdArMbc/WU9scNkAUSF862DD
	 xLjjfAwJRECGmzW+wjCbxfRS0YORZtCNUI4R0vKMMgObj7gYPCCLm0WlrknZBRZvWA
	 goW2FsGVxP/WKljXqWbwJBH9h3345XyuNlvRiaLT7hOL+AbTtopnPbvCGPJTnLlnbD
	 9ONeh08/+Igmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: reset: Add bindings for MediaTek
 MT6589 reset controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akari Tsuyukusa" <akkun11.open@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260716161923.266315-6-akkun11.open@gmail.com>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
 <20260716161923.266315-6-akkun11.open@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 16:47:09 +0000
Message-Id: <20260716164709.990E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The mediatek,mtk-wdt.yaml binding schema was not updated to requ=
ire #reset-cells for the MT6589 watchdog hardware variant.
--

--- Patch [5]: [PATCH 5/7] dt-bindings: reset: Add bindings for MediaTek MT=
6589 reset controller ---
commit b3f415af68c03c846f8813bd551b69190964c62a
Author: Akari Tsuyukusa <akkun11.open@gmail.com>

dt-bindings: reset: Add bindings for MediaTek MT6589 reset controller

This commit adds the reset controller index definitions for the MediaTek
MT6589 SoC. It defines 12 reset lines under the TOPRGU controller.

> diff --git a/include/dt-bindings/reset/mt6589-resets.h b/include/dt-bindi=
ngs/reset/mt6589-resets.h
> new file mode 100644
> --- /dev/null
> +++ b/include/dt-bindings/reset/mt6589-resets.h
> @@ -0,0 +1,25 @@
[ ... ]
> +/* TOPRGU */
> +#define MT6589_TOPRGU_INFRA_RST		0
> +#define MT6589_TOPRGU_DISP_RST		1
[ ... ]
> +#define MT6589_TOPRGU_PWRAP_SPICTL_RST	11
> +
> +#define MT6589_TOPRGU_RST_NUM		12
> +
> +#endif  /* _DT_BINDINGS_RESET_MT6589_RESETS_H */

[Severity: Medium]
Should Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml also
be updated to require the #reset-cells property for the MT6589 variant?

Since this patch introduces the MT6589 hardware as a reset provider, device=
=20
tree nodes lacking the #reset-cells property for mediatek,mt6589-wdt might
incorrectly pass schema validation. Would it make sense to add an if-then
block to the YAML schema in this series to enforce the #reset-cells
requirement?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716161923.2663=
15-1-akkun11.open@gmail.com?part=3D5
