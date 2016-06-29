Return-path: <twp@codeaurora.org>
From: Thomas Pedersen <twp@codeaurora.org>
To: linux-watchdog@vger.kernel.org
Cc: Matthew McClintock <mmcclint@codeaurora.org>,
	Thomas Pedersen <twp@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 1/3] watchdog: qcom: update device tree bindings
Date: Wed, 29 Jun 2016 10:50:00 -0700
Message-Id: <1467222602-18362-1-git-send-email-twp@codeaurora.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Matthew McClintock <mmcclint@codeaurora.org>

Update the compatible string to align with driver and also
add SoC specific string to DTS.

CC: linux-watchdog@vger.kernel.org
Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
Signed-off-by: Thomas Pedersen <twp@codeaurora.org>

---
v2:
Keep SoC specific compatible and add it to DTS.
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.txt | 2 ++
 arch/arm/boot/dts/qcom-apq8064.dtsi                     | 3 ++-
 arch/arm/boot/dts/qcom-ipq8064.dtsi                     | 3 ++-
 arch/arm/boot/dts/qcom-msm8960.dtsi                     | 3 ++-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
index 4726924..6b7b5ce 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
@@ -7,6 +7,8 @@ Required properties :
 			"qcom,kpss-wdt-msm8960"
 			"qcom,kpss-wdt-apq8064"
 			"qcom,kpss-wdt-ipq8064"
+			"qcom,kpss-timer"
+			"qcom,scss-timer"
 
 - reg : shall contain base register location and length
 - clocks : shall contain the input clock
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index df96ccd..e318d04 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -247,7 +247,8 @@
 		};
 
 		timer@200a000 {
-			compatible = "qcom,kpss-timer", "qcom,msm-timer";
+			compatible = "qcom,kpss-timer",
+				     "qcom,kpss-wdt-apq8064", "qcom,msm-timer";
 			interrupts = <1 1 0x301>,
 				     <1 2 0x301>,
 				     <1 3 0x301>;
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 2601a90..2e37557 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -122,7 +122,8 @@
 		};
 
 		timer@200a000 {
-			compatible = "qcom,kpss-timer", "qcom,msm-timer";
+			compatible = "qcom,kpss-timer",
+				     "qcom,kpss-wdt-ipq8064", "qcom,msm-timer";
 			interrupts = <1 1 0x301>,
 				     <1 2 0x301>,
 				     <1 3 0x301>,
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index da05e28..288f56e 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -87,7 +87,8 @@
 		};
 
 		timer@200a000 {
-			compatible = "qcom,kpss-timer", "qcom,msm-timer";
+			compatible = "qcom,kpss-timer",
+				     "qcom,kpss-wdt-msm8960", "qcom,msm-timer";
 			interrupts = <1 1 0x301>,
 				     <1 2 0x301>,
 				     <1 3 0x301>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
