Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbdDNSk7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Apr 2017 14:40:59 -0400
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
Subject: [PATCH v24 01/11] clocksource: arm_arch_timer: split dt-only rate handling
Date: Sat, 15 Apr 2017 02:40:04 +0800
Message-Id: <20170414184014.8524-2-fu.wei@linaro.org>
In-Reply-To: <20170414184014.8524-1-fu.wei@linaro.org>
References: <20170414184014.8524-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

For historical reasons, rate detection when probing via DT is somewhat
convoluted. We tried to package this up in arch_timer_detect_rate(), but
with the addition of ACPI worse, and gets in the way of stringent rate
checking when ACPI is used.

This patch makes arch_timer_detect_rate() specific to DT, ripping out
ACPI logic. In preparation for rework of the MMIO timer probing, the
reading of the relevant CNTFRQ register is factored out to callers. The
function is then renamed to arch_timer_of_configure_rate(), which better
represents its new place in the world.

Comments are added in the DT and ACPI probe paths to explain this.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
[Mark: reword commit message, TODO: rework comments]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 41 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 94de018..0138b0c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -818,24 +818,19 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void
-arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
+/*
+ * For historical reasons, when probing with DT we use whichever (non-zero)
+ * rate was probed first, and don't verify that others match. If the first node
+ * probed has a clock-frequency property, this overrides the HW register.
+ */
+static void arch_timer_of_configure_rate(u32 rate, struct device_node *np)
 {
 	/* Who has more than one independent system counter? */
 	if (arch_timer_rate)
 		return;
 
-	/*
-	 * Try to determine the frequency from the device tree or CNTFRQ,
-	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
-	 */
-	if (!acpi_disabled ||
-	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
-		if (cntbase)
-			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
-		else
-			arch_timer_rate = arch_timer_get_cntfrq();
-	}
+	if (of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
+		arch_timer_rate = rate;
 
 	/* Check the timer frequency. */
 	if (arch_timer_rate == 0)
@@ -1166,6 +1161,7 @@ static int __init arch_timer_init(void)
 static int __init arch_timer_of_init(struct device_node *np)
 {
 	int i;
+	u32 rate;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("multiple nodes in dt, skipping\n");
@@ -1176,7 +1172,8 @@ static int __init arch_timer_of_init(struct device_node *np)
 	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
-	arch_timer_detect_rate(NULL, np);
+	rate = arch_timer_get_cntfrq();
+	arch_timer_of_configure_rate(rate, np);
 
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 
@@ -1212,7 +1209,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	struct device_node *frame, *best_frame = NULL;
 	void __iomem *cntctlbase, *base;
 	unsigned int irq, ret = -EINVAL;
-	u32 cnttidr;
+	u32 cnttidr, rate;
 
 	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
 	cntctlbase = of_iomap(np, 0);
@@ -1278,7 +1275,8 @@ static int __init arch_timer_mem_init(struct device_node *np)
 		goto out;
 	}
 
-	arch_timer_detect_rate(base, np);
+	rate = readl(base + CNTFRQ);
+	arch_timer_of_configure_rate(rate, np);
 	ret = arch_timer_mem_register(base, irq);
 	if (ret)
 		goto out;
@@ -1339,8 +1337,15 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
 		gtdt->non_secure_el2_flags);
 
-	/* Get the frequency from CNTFRQ */
-	arch_timer_detect_rate(NULL, NULL);
+	/*
+	 * When probing via ACPI, we have no mechanism to override the sysreg
+	 * CNTFRQ value. This *must* be correct.
+	 */
+	arch_timer_rate = arch_timer_get_cntfrq();
+	if (!arch_timer_rate) {
+		pr_err(FW_BUG "frequency not available.\n");
+		return -EINVAL;
+	}
 
 	arch_timer_uses_ppi = arch_timer_select_ppi();
 	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
-- 
2.9.3

