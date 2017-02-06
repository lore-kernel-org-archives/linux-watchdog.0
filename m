Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752213AbdBFSvL (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 6 Feb 2017 13:51:11 -0500
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
Subject: [PATCH v21 01/13] clocksource: arm_arch_timer: introduce two functions to get the frequency from mmio and sysreg.
Date: Tue,  7 Feb 2017 02:50:03 +0800
Message-Id: <20170206185015.12296-2-fu.wei@linaro.org>
In-Reply-To: <20170206185015.12296-1-fu.wei@linaro.org>
References: <20170206185015.12296-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The patch introduce two new functions: arch_timer_get_sysreg_freq and
arch_timer_get_mmio_freq, and applys them in arch_timer_detect_rate.
These will be used for getting the frequency from mmio and sysreg to
prepare for reworking counter frequency detection.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 46a1709..1d273d6 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -554,6 +554,23 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
+static u32 arch_timer_get_sysreg_freq(void)
+{
+	/*
+	 * Try to get the frequency from the CNTFRQ of sysreg.
+	 */
+	return arch_timer_get_cntfrq();
+}
+
+static u32 arch_timer_get_mmio_freq(void __iomem *cntbase)
+{
+	/*
+	 * Try to get the frequency from the CNTFRQ of timer frame registers.
+	 * Note: please verify cntbase in caller.
+	 */
+	return readl_relaxed(cntbase + CNTFRQ);
+}
+
 static void
 arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 {
@@ -568,9 +585,9 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 	if (!acpi_disabled ||
 	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
 		if (cntbase)
-			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
+			arch_timer_rate = arch_timer_get_mmio_freq(cntbase);
 		else
-			arch_timer_rate = arch_timer_get_cntfrq();
+			arch_timer_rate = arch_timer_get_sysreg_freq();
 	}
 
 	/* Check the timer frequency. */
-- 
2.9.3

