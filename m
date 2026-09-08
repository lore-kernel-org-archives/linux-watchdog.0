Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C255931F;
	Tue,  8 Sep 2026 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904774; cv=none; b=gGHDJCaBh9B5i+UwUJxOCDYSvhIpSSsfipy6NeiqRypTRnSKIOoUHc8qtX65hblGyn3qW7VjRVRclZ1u0dAtMq5ozmK9Y2EfokUjcmyHJkAI6THc5VGXsQ7lhh8uutTjIXI7AsG8joXXJ0EkKj5PN0E2pbIHVXud33pnn7AMPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904774; c=relaxed/simple;
	bh=eVriJrMeYp3XHPG8ed08fiWSUJ0t9VB3iX+On7WM94M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQcZzKFc1riex8ijAMnPZYR4RGyKM12L3jmwqEOuIRfjF0ETbo1N5b3247cw3+oNtHDm3ccH2zRgta/+HaBaTyRItT+vuYO3cQVlwIchypjXAMsY9j7t7hzf6JajcLqh4Us5h6qdkTozOXTBnFV/J50YHFmatAfOy/uUBdXVRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwY+C3Ad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwY+C3Ad"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38CB4C2BD01;
	Tue,  8 Sep 2026 21:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788904774;
	bh=eVriJrMeYp3XHPG8ed08fiWSUJ0t9VB3iX+On7WM94M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TwY+C3AdgCDls57rUa/PozYUtsrtfKnz5mZYzYMH8Hb3KpCoat0TROhM4+bRGi56A
	 tC+pLzvJDMiKHvaJYO3cy7LbAJ3caCL7rxDjiRHIlJsSCgs2vCdKsqgGEWkqZ42GgD
	 5TxUEf8PxsCa35dvqpmnwbilsdL2keKR+rghecGW4WF7bGg+o1XG1djCPE2/hAFSVd
	 WIXFh/xkFPwbzw2CMMk5eZ+B1gNOxIszqMCj7EYR21sSXtknea4Ox/tFtqSguqAk4t
	 07BmMYvK3t+joilbGtcfCnQaSmLEXoC7t9ekyj3cpoFLEnJ8JBuiGyUtx84sjVZsPh
	 VlqcD17f152hg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251BAC79FAF;
	Tue,  8 Sep 2026 21:59:34 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh.mailbox.org@kernel.org>
Date: Tue, 08 Sep 2026 23:59:16 +0200
Subject: [PATCH v3 3/4] ARM: dts: mediatek: mt8127: Add watchdog support
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-mt8127-amazon-ford-basic-v3-3-fc46bf1b6cb2@mailbox.org>
References: <20260908-mt8127-amazon-ford-basic-v3-0-fc46bf1b6cb2@mailbox.org>
In-Reply-To: <20260908-mt8127-amazon-ford-basic-v3-0-fc46bf1b6cb2@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788904772; l=862;
 i=zkh@mailbox.org; s=20260908; h=from:subject:message-id;
 bh=AX2u3pZcnaoS6OSYF7vpbl8cAzsMvrof+x8jgtKD7wE=;
 b=Opgq1eRNAB4cK7JQilkoPnwcoXZFYTGmYcBGlkjFC1OFvAMRP5q2EhPKrdxSrISHmf9msNqIX
 +e9tnhwKeAIBKXxb/aeZQFcTtOuzfWsroQR3pgkMPdnNC8tpBXyFjir
X-Developer-Key: i=zkh@mailbox.org; a=ed25519;
 pk=up24Xn4ScFKugfT4EJru/UQAS7JOIN+DSQqro+a05T4=
X-Endpoint-Received: by B4 Relay for zkh@mailbox.org/20260908 with
 auth_id=1015
X-Original-From: Zakariya Hadrami <zkh@mailbox.org>
Reply-To: zkh@mailbox.org

From: Zakariya Hadrami <zkh@mailbox.org>

Add watchdog node and disable it by default as it was not present
initially.

Signed-off-by: Zakariya Hadrami <zkh@mailbox.org>
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


