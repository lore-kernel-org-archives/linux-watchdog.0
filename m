Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932987AbcKONPg (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 Nov 2016 08:15:36 -0500
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
Subject: [PATCH v15 06/13] clocksource/drivers/arm_arch_timer: separate out arch_timer_uses_ppi init code to prepare for GTDT.
Date: Tue, 15 Nov 2016 21:13:28 +0800
Message-Id: <1479215615-26950-7-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1479215615-26950-1-git-send-email-fu.wei@linaro.org>
References: <1479215615-26950-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The patch refactor original arch_timer_uses_ppi init code:
(1) Extract a subfunction: arch_timer_uses_ppi_init
(2) Use the new subfunction in arch_timer_of_init and
arch_timer_acpi_init

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 73 +++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 6de164f..af22953 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -821,40 +821,42 @@ static int __init arch_timer_common_init(void)
 	return arch_timer_arch_init();
 }
 
-static int __init arch_timer_init(void)
+/*
+ * If HYP mode is available, we know that the physical timer
+ * has been configured to be accessible from PL1. Use it, so
+ * that a guest can use the virtual timer instead.
+ *
+ * If no interrupt provided for virtual timer, we'll have to
+ * stick to the physical timer. It'd better be accessible...
+ * On ARM64, we we only use ARCH_TIMER_PHYS_NONSECURE_PPI in Linux.
+ *
+ * On ARMv8.1 with VH extensions, the kernel runs in HYP. VHE
+ * accesses to CNTP_*_EL1 registers are silently redirected to
+ * their CNTHP_*_EL2 counterparts, and use a different PPI
+ * number.
+ */
+static int __init arch_timer_uses_ppi_init(void)
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
-
-		if (is_kernel_in_hyp_mode()) {
-			arch_timer_uses_ppi = ARCH_TIMER_HYP_PPI;
-			has_ppi = !!arch_timer_ppi[ARCH_TIMER_HYP_PPI];
-		} else {
+	if (is_hyp_mode_available() && is_kernel_in_hyp_mode()) {
+		arch_timer_uses_ppi = ARCH_TIMER_HYP_PPI;
+	} else if (!arch_timer_ppi[ARCH_TIMER_VIRT_PPI]) {
+		if (IS_ENABLED(CONFIG_ARM64))
+			arch_timer_uses_ppi = ARCH_TIMER_PHYS_NONSECURE_PPI;
+		else
 			arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
-			has_ppi = (!!arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI] ||
-				   !!arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
-		}
-
-		if (!has_ppi) {
-			pr_warn("No interrupt available, giving up\n");
-			return -EINVAL;
-		}
 	}
 
+	if (arch_timer_ppi[arch_timer_uses_ppi])
+		return 0;
+
+	pr_warn("No interrupt available, giving up\n");
+	return -EINVAL;
+}
+
+static int __init arch_timer_init(void)
+{
+	int ret;
+
 	ret = arch_timer_register();
 	if (ret)
 		return ret;
@@ -870,7 +872,7 @@ static int __init arch_timer_init(void)
 
 static int __init arch_timer_of_init(struct device_node *np)
 {
-	int i;
+	int i, ret;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("multiple nodes in dt, skipping\n");
@@ -902,6 +904,10 @@ static int __init arch_timer_of_init(struct device_node *np)
 	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
 		arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
 
+	ret = arch_timer_uses_ppi_init();
+	if (ret)
+		return ret;
+
 	return arch_timer_init();
 }
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
@@ -1011,6 +1017,7 @@ static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
 /* Initialize per-processor generic timer */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
+	int ret;
 	struct acpi_table_gtdt *gtdt;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
@@ -1041,6 +1048,10 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate(NULL, NULL);
 
+	ret = arch_timer_uses_ppi_init();
+	if (ret)
+		return ret;
+
 	/* Always-on capability */
 	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
 
-- 
2.7.4

