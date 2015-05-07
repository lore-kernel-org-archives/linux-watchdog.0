Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33572 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbbEGNix (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 09:38:53 -0400
Received: by wgin8 with SMTP id n8so43887623wgi.0
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 06:38:52 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 01/12] mfd: dt-bindings: Provide human readable define for Clocksource mode
Date: Thu,  7 May 2015 14:38:33 +0100
Message-Id: <1431005924-21777-2-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

ST's Low Power Controller can now operate in three supported modes;
Watchdog, Real Time Clock and most recently as a Clocksource.  This new
define will allow the LPC IP to be configured for Clocksource from DT.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/dt-bindings/mfd/st-lpc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/mfd/st-lpc.h b/include/dt-bindings/mfd/st-lpc.h
index e3e6c75..d05894a 100644
--- a/include/dt-bindings/mfd/st-lpc.h
+++ b/include/dt-bindings/mfd/st-lpc.h
@@ -11,5 +11,6 @@
 
 #define ST_LPC_MODE_RTC		0
 #define ST_LPC_MODE_WDT		1
+#define ST_LPC_MODE_CLKSRC	2
 
 #endif /* __DT_BINDINGS_ST_LPC_H__ */
-- 
1.9.1

