Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753098AbcLHRfK (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 8 Dec 2016 12:35:10 -0500
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
Subject: [PATCH v18 08/15] clocksource/drivers/arm_arch_timer: move arch_timer_needs_of_probing into DT init call
Date: Fri,  9 Dec 2016 01:33:12 +0800
Message-Id: <20161208173319.6618-9-fu.wei@linaro.org>
In-Reply-To: <20161208173319.6618-1-fu.wei@linaro.org>
References: <20161208173319.6618-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

Because arch_timer_needs_of_probing is only for booting with device-tree,
but arch_timer_common_init is a generic init call which shouldn't include
the FW-specific code. It's better to put arch_timer_needs_of_probing into
DT init function.

But for per-cpu timer, the arch_timer_common_init is called from
arch_timer_init. For reaching the goal above, this patch disassemble
arch_timer_init and use arch_timer_register and arch_timer_common_init
directly, just like arch_timer_mem init code is doing.
By this way, all the DT relevant code are only called from DT init call.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 46 ++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 2c9085a..8c813da 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -821,9 +821,6 @@ static bool __init arch_timer_needs_of_probing(void)
 
 static int __init arch_timer_common_init(void)
 {
-	if (acpi_disabled && arch_timer_needs_of_probing())
-		return 0;
-
 	arch_timer_banner(arch_timers_present);
 	arch_counter_register(arch_timers_present);
 	return arch_timer_arch_init();
@@ -861,26 +858,9 @@ static enum arch_timer_ppi_nr __init arch_timer_select_ppi(void)
 	return ARCH_TIMER_PHYS_SECURE_PPI;
 }
 
-static int __init arch_timer_init(void)
-{
-	int ret;
-
-	ret = arch_timer_register();
-	if (ret)
-		return ret;
-
-	ret = arch_timer_common_init();
-	if (ret)
-		return ret;
-
-	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
-
-	return 0;
-}
-
 static int __init arch_timer_of_init(struct device_node *np)
 {
-	int i;
+	int i, ret;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("multiple nodes in dt, skipping\n");
@@ -891,6 +871,8 @@ static int __init arch_timer_of_init(struct device_node *np)
 	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
+	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
+
 	if (!arch_timer_rate &&
 	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
 		arch_timer_detect_rate();
@@ -921,7 +903,14 @@ static int __init arch_timer_of_init(struct device_node *np)
 		return -EINVAL;
 	}
 
-	return arch_timer_init();
+	ret = arch_timer_register();
+	if (ret)
+		return ret;
+
+	if (arch_timer_needs_of_probing())
+		return 0;
+
+	return arch_timer_common_init();
 }
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
 CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
@@ -1008,7 +997,8 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	if (ret)
 		goto out;
 
-	return arch_timer_common_init();
+	if (!arch_timer_needs_of_probing())
+		ret = arch_timer_common_init();
 out:
 	iounmap(cntctlbase);
 	of_node_put(best_frame);
@@ -1037,6 +1027,7 @@ static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
 /* Initialize per-processor generic timer */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
+	int ret;
 	struct acpi_table_gtdt *gtdt;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
@@ -1064,6 +1055,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
 		gtdt->non_secure_el2_flags);
 
+	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
+
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate();
 
@@ -1076,8 +1069,11 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	/* Always-on capability */
 	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
 
-	arch_timer_init();
-	return 0;
+	ret = arch_timer_register();
+	if (ret)
+		return ret;
+
+	return arch_timer_common_init();
 }
 CLOCKSOURCE_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
 #endif
-- 
2.9.3

