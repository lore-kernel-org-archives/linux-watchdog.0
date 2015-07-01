Return-path: <ariel@vanguardiasur.com.ar>
From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be,
	linux@roeck-us.net,
	ezequiel@vanguardiasur.com.ar,
	linux-arm-kernel@lists.infradead.org,
	manabian@gmail.com
Subject: [PATCH v2 2/2] DT: watchdog: Add NXP LPC18xx Watchdog Timer binding documentation
Date: Wed,  1 Jul 2015 17:52:10 -0300
Message-Id: <1435783930-20184-3-git-send-email-ariel@vanguardiasur.com.ar>
In-Reply-To: <1435783930-20184-1-git-send-email-ariel@vanguardiasur.com.ar>
References: <1435783930-20184-1-git-send-email-ariel@vanguardiasur.com.ar>
List-ID: <linux-watchdog@vger.kernel.org>

Add the devicetree binding document for NXP LPC18xx Watchdog Timer.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
---
 .../devicetree/bindings/watchdog/lpc18xx-wdt.txt      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt b/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
new file mode 100644
index 0000000..e7a09eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
@@ -0,0 +1,19 @@
+* NXP LPC18xx Watchdog Timer (WDT)
+
+Required properties:
+- compatible: Should be "nxp,lpc1850-wdt"
+- reg: Should contain WDT registers location and length
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Should contain "wdtclk" and "reg"; the watchdog counter
+               clock and register interface clock respectively.
+- interrupts: Should contain WDT interrupt
+
+Examples:
+
+watchdog@40080000 {
+	compatible = "nxp,lpc1850-wdt";
+	reg = <0x40080000 0x24>;
+	clocks = <&cgu BASE_SAFE_CLK>, <&ccu1 CLK_CPU_WWDT>;
+	clock-names = "wdtclk", "reg";
+	interrupts = <49>;
+};
-- 
1.9.1
