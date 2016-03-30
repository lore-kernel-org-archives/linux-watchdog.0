Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43784 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967AbcC3P3d (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Mar 2016 11:29:33 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: r8a7795: Add RWDT node
Date: Wed, 30 Mar 2016 17:28:43 +0200
Message-Id: <1459351725-14144-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1459351725-14144-1-git-send-email-wsa@the-dreams.de>
References: <1459351725-14144-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This patch adds the RWDT device node for r8a7795.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since last RFC (only on renesas-soc-list):

* rename RWDT to WDT since it can also be used for the now documented SWDT :)
* use mainstream-style for the DT compatibles and update docs

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index bccd52e0462b92..dcdf914b67d4d9 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -167,6 +167,14 @@
 					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		wdt0: wdt@e6020000 {
+			compatible = "renesas,r8a7795-wdt", "renesas,rcar-gen3-wdt";
+			reg = <0 0xe6020000 0 0x0c>;
+			clocks = <&cpg CPG_MOD 402>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		gpio0: gpio@e6050000 {
 			compatible = "renesas,gpio-r8a7795",
 				     "renesas,gpio-rcar";
-- 
2.7.0

