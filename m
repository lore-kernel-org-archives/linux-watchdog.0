Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33040 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752894AbcI1SS3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Sep 2016 14:18:29 -0400
Received: by mail-pf0-f179.google.com with SMTP id 21so19920688pfy.0
        for <linux-watchdog@vger.kernel.org>; Wed, 28 Sep 2016 11:18:29 -0700 (PDT)
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
Subject: [PATCH v14 1/9] clocksource/drivers/arm_arch_timer: Move enums and defines to header file
Date: Thu, 29 Sep 2016 02:17:09 +0800
Message-Id: <1475086637-1914-2-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

To support the arm_arch_timer via ACPI we need to share defines and enums
between the driver and the ACPI parser code.

Split out the relevant defines and enums into arm_arch_timer.h.
No functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 11 -----------
 include/clocksource/arm_arch_timer.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5770054..aea6c10 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -51,8 +51,6 @@
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
-#define ARCH_CP15_TIMER	BIT(0)
-#define ARCH_MEM_TIMER	BIT(1)
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base;
@@ -65,15 +63,6 @@ struct arch_timer {
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
 static u32 arch_timer_rate;
-
-enum ppi_nr {
-	PHYS_SECURE_PPI,
-	PHYS_NONSECURE_PPI,
-	VIRT_PPI,
-	HYP_PPI,
-	MAX_TIMER_PPI
-};
-
 static int arch_timer_ppi[MAX_TIMER_PPI];
 
 static struct clock_event_device __percpu *arch_timer_evt;
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index caedb74..6f06481 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -19,6 +19,9 @@
 #include <linux/timecounter.h>
 #include <linux/types.h>
 
+#define ARCH_CP15_TIMER			BIT(0)
+#define ARCH_MEM_TIMER			BIT(1)
+
 #define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
 #define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
 #define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
@@ -34,6 +37,14 @@ enum arch_timer_reg {
 	ARCH_TIMER_REG_TVAL,
 };
 
+enum ppi_nr {
+	PHYS_SECURE_PPI,
+	PHYS_NONSECURE_PPI,
+	VIRT_PPI,
+	HYP_PPI,
+	MAX_TIMER_PPI
+};
+
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
-- 
2.7.4

