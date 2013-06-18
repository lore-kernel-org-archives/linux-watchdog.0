Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:49727 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab3FRPWH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 11:22:07 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so4012401pdc.33
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 08:22:06 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wim@iguana.be
Cc: marc.zyngier@arm.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 10/14] watchdog/mpcore_wdt: Add support for WDIOC_GETBOOTSTATUS IOCTL
Date: Tue, 18 Jun 2013 20:50:34 +0530
Message-Id: <80203f4eb36a430fafe91ac90102fd932987ad49.1371535243.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

mpcore watchdog can give last boot status, whether we got a watchdog reset or
not, via bit 0 of TWD_WDOG_RESETSTAT register. This patch adds support to return
correct status if WDIOC_GETBOOTSTATUS cmd is called with ioctl.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/include/asm/smp_twd.h | 2 ++
 drivers/watchdog/mpcore_wdt.c  | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index 7b2899c..a62bcfa 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -18,6 +18,8 @@
 #define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
+#define TWD_WDOG_RESETSTAT_MASK		0x1
+
 #include <linux/ioport.h>
 
 struct twd_local_timer {
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index d8917ad..43f749d 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -151,6 +151,7 @@ static int mpcore_wdt_set_heartbeat(struct watchdog_device *wdd, unsigned int t)
 static const struct watchdog_info mpcore_wdt_info = {
 	.options		= WDIOF_SETTIMEOUT |
 				  WDIOF_KEEPALIVEPING |
+				  WDIOF_CARDRESET |
 				  WDIOF_MAGICCLOSE,
 	.identity		= "MPcore Watchdog",
 };
@@ -216,6 +217,9 @@ static int mpcore_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wdt);
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 
+	wdt->wdd.bootstatus = (readl_relaxed(wdt->base + TWD_WDOG_RESETSTAT) &
+			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
+
 	mpcore_wdt_stop(&wdt->wdd);
 
 	ret = watchdog_register_device(&wdt->wdd);
-- 
1.7.12.rc2.18.g61b472e

