Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47467 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab2KLIhf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Nov 2012 03:37:35 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2210724bkc.19
        for <linux-watchdog@vger.kernel.org>; Mon, 12 Nov 2012 00:37:35 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v9 RESEND 2/3] ARM: at91/dts: add at91sam9_wdt driver to at91sam926x, at91sam9g45
Date: Mon, 12 Nov 2012 09:37:26 +0100
Message-Id: <1352709447-8306-3-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1352709447-8306-1-git-send-email-fabio.porcedda@gmail.com>
References: <1352709447-8306-1-git-send-email-fabio.porcedda@gmail.com>
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
index d410581..bfb5bb6 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -246,6 +246,12 @@
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
index 3e6e5c1..ff54612 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -195,6 +195,12 @@
 				#size-cells = <0>;
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
index 3add030..a98c00a 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -262,6 +262,12 @@
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
1.8.0

