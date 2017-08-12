Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33650 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbdHLSn4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 12 Aug 2017 14:43:56 -0400
Received: by mail-lf0-f52.google.com with SMTP id d17so27047316lfe.0
        for <linux-watchdog@vger.kernel.org>; Sat, 12 Aug 2017 11:43:55 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 11/11] ARM: dts: Add PCLK to the Aspeed watchdogs
Date: Sat, 12 Aug 2017 20:43:18 +0200
Message-Id: <20170812184318.10144-12-linus.walleij@linaro.org>
In-Reply-To: <20170812184318.10144-1-linus.walleij@linaro.org>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This adds the PCLK clock to the Aspeed watchdog blocks.
I am not directly familiar with the Aspeed clocking, but
since the IP is derived from Faraday FTWDT010 it probably
has the ability to run the watchdog on the PCLK if
desired so to obtain the frequency from it, it needs to
be present in the device tree, and for completeness the
PCLK should also be referenced and enabled anyways.

Take this opportunity to add the "faraday,ftwdt010"
compatible as fallback to the watchdog IP blocks.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi |  7 +++++--
 arch/arm/boot/dts/aspeed-g5.dtsi | 12 +++++++++---
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 8a04c7e2d818..23b100383c15 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -895,16 +895,19 @@
 			};
 
 			wdt1: wdt@1e785000 {
-				compatible = "aspeed,ast2400-wdt";
+				compatible = "aspeed,ast2400-wdt", "faraday,ftwdt010";
 				reg = <0x1e785000 0x1c>;
 				interrupts = <27>;
+				clocks = <&clk_apb>;
+				clock-names = "PCLK";
 			};
 
 			wdt2: wdt@1e785020 {
-				compatible = "aspeed,ast2400-wdt";
+				compatible = "aspeed,ast2400-wdt", "faraday,ftwdt010";
 				reg = <0x1e785020 0x1c>;
 				interrupts = <27>;
 				clocks = <&clk_apb>;
+				clock-names = "PCLK";
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 9cffe347b828..2322d72cd8a9 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -1003,21 +1003,27 @@
 
 
 			wdt1: wdt@1e785000 {
-				compatible = "aspeed,ast2500-wdt";
+				compatible = "aspeed,ast2500-wdt", "faraday,ftwdt010";
 				reg = <0x1e785000 0x20>;
 				interrupts = <27>;
+				clocks = <&clk_apb>;
+				clock-names = "PCLK";
 			};
 
 			wdt2: wdt@1e785020 {
-				compatible = "aspeed,ast2500-wdt";
+				compatible = "aspeed,ast2500-wdt", "faraday,ftwdt010";
 				reg = <0x1e785020 0x20>;
 				interrupts = <27>;
+				clocks = <&clk_apb>;
+				clock-names = "PCLK";
 				status = "disabled";
 			};
 
 			wdt3: wdt@1e785040 {
-				compatible = "aspeed,ast2500-wdt";
+				compatible = "aspeed,ast2500-wdt", "faraday,ftwdt010";
 				reg = <0x1e785040 0x20>;
+				clocks = <&clk_apb>;
+				clock-names = "PCLK";
 				status = "disabled";
 			};
 
-- 
2.13.4

