Return-Path: <Orson.Zhai@spreadtrum.com>
Return-path: <Orson.Zhai@spreadtrum.com>
From: Eric Long <eric.long@spreadtrum.com>
To: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark
 Rutland <mark.rutland@arm.com>
CC: <baolin.wang@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <eric.long@spreadtrum.com>
Subject: [PATCH v2 1/2] dt-bindings: watchdog: Add Spreadtrum watchdog documentation
Date: Tue, 12 Sep 2017 19:40:08 +0800
Message-ID: <f3daa0f85dda0672c4b057e7f37c690365652e39.1505216059.git.eric.long@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

This patch adds the documentation for Spreadtrum watchdog driver.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
---
changes since v1:
 - No updates.
---
 .../devicetree/bindings/watchdog/sprd-wdt.txt         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sprd-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt b/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
new file mode 100644
index 0000000..aeaf3e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
@@ -0,0 +1,19 @@
+Spreadtrum SoCs Watchdog timer
+
+Required properties:
+- compatible : Should be "sprd,sp9860-wdt".
+- reg : Specifies base physical address and size of the registers.
+- interrupts : Exactly one interrupt specifier.
+- timeout-sec : Contain the default watchdog timeout in seconds.
+- clock-names : Contain the input clock names.
+- clocks : Phandles to input clocks.
+
+Example:
+	watchdog: watchdog@40310000 {
+		compatible = "sprd,sp9860-wdt";
+		reg = <0 0x40310000 0 0x1000>;
+		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+		timeout-sec = <12>;
+		clock-names = "enable", "rtc_enable";
+		clocks = <&clk_aon_apb_gates1 8>, <&clk_aon_apb_rtc_gates 9>;
+	};
-- 
1.9.1
