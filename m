Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52805 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755983AbcGZMUk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jul 2016 08:20:40 -0400
From: fu.wei@linaro.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, marc.zyngier@arm.com,
	lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
	hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
	wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com, leo.duran@amd.com,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v10 2/8] clocksource/drivers/arm_arch_timer: Add a new enum for spi type
Date: Tue, 26 Jul 2016 20:19:19 +0800
Message-Id: <1469535565-20924-3-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patch add a new enum "spi_nr" and use it in the driver.
Just for code's readability, no functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 4 ++--
 include/clocksource/arm_arch_timer.h | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index cb08d63..b12fabd 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -843,9 +843,9 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	}
 
 	if (arch_timer_mem_use_virtual)
-		irq = irq_of_parse_and_map(best_frame, 1);
+		irq = irq_of_parse_and_map(best_frame, VIRT_SPI);
 	else
-		irq = irq_of_parse_and_map(best_frame, 0);
+		irq = irq_of_parse_and_map(best_frame, PHYS_SPI);
 
 	ret = -EINVAL;
 	if (!irq) {
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 6f06481..16dcd10 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -45,6 +45,12 @@ enum ppi_nr {
 	MAX_TIMER_PPI
 };
 
+enum spi_nr {
+	PHYS_SPI,
+	VIRT_SPI,
+	MAX_TIMER_SPI
+};
+
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
-- 
2.5.5

