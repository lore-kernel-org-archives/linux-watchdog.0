Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E972EC081;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781662872; cv=none; b=VF8/LD62ufxIvaHxaoOtFl8aXh1dWYIyI0ONi5dXfxh4T+MrNTfvj7DzmlH8hFePxcKgJrpkybo3E3uEjgB1QBEbf/RfYXbLBfgJLfEfEAdmrVT1MXynFeNWLnzAXx+CO2KnHrhmpwQJ/VXCuZL2y6CiRIltuiI65rzAqjF2zqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781662872; c=relaxed/simple;
	bh=O8e39Y8zZ8di3UFxOjhE2ft5kuA5vKiMtzFy1esWqMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b5l80Q8HG4olZb1eMMqh59o0ymvdZpbP/ZG328Aanl+JO4VneYyaO3JPj516MpYs8qoUdqaQ7FBahP1T91e848PaiUZ/x2b9Y8afaA1cjvAHUQ46idbOGkWsuENg79vyHxkaqNav7FP4Ztwz4L2JqA5CXdY6TkI3NIcHLiv8ob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/Ny7Wij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/Ny7Wij"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CA84C4AF13;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781662872;
	bh=O8e39Y8zZ8di3UFxOjhE2ft5kuA5vKiMtzFy1esWqMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g/Ny7Wij0FghiETR6iRHsZtl8WvGjGYL2yQIxJgyBaXCvix6EuEigEsB40N4gHU7K
	 om/8KVTiZ9ACKeU1pRxo249Y4UtiI/4N+RVO2+VEtpsMYF6Or0Z9jBrVigDR8rrL07
	 oam6uOuqFhXH+Jqe05DKBkgK+X56hyR7oNaee8FEeJow5IegXLKrswFzJiEtrLUL24
	 O9/TeAfbsxMLkT4rQuhtHguQnI7AQAbfJ5kzCpvyRib8+qCQeHAjsjfXOsUFYzRv1j
	 6G/703QifGB5NnbUdvIFJoTcRd8Ju5MFKF2HAOQrX+uEtzn9v+dXwDmzcz85HnoZLD
	 5Jf+EJ6+lwC/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2720ECD98F1;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh1.proton.me@kernel.org>
Date: Wed, 17 Jun 2026 11:20:13 +0900
Subject: [PATCH 4/5] dt-bindings: arm: mediatek: Add MT8127 Amazon ford
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-mt8127-amazon-ford-basic-v1-4-d02ad15ac359@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781662870; l=814;
 i=zkh1@proton.me; s=20260616; h=from:subject:message-id;
 bh=CteuquPMK3ekAPrSrikG9MTiPrJ2S6hY2cdfoA37n5Y=;
 b=QvALVdl1TyvRHk4IbG6e8/iH3V6MqHh3AVd8EW+tQXxk/ZkC7U92/MSbTx1juqnWNb4PxHErv
 mxOxymgs/kyDPvoRRdhunQYznwxiVCPOYX2uHPy6LmUWEZoNykVaRJ6
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
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 382d0eb4d0af..5ddc79689df9 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -124,6 +124,10 @@ properties:
           - enum:
               - mediatek,mt8127-moose
           - const: mediatek,mt8127
+      - items:
+          - enum:
+              - amazon,ford
+          - const: mediatek,mt8127
       - items:
           - enum:
               - mediatek,mt8135-evbp1

-- 
2.54.0


