Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:38700 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961Ab3FRPW1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 11:22:27 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so4081390pab.25
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 08:22:26 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wim@iguana.be
Cc: marc.zyngier@arm.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 13/14] watchdog/mpcore_wdt: Start registers from 0x00 instead of 0x20
Date: Tue, 18 Jun 2013 20:50:37 +0530
Message-Id: <79fc271d14f67b4787270cee02befa7597d96cb0.1371535243.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

TWD_WDOG is at offset 0x20 from TWD base address. Current register offsets
contain this extra 0x20 offset, i.e. users were required to pass base address of
TWD instead of WDOG to WDOG driver.

Change this, so that users can pass base address of WDOG to WDOG driver instead
of TWD module. For this, subtract 0x20 from offsets of WDOG registers.

This could break any current users of TWD_WDOG, but i couldn't find any users of
this driver in current Linux tree. So, haven't fixed any platform code. If some
platforms are broken please report to me, so that we can get them fixed in this
patch only.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/include/asm/smp_twd.h | 19 -------------------
 drivers/watchdog/mpcore_wdt.c  | 24 +++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index a9791c5..c5d81a9 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -6,30 +6,11 @@
 #define TWD_TIMER_CONTROL		0x08
 #define TWD_TIMER_INTSTAT		0x0C
 
-#define TWD_WDOG_LOAD			0x20
-#define TWD_WDOG_COUNTER		0x24
-#define TWD_WDOG_CONTROL		0x28
-#define TWD_WDOG_INTSTAT		0x2C
-#define TWD_WDOG_RESETSTAT		0x30
-#define TWD_WDOG_DISABLE		0x34
-
-#define TWD_WDOG_LOAD_MIN		0x00000000
-#define TWD_WDOG_LOAD_MAX		0xFFFFFFFF
-
 #define TWD_TIMER_CONTROL_ENABLE	(1 << 0)
 #define TWD_TIMER_CONTROL_ONESHOT	(0 << 1)
 #define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
-#define TWD_WDOG_CONTROL_ENABLE		(1 << 0)
-#define TWD_WDOG_CONTROL_IRQ_ENABLE	(1 << 2)
-#define TWD_WDOG_CONTROL_WDT_MODE	(1 << 3)
-#define TWD_WDOG_CONTROL_WDT_PRESCALE(x)	((x) << 8)
-#define TWD_WDOG_CONTROL_PRESCALE_MIN	0x00
-#define TWD_WDOG_CONTROL_PRESCALE_MAX	0xFF
-
-#define TWD_WDOG_RESETSTAT_MASK		0x1
-
 #include <linux/ioport.h>
 
 struct twd_local_timer {
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 64878a7..d7ee4eb 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -34,7 +34,29 @@
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
-#include <asm/smp_twd.h>
+/*
+ * TWD_WDOG is at offset 0x20 from TWD base address. Following register offsets
+ * doesn't contain this extra 0x20 offset, i.e. users of TWD_WDOG must pass base
+ * address of WDOG to WDOG driver instead of TWD module.
+ */
+#define TWD_WDOG_LOAD				0x00
+#define TWD_WDOG_COUNTER			0x04
+#define TWD_WDOG_CONTROL			0x08
+#define TWD_WDOG_INTSTAT			0x0C
+#define TWD_WDOG_RESETSTAT			0x10
+#define TWD_WDOG_DISABLE			0x14
+
+#define TWD_WDOG_LOAD_MIN			0x00000000
+#define TWD_WDOG_LOAD_MAX			0xFFFFFFFF
+
+#define TWD_WDOG_CONTROL_ENABLE			(1 << 0)
+#define TWD_WDOG_CONTROL_IRQ_ENABLE		(1 << 2)
+#define TWD_WDOG_CONTROL_WDT_MODE		(1 << 3)
+#define TWD_WDOG_CONTROL_WDT_PRESCALE(x)	((x) << 8)
+#define TWD_WDOG_CONTROL_PRESCALE_MIN		0x00
+#define TWD_WDOG_CONTROL_PRESCALE_MAX		0xFF
+
+#define TWD_WDOG_RESETSTAT_MASK			0x1
 
 struct mpcore_wdt {
 	struct watchdog_device wdd;
-- 
1.7.12.rc2.18.g61b472e

