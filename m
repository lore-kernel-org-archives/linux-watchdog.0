Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933727AbdCaRxQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Mar 2017 13:53:16 -0400
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
Subject: [PATCH v23 08/11] clocksource: arm_arch_timer: simplify ACPI support code.
Date: Sat,  1 Apr 2017 01:51:02 +0800
Message-Id: <20170331175105.8370-9-fu.wei@linaro.org>
In-Reply-To: <20170331175105.8370-1-fu.wei@linaro.org>
References: <20170331175105.8370-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The patch update arm_arch_timer driver to use the function
provided by the new GTDT driver of ACPI.
By this way, arm_arch_timer.c can be simplified, and separate
all the ACPI GTDT knowledge from this timer driver.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 54 ++++++++++++------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4aaebe7..415e30a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1149,63 +1149,36 @@ static int __init arch_timer_mem_of_init(struct device_node *np)
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_of_init);
 
-#ifdef CONFIG_ACPI
-static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
-{
-	int trigger, polarity;
-
-	if (!interrupt)
-		return 0;
-
-	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
-			: ACPI_LEVEL_SENSITIVE;
-
-	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
-			: ACPI_ACTIVE_HIGH;
-
-	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
-}
-
+#ifdef CONFIG_ACPI_GTDT
 /* Initialize per-processor generic timer */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
 	int ret;
-	struct acpi_table_gtdt *gtdt;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("already initialized, skipping\n");
 		return -EINVAL;
 	}
 
-	gtdt = container_of(table, struct acpi_table_gtdt, header);
-
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
-	arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI] =
-		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
-		gtdt->secure_el1_flags);
+	ret = acpi_gtdt_init(table, NULL);
+	if (ret) {
+		pr_err("Failed to init GTDT table.\n");
+		return ret;
+	}
 
 	arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI] =
-		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
-		gtdt->non_secure_el1_flags);
+		acpi_gtdt_map_ppi(ARCH_TIMER_PHYS_NONSECURE_PPI);
 
 	arch_timer_ppi[ARCH_TIMER_VIRT_PPI] =
-		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
-		gtdt->virtual_timer_flags);
+		acpi_gtdt_map_ppi(ARCH_TIMER_VIRT_PPI);
 
 	arch_timer_ppi[ARCH_TIMER_HYP_PPI] =
-		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
-		gtdt->non_secure_el2_flags);
+		acpi_gtdt_map_ppi(ARCH_TIMER_HYP_PPI);
 
 	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
 
-	/* Get the frequency from the sysreg CNTFRQ */
-	arch_timer_rate = arch_timer_get_cntfrq();
-	if (!arch_timer_rate) {
-		pr_err(FW_BUG "frequency not available.\n");
-		return -EINVAL;
-	}
-
 	arch_timer_uses_ppi = arch_timer_select_ppi();
 	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
 		pr_err("No interrupt available, giving up\n");
@@ -1213,7 +1186,14 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	}
 
 	/* Always-on capability */
-	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
+	arch_timer_c3stop = acpi_gtdt_c3stop(arch_timer_uses_ppi);
+
+	/* Get the frequency from the sysreg CNTFRQ */
+	arch_timer_rate = arch_timer_get_cntfrq();
+	if (!arch_timer_rate) {
+		pr_err(FW_BUG "frequency not available.\n");
+		return -EINVAL;
+	}
 
 	ret = arch_timer_register();
 	if (ret)
-- 
2.9.3

