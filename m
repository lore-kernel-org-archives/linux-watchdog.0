Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:36596 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbbFZSY6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Jun 2015 14:24:58 -0400
Received: by qczu9 with SMTP id u9so5246611qcz.3
        for <linux-watchdog@vger.kernel.org>; Fri, 26 Jun 2015 11:24:57 -0700 (PDT)
From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, linux@roeck-us.net, ezequiel@vanguardiasur.com.ar,
	Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: [PATCH 2/2] DT: watchdog: Add NXP LPC18XX Watchdog Timer binding documentation
Date: Fri, 26 Jun 2015 15:24:32 -0300
Message-Id: <1435343072-8753-3-git-send-email-ariel@vanguardiasur.com.ar>
In-Reply-To: <1435343072-8753-1-git-send-email-ariel@vanguardiasur.com.ar>
References: <1435343072-8753-1-git-send-email-ariel@vanguardiasur.com.ar>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add the devicetree binding document for NXP LPC18XX Watchdog Timer.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
---
 .../devicetree/bindings/watchdog/lpc18xx-wdt.txt      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt b/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
new file mode 100644
index 0000000..12f1861
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
@@ -0,0 +1,19 @@
+* NXP LPC18xx Windowed Watchdog timer (WWDT)
+
+Required properties:
+- compatible: Should be "nxp,lpc18xx-wdt"
+- reg: Should contain WDT registers location and length
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Should contain "wdt" and "sys"; the watchdog counter
+               clock and register interface clock respectively.
+- interrupts: Should contain WDT interrupt
+
+Examples:
+
+watchdog@40080000 {
+	compatible = "nxp,lpc18xx-wdt";
+	reg = <0x40080000 0x24>;
+	clocks = <&xtal>, <&pll1>;
+	clock-names = "wdt", "sys";
+	interrupts = <49>;
+};
-- 
1.9.1

