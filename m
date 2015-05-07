Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38414 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbbEGNjI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 09:39:08 -0400
Received: by wiun10 with SMTP id n10so60271665wiu.1
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 06:39:07 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 10/12] ARM: STi: DT: STih407: Switch LPC mode from RTC to Clocksource
Date: Thu,  7 May 2015 14:38:42 +0100
Message-Id: <1431005924-21777-11-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This aligns with the internal configuration.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 2b2315d..bf1c7f5 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -354,7 +354,7 @@
 			reg = <0x8788000 0x1000>;
 			interrupts = <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clk_s_d3_flexgen CLK_LPC_1>;
-			st,lpc-mode = <ST_LPC_MODE_RTC>;
+			st,lpc-mode = <ST_LPC_MODE_CLKSRC>;
 		};
 	};
 };
-- 
1.9.1

