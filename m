Return-Path: <ezequiel.garcia@free-electrons.com>
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v5 15/20] ARM: mvebu: Enable Armada 370/XP watchdog in the devicetree
Date: Mon, 27 Jan 2014 12:27:15 -0300
Message-Id: <1390836440-12744-16-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Add the DT nodes to enable watchdog support available in Armada 370
and Armada XP SoCs.

Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 4 ++++
 arch/arm/boot/dts/armada-370.dtsi    | 5 +++++
 arch/arm/boot/dts/armada-xp.dtsi     | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 7f10f62..96e0389 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -151,6 +151,10 @@
 				interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
 			};
 
+			watchdog@20300 {
+				reg = <0x20300 0x34>, <0x20704 0x4>;
+			};
+
 			sata@a0000 {
 				compatible = "marvell,orion-sata";
 				reg = <0xa0000 0x5000>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 7a4b82e..aebed9e 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -168,6 +168,11 @@
 				clocks = <&coreclk 2>;
 			};
 
+			watchdog@20300 {
+				compatible = "marvell,armada-370-wdt";
+				clocks = <&coreclk 2>;
+			};
+
 			coreclk: mvebu-sar@18230 {
 				compatible = "marvell,armada-370-core-clock";
 				reg = <0x18230 0x08>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 281c644..8c6c06c 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -74,6 +74,12 @@
 				clock-names = "nbclk", "fixed";
 			};
 
+			watchdog@20300 {
+				compatible = "marvell,armada-xp-wdt";
+				clocks = <&coreclk 2>, <&refclk>;
+				clock-names = "nbclk", "fixed";
+			};
+
 			coreclk: mvebu-sar@18230 {
 				compatible = "marvell,armada-xp-core-clock";
 				reg = <0x18230 0x08>;
-- 
1.8.1.5
