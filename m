Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36660 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbbHASiD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 1 Aug 2015 14:38:03 -0400
Received: by qgeh16 with SMTP id h16so65728361qge.3
        for <linux-watchdog@vger.kernel.org>; Sat, 01 Aug 2015 11:38:01 -0700 (PDT)
From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, linux@roeck-us.net, ezequiel@vanguardiasur.com.ar,
	linux-arm-kernel@lists.infradead.org, manabian@gmail.com,
	Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: [PATCH v5 2/2] DT: watchdog: Add NXP LPC18xx Watchdog Timer binding documentation
Date: Sat,  1 Aug 2015 15:37:17 -0300
Message-Id: <1438454237-22043-3-git-send-email-ariel@vanguardiasur.com.ar>
In-Reply-To: <1438454237-22043-1-git-send-email-ariel@vanguardiasur.com.ar>
References: <1438454237-22043-1-git-send-email-ariel@vanguardiasur.com.ar>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add the devicetree binding document for NXP LPC18xx Watchdog Timer.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
---
 .../devicetree/bindings/watchdog/lpc18xx-wdt.txt      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt b/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
new file mode 100644
index 0000000..09f6b24
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
@@ -0,0 +1,19 @@
+* NXP LPC18xx Watchdog Timer (WDT)
+
+Required properties:
+- compatible: Should be "nxp,lpc1850-wwdt"
+- reg: Should contain WDT registers location and length
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Should contain "wdtclk" and "reg"; the watchdog counter
+               clock and register interface clock respectively.
+- interrupts: Should contain WDT interrupt
+
+Examples:
+
+watchdog@40080000 {
+	compatible = "nxp,lpc1850-wwdt";
+	reg = <0x40080000 0x24>;
+	clocks = <&cgu BASE_SAFE_CLK>, <&ccu1 CLK_CPU_WWDT>;
+	clock-names = "wdtclk", "reg";
+	interrupts = <49>;
+};
-- 
1.9.1

