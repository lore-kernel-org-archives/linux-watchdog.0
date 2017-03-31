Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933363AbdCaRvw (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Mar 2017 13:51:52 -0400
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
Subject: [PATCH v23 01/11] clocksource: arm_arch_timer: add MMIO CNTFRQ helper
Date: Sat,  1 Apr 2017 01:50:55 +0800
Message-Id: <20170331175105.8370-2-fu.wei@linaro.org>
In-Reply-To: <20170331175105.8370-1-fu.wei@linaro.org>
References: <20170331175105.8370-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

We currently open-code the readl() for the MMIO time frequency. To avoid
duplicating the logic with future rework, this patch adds a helepr to
read the MMIO timer frequency, mirroring what we have for the sysreg
timer frequency.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
[Mark: reword commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 3faed19..843f923 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -555,6 +555,11 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
+static u32 arch_timer_mem_get_cntfrq(void __iomem *cntbase)
+{
+	return readl_relaxed(cntbase + CNTFRQ);
+}
+
 static void
 arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 {
@@ -569,7 +574,7 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 	if (!acpi_disabled ||
 	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
 		if (cntbase)
-			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
+			arch_timer_rate = arch_timer_mem_get_cntfrq(cntbase);
 		else
 			arch_timer_rate = arch_timer_get_cntfrq();
 	}
-- 
2.9.3

