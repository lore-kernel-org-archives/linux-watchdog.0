Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852CA2F9D85;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781662872; cv=none; b=ItE3loeHx0lCLpMABadYbyv/rT+b1c6BlhmwZcthcH1YyyUGoj85p5x2+Ucn1fEmoW6XNo3Qy5/WYuA7NXGazGMSD0Apvu6I1TD/hJfAlnLMTH1k9Z5hgfWiE0L2+oV6XUHyikL28ROpuqacqaipQtFIrz8QchZJwFyLpa11YkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781662872; c=relaxed/simple;
	bh=TYv4I/0EdUguA4dQzRGYgV0SyQbG+2UcMGEinY6mWVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPVxzOkXfy36iUDk82Nd1keF7LC8C83szI4T2EThA9TezB8O6MtZnZpRrJAawb9y2hCwAlufPpTmgxC94YmSnzl+JP7QkFZ04NQQh551wkl0NtbauVjVWCPq4uUYt4Dj3j1EFlILy46DFEESJ1dyFoAoDKOtgcqzKe/5lPItFfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRVKpiK6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRVKpiK6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C4BDC4AF0F;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781662872;
	bh=TYv4I/0EdUguA4dQzRGYgV0SyQbG+2UcMGEinY6mWVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qRVKpiK6lvimqkwXV9x0qS6ZtuPoRJJNqQUGVRHDzVCLby+dNpKoJavoZPbNqF4lH
	 wYLfX2mJbbUsc++wZXZfgLgCsc/F+Beee6TESc4XvlT/YsSXYSt3S9/5mwFDZLIBEJ
	 k8d3KeeNt0YyFHQX0qORlYVjVx0446EuVGI6uac1i1B31ChsmU4zB4njHlO6kzx4Od
	 P9Ery8RLqNXT3Wk89ePhjUJqoCBpx9BVskEAijVzo/tNF4fI/ha7220yocehjoM2fJ
	 Rb3Lkv2MbHPJKJqN8y8vBtnGAAp1U2o6JnFGxR+opTjrWi7diS+6IAlNlWrJ62R4oF
	 Xy2w1CHEXsRJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E92CD98F0;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh1.proton.me@kernel.org>
Date: Wed, 17 Jun 2026 11:20:14 +0900
Subject: [PATCH 5/5] dt-bindings: watchdog: mediatek: Add MT8127
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-mt8127-amazon-ford-basic-v1-5-d02ad15ac359@proton.me>
References: <20260617-mt8127-amazon-ford-basic-v1-0-d02ad15ac359@proton.me>
In-Reply-To: <20260617-mt8127-amazon-ford-basic-v1-0-d02ad15ac359@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781662870; l=885;
 i=zkh1@proton.me; s=20260616; h=from:subject:message-id;
 bh=EYpC4LZ5dsncfmZVo1Qa3+LOjpZlxDCulVGvphKLKMQ=;
 b=a/R2TapQVdN1Ryp32CARs1QbBbPlH+I0Wa0q7pOdQP5E4LNloIpf6D7WIqIg15p4aptuMMK16
 IRnMJYOAxcABQiTxiWVbnGl4mqyviY2Thqw6BjpmAtWwzy+IvTLLFTt
X-Developer-Key: i=zkh1@proton.me; a=ed25519;
 pk=9DiJwhINAERP95fbFofXSP77GEnvfO/rMIRRRFDhaoc=
X-Endpoint-Received: by B4 Relay for zkh1@proton.me/20260616 with
 auth_id=824
X-Original-From: Zakariya Hadrami <zkh1@proton.me>
Reply-To: zkh1@proton.me

From: Zakariya Hadrami <zkh1@proton.me>

Add entry for MT8127 SoC's watchdog which is compatible with MT6589's
one.

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


