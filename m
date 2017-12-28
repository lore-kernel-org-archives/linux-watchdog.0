Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:50794 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdL1QjQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 28 Dec 2017 11:39:16 -0500
From: Paul Cercueil <paul@crapouillou.net>
To: Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/7] MIPS: jz4740: dts: Add bindings for the jz4740-wdt driver
Date: Thu, 28 Dec 2017 17:29:36 +0100
Message-Id: <20171228162939.3928-5-paul@crapouillou.net>
In-Reply-To: <20171228162939.3928-1-paul@crapouillou.net>
References: <20171228162939.3928-1-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Also remove the watchdog platform_device from platform.c, since it
wasn't used anywhere anyway.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi |  8 ++++++++
 arch/mips/jz4740/platform.c            | 16 ----------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index cd5185bb90ae..26c6b561d6f7 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -45,6 +45,14 @@
 		#clock-cells = <1>;
 	};
 
+	watchdog: watchdog@10002000 {
+		compatible = "ingenic,jz4740-watchdog";
+		reg = <0x10002000 0x10>;
+
+		clocks = <&cgu JZ4740_CLK_RTC>;
+		clock-names = "rtc";
+	};
+
 	rtc_dev: rtc@10003000 {
 		compatible = "ingenic,jz4740-rtc";
 		reg = <0x10003000 0x40>;
diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index 5b7cdd67a9d9..cbc5f8e87230 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -233,22 +233,6 @@ struct platform_device jz4740_adc_device = {
 	.resource	= jz4740_adc_resources,
 };
 
-/* Watchdog */
-static struct resource jz4740_wdt_resources[] = {
-	{
-		.start = JZ4740_WDT_BASE_ADDR,
-		.end   = JZ4740_WDT_BASE_ADDR + 0x10 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device jz4740_wdt_device = {
-	.name	       = "jz4740-wdt",
-	.id	       = -1,
-	.num_resources = ARRAY_SIZE(jz4740_wdt_resources),
-	.resource      = jz4740_wdt_resources,
-};
-
 /* PWM */
 struct platform_device jz4740_pwm_device = {
 	.name = "jz4740-pwm",
-- 
2.11.0

