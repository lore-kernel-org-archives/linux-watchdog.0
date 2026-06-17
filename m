Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95E3B1B4;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781662872; cv=none; b=Pkd0svvTeGBNfBHqCfQ8nmSr1gqSmW8/pqWxVDaICM6ABZcWCh1t6K+QpQVGosN6YY5tewcptQPncx/QGSkOZaM7GuwvHAefvpt0QAZU5QmjmS1WE1TfndiEmLJdYTtlmcpCFoONeyWCFVlt6A92dRu5s54tUon3JlK9XxGeS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781662872; c=relaxed/simple;
	bh=glvYwgFlMorddfw4uLmdJXSdkoYcHUq+2F+K+ayE2Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gxb3vri5IwBYvuzU6QPBUVnPB4gXcrl54NM5H8CuUtK1W0KN9/bSh5jytVol6B0NU0Djvu0d439Ind9k+J7Ws1sZadtd8VIZ8BE8zw9t1uMK9nlwfDUKqmIt90zJPf3WGrG3hfHXE3JPUY6UugrzMhE5r+RumSH9+4bVfvSnvvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCHnYjTU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCHnYjTU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CB44C4AF14;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781662872;
	bh=glvYwgFlMorddfw4uLmdJXSdkoYcHUq+2F+K+ayE2Dk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UCHnYjTUvpvtyKwb3kT1p5x3vdGe7Wef6jBRM0uWmwB/bhR7NWw4MaNrkP08uvdqx
	 B4LOBuxU65GgP1+RtdZ4Nf2sZ9RwZl/UmfjrF+QoGsQ8JV8G8d8AwW/kB5FNubUJf8
	 VInND4fo7perSV6nCsoSb+BHawdgzHlM6PMWMZYUrHnHRocKuWReHU2d57sXKKZXvj
	 kiW4GIOqqGlpwoPq+wWy5PBWPRodGuEIdrwbak6y4/M02qXPoMzusn+lyld72GKE5/
	 tvVyFiLs0F3lIV20N8euHhAJAB1Js7LsaE1hD69FJkzx5gIxETgsCVI77VHKynMygv
	 nwr4uw8MSl0zg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1791CCD98F2;
	Wed, 17 Jun 2026 02:21:12 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh1.proton.me@kernel.org>
Date: Wed, 17 Jun 2026 11:20:12 +0900
Subject: [PATCH 3/5] ARM: dts: mediatek: Add basic support for Amazon ford
 board
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-mt8127-amazon-ford-basic-v1-3-d02ad15ac359@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781662870; l=1963;
 i=zkh1@proton.me; s=20260616; h=from:subject:message-id;
 bh=ER3ARswagh7xs80gDU1m6FCsuRFGAreidBmq7cULkdo=;
 b=+QdkQGlmeYDRoihE7kbdnK5j5pskDYSpNmqPESbCOZFyNKw/dd4fiNwgD29rBrUV0pJQfSKsL
 3H8qExH4PQ7AjhPY1ZILHmrbn8Dwrgkg7aChlJX9XA93WtOxqOWx+MH
X-Developer-Key: i=zkh1@proton.me; a=ed25519;
 pk=9DiJwhINAERP95fbFofXSP77GEnvfO/rMIRRRFDhaoc=
X-Endpoint-Received: by B4 Relay for zkh1@proton.me/20260616 with
 auth_id=824
X-Original-From: Zakariya Hadrami <zkh1@proton.me>
Reply-To: zkh1@proton.me

From: Zakariya Hadrami <zkh1@proton.me>

This tablet uses a MediaTek MT8127 system-on-chip with 1GB of RAM.
It can currently boot into initramfs with a working UART and
Simple Framebuffer using already initialized panel by the bootloader.

Signed-off-by: Zakariya Hadrami <zkh1@proton.me>
---
 arch/arm/boot/dts/mediatek/Makefile               |  1 +
 arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts | 46 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/mediatek/Makefile b/arch/arm/boot/dts/mediatek/Makefile
index 37c4cded0eae..a610bc75c7d9 100644
--- a/arch/arm/boot/dts/mediatek/Makefile
+++ b/arch/arm/boot/dts/mediatek/Makefile
@@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7623n-rfb-emmc.dtb \
 	mt7623n-bananapi-bpi-r2.dtb \
 	mt7629-rfb.dtb \
+	mt8127-amazon-ford.dtb \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
diff --git a/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts b/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts
new file mode 100644
index 000000000000..21bdab0e43f8
--- /dev/null
+++ b/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+#include "mt8127.dtsi"
+
+/ {
+	model = "MediaTek MT8127 Amazon Ford";
+	compatible = "amazon,ford", "mediatek,mt8127";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+
+		framebuffer0: framebuffer@b7a00000 {
+			compatible = "simple-framebuffer";
+			memory-region = <&framebuffer_reserved>;
+			width = <1024>;
+			height = <600>;
+			stride = <(1024 * 2)>;
+			format = "r5g6b5";
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0x40000000>;
+	};
+
+	reserved-memory {
+		framebuffer_reserved: framebuffer@b7a00000 {
+			reg = <0 0xb7a00000 0 0x1000000>;
+			no-map;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};

-- 
2.54.0


