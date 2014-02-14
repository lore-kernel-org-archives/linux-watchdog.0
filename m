Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59353 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753032AbaBNWZ3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Feb 2014 17:25:29 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RESEND/PATCH v7 15/18] ARM: dove: Enable Dove watchdog in the devicetree
Date: Fri, 14 Feb 2014 19:24:15 -0300
Message-Id: <1392416658-2780-16-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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

