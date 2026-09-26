Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B053769EA;
	Sat, 26 Sep 2026 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790421739; cv=none; b=diDMEnHoVndx4ISGdydgeB00GTmd7s+oFC0SEJUn690MmAvplPxWAPnekwBhz+YfXctt2/zhJgYq7sQkL9OEiMY8pp2qEWjlAhdX/YLnf8qmcWiw78/ChgSmRAeFWBvJFSLaathtJtu3dWEsQc4b3Tmsb0PBDB4n6/IppqDjS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790421739; c=relaxed/simple;
	bh=Cy2LyZAsiwV90qjXBEnY7MxiXgaSMghLh1lvfNTLkwo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i8DvrGlWGH6HWarvAn12zj8k4KsjF/K4tcDsKBlg7VJFrBd3jvABHZN+CbxuN/+Strm8zve+KAt6dgJ+LyXtbrlQiysJYuuEDMdNwT+1PzhbllaSFKdKviAmAVKI13qUmM6YIBgSQenCcZozaFATLmSlMsvt+3XkC8RXB9ynjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpB2eeUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpB2eeUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EEE1F000FF;
	Sat, 26 Sep 2026 11:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790421738;
	bh=ux6o8J2QDm33dcrVlwxejAB4O/AeYXcbPZsvdQoYD7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lpB2eeUxe8hk9IPRC46svY8A7lK0NK1Is/7qaukvJfBPnzHg+EIZCHbqgCWV9y3PL
	 4G4BneknQtLOTsuL/uKw5SSnf/vC1WKziB+4nYHf9+C9kMj9eI0GYr33R0IMcMNjpv
	 nBYc4IWk1xC8vLMZhE0d+qVA+UcoitdTJilEcJI/+QMKVUC1Hcg+NCy1249p+pTXwM
	 5ZEcfLZV0DsRe2T/MTHjtCk0MAkZstRTizck6OBToQHLoUawYIG5Ua4w8p5C/ZkZ3q
	 kUvwOQvRtg+AEqiHoQ9AEmJLXNxueRZXgjd9MFrV3Hu6EHLPJBcnLXh4WlsRQBkaUh
	 MdACsJMpEOX/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: reset: mediatek: add MT7629 TOPRGU
 reset indices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chuanhong Guo" <gch981213@gmail.com>
Cc: linux-watchdog@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260926-b4-mt7629-toprgu-v1-1-c124bf9ac273@gmail.com>
References: <20260926-b4-mt7629-toprgu-v1-0-c124bf9ac273@gmail.com>
 <20260926-b4-mt7629-toprgu-v1-1-c124bf9ac273@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 11:22:17 +0000
Message-Id: <20260926112217.A8EEE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: watchdog: mediatek: missing #reset-cells constraint
--

commit 8696685eaee46e4451438ad7ac853addff28818b
Author: Chuanhong Guo <gch981213@gmail.com>

dt-bindings: reset: mediatek: add MT7629 TOPRGU reset indices

This commit defines all seven reset IDs documented in the MT7629 TOPRGU
SWSYSRST register. It uses their register bit positions as the reset IDs.

> diff --git a/include/dt-bindings/reset/mt7629-resets.h b/include/dt-bindi=
ngs/reset/mt7629-resets.h
> index 6bb85734f68d8..828919eee2982 100644
> --- a/include/dt-bindings/reset/mt7629-resets.h
> +++ b/include/dt-bindings/reset/mt7629-resets.h
> @@ -53,6 +53,15 @@
>  #define MT7629_PCIE0_USER_RST			30
>  #define MT7629_PCIE0_PIPE_RST			31
> =20
> +/* TOPRGU resets */
> +#define MT7629_TOPRGU_INFRA_SW_RST		0
> +#define MT7629_TOPRGU_ETHDMA_SW_RST		1
> +#define MT7629_TOPRGU_DDRPHY_SW_RST		6
> +#define MT7629_TOPRGU_INFRA_AO_SW_RST		8
> +#define MT7629_TOPRGU_CONN_SW_RST		9
> +#define MT7629_TOPRGU_APMIXED_SW_RST		10
> +#define MT7629_TOPRGU_CONN_MCU_SW_RST		12

[Severity: Low]
Since this patch introduces reset provider capabilities for MT7629, does
Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml also need
to be updated in this commit to require #reset-cells for mediatek,mt7629-wd=
t?

Incomplete device tree nodes lacking the #reset-cells property for the MT76=
29
watchdog will silently pass schema validation, violating the subsystem rule
that providers must enforce their required properties.

I note this is corrected later in Patch 3 of the series so there is no
runtime impact, but static validation via dt_binding_check will be incomple=
te
at this specific commit.

> +
>  /* SSUSB Subsystem resets */
>  #define MT7629_SSUSB_PHY_PWR_RST		3
>  #define MT7629_SSUSB_MAC_PWR_RST		4

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-b4-mt7629-=
toprgu-v1-0-c124bf9ac273@gmail.com?part=3D1
