Return-path: <fu.wei@linaro.org>
From: fu.wei@linaro.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org,
        jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v8 4/9] clocksource/drivers/arm_arch_timer: use readq to get 64-bit CNTVCT
Date: Wed, 20 Jul 2016 02:17:59 +0800
Message-Id: <1468952284-28942-5-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1468952284-28942-1-git-send-email-fu.wei@linaro.org>
References: <1468952284-28942-1-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Fu Wei <fu.wei@linaro.org>

This patch simplify arch_counter_get_cntvct_mem function by
using readq to get 64-bit CNTVCT value instead of readl_relaxed.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index e6fd42d..483d2f9 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -418,15 +418,7 @@ u32 arch_timer_get_rate(void)
 
 static u64 arch_counter_get_cntvct_mem(void)
 {
-	u32 vct_lo, vct_hi, tmp_hi;
-
-	do {
-		vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
-		vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
-		tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
-	} while (vct_hi != tmp_hi);
-
-	return ((u64) vct_hi << 32) | vct_lo;
+	return readq(arch_counter_base + CNTVCT_LO);
 }
 
 /*
-- 
2.5.5
