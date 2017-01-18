Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbdARN0i (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 18 Jan 2017 08:26:38 -0500
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
Subject: [PATCH v20 03/17] clocksource/drivers/arm_arch_timer: Rename the PPI enum and its values.
Date: Wed, 18 Jan 2017 21:25:27 +0800
Message-Id: <20170118132541.8989-4-fu.wei@linaro.org>
In-Reply-To: <20170118132541.8989-1-fu.wei@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

Rename the PPI enum and its values to unify the format of enum in
arm_arch_timer.c, also update all the users of this enum.

No functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 84 ++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 36998db..d5a1664 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -69,19 +69,19 @@ struct arch_timer {
 
 static u32 arch_timer_rate;
 
-enum ppi_nr {
-	PHYS_SECURE_PPI,
-	PHYS_NONSECURE_PPI,
-	VIRT_PPI,
-	HYP_PPI,
-	MAX_TIMER_PPI
+enum arch_timer_ppi_nr {
+	ARCH_TIMER_PHYS_SECURE_PPI,
+	ARCH_TIMER_PHYS_NONSECURE_PPI,
+	ARCH_TIMER_VIRT_PPI,
+	ARCH_TIMER_HYP_PPI,
+	ARCH_TIMER_MAX_TIMER_PPI
 };
 
-static int arch_timer_ppi[MAX_TIMER_PPI];
+static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI];
 
 static struct clock_event_device __percpu *arch_timer_evt;
 
-static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
+static enum arch_timer_ppi_nr arch_timer_uses_ppi = ARCH_TIMER_VIRT_PPI;
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
 static bool arch_counter_suspend_stop;
@@ -352,7 +352,7 @@ static void fsl_a008585_set_sne(struct clock_event_device *clk)
 	if (!static_branch_unlikely(&arch_timer_read_ool_enabled))
 		return;
 
-	if (arch_timer_uses_ppi == VIRT_PPI)
+	if (arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI)
 		clk->set_next_event = fsl_a008585_set_next_event_virt;
 	else
 		clk->set_next_event = fsl_a008585_set_next_event_phys;
@@ -372,14 +372,14 @@ static void __arch_timer_setup(unsigned type,
 		clk->cpumask = cpumask_of(smp_processor_id());
 		clk->irq = arch_timer_ppi[arch_timer_uses_ppi];
 		switch (arch_timer_uses_ppi) {
-		case VIRT_PPI:
+		case ARCH_TIMER_VIRT_PPI:
 			clk->set_state_shutdown = arch_timer_shutdown_virt;
 			clk->set_state_oneshot_stopped = arch_timer_shutdown_virt;
 			clk->set_next_event = arch_timer_set_next_event_virt;
 			break;
-		case PHYS_SECURE_PPI:
-		case PHYS_NONSECURE_PPI:
-		case HYP_PPI:
+		case ARCH_TIMER_PHYS_SECURE_PPI:
+		case ARCH_TIMER_PHYS_NONSECURE_PPI:
+		case ARCH_TIMER_HYP_PPI:
 			clk->set_state_shutdown = arch_timer_shutdown_phys;
 			clk->set_state_oneshot_stopped = arch_timer_shutdown_phys;
 			clk->set_next_event = arch_timer_set_next_event_phys;
@@ -459,8 +459,8 @@ static void arch_counter_set_user_access(void)
 
 static bool arch_timer_has_nonsecure_ppi(void)
 {
-	return (arch_timer_uses_ppi == PHYS_SECURE_PPI &&
-		arch_timer_ppi[PHYS_NONSECURE_PPI]);
+	return (arch_timer_uses_ppi == ARCH_TIMER_PHYS_SECURE_PPI &&
+		arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
 }
 
 static u32 check_ppi_trigger(int irq)
@@ -487,8 +487,9 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], flags);
 
 	if (arch_timer_has_nonsecure_ppi()) {
-		flags = check_ppi_trigger(arch_timer_ppi[PHYS_NONSECURE_PPI]);
-		enable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI], flags);
+		flags = check_ppi_trigger(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
+		enable_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI],
+				  flags);
 	}
 
 	arch_counter_set_user_access();
@@ -532,7 +533,7 @@ static void arch_timer_banner(unsigned type)
 		(unsigned long)arch_timer_rate / 1000000,
 		(unsigned long)(arch_timer_rate / 10000) % 100,
 		type & ARCH_TIMER_TYPE_CP15 ?
-			(arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
+			(arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) ? "virt" : "phys" :
 			"",
 		type == (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ? "/" : "",
 		type & ARCH_TIMER_TYPE_MEM ?
@@ -602,7 +603,8 @@ static void __init arch_counter_register(unsigned type)
 
 	/* Register the CP15 based counter if we have one */
 	if (type & ARCH_TIMER_TYPE_CP15) {
-		if (IS_ENABLED(CONFIG_ARM64) || arch_timer_uses_ppi == VIRT_PPI)
+		if (IS_ENABLED(CONFIG_ARM64) ||
+		    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI)
 			arch_timer_read_counter = arch_counter_get_cntvct;
 		else
 			arch_timer_read_counter = arch_counter_get_cntpct;
@@ -640,7 +642,7 @@ static void arch_timer_stop(struct clock_event_device *clk)
 
 	disable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi]);
 	if (arch_timer_has_nonsecure_ppi())
-		disable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI]);
+		disable_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
 
 	clk->set_state_shutdown(clk);
 }
@@ -703,24 +705,24 @@ static int __init arch_timer_register(void)
 
 	ppi = arch_timer_ppi[arch_timer_uses_ppi];
 	switch (arch_timer_uses_ppi) {
-	case VIRT_PPI:
+	case ARCH_TIMER_VIRT_PPI:
 		err = request_percpu_irq(ppi, arch_timer_handler_virt,
 					 "arch_timer", arch_timer_evt);
 		break;
-	case PHYS_SECURE_PPI:
-	case PHYS_NONSECURE_PPI:
+	case ARCH_TIMER_PHYS_SECURE_PPI:
+	case ARCH_TIMER_PHYS_NONSECURE_PPI:
 		err = request_percpu_irq(ppi, arch_timer_handler_phys,
 					 "arch_timer", arch_timer_evt);
-		if (!err && arch_timer_ppi[PHYS_NONSECURE_PPI]) {
-			ppi = arch_timer_ppi[PHYS_NONSECURE_PPI];
+		if (!err && arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]) {
+			ppi = arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI];
 			err = request_percpu_irq(ppi, arch_timer_handler_phys,
 						 "arch_timer", arch_timer_evt);
 			if (err)
-				free_percpu_irq(arch_timer_ppi[PHYS_SECURE_PPI],
+				free_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI],
 						arch_timer_evt);
 		}
 		break;
-	case HYP_PPI:
+	case ARCH_TIMER_HYP_PPI:
 		err = request_percpu_irq(ppi, arch_timer_handler_phys,
 					 "arch_timer", arch_timer_evt);
 		break;
@@ -752,7 +754,7 @@ static int __init arch_timer_register(void)
 out_unreg_notify:
 	free_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], arch_timer_evt);
 	if (arch_timer_has_nonsecure_ppi())
-		free_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI],
+		free_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI],
 				arch_timer_evt);
 
 out_free:
@@ -849,16 +851,16 @@ static int __init arch_timer_init(void)
 	 * their CNTHP_*_EL2 counterparts, and use a different PPI
 	 * number.
 	 */
-	if (is_hyp_mode_available() || !arch_timer_ppi[VIRT_PPI]) {
+	if (is_hyp_mode_available() || !arch_timer_ppi[ARCH_TIMER_VIRT_PPI]) {
 		bool has_ppi;
 
 		if (is_kernel_in_hyp_mode()) {
-			arch_timer_uses_ppi = HYP_PPI;
-			has_ppi = !!arch_timer_ppi[HYP_PPI];
+			arch_timer_uses_ppi = ARCH_TIMER_HYP_PPI;
+			has_ppi = !!arch_timer_ppi[ARCH_TIMER_HYP_PPI];
 		} else {
-			arch_timer_uses_ppi = PHYS_SECURE_PPI;
-			has_ppi = (!!arch_timer_ppi[PHYS_SECURE_PPI] ||
-				   !!arch_timer_ppi[PHYS_NONSECURE_PPI]);
+			arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
+			has_ppi = (!!arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI] ||
+				   !!arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
 		}
 
 		if (!has_ppi) {
@@ -875,7 +877,7 @@ static int __init arch_timer_init(void)
 	if (ret)
 		return ret;
 
-	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[VIRT_PPI];
+	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
 
 	return 0;
 }
@@ -890,7 +892,7 @@ static int __init arch_timer_of_init(struct device_node *np)
 	}
 
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
-	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
+	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
 	arch_timer_detect_rate(NULL, np);
@@ -912,7 +914,7 @@ static int __init arch_timer_of_init(struct device_node *np)
 	 */
 	if (IS_ENABLED(CONFIG_ARM) &&
 	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
-		arch_timer_uses_ppi = PHYS_SECURE_PPI;
+		arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
 
 	/* On some systems, the counter stops ticking when in suspend. */
 	arch_counter_suspend_stop = of_property_read_bool(np,
@@ -1039,19 +1041,19 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
-	arch_timer_ppi[PHYS_SECURE_PPI] =
+	arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI] =
 		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
 		gtdt->secure_el1_flags);
 
-	arch_timer_ppi[PHYS_NONSECURE_PPI] =
+	arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI] =
 		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
 		gtdt->non_secure_el1_flags);
 
-	arch_timer_ppi[VIRT_PPI] =
+	arch_timer_ppi[ARCH_TIMER_VIRT_PPI] =
 		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
 		gtdt->virtual_timer_flags);
 
-	arch_timer_ppi[HYP_PPI] =
+	arch_timer_ppi[ARCH_TIMER_HYP_PPI] =
 		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
 		gtdt->non_secure_el2_flags);
 
-- 
2.9.3

