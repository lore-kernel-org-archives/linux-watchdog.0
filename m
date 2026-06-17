Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED6399377;
	Wed, 17 Jun 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703439; cv=none; b=KrbbXx3syIJ+n9flEI4ItkV9LWr5D/defpGIxCM2Qy9ggktuYHQEjNsLNP9AllkkW73m9pRE7IXSTfudqczDhhBVG8ylx4IZfeMbQmKRv1X72Zu+EFRjxaDPCi/BuvcXZEX7Z8XXU4Q+98KYjoog9mMlxH2gkMrFdLz9671cmr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703439; c=relaxed/simple;
	bh=umvI+70hpxIMaicZcD/7zdWxlqyDkpayKxVnDbtpxNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=haLjnstX4D6zcM3KU+qgbin+ExSUGgk/w/uUgV08Sf77w2MwdeWYMAywgWehx+tc6wr/WtE8mIAnGE6LkP3dAOY/jSjfEaIlkLjHDIdWX035uSZd3AZVzKc4Cyjd4nKb/J0OhIGAuNEvwzTB2KkUR5yrlod7+WiFuo9CGoIqTZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q16UO7GH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q16UO7GH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EB6FC4AF12;
	Wed, 17 Jun 2026 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781703439;
	bh=umvI+70hpxIMaicZcD/7zdWxlqyDkpayKxVnDbtpxNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Q16UO7GHQJAWkOoc/eq9PrRoZZK331hARqnE828vbXiGM5WbJIfZRBgahHjGcOcVJ
	 mvxdV+t6CO6jYChs2CXYdRBRuretH6XJ+4L4pUdS1yCr6e1uZJyDdUlAFyUEANV/UJ
	 aNK1uOnlcRQUB/mr+i2vwhoUBSgPRAHohy4IbvIJ4RtDq+batDZ15tzinYfhaady1f
	 EHHNBCdoYdXWzj8UPX/mw1nfCnW3x+ftvnYu7fs07Q/ctx+NIulUbv+NVDKpCTkB7B
	 nTUbxdoRYz5+fmG0qwknvHJPrRT1WZuPCRzX1dIYk3kZPzggXw6/fNgKjVBwl4MlmN
	 BrPePiXNIRHyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8582BCD98F5;
	Wed, 17 Jun 2026 13:37:19 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh1.proton.me@kernel.org>
Date: Wed, 17 Jun 2026 22:37:00 +0900
Subject: [PATCH v2 2/5] dt-bindings: arm: mediatek: Add MT8127 Amazon ford
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-mt8127-amazon-ford-basic-v2-2-6859e29e72a8@proton.me>
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
 linux-watchdog@vger.kernel.org, Zakariya Hadrami <zkh1@proton.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781703437; l=730;
 i=zkh1@proton.me; s=20260616; h=from:subject:message-id;
 bh=F0En+aj1DoicBnO2Y2v3/IgUJjasWlhR82V0YCbt4Z8=;
 b=7y+V8Ng8ConVZgG/28DWOLAGcNbwj+zlE3ubciYltugfPenaVzAQb94HKvrSzA5HMH/YeQmCB
 5RaPhlKg5JyBBFpJHVQT3YGK43xQX7um1Oh5XrNKiysWyL7jvmeGDdF
X-Developer-Key: i=zkh1@proton.me; a=ed25519;
 pk=9DiJwhINAERP95fbFofXSP77GEnvfO/rMIRRRFDhaoc=
X-Endpoint-Received: by B4 Relay for zkh1@proton.me/20260616 with
 auth_id=824
X-Original-From: Zakariya Hadrami <zkh1@proton.me>
Reply-To: zkh1@proton.me

From: Zakariya Hadrami <zkh1@proton.me>

Add entry for the MT8127 based Amazon ford tablet.

Signed-off-by: Zakariya Hadrami <zkh1@proton.me>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 382d0eb4d0af..853f5e8cd158 100644
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


