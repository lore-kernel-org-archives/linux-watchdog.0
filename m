Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753839AbcKYIrl (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 25 Nov 2016 03:47:41 -0500
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
Subject: [PATCH v17 04/15] clocksource/drivers/arm_arch_timer: rename some enums and defines.
Date: Fri, 25 Nov 2016 16:46:12 +0800
Message-Id: <20161125084623.22515-5-fu.wei@linaro.org>
In-Reply-To: <20161125084623.22515-1-fu.wei@linaro.org>
References: <20161125084623.22515-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

Rename some enums and defines, to unify the format of enums and defines
in arm_arch_timer.h, also update all the users of these enums and defines:
    drivers/clocksource/arm_arch_timer.c
    virt/kvm/arm/hyp/timer-sr.c

No functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 111 ++++++++++++++++++-----------------
 include/clocksource/arm_arch_timer.h |  24 ++++----
 virt/kvm/arm/hyp/timer-sr.c          |   6 +-
 3 files changed, 73 insertions(+), 68 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 15341cf..231175b 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -66,11 +66,11 @@ struct arch_timer {
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
 static u32 arch_timer_rate;
-static int arch_timer_ppi[MAX_TIMER_PPI];
+static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI];
 
 static struct clock_event_device __percpu *arch_timer_evt;
 
-static enum arch_timer_ppi_nr arch_timer_uses_ppi = VIRT_PPI;
+static enum arch_timer_ppi_nr arch_timer_uses_ppi = ARCH_TIMER_VIRT_PPI;
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
 
@@ -340,7 +340,7 @@ static void fsl_a008585_set_sne(struct clock_event_device *clk)
 	if (!static_branch_unlikely(&arch_timer_read_ool_enabled))
 		return;
 
-	if (arch_timer_uses_ppi == VIRT_PPI)
+	if (arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI)
 		clk->set_next_event = fsl_a008585_set_next_event_virt;
 	else
 		clk->set_next_event = fsl_a008585_set_next_event_phys;
@@ -352,7 +352,7 @@ static void __arch_timer_setup(unsigned type,
 {
 	clk->features = CLOCK_EVT_FEAT_ONESHOT;
 
-	if (type == ARCH_CP15_TIMER) {
+	if (type == ARCH_TIMER_TYPE_CP15) {
 		if (arch_timer_c3stop)
 			clk->features |= CLOCK_EVT_FEAT_C3STOP;
 		clk->name = "arch_sys_timer";
@@ -360,14 +360,14 @@ static void __arch_timer_setup(unsigned type,
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
@@ -447,8 +447,8 @@ static void arch_counter_set_user_access(void)
 
 static bool arch_timer_has_nonsecure_ppi(void)
 {
-	return (arch_timer_uses_ppi == PHYS_SECURE_PPI &&
-		arch_timer_ppi[PHYS_NONSECURE_PPI]);
+	return (arch_timer_uses_ppi == ARCH_TIMER_PHYS_SECURE_PPI &&
+		arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
 }
 
 static u32 check_ppi_trigger(int irq)
@@ -469,14 +469,15 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	struct clock_event_device *clk = this_cpu_ptr(arch_timer_evt);
 	u32 flags;
 
-	__arch_timer_setup(ARCH_CP15_TIMER, clk);
+	__arch_timer_setup(ARCH_TIMER_TYPE_CP15, clk);
 
 	flags = check_ppi_trigger(arch_timer_ppi[arch_timer_uses_ppi]);
 	enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], flags);
 
 	if (arch_timer_has_nonsecure_ppi()) {
-		flags = check_ppi_trigger(arch_timer_ppi[PHYS_NONSECURE_PPI]);
-		enable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI], flags);
+		flags = check_ppi_trigger(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
+		enable_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI],
+				  flags);
 	}
 
 	arch_counter_set_user_access();
@@ -513,16 +514,17 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 static void arch_timer_banner(unsigned type)
 {
 	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
-		type & ARCH_CP15_TIMER ? "cp15" : "",
-		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
-		type & ARCH_MEM_TIMER ? "mmio" : "",
+		type & ARCH_TIMER_TYPE_CP15 ? "cp15" : "",
+		type == (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ?
+			" and " : "",
+		type & ARCH_TIMER_TYPE_MEM ? "mmio" : "",
 		(unsigned long)arch_timer_rate / 1000000,
 		(unsigned long)(arch_timer_rate / 10000) % 100,
-		type & ARCH_CP15_TIMER ?
-			(arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
+		type & ARCH_TIMER_TYPE_CP15 ?
+			(arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) ? "virt" : "phys" :
 			"",
-		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
-		type & ARCH_MEM_TIMER ?
+		type == (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ? "/" : "",
+		type & ARCH_TIMER_TYPE_MEM ?
 			arch_timer_mem_use_virtual ? "virt" : "phys" :
 			"");
 }
@@ -588,8 +590,9 @@ static void __init arch_counter_register(unsigned type)
 	u64 start_count;
 
 	/* Register the CP15 based counter if we have one */
-	if (type & ARCH_CP15_TIMER) {
-		if (IS_ENABLED(CONFIG_ARM64) || arch_timer_uses_ppi == VIRT_PPI)
+	if (type & ARCH_TIMER_TYPE_CP15) {
+		if (IS_ENABLED(CONFIG_ARM64) ||
+		    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI)
 			arch_timer_read_counter = arch_counter_get_cntvct;
 		else
 			arch_timer_read_counter = arch_counter_get_cntpct;
@@ -625,7 +628,7 @@ static void arch_timer_stop(struct clock_event_device *clk)
 
 	disable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi]);
 	if (arch_timer_has_nonsecure_ppi())
-		disable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI]);
+		disable_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
 
 	clk->set_state_shutdown(clk);
 }
@@ -688,24 +691,24 @@ static int __init arch_timer_register(void)
 
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
@@ -737,7 +740,7 @@ static int __init arch_timer_register(void)
 out_unreg_notify:
 	free_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], arch_timer_evt);
 	if (arch_timer_has_nonsecure_ppi())
-		free_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI],
+		free_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI],
 				arch_timer_evt);
 
 out_free:
@@ -758,7 +761,7 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
 
 	t->base = base;
 	t->evt.irq = irq;
-	__arch_timer_setup(ARCH_MEM_TIMER, &t->evt);
+	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &t->evt);
 
 	if (arch_timer_mem_use_virtual)
 		func = arch_timer_handler_virt_mem;
@@ -801,13 +804,15 @@ arch_timer_needs_probing(int type, const struct of_device_id *matches)
 
 static int __init arch_timer_common_init(void)
 {
-	unsigned mask = ARCH_CP15_TIMER | ARCH_MEM_TIMER;
+	unsigned mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
 
 	/* Wait until both nodes are probed if we have two timers */
 	if ((arch_timers_present & mask) != mask) {
-		if (arch_timer_needs_probing(ARCH_MEM_TIMER, arch_timer_mem_of_match))
+		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_MEM,
+					     arch_timer_mem_of_match))
 			return 0;
-		if (arch_timer_needs_probing(ARCH_CP15_TIMER, arch_timer_of_match))
+		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_CP15,
+					     arch_timer_of_match))
 			return 0;
 	}
 
@@ -832,16 +837,16 @@ static int __init arch_timer_init(void)
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
@@ -858,7 +863,7 @@ static int __init arch_timer_init(void)
 	if (ret)
 		return ret;
 
-	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[VIRT_PPI];
+	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
 
 	return 0;
 }
@@ -867,13 +872,13 @@ static int __init arch_timer_of_init(struct device_node *np)
 {
 	int i;
 
-	if (arch_timers_present & ARCH_CP15_TIMER) {
+	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("multiple nodes in dt, skipping\n");
 		return 0;
 	}
 
-	arch_timers_present |= ARCH_CP15_TIMER;
-	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
+	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
+	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
 	arch_timer_detect_rate(NULL, np);
@@ -895,7 +900,7 @@ static int __init arch_timer_of_init(struct device_node *np)
 	 */
 	if (IS_ENABLED(CONFIG_ARM) &&
 	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
-		arch_timer_uses_ppi = PHYS_SECURE_PPI;
+		arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
 
 	return arch_timer_init();
 }
@@ -909,7 +914,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	unsigned int irq, ret = -EINVAL;
 	u32 cnttidr;
 
-	arch_timers_present |= ARCH_MEM_TIMER;
+	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
 	cntctlbase = of_iomap(np, 0);
 	if (!cntctlbase) {
 		pr_err("Can't find CNTCTLBase\n");
@@ -1008,28 +1013,28 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
 	struct acpi_table_gtdt *gtdt;
 
-	if (arch_timers_present & ARCH_CP15_TIMER) {
+	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("already initialized, skipping\n");
 		return -EINVAL;
 	}
 
 	gtdt = container_of(table, struct acpi_table_gtdt, header);
 
-	arch_timers_present |= ARCH_CP15_TIMER;
+	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
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
 
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index d23c381..48376a5 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -20,18 +20,18 @@
 #include <linux/timecounter.h>
 #include <linux/types.h>
 
-#define ARCH_CP15_TIMER			BIT(0)
-#define ARCH_MEM_TIMER			BIT(1)
+#define ARCH_TIMER_TYPE_CP15		BIT(0)
+#define ARCH_TIMER_TYPE_MEM		BIT(1)
 
 #define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
 #define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
 #define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
 
-#define CNTHCTL_EL1PCTEN		(1 << 0)
-#define CNTHCTL_EL1PCEN			(1 << 1)
-#define CNTHCTL_EVNTEN			(1 << 2)
-#define CNTHCTL_EVNTDIR			(1 << 3)
-#define CNTHCTL_EVNTI			(0xF << 4)
+#define ARCH_TIMER_CNTHCTL_EL1PCTEN	(1 << 0)
+#define ARCH_TIMER_CNTHCTL_EL1PCEN	(1 << 1)
+#define ARCH_TIMER_CNTHCTL_EVNTEN	(1 << 2)
+#define ARCH_TIMER_CNTHCTL_EVNTDIR	(1 << 3)
+#define ARCH_TIMER_CNTHCTL_EVNTI	(0xF << 4)
 
 enum arch_timer_reg {
 	ARCH_TIMER_REG_CTRL,
@@ -39,11 +39,11 @@ enum arch_timer_reg {
 };
 
 enum arch_timer_ppi_nr {
-	PHYS_SECURE_PPI,
-	PHYS_NONSECURE_PPI,
-	VIRT_PPI,
-	HYP_PPI,
-	MAX_TIMER_PPI
+	ARCH_TIMER_PHYS_SECURE_PPI,
+	ARCH_TIMER_PHYS_NONSECURE_PPI,
+	ARCH_TIMER_VIRT_PPI,
+	ARCH_TIMER_HYP_PPI,
+	ARCH_TIMER_MAX_TIMER_PPI
 };
 
 enum arch_timer_spi_nr {
diff --git a/virt/kvm/arm/hyp/timer-sr.c b/virt/kvm/arm/hyp/timer-sr.c
index 798866a..695b9d9 100644
--- a/virt/kvm/arm/hyp/timer-sr.c
+++ b/virt/kvm/arm/hyp/timer-sr.c
@@ -37,7 +37,7 @@ void __hyp_text __timer_save_state(struct kvm_vcpu *vcpu)
 
 	/* Allow physical timer/counter access for the host */
 	val = read_sysreg(cnthctl_el2);
-	val |= CNTHCTL_EL1PCTEN | CNTHCTL_EL1PCEN;
+	val |= ARCH_TIMER_CNTHCTL_EL1PCTEN | ARCH_TIMER_CNTHCTL_EL1PCEN;
 	write_sysreg(val, cnthctl_el2);
 
 	/* Clear cntvoff for the host */
@@ -55,8 +55,8 @@ void __hyp_text __timer_restore_state(struct kvm_vcpu *vcpu)
 	 * Physical counter access is allowed
 	 */
 	val = read_sysreg(cnthctl_el2);
-	val &= ~CNTHCTL_EL1PCEN;
-	val |= CNTHCTL_EL1PCTEN;
+	val &= ~ARCH_TIMER_CNTHCTL_EL1PCEN;
+	val |= ARCH_TIMER_CNTHCTL_EL1PCTEN;
 	write_sysreg(val, cnthctl_el2);
 
 	if (timer->enabled) {
-- 
2.9.3

