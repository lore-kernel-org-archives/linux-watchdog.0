Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50277 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481AbbBUCU5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 21:20:57 -0500
From: Mathieu Olivari <mathieu@codeaurora.org>
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, wim@iguana.be, corbet@lwn.net,
	standby24x7@gmail.com, mathieu@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Josh Cartwright <joshc@codeaurora.org>
Subject: [PATCH 2/3] ARM: qcom: add description of KPSS WDT for IPQ8064
Date: Fri, 20 Feb 2015 18:19:35 -0800
Message-Id: <1424485176-8348-3-git-send-email-mathieu@codeaurora.org>
In-Reply-To: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add the watchdog related entries to the Krait Processor Sub-system
(KPSS) timer IPQ8064 devicetree section. Also, add a fixed-clock
description of SLEEP_CLK, which will do for now.

Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cb225da..d01f618 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -60,6 +60,14 @@
 		};
 	};
 
+	clocks {
+		sleep_clk: sleep_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			#clock-cells = <0>;
+		};
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -89,10 +97,14 @@
 			compatible = "qcom,kpss-timer", "qcom,msm-timer";
 			interrupts = <1 1 0x301>,
 				     <1 2 0x301>,
-				     <1 3 0x301>;
+				     <1 3 0x301>,
+				     <1 4 0x301>,
+				     <1 5 0x301>;
 			reg = <0x0200a000 0x100>;
 			clock-frequency = <25000000>,
 					  <32768>;
+			clocks = <&sleep_clk>;
+			clock-names = "sleep";
 			cpu-offset = <0x80000>;
 		};
 
-- 
1.9.1

