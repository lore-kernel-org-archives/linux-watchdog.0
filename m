Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B3493643;
	Thu, 10 Sep 2026 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047025; cv=none; b=da5VneDY38Np65iFS714VmhyOgPQhHl4MA1cxn9ML52eYlCvMrD16FmZs3rDhiDKykYr0mM67ik5g/N9jUsQX/A+7Tg71w/gTb/8AWe/TqtN3/nBN21Q9BG4Cza6akTV6QVHTLAk4orQmptnfHKmZw02j2tq+bYBH85fXqoEWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047025; c=relaxed/simple;
	bh=G+GpNyZ3b9TKiMP7cNnhhFlFP84K4fw/zV3su+ptBrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OH4Z0dhsam26gk/NL7Z7E3TteuQ+tD7vStabpVqEPuYrS+vU/1/OFkAPBWUUcfxkOzYDRkLtAFX0HkJ5iMjZhcNpezduiy0N/sBJ/GXCLYwQA0X7HxrwPBdkxXqLBF96344Q9oIZsD4ipZMwpCIJr7dQh/3JN3KTSPMZgAdKJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1t6Z9wc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1t6Z9wc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66915C2BCF6;
	Thu, 10 Sep 2026 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789047025;
	bh=G+GpNyZ3b9TKiMP7cNnhhFlFP84K4fw/zV3su+ptBrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s1t6Z9wccxhkoXYVSOovEaeRSOxmP2g+7msqEQOgK+SzjCf2zueGFTaYYl24TNvJD
	 5Cvr3XlquHvQCY0FVQyFXgMFkLeF9NvQlEEGb7HbnO1GmE0c1pnUGcp36EXQL4kg29
	 sqcMwLqmLkfUrRDDBrVDjaShaBIDXCqBYQRF3s19RaWofBzwbHqPImg+XqJwVPaXLm
	 NJJj5hs7grQ6O04gJyEHbONMz9PbeA4zxnUkODt7AyBSP45JpIeFTIDVUmAWGKMhbH
	 B4ZMgxrCE2qwArYy2OJVv9mRXjX5fXfmw7hNIkVQwWnkuvDGh88mmXSCzQAV55tGRb
	 CTZp/qdC/2/Tg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C6BC79FB9;
	Thu, 10 Sep 2026 13:30:25 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh.mailbox.org@kernel.org>
Date: Thu, 10 Sep 2026 15:29:12 +0200
Subject: [PATCH v5 1/4] dt-bindings: watchdog: mediatek: Add MT8127
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-mt8127-amazon-ford-basic-v5-1-3cb9eeaffd5c@mailbox.org>
References: <20260910-mt8127-amazon-ford-basic-v5-0-3cb9eeaffd5c@mailbox.org>
In-Reply-To: <20260910-mt8127-amazon-ford-basic-v5-0-3cb9eeaffd5c@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789047024; l=1085;
 i=zkh@mailbox.org; s=20260908; h=from:subject:message-id;
 bh=l284B/Dwa1uNqUeDmkdnI4eqix70fVEu1j83lsoUYFE=;
 b=BK/u/Ml/n+dTOzTt148t2f4N0sPqOz2u0dKvpbmaV9yoLqUZUbRUFHqIh8mQ+V8Q2fkAY54/S
 p2ClCYKpmBOCVCSZCQw63DmxCAhI9f6yY7LnPaGFN4T5zs5iKADArE5
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


