Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbdARN0y (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 18 Jan 2017 08:26:54 -0500
From: fu.wei@linaro.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org,
        al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com,
        Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v20 04/17] clocksource/drivers/arm_arch_timer: Move enums and defines to header file.
Date: Wed, 18 Jan 2017 21:25:28 +0800
Message-Id: <20170118132541.8989-5-fu.wei@linaro.org>
In-Reply-To: <20170118132541.8989-1-fu.wei@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

To support the arm_arch_timer via ACPI we need to share defines and enums
between the driver and the ACPI parser code.
So we split out the relevant defines and enums into arm_arch_timer.h.

No functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 11 -----------
 include/clocksource/arm_arch_timer.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d5a1664..90b6661 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -54,8 +54,6 @@
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
-#define ARCH_TIMER_TYPE_CP15		BIT(0)
-#define ARCH_TIMER_TYPE_MEM		BIT(1)
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base;
@@ -68,15 +66,6 @@ struct arch_timer {
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
 static u32 arch_timer_rate;
-
-enum arch_timer_ppi_nr {
-	ARCH_TIMER_PHYS_SECURE_PPI,
-	ARCH_TIMER_PHYS_NONSECURE_PPI,
-	ARCH_TIMER_VIRT_PPI,
-	ARCH_TIMER_HYP_PPI,
-	ARCH_TIMER_MAX_TIMER_PPI
-};
-
 static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI];
 
 static struct clock_event_device __percpu *arch_timer_evt;
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index caedb74..b898637 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -16,9 +16,13 @@
 #ifndef __CLKSOURCE_ARM_ARCH_TIMER_H
 #define __CLKSOURCE_ARM_ARCH_TIMER_H
 
+#include <linux/bitops.h>
 #include <linux/timecounter.h>
 #include <linux/types.h>
 
+#define ARCH_TIMER_TYPE_CP15		BIT(0)
+#define ARCH_TIMER_TYPE_MEM		BIT(1)
+
 #define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
 #define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
 #define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
@@ -34,6 +38,14 @@ enum arch_timer_reg {
 	ARCH_TIMER_REG_TVAL,
 };
 
+enum arch_timer_ppi_nr {
+	ARCH_TIMER_PHYS_SECURE_PPI,
+	ARCH_TIMER_PHYS_NONSECURE_PPI,
+	ARCH_TIMER_VIRT_PPI,
+	ARCH_TIMER_HYP_PPI,
+	ARCH_TIMER_MAX_TIMER_PPI
+};
+
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
-- 
2.9.3

