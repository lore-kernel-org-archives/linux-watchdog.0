Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.nic.cz ([217.31.204.67]:39484 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729343AbeH3S1b (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 30 Aug 2018 14:27:31 -0400
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH 2/2] arm64: dts: marvell: armada-37xx: add nodes to support watchdog
Date: Thu, 30 Aug 2018 16:22:43 +0200
Message-Id: <20180830142243.12153-2-marek.behun@nic.cz>
In-Reply-To: <20180830142243.12153-1-marek.behun@nic.cz>
References: <20180830142243.12153-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This adds the system controller node for CPU Miscellaneous Registers
(which is needed for the watchdog node) and the watchdog node.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
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
