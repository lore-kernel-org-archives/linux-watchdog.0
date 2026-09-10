Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BAE49BD9E;
	Thu, 10 Sep 2026 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047025; cv=none; b=RMfVSf+K+yVqzLCXyr1Ti/77z8954g0TGeCd2gmTWbcFrc57qLrdtDCzREcgpNk6DATXjACIls52hIhuU1P1RpwVuPl7b3No0mCIkUdDFTubu8Tmm557lCj/T1YTcDc/aF/BlspNUmBuUoi5WZYwcIY0pArAreC6VoPbGCvsToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047025; c=relaxed/simple;
	bh=VWlC7n5SUM9DtFOBPFoA8GByTAAgalb/ZLqc2nBu+mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sVcjmw79js5YyczavAe8Vez2aQRTaxXGV1/to+VE0g0dhucaz4/UCuR6V2cpilBtAEUOs3m73vGXS/hphIi/zfWGhAsjRD6H0ro7Zt8rif1MimLwztTwcttPTFd1KnF0epK3gFUfX+6EgIiqlC8jk+R81qJVUDVbmv039SdNCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niv1dyqy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niv1dyqy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 763A8C2BCF5;
	Thu, 10 Sep 2026 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789047025;
	bh=VWlC7n5SUM9DtFOBPFoA8GByTAAgalb/ZLqc2nBu+mg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=niv1dyqyLuz6blBL6bh6N6ldSuwNFZfqM2YhnECq9Mx5DQA9H0LATKZXS+5ighZs3
	 yGucoAyqk6sAbDERaqKn7BO9cKR0ztn5TvWCGdTAy6HnCwXXlT82jWqoy1wB8dBZ0i
	 QDEBYdXPBQEi/G3UceW90H+NBIng0z7mvl5kOT5ik11ZJLzXJLmz5paOKk/TnNYjw5
	 PLPoOIqgOs6VdAa/nztbrlS5Q200iK3LwWNF1qlNN6rJC5Urfv0qHBa+iGknmAJSiS
	 I9rZ3Td5lV2xE8jb3tHuBzPXvL4ocpzcyytieZ2s7uHOWFIRRMMai+/CdqUYv9NN81
	 6gOTHhnPDsLyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564A7C88E40;
	Thu, 10 Sep 2026 13:30:25 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh.mailbox.org@kernel.org>
Date: Thu, 10 Sep 2026 15:29:13 +0200
Subject: [PATCH v5 2/4] dt-bindings: arm: mediatek: Add MT8127 Amazon ford
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-mt8127-amazon-ford-basic-v5-2-3cb9eeaffd5c@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789047024; l=940;
 i=zkh@mailbox.org; s=20260908; h=from:subject:message-id;
 bh=6nQiaYGOKfITeaTuR+B1GCX01jYN4Tqbt4wScWriW9U=;
 b=Sj28nnhxHpArEkTLyWakRCNV540MPZXTEhT//VpZVifjCRiFq3DGcO4Uca9lpsqkhTxMmmCO4
 JL4fipZHsZDDNwStnX5k2DKqSjJYsJWoU935VC089jxS1Kmun9xhSqC
X-Developer-Key: i=zkh@mailbox.org; a=ed25519;
 pk=up24Xn4ScFKugfT4EJru/UQAS7JOIN+DSQqro+a05T4=
X-Endpoint-Received: by B4 Relay for zkh@mailbox.org/20260908 with
 auth_id=1015
X-Original-From: Zakariya Hadrami <zkh@mailbox.org>
Reply-To: zkh@mailbox.org

From: Zakariya Hadrami <zkh@mailbox.org>

Add entry for the MT8127 based Amazon ford tablet.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
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


