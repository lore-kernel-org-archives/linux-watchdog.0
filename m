Return-path: <lee.jones@linaro.org>
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	wim@iguana.be,
	a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux@roeck-us.net
Cc: kernel@stlinux.com,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 08/12] rtc: bindings: Supply knowledge of a third supported device - clocksource
Date: Tue, 12 May 2015 13:58:16 +0100
Message-Id: <1431435500-22899-9-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt b/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
index 73407f50..daf8826 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
@@ -1,20 +1,23 @@
 STMicroelectronics Low Power Controller (LPC) - RTC
 ===================================================
 
-LPC currently supports Watchdog OR Real Time Clock functionality.
+LPC currently supports Watchdog OR Real Time Clock OR Clocksource
+functionality.
 
 [See: ../watchdog/st_lpc_wdt.txt for Watchdog options]
+[See: ../timer/st,stih407-lpc for Clocksource options]
 
 Required properties
 
-- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
-				  "st,stih415-lpc" "st,stid127-lpc"
+- compatible 	: Must be: "st,stih407-lpc"
 - reg		: LPC registers base address + size
 - interrupts    : LPC interrupt line number and associated flags
 - clocks	: Clock used by LPC device (See: ../clock/clock-bindings.txt)
-- st,lpc-mode	: The LPC can run either one of two modes ST_LPC_MODE_RTC [0] or
-		  ST_LPC_MODE_WDT [1].  One (and only one) mode must be
-		  selected.
+- st,lpc-mode	: The LPC can run either one of three modes:
+                  ST_LPC_MODE_RTC    [0]
+                  ST_LPC_MODE_WDT    [1]
+                  ST_LPC_MODE_CLKSRC [2]
+		 One (and only one) mode must be selected.
 
 Example:
 	lpc@fde05000 {
-- 
1.9.1
