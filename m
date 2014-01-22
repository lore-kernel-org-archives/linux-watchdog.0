Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49632 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752130AbaAVXG3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 18:06:29 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v4 16/18] ARM: kirkwood: Add RSTOUT 'reg' entry to devicetree
Date: Wed, 22 Jan 2014 20:05:13 -0300
Message-Id: <1390431915-5115-17-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In order to support multiplatform builds the watchdog devicetree binding
was modified and now the 'reg' property is specified to need two
entries. This commit adds the second entry as-per the new specification.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 8b73c80..80a56b0 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -165,7 +165,7 @@
 
 		wdt: watchdog-timer@20300 {
 			compatible = "marvell,orion-wdt";
-			reg = <0x20300 0x28>;
+			reg = <0x20300 0x28>, <0x20108 0x4>;
 			interrupt-parent = <&bridge_intc>;
 			interrupts = <3>;
 			clocks = <&gate_clk 7>;
-- 
1.8.1.5

