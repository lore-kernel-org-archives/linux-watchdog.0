Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yh0-f45.google.com ([209.85.213.45]:61160 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbaLOLZ4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Dec 2014 06:25:56 -0500
Received: by mail-yh0-f45.google.com with SMTP id f10so4998674yha.18
        for <linux-watchdog@vger.kernel.org>; Mon, 15 Dec 2014 03:25:55 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/8] mfd: bindings: Provide ST bindings for ST's LPC device
Date: Mon, 15 Dec 2014 11:25:33 +0000
Message-Id: <1418642738-17407-4-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1418642738-17407-1-git-send-email-lee.jones@linaro.org>
References: <1418642738-17407-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On current ST platforms the LPC controls a number of functions including
Watchdog and Real Time Clock.  This patch provides the bindings used to
choose and configure the devices.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mfd/st-lpc.txt | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/st-lpc.txt

diff --git a/Documentation/devicetree/bindings/mfd/st-lpc.txt b/Documentation/devicetree/bindings/mfd/st-lpc.txt
new file mode 100644
index 0000000..b13f143
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st-lpc.txt
@@ -0,0 +1,36 @@
+STMicroelectronics Low Power Controller (LPC)
+=============================================
+
+Currently supports Watchdog OR Real Time Clock functionality.
+
+Required properties [common]
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
+Required properties [watchdog mode]
+
+- st,syscfg	: Phandle to syscfg node used to enable watchdog and configure
+		  CPU reset type.
+- timeout-sec	: Watchdog timeout in seconds
+
+Optional properties [watchdog mode]
+
+- st,warm-reset	: If present reset type will be 'warm' - if not it will be cold
+
+Example:
+	lpc@fde05000 {
+		compatible	= "st,stih416-lpc-watchdog";
+		reg		= <0xfde05000 0x1000>;
+		clocks 		= <&clk_s_d3_flexgen CLK_LPC_0>;
+		st,syscfg	= <&syscfg_core>;
+		timeout-sec	= <600>;
+		st,lpc-mode	= <ST_LPC_MODE_WDT>;
+		st,warm-reset;
+	};
-- 
1.9.1

