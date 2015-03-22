Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:56667 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671AbbCVMkr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 22 Mar 2015 08:40:47 -0400
From: Baruch Siach <baruch@tkos.co.il>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH 1/2] watchdog: digicolor: document device tree binding
Date: Sun, 22 Mar 2015 14:40:35 +0200
Message-Id: <6bc6e867b500cd3cfc629b96f90442f5c0aced3a.1427028036.git.baruch@tkos.co.il>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add a device tree binding documentation to the watchdog hardware block on the
Conexant CX92755 SoC. The CX92755 is from the Digicolor SoCs series. Other SoCs
in that series may share the same hardware block.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
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

