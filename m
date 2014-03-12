Return-Path: <ezequiel.garcia@free-electrons.com>
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 7/8] ARM: mvebu: Enable Armada 380/385 watchdog in the devicetree
Date: Wed, 12 Mar 2014 18:11:54 -0300
Message-Id: <1394658715-2017-8-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1394658715-2017-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394658715-2017-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Add the DT nodes to enable the watchdog support available on
Armada 380/385 SoC.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 812ce28..2f0ebc6 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -267,6 +267,13 @@
 				clock-names = "nbclk", "fixed";
 			};
 
+			watchdog@20300 {
+				compatible = "marvell,armada-380-wdt";
+				reg = <0x20300 0x34>, <0x20704 0x4>, <0x18260 0x4>;
+				clocks = <&coreclk 2>, <&refclk>;
+				clock-names = "nbclk", "fixed";
+			};
+
 			eth1: ethernet@30000 {
 				compatible = "marvell,armada-370-neta";
 				reg = <0x30000 0x4000>;
-- 
1.9.0
