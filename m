Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56154 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446Ab2JAMYz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 1 Oct 2012 08:24:55 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so4894647bkc.19
        for <linux-watchdog@vger.kernel.org>; Mon, 01 Oct 2012 05:24:55 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v6 4/5] ARM: at91/dts: add at91sam9_wdt driver to at91sam926x, at91sam9g45
Date: Mon,  1 Oct 2012 14:24:40 +0200
Message-Id: <1349094281-28889-5-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Tested on an at91sam9260 board (evk-pro3).

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 6 ++++++
 arch/arm/boot/dts/at91sam9263.dtsi | 6 ++++++
 arch/arm/boot/dts/at91sam9g45.dtsi | 6 ++++++
 3 files changed, 18 insertions(+)

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
-- 
1.7.11.3

