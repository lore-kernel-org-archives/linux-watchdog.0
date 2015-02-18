Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:46705 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbbBRLtb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Feb 2015 06:49:31 -0500
Received: by wevm14 with SMTP id m14so576696wev.13
        for <linux-watchdog@vger.kernel.org>; Wed, 18 Feb 2015 03:49:30 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com
Subject: [PATCH v3 6/8] rtc: bindings: Provide ST bindings for ST's LPC RTC device
Date: Wed, 18 Feb 2015 11:49:12 +0000
Message-Id: <1424260154-12868-7-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1424260154-12868-1-git-send-email-lee.jones@linaro.org>
References: <1424260154-12868-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On current ST platforms the LPC controls a number of functions including
Watchdog and Real Time Clock.  This patch provides the bindings used to
configure LPC in RTC mode.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/rtc/rtc-st-lpc.txt         | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt b/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
new file mode 100644
index 0000000..aaf9855
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
@@ -0,0 +1,25 @@
+STMicroelectronics Low Power Controller (LPC) - RTC
+===================================================
+
+LPC currently supports Watchdog OR Real Time Clock functionality.
+
+[See: ../watchdog/st_lpc_wdt.txt for Watchdog options]
+
+Required properties
+
+- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
+				  "st,stih415-lpc" "st,stid127-lpc"
+- reg		: LPC registers base address + size
+- interrupts    : LPC interrupt line number and associated flags
+- clocks	: Clock used by LPC device (See: ../clock/clock-bindings.txt)
+- st,lpc-mode	: The LPC can run either one of two modes ST_LPC_MODE_RTC [0] or
+		  ST_LPC_MODE_WDT [1].  One (and only one) mode must be
+		  selected.
+
+Example:
+	lpc@fde05000 {
+		compatible	= "st,stih416-lpc-watchdog";
+		reg		= <0xfde05000 0x1000>;
+		clocks 		= <&clk_s_d3_flexgen CLK_LPC_0>;
+		st,lpc-mode	= <ST_LPC_MODE_RTC>;
+	};
-- 
1.9.1

