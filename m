Return-path: <Joshua.Henderson@microchip.com>
From: Joshua Henderson <joshua.henderson@microchip.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-mips@linux-mips.org>, <ralf@linux-mips.org>, Purna Chandra Mandal
	<purna.mandal@microchip.com>, Joshua Henderson
	<joshua.henderson@microchip.com>, Rob Herring <robh+dt@kernel.org>, Pawel
 Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Wim Van
 Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	<devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: [PATCH v2 1/2] dt/bindings: Add bindings for PIC32 deadman timer peripheral
Date: Thu, 25 Feb 2016 11:30:50 -0700
Message-ID: <1456425056-24483-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

From: Purna Chandra Mandal <purna.mandal@microchip.com>

Document the devicetree bindings for the deadman timer peripheral found on
Microchip PIC32 SoC class devices.

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Note: Please merge this patch series through the MIPS tree.

Changes since v1:
	- Change the example node name to be standard.
---
 .../bindings/watchdog/microchip,pic32-dmt.txt      |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/microchip,pic32-dmt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/microchip,pic32-dmt.txt b/Documentation/devicetree/bindings/watchdog/microchip,pic32-dmt.txt
new file mode 100644
index 0000000..852f694
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/microchip,pic32-dmt.txt
@@ -0,0 +1,19 @@
+* Microchip PIC32 Deadman Timer
+
+The deadman timer is used to reset the processor in the event of a software
+malfunction. It is a free-running instruction fetch timer, which is clocked
+whenever an instruction fetch occurs until a count match occurs.
+
+Required properties:
+- compatible: must be "microchip,pic32mzda-dmt".
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- clocks: phandle of parent clock (should be &PBCLK7).
+
+Example:
+
+	watchdog@1f800a00 {
+		compatible = "microchip,pic32mzda-dmt";
+		reg = <0x1f800a00 0x80>;
+		clocks = <&PBCLK7>;
+	};
-- 
1.7.9.5
