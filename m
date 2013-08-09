From: John Crispin <blogic@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: John Crispin <blogic@openwrt.org>, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH V3 1/2] DT: Add documentation for rt2880-wdt
Date: Fri,  9 Aug 2013 21:00:31 +0200
Message-Id: <1376074831-29561-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

This document describes the binding of the watchdog core found ralink wireless
SoC.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: devicetree-discuss@lists.ozlabs.org
---
Changes in V3:
* renamed file to rt2880-wdt.txt

 .../devicetree/bindings/watchdog/rt2880-wdt.txt     |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/rt2880-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/rt2880-wdt.txt b/Documentation/devicetree/bindings/watchdog/rt2880-wdt.txt
new file mode 100644
index 0000000..a654dd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/rt2880-wdt.txt
@@ -0,0 +1,19 @@
+Ralink Watchdog Timers
+
+Required properties :
+- compatible: must be "ralink,rt2880-wdt"
+- reg: physical base address of the controller and length of the register range
+
+Optional properties :
+- interrupt-parent: phandle to the INTC device node
+- interrupts: Specify the INTC interrupt number
+
+Example:
+
+	watchdog@120 {
+		compatible = "ralink,rt2880-wdt";
+		reg = <0x120 0x10>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <1>;
+	};
-- 
1.7.10.4
