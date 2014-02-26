Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:38165 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751432AbaBZMu4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 26 Feb 2014 07:50:56 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 1/2] ARM: mvebu: Enable Armada 375 watchdog in the devicetree
Date: Wed, 26 Feb 2014 09:50:46 -0300
Message-Id: <1393419047-10071-2-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1393419047-10071-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1393419047-10071-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add the DT nodes to enable the watchdog support available on
Armada 375 SoC.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 3877693f..a2003cb 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -320,6 +320,12 @@
 				clocks = <&coreclk 0>;
 			};
 
+			watchdog@20300 {
+				compatible = "marvell,armada-375-wdt", "marvell,armada-370-wdt";
+				reg = <0x20300 0x34>, <0x20704 0x4>;
+				clocks = <&coreclk 0>;
+			};
+
 			xor@60800 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60800 0x100
-- 
1.8.1.5

