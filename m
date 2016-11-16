Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932982AbcKPNu7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 16 Nov 2016 08:50:59 -0500
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
Subject: [PATCH v16 07/15] clocksource/drivers/arm_arch_timer: Refactor arch_timer_detect_rate to keep dt code in *_of_init
Date: Wed, 16 Nov 2016 21:49:00 +0800
Message-Id: <1479304148-2965-8-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The patch refactor original arch_timer_detect_rate function:
    (1) Separate out device-tree code, keep them in device-tree init
    function:
        arch_timer_of_init,
        arch_timer_mem_init;
    (2) Improve original mechanism, if getting from memory-mapped timer
    fail, try arch_timer_get_cntfrq() again.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 45 +++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index af22953..fe4e812 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -487,27 +487,31 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void
-arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
+static void arch_timer_detect_rate(void __iomem *cntbase)
 {
 	/* Who has more than one independent system counter? */
 	if (arch_timer_rate)
 		return;
-
 	/*
-	 * Try to determine the frequency from the device tree or CNTFRQ,
-	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
+	 * If we got memory-mapped timer(cntbase != NULL),
+	 * try to determine the frequency from CNTFRQ in memory-mapped timer.
 	 */
-	if (!acpi_disabled ||
-	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
-		if (cntbase)
-			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
-		else
-			arch_timer_rate = arch_timer_get_cntfrq();
-	}
+	if (cntbase)
+		arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
+	/*
+	 * Because in a system that implements both Secure and
+	 * Non-secure states, CNTFRQ is only accessible in Secure state.
+	 * So the operation above may fail, even if (cntbase != NULL),
+	 * especially on ARM64.
+	 * In this case, we can try cntfrq_el0(system coprocessor register).
+	 */
+	if (!arch_timer_rate)
+		arch_timer_rate = arch_timer_get_cntfrq();
+	else
+		return;
 
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
+		arch_timer_detect_rate(NULL);
 
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 
@@ -983,7 +989,14 @@ static int __init arch_timer_mem_init(struct device_node *np)
 		goto out;
 	}
 
-	arch_timer_detect_rate(base, np);
+	/*
+	 * Try to determine the frequency from the device tree,
+	 * if fail, get the frequency from CNTFRQ.
+	 */
+	if (!arch_timer_rate &&
+	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
+		arch_timer_detect_rate(base);
+
 	ret = arch_timer_mem_register(base, irq);
 	if (ret)
 		goto out;
@@ -1046,7 +1059,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		gtdt->non_secure_el2_flags);
 
 	/* Get the frequency from CNTFRQ */
-	arch_timer_detect_rate(NULL, NULL);
+	arch_timer_detect_rate(NULL);
 
 	ret = arch_timer_uses_ppi_init();
 	if (ret)
-- 
2.7.4

