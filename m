Return-path: <Joshua.Henderson@microchip.com>
From: Joshua Henderson <joshua.henderson@microchip.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-mips@linux-mips.org>, <ralf@linux-mips.org>, Joshua Henderson
	<joshua.henderson@microchip.com>, Rob Herring <robh+dt@kernel.org>, Pawel
 Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Wim Van
 Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	<devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: [PATCH v3 1/2] dt/bindings: Add bindings for PIC32 watchdog peripheral
Date: Fri, 26 Feb 2016 10:19:27 -0700
Message-ID: <1456507177-5502-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Document the devicetree bindings for the watchdog peripheral found on
Microchip PIC32 SoC class devices.

Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
Note: Please merge this patch series through the MIPS tree.

Changes since v2: None
Changes since v1:
	- Change the example node name to be standard.
---
 .../bindings/watchdog/microchip,pic32-wdt.txt      |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt b/Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt
new file mode 100644
index 0000000..d140103
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt
@@ -0,0 +1,18 @@
+* Microchip PIC32 Watchdog Timer
+
+When enabled, the watchdog peripheral can be used to reset the device if the
+WDT is not cleared periodically in software.
+
+Required properties:
+- compatible: must be "microchip,pic32mzda-wdt".
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- clocks: phandle of source clk. should be <&LPRC> clk.
+
+Example:
+
+	watchdog@1f800800 {
+		compatible = "microchip,pic32mzda-wdt";
+		reg = <0x1f800800 0x200>;
+		clocks = <&LPRC>;
+	};
-- 
1.7.9.5
