Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318193CB911;
	Wed,  9 Sep 2026 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982691; cv=none; b=shaEY0grgSW7ahZqCIgxL5JJZ7MvYHodIsnT9z2QEPqI0FBg2GkYEhOx+vrR0sBZOmuzhSkUEenQi/hoDC1n2OunaqnTwgj9FOm5aSaZLWob7CR8BA2P97R9DN93yLP3xqAlWIEe9TLrUTIgX/g3dgxgo79pyIbDUSIDw4e5REM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982691; c=relaxed/simple;
	bh=P0qNZiLTQV7gn0UuncV6cdn6iEieMHPrHFYC39KFYEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ecj82K3/EYkVwhEU6qnKm6I1G03SHV837BK8Rqe0EOD5qikau4l+i4duePXjBJYdhgliBHpIqtACixoajQWgMejcCtdGsOTL1OrdGFNSWOd1eU8Ac13Anj4kd4QKdqnYGG52AEadGMOiMOvXBQMFvu/Yq4dpXIF74V5jrWojlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc799gg8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wc799gg8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDCCDC2BCF4;
	Wed,  9 Sep 2026 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788982690;
	bh=P0qNZiLTQV7gn0UuncV6cdn6iEieMHPrHFYC39KFYEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Wc799gg8FqMwlc1yZbvQ9bj+97QFPi+iXk803jluNlnO0qKkM0YGbsNBFpWZp01ZR
	 lkHUVW3BQT2PY8dtpB8hlW3/hATWVKZZuN+mZi/Z74g/O0Zn6hnlIbMzZA5HzyiQNc
	 5sOGazJhU9gh65elRXtY0DyqDbLEjsuCPPWhV6WSPP5GGgBbWHgkxyN1iVHn85ffWN
	 02qPCVxCxTsVYoLNzVlKe3vlscMe6aPwhX+yxWaX4hBKWWu0mMcwiqC0y7T/LTC/UI
	 /8SibVrVNaqgofS2pZ5Ht6iW7rbvnMNMrSnnlFrMpAWy1Yi2jt1G7G566KUI1MLe9G
	 mWaLxDodTrRpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74F8C79FBD;
	Wed,  9 Sep 2026 19:38:10 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh.mailbox.org@kernel.org>
Date: Wed, 09 Sep 2026 21:38:01 +0200
Subject: [PATCH v4 2/4] dt-bindings: arm: mediatek: Add MT8127 Amazon ford
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mt8127-amazon-ford-basic-v4-2-e9af5c420ab1@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788982689; l=801;
 i=zkh@mailbox.org; s=20260908; h=from:subject:message-id;
 bh=6yb/XWefb2wuZDPOBmfMPSdJsXYrkjPox9GtsLygo8Q=;
 b=5LffDZHmyNBAclDIcnlkhY1WJo3bKSUx98Ij5Kr3xlAwsWWLtksy5ZX/y2KUMOhsuNjLVaCPJ
 XyeIZo04YroDql575Ijfy+wvDgQN8yZLKhQoYzBtHaMhTPJ/WrBflL+
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


