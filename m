Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317363CB8F5;
	Wed,  9 Sep 2026 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982691; cv=none; b=lbAp2QW9N5BVoc7HmnDk7Sq4xsopHDnG0BKBKXm8kM0ZPENmysUzAaGGwLNHdmX+GI4B9ewGJOVxg5rId9PeayI2510VBe+M9kyiXZwsDtogJ+52eYMF+609F06VTFd22m9TSpCOlVPjAljllGPr/PfSSbfhT6DDTViReBGrz2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982691; c=relaxed/simple;
	bh=eVriJrMeYp3XHPG8ed08fiWSUJ0t9VB3iX+On7WM94M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I48xDAPim7A/qIdlwpV9HPD+2+HyG9vYglR/R2ay4EvnKNzegVOc+/HdIAzvvuHsIp5WBv1vSCzurL/zeq7aWGOIbQjVbOwTqsF5eiqRhDakhWdgorS1IIGYjqtQvtee48AbNQcnLkWw6I0oswZ5LZ3ZYP3DOXCxHwKXGaVbJoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4lG4TP3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4lG4TP3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8AC2C4AF0B;
	Wed,  9 Sep 2026 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788982690;
	bh=eVriJrMeYp3XHPG8ed08fiWSUJ0t9VB3iX+On7WM94M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p4lG4TP387gYVDOAYLi1dpNhG00Pgr2+zjS+x5lmndd7KBHE0UHSX3gywW3Rhff74
	 LJTTn6Mw+CiJZF8e6WOOl3RcEwMYhll7BNtal6gGl8XsJv0Rwf4Nt7z+opSMNzQ4py
	 m8pwnaMkSW1g34K0gXlYfBip+bvMfXmeGogDaBVkeMj1PeeSaUDNu3UGJ6dNycOIPu
	 ZPjhoXhop+5061m73kM/4FXrugIwJnHSkSLX9sE09+cBBRy3cekBHdUyL4ro+1jvy/
	 ug//93OonOa62628oEL6riXXXh9sM8D2FbmeolDKqI/iZrKXzQhwvV6fWfjLjlG6E3
	 1Ygg0JDAzqdng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B702EC79FB7;
	Wed,  9 Sep 2026 19:38:10 +0000 (UTC)
From: Zakariya Hadrami via B4 Relay <devnull+zkh.mailbox.org@kernel.org>
Date: Wed, 09 Sep 2026 21:38:02 +0200
Subject: [PATCH v4 3/4] ARM: dts: mediatek: mt8127: Add watchdog support
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mt8127-amazon-ford-basic-v4-3-e9af5c420ab1@mailbox.org>
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
 Zakariya Hadrami <zkh@mailbox.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788982689; l=862;
 i=zkh@mailbox.org; s=20260908; h=from:subject:message-id;
 bh=AX2u3pZcnaoS6OSYF7vpbl8cAzsMvrof+x8jgtKD7wE=;
 b=uG15he8dZDkFSIREAXSI+NqppUoKDQER6oojwbFPs5KSsXn3gCGG8cTrmab/fuF9Bm0vT/xKh
 JuzD5J7o/2RAjaa2QT91eqNRlYs2tbtbKqktdVVtd4oAZeITdD0QEzJ
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


