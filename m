Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55856 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054Ab2ISL5t (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Sep 2012 07:57:49 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so464087bkw.19
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Sep 2012 04:57:49 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH v2 2/2] ARM: at91: add at91sam9_wdt driver to at91sam9260
Date: Wed, 19 Sep 2012 13:57:41 +0200
Message-Id: <1348055861-7857-3-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1348055861-7857-1-git-send-email-fabio.porcedda@gmail.com>
References: <1348055861-7857-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Tested on an at91sam9260 board (evk-pro3)

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 66389c1..680b1c8 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -233,6 +233,12 @@
 					trigger-external;
 				};
 			};
+
+			watchdog@fffffd40 {
+				compatible = "atmel,at91sam9-wdt";
+				reg = <0xfffffd40 0x10>;
+			};
+
 		};
 
 		nand0: nand@40000000 {
-- 
1.7.11.3

