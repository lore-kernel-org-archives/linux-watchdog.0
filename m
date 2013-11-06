Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52422 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756521Ab3KFLdn (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 Nov 2013 06:33:43 -0500
Message-ID: <527A28F0.6050406@ti.com>
Date: Wed, 6 Nov 2013 13:33:04 +0200
From: "ivan.khoronzhuk" <ivan.khoronzhuk@ti.com>
MIME-Version: 1.0
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, <wim@iguana.be>,
	<nsekhar@ti.com>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <grant.likely@linaro.org>, <rob.herring@calxeda.com>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<swarren@wwwdotorg.org>, <galak@kernel.crashing.org>,
	<ijc+devicetree@hellion.org.uk>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Fwd: [PATCH 8/8] arm: dts: keystone: add watchdog entry
References: <1383680783-12114-9-git-send-email-ivan.khoronzhuk@ti.com>
In-Reply-To: <1383680783-12114-9-git-send-email-ivan.khoronzhuk@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add watchdog entry to keystone device tree.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/boot/dts/keystone.dts |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dts b/arch/arm/boot/dts/keystone.dts
index 100bdf5..a6e5f91 100644
--- a/arch/arm/boot/dts/keystone.dts
+++ b/arch/arm/boot/dts/keystone.dts
@@ -179,5 +179,11 @@
 			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clkspi>;
 		};
+
+		wdt: wdt@022f0080 {
+			compatible = "ti,keystone-wdt";
+			reg = <0x022f0080 0x80>;
+			clocks = <&clkwdtimer0>;
+		};
 	};
 };
-- 
1.7.9.5



