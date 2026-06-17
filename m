Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED02F8E85;
	Wed, 17 Jun 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703439; cv=none; b=kfXxi+ngbl2ZYOtrgNE6uoTNW4Gzr8e3Dy8J2M0OJn/k+HhJTGs8xkE89DjpKuEM2mmn92VOS/rOp5xGn7eq5q0sFCcol3LAZrjY3ZciSBqOsuftvukQMrS5d1NI5q/DFingn0xdz++TE6YT5NpdDvXjOAtE1u2UMbpuOTUMqfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703439; c=relaxed/simple;
	bh=oDALUj//HPljI6BidS2OPjD+hQfSM7usFOv2D9/WMF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZBNFFVFGi2ENwE3IhO7Rho3cvpFpZlyir/m1u9M9goGfxub+esw8NTfP1qXIj8uvbTMIC1PbjlRG8wh3TilCwDuGL3ZoT68hOWdKzhvDU82UEJSWT7VonCltV2JoPgSNr8C+ZQHhtLY8ZxQ8+LL83NoUDtPZSKq1qwZWILCi+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/VMKbDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/VMKbDX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C846C2BCB8;
	Wed, 17 Jun 2026 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781703439;
	bh=oDALUj//HPljI6BidS2OPjD+hQfSM7usFOv2D9/WMF4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k/VMKbDXmH6Tylzq01TtdO5kO7xpnSu8NRbPJVI7EDg7UhvKwNfCH3QHhe8mTozaf
	 axM3pk28E+Ex4E8eYoE6jWmRK9l9SqFlkbJxmwozvH1pLpA6gSyWXfBDCmKczKgLyx
	 mOlsCQL7RtfqDyUi4QAU/ScptRNWfXS8qIatFlK1FPFu1fRiVzlxWLfhylB0lefW7I
	 wTKSohIAd8mEvr9uhzDxIxszGUzZ7VRQGi5X+i6knRizmuR8d9pfeXZyOjbdJRRcdB
	 O6tzgmZDDRGDwHCY0CE5jz4uAPDtLak99dlbBRipViJnOc4SO0yg4liyjn4gf8Le5o
	 mnOpzokdKxJAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64427CD98E2;
	Wed, 17 Jun 2026 13:37:19 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh1.proton.me@kernel.org>
Date: Wed, 17 Jun 2026 22:36:59 +0900
Subject: [PATCH v2 1/5] dt-bindings: watchdog: mediatek: Add MT8127
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-mt8127-amazon-ford-basic-v2-1-6859e29e72a8@proton.me>
References: <20260617-mt8127-amazon-ford-basic-v2-0-6859e29e72a8@proton.me>
In-Reply-To: <20260617-mt8127-amazon-ford-basic-v2-0-6859e29e72a8@proton.me>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, Zakariya Hadrami <zkh1@proton.me>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781703437; l=955;
 i=zkh1@proton.me; s=20260616; h=from:subject:message-id;
 bh=biWOiqmry9LgaiOTwUC1SAvyWdKvAgZ0Pq6ZY68s2fM=;
 b=Wu9XaZItWvuv0sYoM0oaHGAcXv1MIFgt+LwbNE4sArjeTWwzng7Z+5bXygQ/KBpPuRzOYDXRI
 TxqAKg0i4FyAlBYdJC3VY+5q22B6OZszpXuoZX5nVJmmWXA/jbE4rsq
X-Developer-Key: i=zkh1@proton.me; a=ed25519;
 pk=9DiJwhINAERP95fbFofXSP77GEnvfO/rMIRRRFDhaoc=
X-Endpoint-Received: by B4 Relay for zkh1@proton.me/20260616 with
 auth_id=824
X-Original-From: Zakariya Hadrami <zkh1@proton.me>
Reply-To: zkh1@proton.me

From: Zakariya Hadrami <zkh1@proton.me>

Add entry for MT8127 SoC's watchdog which is compatible with MT6589's
one.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Zakariya Hadrami <zkh1@proton.me>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 953629cb9558..e6e4546da0aa 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -40,6 +40,7 @@ properties:
               - mediatek,mt7622-wdt
               - mediatek,mt7623-wdt
               - mediatek,mt7629-wdt
+              - mediatek,mt8127-wdt
               - mediatek,mt8173-wdt
               - mediatek,mt8188-wdt
               - mediatek,mt8189-wdt

-- 
2.54.0


