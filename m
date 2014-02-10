Return-Path: <ezequiel.garcia@free-electrons.com>
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v7 15/18] ARM: dove: Enable Dove watchdog in the devicetree
Date: Mon, 10 Feb 2014 20:00:34 -0300
Message-Id: <1392073237-2554-16-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Add the devicetree node to enable watchdog support available in Dove SoCs.

Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/dove.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 2b76524..a88ed73 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -210,6 +210,14 @@
 				clocks = <&core_clk 0>;
 			};
 
+			watchdog@20300 {
+				compatible = "marvell,orion-wdt";
+				reg = <0x20300 0x28>, <0x20108 0x4>;
+				interrupt-parent = <&bridge_intc>;
+				interrupts = <3>;
+				clocks = <&core_clk 0>;
+			};
+
 			crypto: crypto-engine@30000 {
 				compatible = "marvell,orion-crypto";
 				reg = <0x30000 0x10000>,
-- 
1.8.1.5
