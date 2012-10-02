Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47742 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab2JBQBM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Oct 2012 12:01:12 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so5605450bkc.19
        for <linux-watchdog@vger.kernel.org>; Tue, 02 Oct 2012 09:01:11 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v7 3/3] ARM: at91/dts: evk-pro3: enable watchdog
Date: Tue,  2 Oct 2012 18:01:02 +0200
Message-Id: <1349193662-23482-4-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1349193662-23482-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349193662-23482-1-git-send-email-fabio.porcedda@gmail.com>
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

