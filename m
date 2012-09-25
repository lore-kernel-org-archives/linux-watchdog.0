Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38086 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab2IYKZO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 25 Sep 2012 06:25:14 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so689335eek.19
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Sep 2012 03:25:13 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v4 2/2] ARM: at91: add at91sam9_wdt driver to at91sam926x, at91sam9g45
Date: Tue, 25 Sep 2012 12:25:04 +0200
Message-Id: <1348568704-28304-3-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1348568704-28304-1-git-send-email-fabio.porcedda@gmail.com>
References: <1348568704-28304-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Enable the driver for the evk-pro3 board.

Tested on an at91sam9260 board (evk-pro3).

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 6 ++++++
 arch/arm/boot/dts/at91sam9263.dtsi | 6 ++++++
 arch/arm/boot/dts/at91sam9g45.dtsi | 6 ++++++
 arch/arm/boot/dts/evk-pro3.dts     | 4 ++++
 4 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 7c95f76..7612193 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -236,6 +236,12 @@
 					trigger-external;
 				};
 			};
+
+			watchdog@fffffd40 {
+				compatible = "atmel,at91sam9260-wdt";
+				reg = <0xfffffd40 0x10>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand@40000000 {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 195019b..d822240 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -185,6 +185,12 @@
 				interrupts = <24 4 2>;
 				status = "disabled";
 			};
+
+			watchdog@fffffd40 {
+				compatible = "atmel,at91sam9260-wdt";
+				reg = <0xfffffd40 0x10>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand@40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 63751b1..df998ab 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -242,6 +242,12 @@
 					trigger-value = <0x6>;
 				};
 			};
+
+			watchdog@fffffd40 {
+				compatible = "atmel,at91sam9260-wdt";
+				reg = <0xfffffd40 0x10>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand@40000000 {
diff --git a/arch/arm/boot/dts/evk-pro3.dts b/arch/arm/boot/dts/evk-pro3.dts
index b7354e6..ce959ee 100644
--- a/arch/arm/boot/dts/evk-pro3.dts
+++ b/arch/arm/boot/dts/evk-pro3.dts
@@ -26,6 +26,10 @@
 				atmel,vbus-gpio = <&pioC 5 0>;
 				status = "okay";
 			};
+
+			watchdog@fffffd40 {
+				status = "okay";
+			};
 		};
 
 		usb0: ohci@00500000 {
-- 
1.7.11.3

