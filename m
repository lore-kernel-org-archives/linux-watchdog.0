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
Subject: [PATCH v7 13/18] ARM: mvebu: Enable Armada 370/XP watchdog in the devicetree
Date: Mon, 10 Feb 2014 20:00:32 -0300
Message-Id: <1392073237-2554-14-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Add the DT nodes to enable watchdog support available in Armada 370
and Armada XP SoCs.

Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 4 ++++
 arch/arm/boot/dts/armada-370.dtsi    | 5 +++++
 arch/arm/boot/dts/armada-xp.dtsi     | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 74b5964..7bbc4ac 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -199,6 +199,10 @@
 				interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
 			};
 
+			watchdog@20300 {
+				reg = <0x20300 0x34>, <0x20704 0x4>;
+			};
+
 			usb@50000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x50000 0x500>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 0d8530c..b7759b2 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -196,6 +196,11 @@
 				clocks = <&coreclk 2>;
 			};
 
+			watchdog@20300 {
+				compatible = "marvell,armada-370-wdt";
+				clocks = <&coreclk 2>;
+			};
+
 			usb@50000 {
 				clocks = <&coreclk 0>;
 			};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index b8b84a2..abb9f9d 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -111,6 +111,12 @@
 				clock-names = "nbclk", "fixed";
 			};
 
+			watchdog@20300 {
+				compatible = "marvell,armada-xp-wdt";
+				clocks = <&coreclk 2>, <&refclk>;
+				clock-names = "nbclk", "fixed";
+			};
+
 			armada-370-xp-pmsu@22000 {
 				compatible = "marvell,armada-370-xp-pmsu";
 				reg = <0x22100 0x400>, <0x20800 0x20>;
-- 
1.8.1.5
