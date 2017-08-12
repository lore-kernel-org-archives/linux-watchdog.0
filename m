Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36323 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbdHLSnx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 12 Aug 2017 14:43:53 -0400
Received: by mail-lf0-f49.google.com with SMTP id o85so26909236lff.3
        for <linux-watchdog@vger.kernel.org>; Sat, 12 Aug 2017 11:43:53 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/11] ARM: dts: fix PCLK name on Gemini and MOXA ART
Date: Sat, 12 Aug 2017 20:43:17 +0200
Message-Id: <20170812184318.10144-11-linus.walleij@linaro.org>
In-Reply-To: <20170812184318.10144-1-linus.walleij@linaro.org>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

These platforms provide a clock to their watchdog, in each
case this is the peripheral clock (PCLK), so explicitly
name the clock in the device tree.

Take this opportunity to add the "faraday,ftwdt010"
compatible as fallback to the watchdog IP blocks.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini.dtsi | 3 ++-
 arch/arm/boot/dts/moxart.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index c68e8d430234..f0d178c77153 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -145,11 +145,12 @@
 		};
 
 		watchdog@41000000 {
-			compatible = "cortina,gemini-watchdog";
+			compatible = "cortina,gemini-watchdog", "faraday,ftwdt010";
 			reg = <0x41000000 0x1000>;
 			interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&syscon GEMINI_RESET_WDOG>;
 			clocks = <&syscon GEMINI_CLK_APB>;
+			clock-names = "PCLK";
 		};
 
 		uart0: serial@42000000 {
diff --git a/arch/arm/boot/dts/moxart.dtsi b/arch/arm/boot/dts/moxart.dtsi
index 1f4c795d3f72..da7b3237bfe9 100644
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -87,9 +87,10 @@
 		};
 
 		watchdog: watchdog@98500000 {
-			compatible = "moxa,moxart-watchdog";
+			compatible = "moxa,moxart-watchdog", "faraday,ftwdt010";
 			reg = <0x98500000 0x10>;
 			clocks = <&clk_apb>;
+			clock-names = "PCLK";
 		};
 
 		sdhci: sdhci@98e00000 {
-- 
2.13.4

