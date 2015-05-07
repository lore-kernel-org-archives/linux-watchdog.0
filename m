Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38369 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbEGNjG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 09:39:06 -0400
Received: by wiun10 with SMTP id n10so60270569wiu.1
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 06:39:05 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 09/12] MAINTAINERS: Add the LPC Clocksource to STi maintained driver list
Date: Thu,  7 May 2015 14:38:41 +0100
Message-Id: <1431005924-21777-10-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2bc71e7..af9e952 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1454,6 +1454,7 @@ S:	Maintained
 F:	arch/arm/mach-sti/
 F:	arch/arm/boot/dts/sti*
 F:	drivers/clocksource/arm_global_timer.c
+F:	drivers/clocksource/clksrc_st_lpc.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/mmc/host/sdhci-st.c
-- 
1.9.1

