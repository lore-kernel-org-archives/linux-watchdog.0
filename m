Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:17943 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752994AbdCAW4T (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 1 Mar 2017 17:56:19 -0500
From: Chris Brandt <chris.brandt@renesas.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v3 3/3] ARM: dts: r7s72100: Add watchdog timer
Date: Wed,  1 Mar 2017 17:54:55 -0500
Message-Id: <20170301225455.22818-4-chris.brandt@renesas.com>
In-Reply-To: <20170301225455.22818-1-chris.brandt@renesas.com>
References: <20170301225455.22818-1-chris.brandt@renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add watchdog timer support for RZ/A1.
For the RZ/A1, the only way to do a reset is to overflow the WDT, so this
is useful even if you don't need the watchdog functionality.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
* added Reviewed-by
v2:
* changed "renesas,r7s72100-reset" to "renesas,r7s72100-wdt"
* changed "renesas,wdt-reset" to "renesas,rza-wdt"
* added interupt property (even though it is not used)
* added clocks property
---
 arch/arm/boot/dts/r7s72100.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index ed62e19..6ecee72 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -382,6 +382,13 @@
 		cache-level = <2>;
 	};
 
+	wdt: timer@fcfe0000 {
+		compatible = "renesas,r7s72100-wdt", "renesas,rza-wdt";
+		reg = <0xfcfe0000 0x6>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&p0_clk>;
+	};
+
 	i2c0: i2c@fcfee000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.10.1


