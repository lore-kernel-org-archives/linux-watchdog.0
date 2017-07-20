Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37237 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936195AbdGTKXF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Jul 2017 06:23:05 -0400
From: Matthias Brugger <matthias.bgg@gmail.com>
To: wim@iguana.be, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4/4] arm64: dts: mediatek: Delete unused dummy clock for MT6797
Date: Thu, 20 Jul 2017 12:22:47 +0200
Message-Id: <20170720102247.12342-4-matthias.bgg@gmail.com>
In-Reply-To: <20170720102247.12342-1-matthias.bgg@gmail.com>
References: <20170720102247.12342-1-matthias.bgg@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

After adding the clock subsystem to the SOC, the dummy
clock clk32k is not longer needed. Delete it.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 1cb45219ef05..4beaa71107d7 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -108,13 +108,6 @@
 		clock-output-names = "clk26m";
 	};
 
-	clk32k: oscillator@1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32000>;
-		clock-output-names = "clk32k";
-	};
-
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-- 
2.12.3

