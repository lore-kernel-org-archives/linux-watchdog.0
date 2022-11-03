Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF3FC4332F
	for <linux-watchdog@archiver.kernel.org>; Thu,  3 Nov 2022 22:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiKCWk3 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 3 Nov 2022 18:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiKCWkX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 3 Nov 2022 18:40:23 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 980BF1EEF9;
        Thu,  3 Nov 2022 15:40:21 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.96,135,1665414000"; 
   d="scan'208";a="141405084"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Nov 2022 07:40:21 +0900
Received: from mulinux.home (unknown [10.226.92.174])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E4BA0400A8BF;
        Fri,  4 Nov 2022 07:40:15 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 2/3] arm64: dts: renesas: r9a09g011: Add watchdog node
Date:   Thu,  3 Nov 2022 22:39:55 +0000
Message-Id: <20221103223956.50575-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103223956.50575-1-fabrizio.castro.jz@renesas.com>
References: <20221103223956.50575-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The r9a09g011 (a.k.a. RZ/V2M) comes with two watchdog IPs,
but Linux is only allowed one.

Add a node for the watchdog allowed to Linux to the SoC
specific dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index fb1a97202c38..9859c717bd10 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -161,6 +161,19 @@ uart0: serial@a4040000 {
 			status = "disabled";
 		};
 
+		wdt0: watchdog@a4050000 {
+			compatible = "renesas,r9a09g011-wdt",
+				     "renesas,rzv2m-wdt";
+			reg = <0 0xa4050000 0 0x80>;
+			clocks = <&cpg CPG_MOD R9A09G011_WDT0_PCLK>,
+				 <&cpg CPG_MOD R9A09G011_WDT0_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&cpg R9A09G011_WDT0_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@b6250000 {
 			compatible = "renesas,r9a09g011-pinctrl";
 			reg = <0 0xb6250000 0 0x800>;
-- 
2.34.1

