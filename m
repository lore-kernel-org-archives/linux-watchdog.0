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
Subject: [PATCH v2 03/12] clocksource: sti: Provide 'use timer as sched clock' capability
Date: Tue, 12 May 2015 13:58:11 +0100
Message-Id: <1431435500-22899-4-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clocksource/clksrc_st_lpc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clocksource/clksrc_st_lpc.c b/drivers/clocksource/clksrc_st_lpc.c
index 1ad1714..90f5bb8 100644
--- a/drivers/clocksource/clksrc_st_lpc.c
+++ b/drivers/clocksource/clksrc_st_lpc.c
@@ -16,6 +16,7 @@
 #include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/of_address.h>
+#include <linux/sched_clock.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/mfd/st-lpc.h>
@@ -38,6 +39,11 @@ static void st_clksrc_reset(void)
 	writel_relaxed(1, ddata.base + LPC_LPT_START_OFF);
 }
 
+static u64 notrace st_clksrc_sched_clock_read(void)
+{
+	return (u64)readl_relaxed(ddata.base + LPC_LPT_LSB_OFF);
+}
+
 static int __init st_clksrc_init(void)
 {
 	unsigned long rate;
@@ -47,6 +53,8 @@ static int __init st_clksrc_init(void)
 
 	rate = clk_get_rate(ddata.clk);
 
+	sched_clock_register(st_clksrc_sched_clock_read, 32, rate);
+
 	ret = clocksource_mmio_init(ddata.base + LPC_LPT_LSB_OFF,
 				    "clksrc-st-lpc", rate, 300, 32,
 				    clocksource_mmio_readl_up);
-- 
1.9.1
