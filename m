Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:47164 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758375AbbCDOVp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Mar 2015 09:21:45 -0500
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v3 1/9] ARM: at91/dt: declare atmel,at91rm9200-st as a syscon
Date: Wed,  4 Mar 2015 15:21:29 +0100
Message-Id: <1425478897-27322-2-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The system timer register range is also used for the watchdog. Declare it as a
syscon to be able to get a regmap early enough in the boot process

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index ad319f84f560..0fbb3582ec9d 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -46,7 +46,7 @@ PIT Timer required properties:
   shared across all System Controller members.
 
 System Timer (ST) required properties:
-- compatible: Should be "atmel,at91rm9200-st"
+- compatible: Should be "atmel,at91rm9200-st", "syscon"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt for the ST which is the IRQ line
   shared across all System Controller members.
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 21c2b504f977..1b1c1ac2c4f6 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -356,7 +356,7 @@
 			};
 
 			st: timer@fffffd00 {
-				compatible = "atmel,at91rm9200-st";
+				compatible = "atmel,at91rm9200-st", "syscon";
 				reg = <0xfffffd00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 			};
-- 
2.1.0

