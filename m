Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:64458 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933563AbdDFMUu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Apr 2017 08:20:50 -0400
From: Yannick Fertre <yannick.fertre@st.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Philippe Cornu <philippe.cornu@st.com>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 3/5] ARM: dts: stm32: Add watchdog support for STM32F429 SoC
Date: Thu, 6 Apr 2017 14:19:26 +0200
Message-ID: <1491481168-22213-4-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1491481168-22213-1-git-send-email-yannick.fertre@st.com>
References: <1491481168-22213-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add watchdog into DT for stm32f429 family.

Signed-off-by: Yannick FERTRE <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 89327d6..d84dd44 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -64,7 +64,7 @@
 			clock-frequency = <32768>;
 		};
 
-		clk-lsi {
+		clk_lsi: clk-lsi {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32000>;
@@ -306,6 +306,13 @@
 			status = "disabled";
 		};
 
+		iwdg: watchdog@40003000 {
+			compatible = "st,stm32-iwdg";
+			reg = <0x40003000 0x400>;
+			clocks = <&clk_lsi>;
+			status = "disabled";
+		};
+
 		usart2: serial@40004400 {
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40004400 0x400>;
-- 
1.9.1

