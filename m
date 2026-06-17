Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83D3D1AB5;
	Wed, 17 Jun 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703439; cv=none; b=ceePBu1pxnn6O4pCEl/be5KEquCM+76XXX+LJ73/l43yiFIDIRbXLl6lE90MPqS2Qf+LN/Gxa7/hHFvk83PQ7a5C/Po1Ln06ffVh5T9/Y/53TF8m8FVixz59bHCpW6BhDA+Iyv5VyrOLlPPvc2eK6kwFYqIAIeEFETUXvsEW+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703439; c=relaxed/simple;
	bh=YzthG8T7DZ1GuXwGfr6wQ95GjczcSmwJxvu5eL0Ej04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvP0A+1eqZA4yiHHDuQYACEraEeRmUV+s1ZIYSHP6Fw4krnVUoJHwd9JtMBg4R7vcx3FEsyRYCdWPaE17LvZB7J69K4+TUa2WPiANshDSPZR8RpL98cptp5pfWNin33IIEkOGI+PGOJSBIxzGdXyyirauQAe72RkXYNFfhK8hnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQmQFMJ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQmQFMJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC122C2BCC7;
	Wed, 17 Jun 2026 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781703439;
	bh=YzthG8T7DZ1GuXwGfr6wQ95GjczcSmwJxvu5eL0Ej04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PQmQFMJ5qE4phg8+H571bqSzrT9aBpSz7CmVLH7G9VqZudE71XnBFfNpYjS5imdU8
	 9tiJRlZt77QeMibJyiGelfUdSMpWlWPD8XwOFi5PHeTn0ptvPdgg7hPoFKC4mbuvHa
	 cocSCQfTqAX7kgOSwA0Ku8jUUJ+NZHjghgyem23UBj622QXC3IIunRaFo2KdCYX4al
	 iAEj46e9kxsaw6x3SFnheZvNuetLkXdOHljLoAN7BehQRIOgzfTUnd2tPvJ3csYVal
	 oeQTm8x1cxd9Rk+5kpap36jF8trcVIwYTDi3uREv2dGucvxCOKyhLhnFBie0RRX2Xs
	 nzAcfBlOW8l0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BC7CD98E4;
	Wed, 17 Jun 2026 13:37:19 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh1.proton.me@kernel.org>
Date: Wed, 17 Jun 2026 22:37:02 +0900
Subject: [PATCH v2 4/5] ARM: dts: mediatek: mt8127: Add watchdog support
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-mt8127-amazon-ford-basic-v2-4-6859e29e72a8@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781703437; l=861;
 i=zkh1@proton.me; s=20260616; h=from:subject:message-id;
 bh=ck6RUwGt3onyIKpysTjlnK4pbinSKUlxnk21K9K4+jE=;
 b=yBuV/4Rj9N6eyoFk0usQ08cuR8RzxTGBlaF5MDRxOLMu1onoXtXAQRZ7nvhqrS78XWqjF7Sdf
 MToxUjq0gBpCEQSMYTtZmlP47sCSY1HJru9MaQ9CtIEQ90wvXSr42sX
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
index bd61ec7e70c0..3e23673e7a9e 100644
--- a/arch/arm/boot/dts/mediatek/mt8127.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt8127.dtsi
@@ -99,6 +99,13 @@ soc {
 		compatible = "simple-bus";
 		ranges;
 
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt8127-wdt","mediatek,mt6589-wdt";
+			reg = <0 0x10007000 0 0x100>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
+			status = "disabled";
+		};
+
 		timer: timer@10008000 {
 			compatible = "mediatek,mt8127-timer",
 					"mediatek,mt6577-timer";

-- 
2.54.0


