Return-Path: <marek.behun@nic.cz>
Return-path: <marek.behun@nic.cz>
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org,
	Guenter Roeck <linux@roeck-us.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v2 4/4] arm64: dts: marvell: armada-37xx: add nodes to support watchdog
Date: Tue,  4 Sep 2018 11:56:27 +0200
Message-Id: <20180904095627.25552-4-marek.behun@nic.cz>
In-Reply-To: <20180904095627.25552-1-marek.behun@nic.cz>
References: <20180904095627.25552-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

This adds the system controller node for CPU Miscellaneous Registers
(which is needed for the watchdog node) and the watchdog node.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index d9531e242eb4..048b072080c2 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -80,6 +80,18 @@
 			/* 32M internal register @ 0xd000_0000 */
 			ranges = <0x0 0x0 0xd0000000 0x2000000>;
 
+			wdt: watchdog-timer@8300 {
+				compatible = "marvell,armada-3700-wdt";
+				reg = <0x8300 0x40>;
+				marvell,system-controller = <&cpu_misc>;
+				clocks = <&xtalclk>;
+			};
+
+			cpu_misc: system-controller@d000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0xd000 0x1000>;
+			};
+
 			spi0: spi@10600 {
 				compatible = "marvell,armada-3700-spi";
 				#address-cells = <1>;
-- 
2.16.4
