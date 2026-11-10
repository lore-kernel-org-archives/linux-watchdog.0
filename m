Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794338555;
	b=IRk5v2tBVn4xLYHXHbnCx7KmDDOmO34YmE0ihv8TLJUzKubCGU0Q+ryCcVluluufDrkc
	 d5Q2YAPt5y4jxtpKpB8esaY0Nc3p/qkWoQLmt585w5eq/ysdF9DFFYjpDlzziqjaZEPSG
	 d7R+IujpS8SaHIqZNfzw87euxXIMgELxIOTK7FM+qUruMKL2jtQ6yWk2t0phhT1OxZdIh
	 xlX03X6Z/erHeTBYs9wHOXn+Li5G5GcvDw4DexzqzxB7nPZD3XqCovB5LQiTwW2qlWgSB
	 dpuFBaL+MGteGyjtSC4JSXhdTJkTbwQxtcsBWOO3Ad8LgAA74cZ9XZswYPJwOQIC35Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338555;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Wv4YmS5I/QtVuoDrIm2R5tBBAXU/92I2IsMHmbWiOeM=;
	b=UL6XXZuQPW9MsgAu0tmLQ8ShA1ablosIQq1EuwR8PP+Ak8oZ/Ii+tbssfjWuK60pqpSX
	 2owogkR8Bh7chypKMBweZE36PSK9XRbHBLsFYxpIyXANzqfOxR7RU/txLEcb0BM5GLWQg
	 e5V+ylmhE7ymzB6EkA7+p62kr1QNcoxuXj/7VfRelpqVWcV2OJvwqiB/Y1vG9wp6pRlPH
	 vkE1aJtjv1kZS5iJiTpI/rMwzXLyiydLksGZyFXBKxOlp54t2epHIh9Ommdq1Rzdtg0CC
	 EvXbQLHGoy9lg3/N369y02y3gzGMbMRVwGNO9JZScdJyxLMlV80f8bRSwFcpU9NfggA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwTv+p8I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD109606A32E;
	Tue, 10 Nov 2026 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwTv+p8I
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794338554;
	b=Pni05cul1edQvDBv+Q0Obf52Y25T6cxVkBOZwW517EKT9I40RYk68ecHFniKDc27s7rM
	 6SyPIOynBMrWsvOX2JEV6sj0gFCytmYYfh+BlmmMHxtkgEQZoF0MtgggERuPdmoXnQqQp
	 6kMqCsmftBSbvfR81y7Qt33OCOXCVTThCmvl/Uh4wCcUPVEjV3pI3WnEMhLLS7TRgqd9o
	 sJyzR9rbUHNmeZuiEbCrjpp6o2CaWV1ujqa2gF08AZKnVK/+x9mDf3/rOaWBXEJa9jW4m
	 pZ3XaLi8+pPmPImEKXjAiOxDP4sFSILJ/aAvEBWrTHHFUrnRA+BTw979Pn8Ri4owstQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794338554;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Wv4YmS5I/QtVuoDrIm2R5tBBAXU/92I2IsMHmbWiOeM=;
	b=EjSD2QCl9KD3cCCGHdDSAV7GpZwKDVMwM+/LH/TUzfS4z0ATtv2ZLS7bAnSy0lVu4ynN
	 rOQixjtgMRPfs9npH0YSA9PQQu4E4rq2IFkoIP3y3wb2nG3wMTAScVPsWylQ24DgmQoqa
	 Tztjqm+YWcPPSkyKwpJtLh50utJMUmJ/XZ2BVIVREz1vZfawM1i3ERYkOtPTRvhy0bSiU
	 lTDmnyvICu8F/XvkDbPkrrKaavDilYY7O+rA572RhtqrVcqzf5Yf8BkoQT0YRbAIq5IlB
	 MBXJvhfy+GcchoSS4ir0iylLSyRO2L9X+2m1XD4Y5nnvAQGPaNbWvZS5AwaU3QemgrQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3C4C81F008A1;
	Tue, 10 Nov 2026 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338554;
	bh=Wv4YmS5I/QtVuoDrIm2R5tBBAXU/92I2IsMHmbWiOeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=iwTv+p8I6g6+Yht7K6k/DsUmaJC65JNqwht04hpcJTagXg2kQRiyd0P7/+jTLlHlm
	 oyz0x2ZsQ1Y6iAvfjI296N9MLOQ4FqAzC3REdLhJvTdHPpBBxlxj/b2YcZCMOtl7k5
	 6eO+UDIVB6IG+IeKTjj3GmhS6y+gqX3O8ZnitmvD+TerJCTjw7p5GqItYqjvG8bCTM
	 r0LLM8euvTOfdVioSnawRfoFb4cIi69aKkcGr2IKhQUWylySLBZNnfpDbbrYV1ALBb
	 rYCKyDMlT14eGtOGFceHod9uPLYDEdR54Ga7HKS8bIIl1pdWi07xUgRbyNTvEeD13j
	 XG/J6wY5D/EoA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A95A548C35;
	Tue, 10 Nov 2026 19:22:32 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 10 Nov 2026 21:22:21 +0200
Subject: [PATCH 1/3] dt-bindings: watchdog: mediatek,mtk-wdt: fix mt6797
 compatible
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-6797-wdt-v1-1-7f07755b6074@protonmail.com>
References: <20261110-6797-wdt-v1-0-7f07755b6074@protonmail.com>
In-Reply-To: <20261110-6797-wdt-v1-0-7f07755b6074@protonmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ben Grisdale <bengris32@protonmail.ch>, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794338551; l=3012;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=Zw97QWbf++CwhqrLj51/69tH/MLwpOaRQogdPi+R4S0=;
 b=8oQIrY9yvADvaSdBrJfYTzEmQNP0HQ2PwbUUgck0/rybLTdtwhNV/ylo/EN0MVnBLhBV8kfDk
 E+Y/Bjfg6pmAyPrlVhtEc8ce93ohgTTUQcCvAc/MxK0gwLDy9p+MfZU
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

The TOPRGU reset bits on the mt6797 SoC do not match that of mt6589,
therefore they are not compatible [1].

Deprecate the mt6589 fallback for mt6797 and add its own compatible
string. Also add a new binding header for the actual watchdog resets on
the SoC.

Link: https://www.96boards.org/documentation/consumer/mediatekx20/additional-docs/docs/MT6797_Register_Table_Part_1.pdf [1]
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |  6 +++++-
 include/dt-bindings/reset/mediatek,mt6797-wdt.h    | 25 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 8e8991ac95ea..d9b5675794cc 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -24,6 +24,7 @@ properties:
           - mediatek,mt6589-wdt
           - mediatek,mt6735-wdt
           - mediatek,mt6795-wdt
+          - mediatek,mt6797-wdt
           - mediatek,mt7986-wdt
           - mediatek,mt7988-wdt
           - mediatek,mt8163-wdt
@@ -38,7 +39,6 @@ properties:
               - mediatek,mt2701-wdt
               - mediatek,mt6572-wdt
               - mediatek,mt6582-wdt
-              - mediatek,mt6797-wdt
               - mediatek,mt7622-wdt
               - mediatek,mt7623-wdt
               - mediatek,mt7629-wdt
@@ -49,6 +49,10 @@ properties:
               - mediatek,mt8365-wdt
               - mediatek,mt8516-wdt
           - const: mediatek,mt6589-wdt
+      - items:
+          - const: mediatek,mt6797-wdt
+          - const: mediatek,mt6589-wdt
+        deprecated: true
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/reset/mediatek,mt6797-wdt.h b/include/dt-bindings/reset/mediatek,mt6797-wdt.h
new file mode 100644
index 000000000000..32a2bdaf47c7
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6797-wdt.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_RESET_MEDIATEK_MT6797_WDT_H_
+#define _DT_BINDINGS_RESET_MEDIATEK_MT6797_WDT_H_
+
+/* TOPRGU resets */
+#define MT6797_TOPRGU_INFRA_RST		0
+#define MT6797_TOPRGU_MM_RST		1
+#define MT6797_TOPRGU_MFG_RST		2
+#define MT6797_TOPRGU_VENC_RST		3
+#define MT6797_TOPRGU_VDEC_RST		4
+#define MT6797_TOPRGU_IMG_RST		5
+#define MT6797_TOPRGU_DDRPHY_RST	6
+#define MT6797_TOPRGU_MD_RST		7
+#define MT6797_TOPRGU_INFRA_AO_RST	8
+#define MT6797_TOPRGU_CONN_RST		9
+#define MT6797_TOPRGU_APMIXED_RST	10
+#define MT6797_TOPRGU_PWRAP_SPICTL_RST	11
+#define MT6797_TOPRGU_CONN_MCU_RST	12
+#define MT6797_TOPRGU_MJC_RST		13
+#define MT6797_TOPRGU_AUDIO_RST		14
+#define MT6797_TOPRGU_C2K_SYS_RST	15
+#define MT6797_TOPRGU_C2K_WDT_RST	16
+
+#endif /* _DT_BINDINGS_RESET_MEDIATEK_MT6797_WDT_H_ */

-- 
2.56.0


