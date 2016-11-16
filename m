Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933016AbcKPNvE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 16 Nov 2016 08:51:04 -0500
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
Subject: [PATCH v16 08/15] clocksource/drivers/arm_arch_timer: Refactor arch_timer_needs_probing, and call it only if acpi disabled.
Date: Wed, 16 Nov 2016 21:49:01 +0800
Message-Id: <1479304148-2965-9-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The patch refactor original arch_timer_needs_probing function:
    (1) Separate out arch_timer_needs_probing from arch_timer_common_init,
    and call it only if acpi disabled.
    (2) Rename arch_timer_needs_probing to arch_timer_needs_of_probing.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fe4e812..9ddc091 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -792,15 +792,28 @@ static const struct of_device_id arch_timer_mem_of_match[] __initconst = {
 	{},
 };
 
-static bool __init
-arch_timer_needs_probing(int type, const struct of_device_id *matches)
+static bool __init arch_timer_needs_of_probing(void)
 {
 	struct device_node *dn;
 	bool needs_probing = false;
+	unsigned int mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
+
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
 
-	dn = of_find_matching_node(NULL, matches);
-	if (dn && of_device_is_available(dn) && !(arch_timers_present & type))
+	if (dn && of_device_is_available(dn))
 		needs_probing = true;
+
 	of_node_put(dn);
 
 	return needs_probing;
@@ -808,17 +821,8 @@ arch_timer_needs_probing(int type, const struct of_device_id *matches)
 
 static int __init arch_timer_common_init(void)
 {
-	unsigned int mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
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
2.7.4

