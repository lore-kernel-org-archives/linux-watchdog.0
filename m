Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA172882CD;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781662872; cv=none; b=bfO/oXRarazdornoakpsayEgUisr26137JZktQAsZLrW7cBGlJrtAXuDapNPc8/mbdTwk9YFRHrukuVg3gk2CjInXXEzhucH/DGNuhP4hRiuDkLNWeERzNHRCSWEzz5F4S7Sayg1fp+hsyyCIiFO2t7DXbu1D+V/M3jIwS5VWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781662872; c=relaxed/simple;
	bh=okVJkcSHdv1fcrHSQb1tZv36Onz2yNyEZIN6TeMJWKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orTrvNvJn6FJuALodEdkW5ot3zQs4uqntQp+u2+kXcUUUdY3NBR6jb9HkWW789zUDYw36UlH/Mtmt6zkwbQRTyguUw7JWynV+QOIyAetdtjLNIYPEUeS6LbQ2TZrGGF1Tha8b0W6KyPnKu5ArQkV69qtZMl16ZYnpinz02LzTz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngWtH8wv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngWtH8wv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1923AC4AF0E;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781662872;
	bh=okVJkcSHdv1fcrHSQb1tZv36Onz2yNyEZIN6TeMJWKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ngWtH8wvpOXfgKCEHojgD9Sr1IMhVUNuZu+n3bTUriqQcX0YpiePBaRhsLApaOsNN
	 slnG5TSqgWRC35wVLXyL+fDpGf0jYVHPjb3UJYT6OKcZlHSsL+Bz9qx3AV9Rbx7qlw
	 MG7JJXXZBQyxZqRa+9cNjlm9OJ7aTlCjumlxNC4waPW3h4y6I/In0Q/CgYihBVBoM2
	 DtbhGSzcdR5Xn3TtJR6aRyCdAC/AaMpcPaAoG/2FZf9aE/r7Iq8Fm9CAbfYZ/xZDwC
	 CN5yc6x1QKCAyuk4vq3+X8zOZI1WvSP2wHmZr3yTFMXCGMpNFUwpDC0db2Q4zdqi/D
	 QMoGNjjADwJVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06009CD98E1;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh1.proton.me@kernel.org>
Date: Wed, 17 Jun 2026 11:20:11 +0900
Subject: [PATCH 2/5] ARM: dts: mediatek: mt8127: Add watchdog support
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-mt8127-amazon-ford-basic-v1-2-d02ad15ac359@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781662870; l=804;
 i=zkh1@proton.me; s=20260616; h=from:subject:message-id;
 bh=VQZ++2hpaaS615uXsB1OWz8s3q+mSXl0RmexhIj1JJQ=;
 b=7rwtqv+oizSQabmlSevY4WbpbTst2BLlCJJWBG7WrtKPbQ9bPsyIEEu0s9c0rVp7leuzziRIV
 FJTxOfalaNFAcWNqU5OL4O0RSo9iNIB876MyCAJuNZP25Zu3ku+mVMg
X-Developer-Key: i=zkh1@proton.me; a=ed25519;
 pk=9DiJwhINAERP95fbFofXSP77GEnvfO/rMIRRRFDhaoc=
X-Endpoint-Received: by B4 Relay for zkh1@proton.me/20260616 with
 auth_id=824
X-Original-From: Zakariya Hadrami <zkh1@proton.me>
Reply-To: zkh1@proton.me

From: Zakariya Hadrami <zkh1@proton.me>

Add watchdog node and disable it by default as it was not present
initially.

Signed-off-by: Zakariya Hadrami <zkh1@proton.me>
---
 arch/arm/boot/dts/mediatek/mt8127.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mediatek/mt8127.dtsi b/arch/arm/boot/dts/mediatek/mt8127.dtsi
index bd61ec7e70c0..1855dda42710 100644
--- a/arch/arm/boot/dts/mediatek/mt8127.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt8127.dtsi
@@ -159,5 +159,12 @@ uart3: serial@11005000 {
 			clocks = <&uart_clk>;
 			status = "disabled";
 		};
+
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt8127-wdt","mediatek,mt6589-wdt";
+			reg = <0 0x10007000 0 0x100>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
+			status = "disabled";
+		};
 	};
 };

-- 
2.54.0


