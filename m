Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751716AbdBFSwB (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 6 Feb 2017 13:52:01 -0500
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
Subject: [PATCH v21 06/13] clocksource: arm_arch_timer: move arch_timer_needs_of_probing into DT init call
Date: Tue,  7 Feb 2017 02:50:08 +0800
Message-Id: <20170206185015.12296-7-fu.wei@linaro.org>
In-Reply-To: <20170206185015.12296-1-fu.wei@linaro.org>
References: <20170206185015.12296-1-fu.wei@linaro.org>
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
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 46 ++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 97ed103..f2b9ec4 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -887,9 +887,6 @@ static bool __init arch_timer_needs_of_probing(void)
 
 static int __init arch_timer_common_init(void)
 {
-	if (acpi_disabled && arch_timer_needs_of_probing())
-		return 0;
-
 	arch_timer_banner(arch_timers_present);
 	arch_counter_register(arch_timers_present);
 	return arch_timer_arch_init();
@@ -927,26 +924,9 @@ static enum arch_timer_ppi_nr __init arch_timer_select_ppi(void)
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
@@ -957,6 +937,8 @@ static int __init arch_timer_of_init(struct device_node *np)
 	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
+	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
+
 	/*
 	 * Try to determine the frequency from the device tree,
 	 * if fail, get the frequency from the sysreg CNTFRQ.
@@ -1001,7 +983,14 @@ static int __init arch_timer_of_init(struct device_node *np)
 	arch_counter_suspend_stop = of_property_read_bool(np,
 							 "arm,no-tick-in-suspend");
 
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
@@ -1093,7 +1082,8 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	if (ret)
 		goto out;
 
-	return arch_timer_common_init();
+	if (!arch_timer_needs_of_probing())
+		ret = arch_timer_common_init();
 out:
 	iounmap(cntctlbase);
 	of_node_put(best_frame);
@@ -1122,6 +1112,7 @@ static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
 /* Initialize per-processor generic timer */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
+	int ret;
 	struct acpi_table_gtdt *gtdt;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
@@ -1149,6 +1140,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
 		gtdt->non_secure_el2_flags);
 
+	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
+
 	/* Get the frequency from the sysreg CNTFRQ */
 	arch_timer_sysreg_freq = arch_timer_get_sysreg_freq();
 	if (!arch_timer_sysreg_freq) {
@@ -1165,8 +1158,11 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
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

