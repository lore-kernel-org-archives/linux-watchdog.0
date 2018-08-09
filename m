Return-Path: <paul@crapouillou.net>
Return-path: <paul@crapouillou.net>
From: Paul Cercueil <paul@crapouillou.net>
To: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ralf Baechle <ralf@linux-mips.org>,
	Paul Burton <paul.burton@mips.com>,
	James Hogan <jhogan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lee Jones <lee.jones@linaro.org>,
	Mathieu Malaterre <malat@debian.org>,
	Ezequiel Garcia <ezequiel@collabora.co.uk>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-mips@linux-mips.org,
	linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 04/24] dt-bindings: Add doc for the Ingenic TCU drivers
Date: Thu,  9 Aug 2018 23:43:54 +0200
Message-Id: <20180809214414.20905-5-paul@crapouillou.net>
In-Reply-To: <20180809214414.20905-1-paul@crapouillou.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
List-ID: <linux-watchdog@vger.kernel.org>

Add documentation about how to properly use the Ingenic TCU
(Timer/Counter Unit) drivers from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |  25 ----
 .../devicetree/bindings/timer/ingenic,tcu.txt      | 134 +++++++++++++++++++++
 .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  17 ---
 3 files changed, 134 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt

 v4: New patch in this series. Corresponds to V2 patches 3-4-5 with
     added content.

 v5: - Edited PWM/watchdog DT bindings documentation to point to the new
       document.
     - Moved main document to
       Documentation/devicetree/bindings/timer/ingenic,tcu.txt
     - Updated documentation to reflect the new devicetree bindings.

 v6: - Removed PWM/watchdog documentation files as asked by upstream
     - Removed doc about properties that should be implicit
     - Removed doc about ingenic,timer-channel /
       ingenic,clocksource-channel as they are gone
     - Fix WDT clock name in the binding doc
     - Fix lengths of register areas in watchdog/pwm nodes

diff --git a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
deleted file mode 100644
index 7d9d3f90641b..000000000000
--- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Ingenic JZ47xx PWM Controller
-=============================
-
-Required properties:
-- compatible: One of:
-  * "ingenic,jz4740-pwm"
-  * "ingenic,jz4770-pwm"
-  * "ingenic,jz4780-pwm"
-- #pwm-cells: Should be 3. See pwm.txt in this directory for a description
-  of the cells format.
-- clocks : phandle to the external clock.
-- clock-names : Should be "ext".
-
-
-Example:
-
-	pwm: pwm@10002000 {
-		compatible = "ingenic,jz4740-pwm";
-		reg = <0x10002000 0x1000>;
-
-		#pwm-cells = <3>;
-
-		clocks = <&ext>;
-		clock-names = "ext";
-	};
diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
new file mode 100644
index 000000000000..838ce5065534
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
@@ -0,0 +1,134 @@
+Ingenic JZ47xx SoCs Timer/Counter Unit devicetree bindings
+==========================================================
+
+For a description of the TCU hardware and drivers, have a look at
+Documentation/mips/ingenic-tcu.txt.
+
+Required properties:
+
+- compatible: Must be one of:
+  * ingenic,jz4740-tcu
+  * ingenic,jz4725b-tcu
+  * ingenic,jz4770-tcu
+- reg: Should be the offset/length value corresponding to the TCU registers
+- clocks: List of phandle & clock specifiers for clocks external to the TCU.
+  The "pclk", "rtc", "ext" and "tcu" clocks should be provided.
+- clock-names: List of name strings for the external clocks.
+- #clock-cells: Should be <1>;
+  Clock consumers specify this argument to identify a clock. The valid values
+  may be found in <dt-bindings/clock/ingenic,tcu.h>.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value should be 1.
+- interrupt-parent : phandle of the interrupt controller.
+- interrupts : Specifies the interrupt the controller is connected to.
+
+
+Children nodes
+==========================================================
+
+
+PWM node:
+---------
+
+Required properties:
+
+- compatible: Must be one of:
+  * ingenic,jz4740-pwm
+  * ingenic,jz4725b-pwm
+- #pwm-cells: Should be 3. See ../pwm/pwm.txt for a description of the cell
+  format.
+- clocks: List of phandle & clock specifiers for the TCU clocks.
+- clock-names: List of name strings for the TCU clocks.
+
+
+Watchdog node:
+--------------
+
+Required properties:
+
+- compatible: Must be one of:
+  * ingenic,jz4740-watchdog
+  * ingenic,jz4780-watchdog
+- clocks: phandle to the WDT clock
+- clock-names: should be "wdt"
+
+
+OST node:
+---------
+
+Required properties:
+
+- compatible: Must be one of:
+  * ingenic,jz4725b-ost
+  * ingenic,jz4770-ost
+- clocks: phandle to the OST clock
+- clock-names: should be "ost"
+- interrupts : Specifies the interrupt the OST is connected to.
+
+
+Example
+==========================================================
+
+#include <dt-bindings/clock/jz4770-cgu.h>
+#include <dt-bindings/clock/ingenic,tcu.h>
+
+/ {
+	tcu: timer@10002000 {
+		compatible = "ingenic,jz4770-tcu";
+		reg = <0x10002000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10002000 0x1000>;
+
+		#clock-cells = <1>;
+
+		clocks = <&cgu JZ4770_CLK_RTC
+			  &cgu JZ4770_CLK_EXT
+			  &cgu JZ4770_CLK_PCLK
+			  &cgu JZ4770_CLK_EXT>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <27 26 25>;
+
+		watchdog: watchdog@0 {
+			compatible = "ingenic,jz4740-watchdog";
+			reg = <0x0 0xc>;
+
+			clocks = <&tcu TCU_CLK_WDT>;
+			clock-names = "wdt";
+		};
+
+		pwm: pwm@10 {
+			compatible = "ingenic,jz4740-pwm";
+			reg = <0x10 0x40>;
+
+			#pwm-cells = <3>;
+
+			clocks = <&tcu TCU_CLK_TIMER0
+				  &tcu TCU_CLK_TIMER1
+				  &tcu TCU_CLK_TIMER2
+				  &tcu TCU_CLK_TIMER3
+				  &tcu TCU_CLK_TIMER4
+				  &tcu TCU_CLK_TIMER5
+				  &tcu TCU_CLK_TIMER6
+				  &tcu TCU_CLK_TIMER7>;
+			clock-names = "timer0", "timer1", "timer2", "timer3",
+				      "timer4", "timer5", "timer6", "timer7";
+		};
+
+		ost: timer@e0 {
+			compatible = "ingenic,jz4770-ost";
+			reg = <0xe0 0x20>;
+
+			clocks = <&tcu TCU_CLK_OST>;
+			clock-names = "ost";
+
+			interrupts = <15>;
+		};
+	};
+};
diff --git a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt b/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
deleted file mode 100644
index ce1cb72d5345..000000000000
--- a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Ingenic Watchdog Timer (WDT) Controller for JZ4740 & JZ4780
-
-Required properties:
-compatible: "ingenic,jz4740-watchdog" or "ingenic,jz4780-watchdog"
-reg: Register address and length for watchdog registers
-clocks: phandle to the RTC clock
-clock-names: should be "rtc"
-
-Example:
-
-watchdog: jz4740-watchdog@10002000 {
-	compatible = "ingenic,jz4740-watchdog";
-	reg = <0x10002000 0x10>;
-
-	clocks = <&cgu JZ4740_CLK_RTC>;
-	clock-names = "rtc";
-};
-- 
2.11.0
