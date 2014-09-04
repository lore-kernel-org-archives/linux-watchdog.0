Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:47644 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbaIDOkg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Sep 2014 10:40:36 -0400
Received: by mail-yk0-f179.google.com with SMTP id 142so6052634ykq.24
        for <linux-watchdog@vger.kernel.org>; Thu, 04 Sep 2014 07:40:35 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, David Paris <david.paris@st.com>
Subject: [PATCH 1/4] ARM: STi: DT: STiH407: Add Device Tree node for LPC Watchdog
Date: Thu,  4 Sep 2014 15:39:48 +0100
Message-Id: <1409841592-18890-2-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1409841592-18890-1-git-send-email-lee.jones@linaro.org>
References: <1409841592-18890-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: David Paris <david.paris@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index f539627a..303df6c 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -259,5 +259,15 @@
 
 			status = "disabled";
 		};
+
+		watchdog@0x8787000 {
+			compatible = "st,stih407-watchdog";
+			reg = <0x8787000 0x1000>, <0x204 0x4>;
+			reg-names = "base", "syscfg-en";
+			clock-names = "st_wdog";
+			clocks = <&clk_s_d3_flexgen CLK_LPC_0>;
+			timeout-sec = <600>;
+			st,syscfg = <&syscfg_core>;
+		};
 	};
 };
-- 
1.9.1

