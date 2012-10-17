Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:32928 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab2JQMdX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Oct 2012 08:33:23 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1799284eaa.19
        for <linux-watchdog@vger.kernel.org>; Wed, 17 Oct 2012 05:33:23 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v9 3/3] ARM: at91/dts: evk-pro3: enable watchdog
Date: Wed, 17 Oct 2012 14:33:14 +0200
Message-Id: <1350477194-16802-4-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1350477194-16802-1-git-send-email-fabio.porcedda@gmail.com>
References: <1350477194-16802-1-git-send-email-fabio.porcedda@gmail.com>
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

