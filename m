From: John Crispin <blogic@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: John Crispin <blogic@openwrt.org>, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: [PATCH V2 1/2] DT: Add documentation for ralink-wdt
Date: Thu,  8 Aug 2013 11:41:59 +0200
Message-Id: <1375954919-30737-1-git-send-email-blogic@openwrt.org>
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

Describe ralink-wdt binding.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
V1 used the old devicetree list as Cc.

 .../devicetree/bindings/watchdog/ralink-wdt.txt     |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/ralink-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt b/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt
new file mode 100644
index 0000000..a70f0e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt
@@ -0,0 +1,19 @@
+Ralink Watchdog Timers
+
+Required properties :
+- compatible: must be "ralink,rt2880-wdt"
+- reg: physical base address of the controller and length of the register range
+
+Optional properties :
+- interrupt-parent: phandle to the INTC device node
+- interrupts : Specify the INTC interrupt number
+
+Example:
+
+	watchdog@120 {
+		compatible = "ralink,mt7620a-wdt", "ralink,rt2880-wdt";
+		reg = <0x120 0x10>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <1>;
+	};
-- 
1.7.10.4
