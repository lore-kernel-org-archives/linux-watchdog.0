Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933372AbcKONRA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 Nov 2016 08:17:00 -0500
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
Subject: [PATCH v15 12/13] clocksource/drivers/arm_arch_timer: Add GTDT support for memory-mapped timer
Date: Tue, 15 Nov 2016 21:13:34 +0800
Message-Id: <1479215615-26950-13-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1479215615-26950-1-git-send-email-fu.wei@linaro.org>
References: <1479215615-26950-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The patch add memory-mapped timer register support by using the
information provided by the new GTDT driver of ACPI.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 653374c..350d0b9 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1053,7 +1053,28 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_of_init);
 
 #ifdef CONFIG_ACPI_GTDT
-/* Initialize per-processor generic timer */
+static int __init arch_timer_mem_acpi_init(void)
+{
+	struct arch_timer_mem *timer_mem;
+	int ret = 0;
+	int i = 0;
+
+	timer_mem = kzalloc(sizeof(*timer_mem), GFP_KERNEL);
+	if (!timer_mem)
+		return -ENOMEM;
+
+	while (!gtdt_arch_timer_mem_init(timer_mem, i)) {
+		ret = arch_timer_mem_init(timer_mem);
+		if (ret)
+			break;
+		i++;
+	}
+
+	kfree(timer_mem);
+	return ret;
+}
+
+/* Initialize per-processor generic timer and memory-mapped timer(if present) */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
 	int ret;
@@ -1090,6 +1111,9 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate(NULL, NULL);
 
+	if (arch_timer_mem_acpi_init())
+		pr_err("Failed to initialize memory-mapped timer.\n");
+
 	ret = arch_timer_init();
 
 error:
-- 
2.7.4

