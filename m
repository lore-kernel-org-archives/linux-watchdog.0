Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40590 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753304AbbCLMIM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 12 Mar 2015 08:08:12 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v5 01/10] ARM: at91/dt: declare atmel,at91rm9200-st as a syscon
Date: Thu, 12 Mar 2015 13:07:25 +0100
Message-Id: <1426162054-9987-2-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The system timer register range is used to handle three different
functionalities: Periodic Interval Timer, Real Time Timer and watchdog. Declare
it as a syscon to be able to get a regmap.
Also declare it as a simple-mfd and its watchdog subnode.

Finally, document the watchdog compatible string.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

fixup! ARM: at91/dt: declare atmel,at91rm9200-st as a syscon
---
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 4 +++-
 arch/arm/boot/dts/at91rm9200.dtsi                    | 6 +++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index ad319f84f560..2e99b5b57350 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -46,10 +46,12 @@ PIT Timer required properties:
   shared across all System Controller members.
 
 System Timer (ST) required properties:
-- compatible: Should be "atmel,at91rm9200-st"
+- compatible: Should be "atmel,at91rm9200-st", "syscon", "simple-mfd"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt for the ST which is the IRQ line
   shared across all System Controller members.
+Its subnodes can be:
+- watchdog: compatible should be "atmel,at91rm9200-wdt"
 
 TC/TCLIB Timer required properties:
 - compatible: Should be "atmel,<chip>-tcb".
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 21c2b504f977..b777d21b8a7c 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -356,9 +356,13 @@
 			};
 
 			st: timer@fffffd00 {
-				compatible = "atmel,at91rm9200-st";
+				compatible = "atmel,at91rm9200-st", "syscon", "simple-mfd";
 				reg = <0xfffffd00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+
+				watchdog {
+					compatible = "atmel,at91rm9200-wdt";
+				};
 			};
 
 			rtc: rtc@fffffe00 {
-- 
2.1.0

