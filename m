Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49127 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750994AbeFYPn7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 25 Jun 2018 11:43:59 -0400
From: Ludovic Barre <ludovic.Barre@st.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V5 3/5] ARM: dts: stm32: add iwdg2 support for stm32mp157c
Date: Mon, 25 Jun 2018 17:43:01 +0200
Message-ID: <1529941383-8653-4-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds independent watchdog support for stm32mp157c.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 7d17538..95cc166 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -784,6 +784,14 @@
 			status = "disabled";
 		};
 
+		iwdg2: watchdog@5a002000 {
+			compatible = "st,stm32mp1-iwdg";
+			reg = <0x5a002000 0x400>;
+			clocks = <&rcc IWDG2>, <&rcc CK_LSI>;
+			clock-names = "pclk", "lsi";
+			status = "disabled";
+		};
+
 		usbphyc: usbphyc@5a006000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4

