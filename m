Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751842AbdARN0c (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 18 Jan 2017 08:26:32 -0500
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
Subject: [PATCH v20 02/17] clocksource/drivers/arm_arch_timer: Rename the timer type macros.
Date: Wed, 18 Jan 2017 21:25:26 +0800
Message-Id: <20170118132541.8989-3-fu.wei@linaro.org>
In-Reply-To: <20170118132541.8989-1-fu.wei@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

Rename the timer type macros to unify the format of macros in
arm_arch_timer.c, also update all the users of these macros.

No functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 43 +++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 923bd5c..36998db 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -54,8 +54,8 @@
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
-#define ARCH_CP15_TIMER	BIT(0)
-#define ARCH_MEM_TIMER	BIT(1)
+#define ARCH_TIMER_TYPE_CP15		BIT(0)
+#define ARCH_TIMER_TYPE_MEM		BIT(1)
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base;
@@ -364,7 +364,7 @@ static void __arch_timer_setup(unsigned type,
 {
 	clk->features = CLOCK_EVT_FEAT_ONESHOT;
 
-	if (type == ARCH_CP15_TIMER) {
+	if (type == ARCH_TIMER_TYPE_CP15) {
 		if (arch_timer_c3stop)
 			clk->features |= CLOCK_EVT_FEAT_C3STOP;
 		clk->name = "arch_sys_timer";
@@ -481,7 +481,7 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	struct clock_event_device *clk = this_cpu_ptr(arch_timer_evt);
 	u32 flags;
 
-	__arch_timer_setup(ARCH_CP15_TIMER, clk);
+	__arch_timer_setup(ARCH_TIMER_TYPE_CP15, clk);
 
 	flags = check_ppi_trigger(arch_timer_ppi[arch_timer_uses_ppi]);
 	enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], flags);
@@ -525,16 +525,17 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
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
+		type & ARCH_TIMER_TYPE_CP15 ?
 			(arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
 			"",
-		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
-		type & ARCH_MEM_TIMER ?
+		type == (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ? "/" : "",
+		type & ARCH_TIMER_TYPE_MEM ?
 			arch_timer_mem_use_virtual ? "virt" : "phys" :
 			"");
 }
@@ -600,7 +601,7 @@ static void __init arch_counter_register(unsigned type)
 	u64 start_count;
 
 	/* Register the CP15 based counter if we have one */
-	if (type & ARCH_CP15_TIMER) {
+	if (type & ARCH_TIMER_TYPE_CP15) {
 		if (IS_ENABLED(CONFIG_ARM64) || arch_timer_uses_ppi == VIRT_PPI)
 			arch_timer_read_counter = arch_counter_get_cntvct;
 		else
@@ -772,7 +773,7 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
 
 	t->base = base;
 	t->evt.irq = irq;
-	__arch_timer_setup(ARCH_MEM_TIMER, &t->evt);
+	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &t->evt);
 
 	if (arch_timer_mem_use_virtual)
 		func = arch_timer_handler_virt_mem;
@@ -815,13 +816,15 @@ arch_timer_needs_probing(int type, const struct of_device_id *matches)
 
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
 
@@ -881,12 +884,12 @@ static int __init arch_timer_of_init(struct device_node *np)
 {
 	int i;
 
-	if (arch_timers_present & ARCH_CP15_TIMER) {
+	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("multiple nodes in dt, skipping\n");
 		return 0;
 	}
 
-	arch_timers_present |= ARCH_CP15_TIMER;
+	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
@@ -927,7 +930,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	unsigned int irq, ret = -EINVAL;
 	u32 cnttidr;
 
-	arch_timers_present |= ARCH_MEM_TIMER;
+	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
 	cntctlbase = of_iomap(np, 0);
 	if (!cntctlbase) {
 		pr_err("Can't find CNTCTLBase\n");
@@ -1027,14 +1030,14 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
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
 
 	arch_timer_ppi[PHYS_SECURE_PPI] =
 		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
-- 
2.9.3

