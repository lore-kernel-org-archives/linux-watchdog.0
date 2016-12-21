Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757907AbcLUGrW (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Dec 2016 01:47:22 -0500
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
Subject: [PATCH v19 05/15] clocksource/drivers/arm_arch_timer: rework PPI determination
Date: Wed, 21 Dec 2016 14:45:53 +0800
Message-Id: <20161221064603.11830-6-fu.wei@linaro.org>
In-Reply-To: <20161221064603.11830-1-fu.wei@linaro.org>
References: <20161221064603.11830-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

Currently, the arch timer driver uses ARCH_TIMER_PHYS_SECURE_PPI to
mean the driver will use the secure PPI *and* potentialy also use the
non-secure PPI. This is somewhat confusing.

For arm64, where it never makes sense to use the secure PPI, this
means we must always request the useless secure PPI, adding to the
confusion. For ACPI, where we may not even have a valid secure PPI
number, this is additionally problematic. We need the driver to be
able to use *only* the non-secure PPI.

The logic to choose which PPI to use is intertwined with other logic
in arch_timer_init(). This patch factors the PPI determination out
into a new function named arch_timer_select_ppi, and then reworks it
so that we can handle having only a non-secure PPI.

This patch also moves arch_timer_ppi verification out to caller,
because we can verify the configuration from device-tree for ARM by this
way.

Meanwhile, because we will select ARCH_TIMER_PHYS_NONSECURE_PPI for ARM64,
the logic in arch_timer_register also need to be updated.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 77 +++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index c7b4e50..c7b4482 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -702,7 +702,7 @@ static int __init arch_timer_register(void)
 	case ARCH_TIMER_PHYS_NONSECURE_PPI:
 		err = request_percpu_irq(ppi, arch_timer_handler_phys,
 					 "arch_timer", arch_timer_evt);
-		if (!err && arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]) {
+		if (!err && arch_timer_has_nonsecure_ppi()) {
 			ppi = arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI];
 			err = request_percpu_irq(ppi, arch_timer_handler_phys,
 						 "arch_timer", arch_timer_evt);
@@ -824,39 +824,41 @@ static int __init arch_timer_common_init(void)
 	return arch_timer_arch_init();
 }
 
-static int __init arch_timer_init(void)
+/**
+ * arch_timer_select_ppi() - Select suitable PPI for the current system.
+ *
+ * If HYP mode is available, we know that the physical timer
+ * has been configured to be accessible from PL1. Use it, so
+ * that a guest can use the virtual timer instead.
+ *
+ * On ARMv8.1 with VH extensions, the kernel runs in HYP. VHE
+ * accesses to CNTP_*_EL1 registers are silently redirected to
+ * their CNTHP_*_EL2 counterparts, and use a different PPI
+ * number.
+ *
+ * If no interrupt provided for virtual timer, we'll have to
+ * stick to the physical timer. It'd better be accessible...
+ * For arm64 we never use the secure interrupt.
+ *
+ * Return: a suitable PPI type for the current system.
+ */
+static enum arch_timer_ppi_nr __init arch_timer_select_ppi(void)
 {
-	int ret;
-	/*
-	 * If HYP mode is available, we know that the physical timer
-	 * has been configured to be accessible from PL1. Use it, so
-	 * that a guest can use the virtual timer instead.
-	 *
-	 * If no interrupt provided for virtual timer, we'll have to
-	 * stick to the physical timer. It'd better be accessible...
-	 *
-	 * On ARMv8.1 with VH extensions, the kernel runs in HYP. VHE
-	 * accesses to CNTP_*_EL1 registers are silently redirected to
-	 * their CNTHP_*_EL2 counterparts, and use a different PPI
-	 * number.
-	 */
-	if (is_hyp_mode_available() || !arch_timer_ppi[ARCH_TIMER_VIRT_PPI]) {
-		bool has_ppi;
+	if (is_hyp_mode_available() && is_kernel_in_hyp_mode())
+		return ARCH_TIMER_HYP_PPI;
 
-		if (is_kernel_in_hyp_mode()) {
-			arch_timer_uses_ppi = ARCH_TIMER_HYP_PPI;
-			has_ppi = !!arch_timer_ppi[ARCH_TIMER_HYP_PPI];
-		} else {
-			arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
-			has_ppi = (!!arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI] ||
-				   !!arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
-		}
+	if (arch_timer_ppi[ARCH_TIMER_VIRT_PPI])
+		return ARCH_TIMER_VIRT_PPI;
 
-		if (!has_ppi) {
-			pr_warn("No interrupt available, giving up\n");
-			return -EINVAL;
-		}
-	}
+	if (IS_ENABLED(CONFIG_ARM64))
+		return ARCH_TIMER_PHYS_NONSECURE_PPI;
+
+	return ARCH_TIMER_PHYS_SECURE_PPI;
+}
+
+static int __init arch_timer_init(void)
+{
+	int ret;
 
 	ret = arch_timer_register();
 	if (ret)
@@ -904,6 +906,13 @@ static int __init arch_timer_of_init(struct device_node *np)
 	if (IS_ENABLED(CONFIG_ARM) &&
 	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
 		arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
+	else
+		arch_timer_uses_ppi = arch_timer_select_ppi();
+
+	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
+		pr_err("No interrupt available, giving up\n");
+		return -EINVAL;
+	}
 
 	/* On some systems, the counter stops ticking when in suspend. */
 	arch_counter_suspend_stop = of_property_read_bool(np,
@@ -1049,6 +1058,12 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate(NULL, NULL);
 
+	arch_timer_uses_ppi = arch_timer_select_ppi();
+	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
+		pr_err("No interrupt available, giving up\n");
+		return -EINVAL;
+	}
+
 	/* Always-on capability */
 	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
 
-- 
2.9.3

