Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:44421 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751053AbaJYSaI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 Oct 2014 14:30:08 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 4/4] ARM: mvebu: Enable the reference clock for timer and watchdog on Armada 375 SoC
Date: Sat, 25 Oct 2014 11:48:42 -0300
Message-Id: <1414248522-16055-5-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Now that the timer and watchdog drivers support the Armada 375 usage of
the reference clock, we can enable it in the devicetree.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index de65714..9721e55 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -36,6 +36,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <2000000000>;
 		};
+		/* 25 MHz reference crystal */
+		refclk: oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+		};
 	};
 
 	cpus {
@@ -366,13 +372,15 @@
 						      <&gic  GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 						      <&mpic 5>,
 						      <&mpic 6>;
-				clocks = <&coreclk 0>;
+				clocks = <&coreclk 0>, <&refclk>;
+				clock-names = "nbclk", "fixed";
 			};
 
 			watchdog@20300 {
 				compatible = "marvell,armada-375-wdt";
 				reg = <0x20300 0x34>, <0x20704 0x4>, <0x18254 0x4>;
-				clocks = <&coreclk 0>;
+				clocks = <&coreclk 0>, <&refclk>;
+				clock-names = "nbclk", "fixed";
 			};
 
 			cpurst@20800 {
-- 
2.1.0

