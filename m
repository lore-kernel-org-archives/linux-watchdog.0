Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4FD49C4A1;
	Thu, 10 Sep 2026 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047025; cv=none; b=r6FBswBVwuIrce1Tz+A0GuVwi7k0dQ/yHOmpsR9QvjTdy5+fej9jOPF4MWMWkSumuPFroIIJtaXyNmqZ+BHjB+LWx//stSZInqM3+KkO4qzZ8KmLS2KUMpJiuWGZTmr0aKzru9xU6vv7Kjtdh0ra/vLc24cELrSQrWTek/gKV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047025; c=relaxed/simple;
	bh=el2c82Q9jZQnjAq8JeoE5xjoAon2Ir7WXQIwYLoiIw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iqIYrI2/3iRK2SrKxYFTOTeqAFm+IulyNM+TmcQBVw3F1tXADxroFZyXBvFu8PMu2e24m16N2tV2x/GhVL91aWD/kn55yQX1+keRB7cDXUpPJUgwV5MOcZFPI/AKzrpVOFqL3EdI6RvvO9YZmGXmlzGkr51GQE039I289lp1waA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoTvcL4q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoTvcL4q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8260BC2BCFD;
	Thu, 10 Sep 2026 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789047025;
	bh=el2c82Q9jZQnjAq8JeoE5xjoAon2Ir7WXQIwYLoiIw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IoTvcL4qb7kAMMNsSio6TLzR1pW0FNlzpjQqpXpYlFOZlT8PINKJ1CcqXL3yvFlIj
	 Htqn4gGBV/CECLX4eLSuqd6jKBpSOTYJQNGkTCJVwStZNseYn4VMdiampYHP1zYtwM
	 67gggLPrSPO0AyzIaqBq/8czTbEgc+macRiNj9GYZMKPx10U3IHsIKc4/l9iBAssWA
	 bpdMoUuVNS0JE3dxbnmYwxRjop0t87+UwL+yIoIUmfqVvM1RW01RmH0i0GV3q01OdG
	 1n/FlEVnxZgfr9tR+2/MyrzyDOJqf/u2jgj6BqMD97hwXcGZnKci9qSa4tjNMsaXQ7
	 784c1xdNpjITw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB34C79F9F;
	Thu, 10 Sep 2026 13:30:25 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh.mailbox.org@kernel.org>
Date: Thu, 10 Sep 2026 15:29:14 +0200
Subject: [PATCH v5 3/4] ARM: dts: mediatek: mt8127: Add watchdog support
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-mt8127-amazon-ford-basic-v5-3-3cb9eeaffd5c@mailbox.org>
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
 Zakariya Hadrami <zkh@mailbox.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789047024; l=946;
 i=zkh@mailbox.org; s=20260908; h=from:subject:message-id;
 bh=rS6D92PxCdmOuwt2bs95T+mGttnr+N31hBdnrfYmhjI=;
 b=WzS9g1XKg6ATeApnvLuhMIwY0EkbHusHCzcPlKpXj7IJ/nhfYzHhlAAmNFwo8WxsLAwhHVfrW
 pUzwelPvzq1BA2zE7X3R/uL/NQcrKdfV+NEJDsGiI/6ZJAD29CoOm/9
X-Developer-Key: i=zkh@mailbox.org; a=ed25519;
 pk=up24Xn4ScFKugfT4EJru/UQAS7JOIN+DSQqro+a05T4=
X-Endpoint-Received: by B4 Relay for zkh@mailbox.org/20260908 with
 auth_id=1015
X-Original-From: Zakariya Hadrami <zkh@mailbox.org>
Reply-To: zkh@mailbox.org

From: Zakariya Hadrami <zkh@mailbox.org>

Add watchdog node and disable it by default as it was not present
initially.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Zakariya Hadrami <zkh@mailbox.org>
---
 arch/arm/boot/dts/mediatek/mt8127.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mediatek/mt8127.dtsi b/arch/arm/boot/dts/mediatek/mt8127.dtsi
index bd61ec7e70c0..9bdf55d2da47 100644
--- a/arch/arm/boot/dts/mediatek/mt8127.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt8127.dtsi
@@ -99,6 +99,13 @@ soc {
 		compatible = "simple-bus";
 		ranges;
 
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt8127-wdt", "mediatek,mt6589-wdt";
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


