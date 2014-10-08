Return-path: <lee.jones@linaro.org>
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org,
	kernel@stlinux.com,
	wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	devicetree@vger.kernel.org,
	David Paris <david.paris@st.com>
Subject: [PATCH 3/4] watchdog: st_wdt: Provide binding documentation for ST's LPC Watchdog driver
Date: Wed,  8 Oct 2014 10:33:29 +0100
Message-Id: <1412760810-23199-4-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1412760810-23199-1-git-send-email-lee.jones@linaro.org>
References: <1412760810-23199-1-git-send-email-lee.jones@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

Cc: devicetree@vger.kernel.org
Signed-off-by: David Paris <david.paris@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/watchdog/st-lpc-wdt.txt    | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/st-lpc-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/st-lpc-wdt.txt b/Documentation/devicetree/bindings/watchdog/st-lpc-wdt.txt
new file mode 100644
index 0000000..520ce90
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/st-lpc-wdt.txt
@@ -0,0 +1,30 @@
+STMicroelectronics LPC Watchdog
+===============================
+
+Required properties
+
+- compatible 	: Must be one of:
+			"st,stih407-watchdog"
+			"st,stih416-watchdog"
+			"st,stih415-watchdog"
+			"st,stid127-watchdog"
+- reg		: LPC registers base address + range
+- reg-names	: Register map "base" and "syscfg-en" are compulsory. "type" is
+		  platform dependent and not required for the STiH407
+- clock-names 	: Should be "lpc_wdt"
+- clocks	: Clock used by LPC device
+- timeout-sec	: Watchdog timeout in seconds
+- st,syscfg	: Syscfg node used to configure CPU reset type and mask
+- st,warm_reset	: If present, reset type will be 'warm'. If not, it will be cold
+
+Example:
+	watchdog@fde05000 {
+		compatible	= "st,stih416-lpc-watchdog";
+		reg		= <0xfde05000 0x1000> <0x204 0x4>;
+		reg-names	= "base", "syscfg-en"
+		clock-names	= "lpc_wdt";
+		clocks 		= <&clk_s_d3_flexgen CLK_LPC_0>;
+		timeout-sec	= <600>;
+		st,syscfg	= <&syscfg_core>;
+		st,warm_reset;
+	};
-- 
1.9.1
