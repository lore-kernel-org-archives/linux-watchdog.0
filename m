Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B04055821C;
	Tue,  8 Sep 2026 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904774; cv=none; b=etOsnXmAJEzAuAIvOhc82j0PHIu6D2Fr02Hk/rtRhrtTGSq1pamXea4rXFIrpvrCmGexZPAmlY3ibnHkUz1tQzIxbZJhq6/dvVElmDo2Rf33ZYNkC+J2T3UG3QLpJd5Rs0J+OHV9m4xSUIVHjN/hH3zYKFfn23A50qCqz6S4BHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904774; c=relaxed/simple;
	bh=XNvMPjZX0+WXpT4mWFJChE+oCnrBaMYSvQo6qFGzXNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ilBP+VMw2m+POUOML/PRhrkNH3uF1JL6YVtd4sIfeXNj1JOdLc7Y6FK83Oql32hz7e5Uw2uAtrDcWE4icU0jQdo0xssp8IDJzrZPgt0aHEOELg1WsPD2Upd0gvic1uJ9V61W9CDv0xmXZw1MlN2TC87BBFcaK5X9xXGdt08H2zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMBpPynJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMBpPynJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 183BAC2BCFC;
	Tue,  8 Sep 2026 21:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788904774;
	bh=XNvMPjZX0+WXpT4mWFJChE+oCnrBaMYSvQo6qFGzXNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rMBpPynJ/jbBSHPVFb+iauYmGA+HS1B1MS6KAdbl4OiKfBQ/tVDzVG/cqL7krrwYh
	 KcEhNi90sKM5IYmuLrHPjMbahBH3pPW/EUCx3QCTcctXW/4ArWd8NTiqzW+QkvuqTn
	 RzOiH/z59YzsSLvmVb1fqKnOd8yUToAukoEVGtqJAQ4JGUw0534sajzbQVCXvZsVnZ
	 M6Re/HZEz2caGMeQR4NoWXBPN+KJlU+fDw5M6JgGCu57CjlGIOlpyWpl3Ov0D84yxk
	 DSiCancBm/Wu9wI4UOyxkoWlN8X1nvMPqO/x6H4FJXbEHgjO/mGG+SYBC28x2MKJDn
	 6025PxVujHJIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF59C79F82;
	Tue,  8 Sep 2026 21:59:33 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh.mailbox.org@kernel.org>
Date: Tue, 08 Sep 2026 23:59:14 +0200
Subject: [PATCH v3 1/4] dt-bindings: watchdog: mediatek: Add MT8127
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-mt8127-amazon-ford-basic-v3-1-fc46bf1b6cb2@mailbox.org>
References: <20260908-mt8127-amazon-ford-basic-v3-0-fc46bf1b6cb2@mailbox.org>
In-Reply-To: <20260908-mt8127-amazon-ford-basic-v3-0-fc46bf1b6cb2@mailbox.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, zkh1@proton.me, 
 Zakariya Hadrami <zkh@mailbox.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788904772; l=1002;
 i=zkh@mailbox.org; s=20260908; h=from:subject:message-id;
 bh=W+fYT6FEZ+BsGX4xaHNPJY7m/vM9qOAG6TkfJVwh8eg=;
 b=PCj7oU1XtdbOT9dwhnGljvOvur9e+ECwW7YUpNX1BodnT9teCU02+9L3pZFFViomE5NyniZw4
 hjGyJVQOETEBuADtfMYhrTrh6Bbtkq6O8PfUV611A1nx2e4QE1UizhY
X-Developer-Key: i=zkh@mailbox.org; a=ed25519;
 pk=up24Xn4ScFKugfT4EJru/UQAS7JOIN+DSQqro+a05T4=
X-Endpoint-Received: by B4 Relay for zkh@mailbox.org/20260908 with
 auth_id=1015
X-Original-From: Zakariya Hadrami <zkh@mailbox.org>
Reply-To: zkh@mailbox.org

From: Zakariya Hadrami <zkh@mailbox.org>

Add entry for MT8127 SoC's watchdog which is compatible with MT6589's
one.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Zakariya Hadrami <zkh@mailbox.org>
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


