Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:53694 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbbAVL4w (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 22 Jan 2015 06:56:52 -0500
Received: by mail-ig0-f176.google.com with SMTP id hl2so25629010igb.3
        for <linux-watchdog@vger.kernel.org>; Thu, 22 Jan 2015 03:56:52 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com
Subject: [PATCH v2 4/9] ARM: STi: DT: STiH407: Add Device Tree node for the LPC
Date: Thu, 22 Jan 2015 11:56:02 +0000
Message-Id: <1421927767-28889-5-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1421927767-28889-1-git-send-email-lee.jones@linaro.org>
References: <1421927767-28889-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On current ST platforms the LPC controls a number of functions.  This
patch enables support for the LPC Watchdog and LPC RTC devices on LPC1
and LPC2 respectively.

Signed-off-by: David Paris <david.paris@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 3e31d32..04448a7 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -7,6 +7,7 @@
  * publishhed by the Free Software Foundation.
  */
 #include "stih407-pinctrl.dtsi"
+#include <dt-bindings/mfd/st-lpc.h>
 #include <dt-bindings/reset-controller/stih407-resets.h>
 / {
 	#address-cells = <1>;
@@ -274,5 +275,24 @@
 
 			status = "disabled";
 		};
+
+		/* Watchdog and Real-Time Clock */
+		lpc@8787000 {
+			compatible = "st,stih407-lpc";
+			reg = <0x8787000 0x1000>;
+			interrupts = <GIC_SPI 129 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clk_s_d3_flexgen CLK_LPC_0>;
+			timeout-sec = <120>;
+			st,syscfg = <&syscfg_core>;
+			st,lpc-mode = <ST_LPC_MODE_WDT>;
+		};
+
+		lpc@8788000 {
+			compatible = "st,stih407-lpc";
+			reg = <0x8788000 0x1000>;
+			interrupts = <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clk_s_d3_flexgen CLK_LPC_1>;
+			st,lpc-mode = <ST_LPC_MODE_RTC>;
+		};
 	};
 };
-- 
1.9.1

