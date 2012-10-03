Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63241 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932573Ab2JCPsT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Oct 2012 11:48:19 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so6224691bkc.19
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Oct 2012 08:48:18 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>
Cc: devicetree-discuss@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v8 3/3] ARM: at91/dts: evk-pro3: enable watchdog
Date: Wed,  3 Oct 2012 17:48:06 +0200
Message-Id: <1349279286-11261-4-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1349279286-11261-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349279286-11261-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Tested on evk-pro3.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 arch/arm/boot/dts/evk-pro3.dts | 4 ++++
 1 file changed, 4 insertions(+)

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

