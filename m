Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59347 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753032AbaBNWZZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Feb 2014 17:25:25 -0500
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
Subject: [RESEND/PATCH v7 14/18] ARM: kirkwood: Add RSTOUT 'reg' entry to devicetree
Date: Fri, 14 Feb 2014 19:24:14 -0300
Message-Id: <1392416658-2780-15-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In order to support multiplatform builds the watchdog devicetree binding
was modified and now the 'reg' property is specified to need two
entries. This commit adds the second entry as-per the new specification.

Tested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 6abf44d..85542c2 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -178,7 +178,7 @@
 
 		wdt: watchdog-timer@20300 {
 			compatible = "marvell,orion-wdt";
-			reg = <0x20300 0x28>;
+			reg = <0x20300 0x28>, <0x20108 0x4>;
 			interrupt-parent = <&bridge_intc>;
 			interrupts = <3>;
 			clocks = <&gate_clk 7>;
-- 
1.8.1.5

