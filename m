Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56023 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754345AbdELNfE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 12 May 2017 09:35:04 -0400
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v2 3/3] ARM: socfpga: dtsi: add dw-wdt reset lines
Date: Fri, 12 May 2017 15:34:37 +0200
Message-Id: <f254e0ec6bdab730a2ee112010e2a96efd4a9ed8.1494595189.git-series.s.trumtrar@pengutronix.de>
In-Reply-To: <44e4e733055cfa2ed79091542c7bb17aa24afca9.1494595189.git-series.s.trumtrar@pengutronix.de>
References: <44e4e733055cfa2ed79091542c7bb17aa24afca9.1494595189.git-series.s.trumtrar@pengutronix.de>
In-Reply-To: <cover.e174fd0fa926fadf54e0f76e07f238bed3e162fc.1494595189.git-series.s.trumtrar@pengutronix.de>
References: <cover.e174fd0fa926fadf54e0f76e07f238bed3e162fc.1494595189.git-series.s.trumtrar@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/socfpga.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 2c43c4d85dee..bd976cfc3b07 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -916,6 +916,7 @@
 			reg = <0xffd02000 0x1000>;
 			interrupts = <0 171 4>;
 			clocks = <&osc1>;
+			resets = <&rst L4WD0_RESET>;
 			status = "disabled";
 		};
 
@@ -924,6 +925,7 @@
 			reg = <0xffd03000 0x1000>;
 			interrupts = <0 172 4>;
 			clocks = <&osc1>;
+			resets = <&rst L4WD1_RESET>;
 			status = "disabled";
 		};
 	};
-- 
git-series 0.9.1
