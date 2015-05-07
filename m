Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37802 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbbEGNi4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 09:38:56 -0400
Received: by widdi4 with SMTP id di4so60284958wid.0
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 06:38:55 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 03/12] clocksource: sti: Provide 'use timer as sched clock' capability
Date: Thu,  7 May 2015 14:38:35 +0100
Message-Id: <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clocksource/Kconfig         |  8 ++++++++
 drivers/clocksource/clksrc_st_lpc.c | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index ac424cf..218daf8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -258,4 +258,12 @@ config CLKSRC_ST_LPC
 	help
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
+
+config CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
+	bool
+	depends on CLKSRC_ST_LPC
+	default y
+	help
+	  Use Low Power controller timer clock source as sched_clock
+
 endmenu
diff --git a/drivers/clocksource/clksrc_st_lpc.c b/drivers/clocksource/clksrc_st_lpc.c
index 18a7dcd0..3d92b26 100644
--- a/drivers/clocksource/clksrc_st_lpc.c
+++ b/drivers/clocksource/clksrc_st_lpc.c
@@ -16,6 +16,7 @@
 #include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/of_address.h>
+#include <linux/sched_clock.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/mfd/st-lpc.h>
@@ -38,6 +39,13 @@ static void st_clksrc_reset(void)
 	writel_relaxed(1, ddata.base + LPC_LPT_START_OFF);
 }
 
+#ifdef CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
+static u64 notrace st_clksrc_sched_clock_read(void)
+{
+	return (u64)readl_relaxed(ddata.base + LPC_LPT_LSB_OFF);
+}
+#endif
+
 static int __init st_clksrc_init(void)
 {
 	unsigned long rate;
@@ -47,6 +55,9 @@ static int __init st_clksrc_init(void)
 
 	rate = clk_get_rate(ddata.clk);
 
+#ifdef CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
+	sched_clock_register(st_clksrc_sched_clock_read, 32, rate);
+#endif
 	ret = clocksource_mmio_init(ddata.base + LPC_LPT_LSB_OFF,
 				    "clksrc-st-lpc", rate, 300, 32,
 				    clocksource_mmio_readl_up);
-- 
1.9.1

