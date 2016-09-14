Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38427 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765286AbcINULj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 14 Sep 2016 16:11:39 -0400
Received: by mail-wm0-f47.google.com with SMTP id 1so52822056wmz.1
        for <linux-watchdog@vger.kernel.org>; Wed, 14 Sep 2016 13:11:39 -0700 (PDT)
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
Subject: [PATCH v13 3/8] clocksource/drivers/arm_arch_timer: Improve printk relevant code
Date: Thu, 15 Sep 2016 04:09:36 +0800
Message-Id: <1473883781-9571-4-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1473883781-9571-1-git-send-email-fu.wei@linaro.org>
References: <1473883781-9571-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patch defines pr_fmt(fmt) for all pr_* functions,
then the pr_* doesn't need to add "arch_timer:" everytime.

Also delete some Blank Spaces in arch_timer_banner,
according to the suggestion from checkpatch.pl.

No functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 53 ++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 059f7fb..7d48349 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -32,6 +32,9 @@
 
 #include <clocksource/arm_arch_timer.h>
 
+#undef pr_fmt
+#define pr_fmt(fmt) "arch_timer: " fmt
+
 #define CNTTIDR		0x08
 #define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
 
@@ -418,24 +421,24 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 
 	/* Check the timer frequency. */
 	if (arch_timer_rate == 0)
-		pr_warn("Architected timer frequency not available\n");
+		pr_warn("frequency not available\n");
 }
 
 static void arch_timer_banner(unsigned type)
 {
-	pr_info("Architected %s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
-		     type & ARCH_CP15_TIMER ? "cp15" : "",
-		     type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
-		     type & ARCH_MEM_TIMER ? "mmio" : "",
-		     (unsigned long)arch_timer_rate / 1000000,
-		     (unsigned long)(arch_timer_rate / 10000) % 100,
-		     type & ARCH_CP15_TIMER ?
-		     (arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
-			"",
-		     type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
-		     type & ARCH_MEM_TIMER ?
-			arch_timer_mem_use_virtual ? "virt" : "phys" :
-			"");
+	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
+		type & ARCH_CP15_TIMER ? "cp15" : "",
+		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
+		type & ARCH_MEM_TIMER ? "mmio" : "",
+		(unsigned long)arch_timer_rate / 1000000,
+		(unsigned long)(arch_timer_rate / 10000) % 100,
+		type & ARCH_CP15_TIMER ?
+		(arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
+		"",
+		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
+		type & ARCH_MEM_TIMER ?
+		arch_timer_mem_use_virtual ? "virt" : "phys" :
+		"");
 }
 
 u32 arch_timer_get_rate(void)
@@ -528,8 +531,7 @@ static void __init arch_counter_register(unsigned type)
 
 static void arch_timer_stop(struct clock_event_device *clk)
 {
-	pr_debug("arch_timer_teardown disable IRQ%d cpu #%d\n",
-		 clk->irq, smp_processor_id());
+	pr_debug("disable IRQ%d cpu #%d\n", clk->irq, smp_processor_id());
 
 	disable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi]);
 	if (arch_timer_has_nonsecure_ppi())
@@ -622,8 +624,7 @@ static int __init arch_timer_register(void)
 	}
 
 	if (err) {
-		pr_err("arch_timer: can't register interrupt %d (%d)\n",
-		       ppi, err);
+		pr_err("can't register interrupt %d (%d)\n", ppi, err);
 		goto out_free;
 	}
 
@@ -676,7 +677,7 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
 
 	ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &t->evt);
 	if (ret) {
-		pr_err("arch_timer: Failed to request mem timer irq\n");
+		pr_err("Failed to request mem timer irq\n");
 		kfree(t);
 	}
 
@@ -754,7 +755,7 @@ static int __init arch_timer_init(void)
 		}
 
 		if (!has_ppi) {
-			pr_warn("arch_timer: No interrupt available, giving up\n");
+			pr_warn("No interrupt available, giving up\n");
 			return -EINVAL;
 		}
 	}
@@ -777,7 +778,7 @@ static int __init arch_timer_of_init(struct device_node *np)
 	int i;
 
 	if (arch_timers_present & ARCH_CP15_TIMER) {
-		pr_warn("arch_timer: multiple nodes in dt, skipping\n");
+		pr_warn("multiple nodes in dt, skipping\n");
 		return 0;
 	}
 
@@ -812,7 +813,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	arch_timers_present |= ARCH_MEM_TIMER;
 	cntctlbase = of_iomap(np, 0);
 	if (!cntctlbase) {
-		pr_err("arch_timer: Can't find CNTCTLBase\n");
+		pr_err("Can't find CNTCTLBase\n");
 		return -ENXIO;
 	}
 
@@ -827,7 +828,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 		u32 cntacr;
 
 		if (of_property_read_u32(frame, "frame-number", &n)) {
-			pr_err("arch_timer: Missing frame-number\n");
+			pr_err("Missing frame-number\n");
 			of_node_put(frame);
 			goto out;
 		}
@@ -856,7 +857,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	ret= -ENXIO;
 	base = arch_counter_base = of_iomap(best_frame, 0);
 	if (!base) {
-		pr_err("arch_timer: Can't map frame's registers\n");
+		pr_err("Can't map frame's registers\n");
 		goto out;
 	}
 
@@ -867,7 +868,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 
 	ret = -EINVAL;
 	if (!irq) {
-		pr_err("arch_timer: Frame missing %s irq",
+		pr_err("Frame missing %s irq",
 		       arch_timer_mem_use_virtual ? "virt" : "phys");
 		goto out;
 	}
@@ -909,7 +910,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	struct acpi_table_gtdt *gtdt;
 
 	if (arch_timers_present & ARCH_CP15_TIMER) {
-		pr_warn("arch_timer: already initialized, skipping\n");
+		pr_warn("already initialized, skipping\n");
 		return -EINVAL;
 	}
 
-- 
2.7.4

