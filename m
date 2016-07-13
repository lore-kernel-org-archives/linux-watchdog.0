Return-path: <fu.wei@linaro.org>
From: fu.wei@linaro.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org,
        jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, davem@davemloft.net,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        kvalo@codeaurora.org, mchehab@kernel.org, jslaby@suse.cz,
        christoffer.dall@linaro.org, julien.grall@arm.com,
        Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v7 1/9] clocksource/drivers/arm_arch_timer: Move enums and defines to header file
Date: Thu, 14 Jul 2016 01:53:14 +0800
Message-Id: <1468432402-4872-2-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

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
index 4814446..5d7272e 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -48,8 +48,6 @@
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
-#define ARCH_CP15_TIMER	BIT(0)
-#define ARCH_MEM_TIMER	BIT(1)
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base;
@@ -62,15 +60,6 @@ struct arch_timer {
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
2.5.5
