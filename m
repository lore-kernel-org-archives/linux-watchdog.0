Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:50782 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdL1QjO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 28 Dec 2017 11:39:14 -0500
From: Paul Cercueil <paul@crapouillou.net>
To: Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/7] MIPS: jz4780: dts: Fix watchdog node
Date: Thu, 28 Dec 2017 17:29:37 +0100
Message-Id: <20171228162939.3928-6-paul@crapouillou.net>
In-Reply-To: <20171228162939.3928-1-paul@crapouillou.net>
References: <20171228162939.3928-1-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

- The previous node requested a memory area of 0x100 bytes, while the
  driver only manipulates four registers present in the first 0x10 bytes.

- The driver requests for the "rtc" clock, but the previous node did not
  provide any.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 9b5794667aee..a52f59bf58c7 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -221,7 +221,10 @@
 
 	watchdog: watchdog@10002000 {
 		compatible = "ingenic,jz4780-watchdog";
-		reg = <0x10002000 0x100>;
+		reg = <0x10002000 0x10>;
+
+		clocks = <&cgu JZ4780_CLK_RTCLK>;
+		clock-names = "rtc";
 	};
 
 	nemc: nemc@13410000 {
-- 
2.11.0

