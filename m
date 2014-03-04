Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41833 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751464AbaCDQHq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Mar 2014 11:07:46 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 5/7] ARM: mvebu: Enable Armada 375 watchdog in the devicetree
Date: Tue,  4 Mar 2014 13:07:22 -0300
Message-Id: <1393949244-5011-6-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add the DT nodes to enable the watchdog support available on
Armada 375 SoC.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 3877693f..0bfa57b 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -320,6 +320,12 @@
 				clocks = <&coreclk 0>;
 			};
 
+			watchdog@20300 {
+				compatible = "marvell,armada-375-wdt";
+				reg = <0x20300 0x34>, <0x20704 0x4>, <0x18254 0x4>;
+				clocks = <&coreclk 0>;
+			};
+
 			xor@60800 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60800 0x100
-- 
1.8.1.5

