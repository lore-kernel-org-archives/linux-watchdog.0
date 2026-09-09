Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315DA3CB543;
	Wed,  9 Sep 2026 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982691; cv=none; b=lY3q01Eq59ItXxHx6K0QtLGxKLvjuoMfjNA1n39M60HwYve71vtHQKA/lmE12CFJIVUtg7879wh/OtLbB2wcIhDqhr79t0CBzmsC5AYaiIPCB+nRiVvu23ZLJv341MaLx1z0vml824dn9x9l7M/NiuNJI0w3jpSzp9nCms+lxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982691; c=relaxed/simple;
	bh=XNvMPjZX0+WXpT4mWFJChE+oCnrBaMYSvQo6qFGzXNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h4I+wz6vyyeT1Cv8WNCm9dwi3LmKdris6eA2irdomJ7sArRydZdnX3VRcDgcdSD7XgCB0NQJi+yR6ghC3fkl5keBnhMhNCG3YEhgXSaocllDWVQEQ/vUivGk5VlRFrxEfMBa6kYebHSZtMMDtQ8SU9mF27v8pXCnZ62/4bnI9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KljriqbO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KljriqbO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBFFBC2BCF5;
	Wed,  9 Sep 2026 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788982690;
	bh=XNvMPjZX0+WXpT4mWFJChE+oCnrBaMYSvQo6qFGzXNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KljriqbOZ9h6iBKiEI5uUOhHf1aXYEQauA9cpkNln+QyTSsu6owH1kLK23Y0rAOdG
	 dq4I0+uMo6wPAIjl3J7SwXqUd+w1WwMZwTaAK/RgH7p5EB2ftUdLoeFXFApa5BZnTH
	 ADDZeskYEpwMm3nbVFwPyT77gUD268/nTnLvBbKBr7chk+I7x3oAh1RzCHVc1Tc7e0
	 yZokg4dyx31bn03VzedB8+iLxhcky1xxd/sjIepZR+AHlEawl4CwwTlc+ZrCeFJnrk
	 VIDkYmEx5ERYvbO27AiIL7IU49zjJ2yLdgnkzjCrdr4N/t6YyPiFtRun4x06XgoXdw
	 zfago7OqBobOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97760C79FB6;
	Wed,  9 Sep 2026 19:38:10 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh.mailbox.org@kernel.org>
Date: Wed, 09 Sep 2026 21:38:00 +0200
Subject: [PATCH v4 1/4] dt-bindings: watchdog: mediatek: Add MT8127
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mt8127-amazon-ford-basic-v4-1-e9af5c420ab1@mailbox.org>
References: <20260909-mt8127-amazon-ford-basic-v4-0-e9af5c420ab1@mailbox.org>
In-Reply-To: <20260909-mt8127-amazon-ford-basic-v4-0-e9af5c420ab1@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788982689; l=1002;
 i=zkh@mailbox.org; s=20260908; h=from:subject:message-id;
 bh=W+fYT6FEZ+BsGX4xaHNPJY7m/vM9qOAG6TkfJVwh8eg=;
 b=RO0NOexUOQYrZNLa23zzQi2txgyiSv65tHeLLA4wRx8ItAsbTC49OnXWOb+MlWL+Ux6G9DNOx
 ztGz/sAG2e8AzaFPAc2pqzxQbvLgLX/GAhzoggVEj1Q2iYvlc8rgPQy
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


