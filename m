Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35699 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbbGOAvn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 14 Jul 2015 20:51:43 -0400
Received: by qget71 with SMTP id t71so11911489qge.2
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Jul 2015 17:51:43 -0700 (PDT)
From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, linux@roeck-us.net, ezequiel@vanguardiasur.com.ar,
	linux-arm-kernel@lists.infradead.org, manabian@gmail.com,
	Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: [PATCH v3 2/2] DT: watchdog: Add NXP LPC18xx Watchdog Timer binding documentation
Date: Tue, 14 Jul 2015 21:50:45 -0300
Message-Id: <1436921445-11138-3-git-send-email-ariel@vanguardiasur.com.ar>
In-Reply-To: <1436921445-11138-1-git-send-email-ariel@vanguardiasur.com.ar>
References: <1436921445-11138-1-git-send-email-ariel@vanguardiasur.com.ar>
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

