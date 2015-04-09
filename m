Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34622 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511AbbDIOrx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 9 Apr 2015 10:47:53 -0400
Received: by widjs5 with SMTP id js5so56938529wid.1
        for <linux-watchdog@vger.kernel.org>; Thu, 09 Apr 2015 07:47:52 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, a.zummo@towertech.it, david.paris@st.com
Subject: [PATCH v7 7/9] rtc: bindings: Provide ST bindings for ST's LPC RTC device
Date: Thu,  9 Apr 2015 15:47:32 +0100
Message-Id: <1428590854-14095-8-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1428590854-14095-1-git-send-email-lee.jones@linaro.org>
References: <1428590854-14095-1-git-send-email-lee.jones@linaro.org>
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
index 0000000..73407f50
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
+		compatible	= "st,stih407-lpc";
+		reg		= <0xfde05000 0x1000>;
+		clocks 		= <&clk_s_d3_flexgen CLK_LPC_0>;
+		st,lpc-mode	= <ST_LPC_MODE_RTC>;
+	};
-- 
1.9.1

