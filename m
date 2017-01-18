Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751842AbdARNg4 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 18 Jan 2017 08:36:56 -0500
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
Subject: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework counter frequency detection.
Date: Wed, 18 Jan 2017 21:25:32 +0800
Message-Id: <20170118132541.8989-9-fu.wei@linaro.org>
In-Reply-To: <20170118132541.8989-1-fu.wei@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The counter frequency detection call(arch_timer_detect_rate) combines two
ways to get counter frequency: system coprocessor register and MMIO timer.
But in a specific timer init code, we only need one way to try:
getting frequency from MMIO timer register will be needed only when we
init MMIO timer; getting frequency from system coprocessor register will
be needed only when we init arch timer.

This patch separates paths to determine frequency:
Separate out the MMIO frequency and the sysreg frequency detection call,
and use the appropriate one for the counter.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 40 ++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 6484f84..9482481 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -488,23 +488,33 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void arch_timer_detect_rate(void __iomem *cntbase)
+static void __arch_timer_determine_rate(u32 rate)
 {
-	/* Who has more than one independent system counter? */
-	if (arch_timer_rate)
-		return;
+	/* Check the timer frequency. */
+	if (!arch_timer_rate) {
+		if (rate)
+			arch_timer_rate = rate;
+		else
+			pr_warn("frequency not available\n");
+	} else if (rate && arch_timer_rate != rate) {
+		pr_warn("got different frequency, keep original.\n");
+	}
+}
 
+static void arch_timer_detect_rate(void)
+{
 	/*
-	 * Try to determine the frequency from the MMIO timer or the sysreg.
+	 * Try to get the timer frequency from the sysreg CNTFRQ.
 	 */
-	if (cntbase)
-		arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
-	else
-		arch_timer_rate = arch_timer_get_cntfrq();
+	__arch_timer_determine_rate(arch_timer_get_cntfrq());
+}
 
-	/* Check the timer frequency. */
-	if (arch_timer_rate == 0)
-		pr_warn("frequency not available\n");
+static void arch_timer_mem_detect_rate(void __iomem *cntbase)
+{
+	/*
+	 * Try to get the timer frequency from the CNTFRQ reg of MMIO timer.
+	 */
+	__arch_timer_determine_rate(readl_relaxed(cntbase + CNTFRQ));
 }
 
 static void arch_timer_banner(unsigned type)
@@ -887,7 +897,7 @@ static int __init arch_timer_of_init(struct device_node *np)
 	 */
 	if (!arch_timer_rate &&
 	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
-		arch_timer_detect_rate(NULL);
+		arch_timer_detect_rate();
 
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 
@@ -1001,7 +1011,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	 */
 	if (!arch_timer_rate &&
 	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
-		arch_timer_detect_rate(base);
+		arch_timer_mem_detect_rate(base);
 
 	ret = arch_timer_mem_register(base, irq);
 	if (ret)
@@ -1064,7 +1074,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		gtdt->non_secure_el2_flags);
 
 	/* Get the frequency from the sysreg CNTFRQ */
-	arch_timer_detect_rate(NULL);
+	arch_timer_detect_rate();
 
 	arch_timer_uses_ppi = arch_timer_select_ppi();
 	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
-- 
2.9.3

