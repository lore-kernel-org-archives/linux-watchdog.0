Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB685568FCD;
	Tue,  8 Sep 2026 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890039; cv=none; b=c10PqDhlDtFYsM1bsdxTw6B2hLT3kQ+ZbH0ZnpoinSfr8Yw1Qp3vYcQlzYQqi98WeUu+E0hWCLVFXSsr9bkSo5vXD3FeNg1iGswXUda/pFSfdl9lsTcYZTDIZ7dEl3WOlCLHMDZJn6BSqmm7aD9HJs3PiRERaRwuZPiuwqtYQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890039; c=relaxed/simple;
	bh=THyk43Os195QXhM6lmIGBTbk+u8i8mAeEpREyyeu5Bc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WOq/6P1tklOqaBFraLdLjkQN6D4xfy1qPM1y4wZkpdQeV9tIuY1EHPUXyQ1pWvpL7p63fqwvRkvFe3P0HU3Ur+hI16hz910byylg/3ht9L7/P//K/vX66WqojLTgDfEt5gVL5al2VCQ4JSUIoy1zETrWs5XfkGyZxI+Hb/CxMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrAnQQzo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrAnQQzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB1B1F00A3A;
	Tue,  8 Sep 2026 17:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890037;
	bh=4QtM6Hbi4gcywrhhjCn+7LKCMCBN31he95Z6+BIsvL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YrAnQQzoZjGEEQ1bEJlKZIPx3b72jxLZfmFCM3nnDJ3HfT1OxBULdS7r7CiaDvZr9
	 NpaSni/55+zi2/LlHuz4PasyOgnGyskkt22IAHghc/QTMk8AQtFL2GDX5zp7JftiK1
	 0I97MrP5/m5afAjFtO6V3RabaIKxT50pghezytVXzouxFWkbZE89B3dR7fVzZFeGdr
	 h+ZRbpQpL9HSBQB4aegyLfrlIGx6QGiX1Hfn1QDqIQT7RPNHK7pduJVNz/G933QwUL
	 OVBi6EAx27Xz8p/FcVmbqrLWh2kJIvEWBy8Ww5ZAsIemo2NNViYU8oPrstfQV8g1Al
	 PafGxWSgOcs3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/8] dt-bindings: watchdog: Add compatible for
 MediaTek mt8167
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260908174259.9009-4-l.scorcia@gmail.com>
References: <20260908174259.9009-1-l.scorcia@gmail.com>
 <20260908174259.9009-4-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 17:53:56 +0000
Message-Id: <20260908175357.3FB1B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing required property constraint for new provider capabiliti=
es
--

commit 1623803f044eb5bb4bdac92465a186ae36fe6a1a
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

dt-bindings: watchdog: Add compatible for MediaTek mt8167

Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
which in turn falls back on mt6589-wdt. However according to the data
sheet mt8167 toprgu is not actually compatible with mt6589 (it has 14 sw
resets instead of 12, and its reset bit map table is different from
mt6589).

Update the mtk-wdt binding to add a dedicated compatible for mt8167 and
add the IDs that can be used in device trees to identify subsystem resets.

> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.=
yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index 953629cb9558b..f514be8a5851d 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -26,6 +26,7 @@ properties:
>            - mediatek,mt6795-wdt
>            - mediatek,mt7986-wdt
>            - mediatek,mt7988-wdt
> +          - mediatek,mt8167-wdt

[Severity: Medium]
Should #reset-cells be added as a conditionally required property for this
new compatible?

Since this patch adds reset provider capabilities to the hardware (defining
reset IDs in include/dt-bindings/reset/mediatek,mt8167-wdt.h), the schema
needs to ensure #reset-cells is conditionally required for this variant.

Without adding #reset-cells to a required list for mediatek,mt8167-wdt
under properties:compatible:oneOf or via an allOf block, a device tree
node omitting it will silently pass dt_binding_check validation. This allows
incomplete configurations that will fail at runtime when dependent nodes try
to consume the resets.

>            - mediatek,mt8183-wdt
>            - mediatek,mt8186-wdt
>            - mediatek,mt8188-wdt

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908174259.9009=
-1-l.scorcia@gmail.com?part=3D3
