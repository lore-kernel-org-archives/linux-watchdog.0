Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754557AbdDNSlR (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Apr 2017 14:41:17 -0400
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
Subject: [PATCH v24 02/11] clocksource: arm_arch_timer: refactor arch_timer_needs_probing
Date: Sat, 15 Apr 2017 02:40:05 +0800
Message-Id: <20170414184014.8524-3-fu.wei@linaro.org>
In-Reply-To: <20170414184014.8524-1-fu.wei@linaro.org>
References: <20170414184014.8524-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

When booting with DT, it's possible for timer nodes to be probed in any
order. Some common initialisation needs to occur after all nodes have
been probed, and arch_timer_common_init() has code to detect when this
has happened.

This logic is DT-specific, and it would be best to factor it out of the
common code that will be shared with ACPI.

This patch folds this into the existing arch_timer_needs_probing(),
which is renamed to arch_timer_needs_of_probing(), and no longer takes
any arguments. This is only called when using DT, and not when using
ACPI, which will have a deterministic probe order.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
[Mark: reword commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 0138b0c..03d71d6 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1076,15 +1076,28 @@ static const struct of_device_id arch_timer_mem_of_match[] __initconst = {
 	{},
 };
 
-static bool __init
-arch_timer_needs_probing(int type, const struct of_device_id *matches)
+static bool __init arch_timer_needs_of_probing(void)
 {
 	struct device_node *dn;
 	bool needs_probing = false;
+	unsigned int mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
 
-	dn = of_find_matching_node(NULL, matches);
-	if (dn && of_device_is_available(dn) && !(arch_timers_present & type))
+	/* We have two timers, and both device-tree nodes are probed. */
+	if ((arch_timers_present & mask) == mask)
+		return false;
+
+	/*
+	 * Only one type of timer is probed,
+	 * check if we have another type of timer node in device-tree.
+	 */
+	if (arch_timers_present & ARCH_TIMER_TYPE_CP15)
+		dn = of_find_matching_node(NULL, arch_timer_mem_of_match);
+	else
+		dn = of_find_matching_node(NULL, arch_timer_of_match);
+
+	if (dn && of_device_is_available(dn))
 		needs_probing = true;
+
 	of_node_put(dn);
 
 	return needs_probing;
@@ -1092,17 +1105,8 @@ arch_timer_needs_probing(int type, const struct of_device_id *matches)
 
 static int __init arch_timer_common_init(void)
 {
-	unsigned mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
-
-	/* Wait until both nodes are probed if we have two timers */
-	if ((arch_timers_present & mask) != mask) {
-		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_MEM,
-					     arch_timer_mem_of_match))
-			return 0;
-		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_CP15,
-					     arch_timer_of_match))
-			return 0;
-	}
+	if (acpi_disabled && arch_timer_needs_of_probing())
+		return 0;
 
 	arch_timer_banner(arch_timers_present);
 	arch_counter_register(arch_timers_present);
-- 
2.9.3

