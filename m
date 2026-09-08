Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B205559307;
	Tue,  8 Sep 2026 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904774; cv=none; b=J2hhf8TTOYcIKovSOIwGkokzYRGz4W9Tx3u3KKLH7eGyCzY9DnngGpvqaW/8uBSl0NQMbq8e61p0hxa65ZNHMzBSOe16sAfUqkbhcBUpFBV+loQOyTP0VkUX60MqGd1F/Mqqf+IYvmJEXxcAFo3RwRIGi86C4m1gKTW+eIP+FpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904774; c=relaxed/simple;
	bh=P0qNZiLTQV7gn0UuncV6cdn6iEieMHPrHFYC39KFYEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYnATcUMBfDXSCVruyIH4XoCzPn1P6+0WwNX8Zq0Q8ZEezhDsqWJecMhMJMhYJwBuu/6AGDjf6t5hiblVir3ibJEV4ZXeX8qg/7yTiREksKJMUsj+aI7cqLk3ksD4/vGsR9R9EFHfM04CqlCuKGw8WXH89YmiYlp04GE6DUK43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqm26a/y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqm26a/y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 326F1C2BCFD;
	Tue,  8 Sep 2026 21:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788904774;
	bh=P0qNZiLTQV7gn0UuncV6cdn6iEieMHPrHFYC39KFYEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iqm26a/yV1ug357w6VwTeYtp7fJC7QQiSaxeVV3Nrbo2zXD9b9TH6LfKNTBldEQ0v
	 MGcPBnsZcMCYjT1GsEv792p6QsQ1Hf6xl3UzjSgMzxZVgbjlvHsqOC3JWXfzgONf/u
	 hjnu4n0ktg5rF/zfFoBTNu1yBThdpIfLmQG5mFaQk1yppmibyLG0RmckPTYydKjkFx
	 ReYQyJKz7Yt9eEGExPiLvBuobIxB0xpcBsAZGZe+pIVZsdG1uiufwOKSMwJkHNoaZO
	 +wXdkoPusLGKHAoW0KupTl6EeHc6oy9h92jY+AOIvq3e2Ib4+v/pcsv+3kDX8D+52f
	 Xl/nFLsItoc9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECBCC79FA1;
	Tue,  8 Sep 2026 21:59:34 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh.mailbox.org@kernel.org>
Date: Tue, 08 Sep 2026 23:59:15 +0200
Subject: [PATCH v3 2/4] dt-bindings: arm: mediatek: Add MT8127 Amazon ford
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-mt8127-amazon-ford-basic-v3-2-fc46bf1b6cb2@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788904772; l=801;
 i=zkh@mailbox.org; s=20260908; h=from:subject:message-id;
 bh=6yb/XWefb2wuZDPOBmfMPSdJsXYrkjPox9GtsLygo8Q=;
 b=sMFKiD/2GwzKF6d3GNzPKgkcUEADwWjdd4VxnmDVNy01sA43lzYh19cVJCMiFZLQzBNjFB/d9
 ven0HoGbl/fAW6uhnnr6u5r5kjEHBdffi7Qm93MES4UX2N4vsP9kSMV
X-Developer-Key: i=zkh@mailbox.org; a=ed25519;
 pk=up24Xn4ScFKugfT4EJru/UQAS7JOIN+DSQqro+a05T4=
X-Endpoint-Received: by B4 Relay for zkh@mailbox.org/20260908 with
 auth_id=1015
X-Original-From: Zakariya Hadrami <zkh@mailbox.org>
Reply-To: zkh@mailbox.org

From: Zakariya Hadrami <zkh@mailbox.org>

Add entry for the MT8127 based Amazon ford tablet.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Zakariya Hadrami <zkh@mailbox.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index cd4040ad3437..180e6e4948e7 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -122,6 +122,7 @@ properties:
           - const: mediatek,mt7988a
       - items:
           - enum:
+              - amazon,ford
               - mediatek,mt8127-moose
           - const: mediatek,mt8127
       - items:

-- 
2.54.0


