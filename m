Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60592 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758391Ab3GOXeQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jul 2013 19:34:16 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree-discuss@lists.ozlabs.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	wim@iguana.be, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 10/10] ARM: kirkwood: Fix the device-tree watchdog's node reg property
Date: Mon, 15 Jul 2013 20:32:43 -0300
Message-Id: <1373931163-12670-11-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog driver now needs two 'reg' property cells. The first one
is for the register containing the watchdog counter, while the second
one is for the RSTOUT register.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index ca296c3..0d74ee9 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -116,7 +116,8 @@
 
 		wdt: watchdog-timer@20300 {
 			compatible = "marvell,orion-wdt";
-			reg = <0x20300 0x28>;
+			reg = <0x20324 0x04
+			       0x20108 0x04>;
 			interrupt-parent = <&bridge_intc>;
 			interrupts = <3>;
 			clocks = <&gate_clk 7>;
-- 
1.8.1.5

