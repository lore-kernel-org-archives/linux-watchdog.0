Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754779AbdDNSlk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Apr 2017 14:41:40 -0400
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
Subject: [PATCH v24 04/11] clocksource: arm_arch_timer: add structs to describe MMIO timer
Date: Sat, 15 Apr 2017 02:40:07 +0800
Message-Id: <20170414184014.8524-5-fu.wei@linaro.org>
In-Reply-To: <20170414184014.8524-1-fu.wei@linaro.org>
References: <20170414184014.8524-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

In preparation for ACPI GTDT support, this patch adds structs to
describe the MMIO timers indepedent of the firmware interface.

Subsequent patches will use these to split the FW/HW probing logic, so
that the HW probing logic can be shared by ACPI and DT.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 include/clocksource/arm_arch_timer.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 4a98c06..cc805b7 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -57,6 +57,8 @@ enum arch_timer_spi_nr {
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
 #define ARCH_TIMER_MEM_VIRT_ACCESS	3
 
+#define ARCH_TIMER_MEM_MAX_FRAMES	8
+
 #define ARCH_TIMER_USR_PCT_ACCESS_EN	(1 << 0) /* physical counter */
 #define ARCH_TIMER_USR_VCT_ACCESS_EN	(1 << 1) /* virtual counter */
 #define ARCH_TIMER_VIRT_EVT_EN		(1 << 2)
@@ -72,6 +74,20 @@ struct arch_timer_kvm_info {
 	int virtual_irq;
 };
 
+struct arch_timer_mem_frame {
+	bool valid;
+	phys_addr_t cntbase;
+	size_t size;
+	int phys_irq;
+	int virt_irq;
+};
+
+struct arch_timer_mem {
+	phys_addr_t cntctlbase;
+	size_t size;
+	struct arch_timer_mem_frame frame[ARCH_TIMER_MEM_MAX_FRAMES];
+};
+
 #ifdef CONFIG_ARM_ARCH_TIMER
 
 extern u32 arch_timer_get_rate(void);
-- 
2.9.3

