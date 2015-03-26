Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:56851 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbbCZID4 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Mar 2015 04:03:56 -0400
From: Baruch Siach <baruch@tkos.co.il>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v2 1/2] watchdog: digicolor: document device tree binding
Date: Thu, 26 Mar 2015 09:59:50 +0200
Message-Id: <a4554d0a61c62b85a7d66b6e3d16d07f8a498025.1427356791.git.baruch@tkos.co.il>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add a device tree binding documentation to the watchdog hardware block on the
Conexant CX92755 SoC. The CX92755 is from the Digicolor SoCs series. Other SoCs
in that series may share the same hardware block.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2:
   No change
---
 .../devicetree/bindings/watchdog/digicolor-wdt.txt | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt b/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt
new file mode 100644
index 000000000000..a882967e17d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt
@@ -0,0 +1,25 @@
+Conexant Digicolor SoCs Watchdog timer
+
+The watchdog functionality in Conexant Digicolor SoCs relies on the so called
+"Agent Communication" block. This block includes the eight programmable system
+timer counters. The first timer (called "Timer A") is the only one that can be
+used as watchdog.
+
+Required properties:
+
+- compatible : Should be "cnxt,cx92755-wdt"
+- reg : Specifies base physical address and size of the registers
+- clocks : phandle; specifies the clock that drives the timer
+
+Optional properties:
+
+- timeout-sec : Contains the watchdog timeout in seconds
+
+Example:
+
+	watchdog@f0000fc0 {
+		compatible = "cnxt,cx92755-wdt";
+		reg = <0xf0000fc0 0x8>;
+		clocks = <&main_clk>;
+		timeout-sec = <15>;
+	};
-- 
2.1.4

