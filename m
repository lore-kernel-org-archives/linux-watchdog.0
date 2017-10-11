Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45866 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756806AbdJKCby (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Oct 2017 22:31:54 -0400
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: linux@roeck-us.net, wim@iguana.be,
        gregory.clement@free-electrons.com, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] ARM: mvebu: dts: connect interrupt for WD on armada-38x
Date: Wed, 11 Oct 2017 15:29:58 +1300
Message-Id: <20171011022958.31268-4-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
References: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog timer interrupt is available internally on the Armada-38x
SoCs. Connect it so that we can have the orion_wdt_irq generate debug
information when a watchdog timeout occurs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-38x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 7ff0811e61db..9ac76c54c9e5 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -408,6 +408,7 @@
 				reg = <0x20300 0x34>, <0x20704 0x4>, <0x18260 0x4>;
 				clocks = <&coreclk 2>, <&refclk>;
 				clock-names = "nbclk", "fixed";
+				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			cpurst: cpurst@20800 {
-- 
2.14.2

