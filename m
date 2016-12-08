Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752079AbcLHRet (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 8 Dec 2016 12:34:49 -0500
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
Subject: [PATCH v18 06/15] clocksource/drivers/arm_arch_timer: Rework counter frequency detection.
Date: Fri,  9 Dec 2016 01:33:10 +0800
Message-Id: <20161208173319.6618-7-fu.wei@linaro.org>
In-Reply-To: <20161208173319.6618-1-fu.wei@linaro.org>
References: <20161208173319.6618-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

Currently, the counter frequency detection call(arch_timer_detect_rate)
combines all the ways to get counter frequency: device-tree property,
system coprocessor register, MMIO timer. But in the most of use cases,
we don't need all the ways to try:
For example, reading device-tree property will be needed only when
system boot with device-tree, getting frequency from MMIO timer register
will beneeded only when we init MMIO timer.

This patch separates paths to determine frequency:
Separate out device-tree code, keep them in device-tree init function.
Separate out the MMIO frequency and the sysreg frequency detection call,
and use the appropriate one for the counter.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 49 +++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index e43be0a..e554081 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -487,27 +487,31 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void
-arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
+static void arch_timer_detect_rate(void)
 {
-	/* Who has more than one independent system counter? */
-	if (arch_timer_rate)
-		return;
+	/*
+	 * Try to get the timer frequency from
+	 * cntfrq_el0(system coprocessor register).
+	 */
+	if (!arch_timer_rate)
+		arch_timer_rate = arch_timer_get_cntfrq();
+
+	/* Check the timer frequency. */
+	if (!arch_timer_rate)
+		pr_warn("frequency not available\n");
+}
 
+static void arch_timer_mem_detect_rate(void __iomem *cntbase)
+{
 	/*
-	 * Try to determine the frequency from the device tree or CNTFRQ,
-	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
+	 * Try to determine the frequency from
+	 * CNTFRQ in memory-mapped timer.
 	 */
-	if (!acpi_disabled ||
-	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
-		if (cntbase)
-			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
-		else
-			arch_timer_rate = arch_timer_get_cntfrq();
-	}
+	if (!arch_timer_rate)
+		arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
 
 	/* Check the timer frequency. */
-	if (arch_timer_rate == 0)
+	if (!arch_timer_rate)
 		pr_warn("frequency not available\n");
 }
 
@@ -883,7 +887,9 @@ static int __init arch_timer_of_init(struct device_node *np)
 	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
-	arch_timer_detect_rate(NULL, np);
+	if (!arch_timer_rate &&
+	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
+		arch_timer_detect_rate();
 
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 
@@ -986,7 +992,14 @@ static int __init arch_timer_mem_init(struct device_node *np)
 		goto out;
 	}
 
-	arch_timer_detect_rate(base, np);
+	/*
+	 * Try to determine the frequency from the device tree,
+	 * if fail, get the frequency from CNTFRQ.
+	 */
+	if (!arch_timer_rate &&
+	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
+		arch_timer_mem_detect_rate(base);
+
 	ret = arch_timer_mem_register(base, irq);
 	if (ret)
 		goto out;
@@ -1048,7 +1061,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		gtdt->non_secure_el2_flags);
 
 	/* Get the frequency from CNTFRQ */
-	arch_timer_detect_rate(NULL, NULL);
+	arch_timer_detect_rate();
 
 	arch_timer_uses_ppi = arch_timer_select_ppi();
 	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
-- 
2.9.3

