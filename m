Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752424AbdBFSvl (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 6 Feb 2017 13:51:41 -0500
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
Subject: [PATCH v21 04/13] clocksource: arm_arch_timer: split arch_timer_rate for different types of timer
Date: Tue,  7 Feb 2017 02:50:06 +0800
Message-Id: <20170206185015.12296-5-fu.wei@linaro.org>
In-Reply-To: <20170206185015.12296-1-fu.wei@linaro.org>
References: <20170206185015.12296-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

Currently, arch_timer_rate is used to store the frequency got from per-cpu
arch-timer or the memory-mapped (MMIO) timers. But those values come from
different registers which should all be initialized by firmware.

This patch remove arch_timer_rate, and use arch_timer_sysreg_freq and
arch_timer_mmio_freq instead.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 42 ++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 63fb441..97a4e90 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -65,7 +65,8 @@ struct arch_timer {
 
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
-static u32 arch_timer_rate;
+static u32 arch_timer_sysreg_freq;
+static u32 arch_timer_mmio_freq;
 static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI];
 
 static struct clock_event_device __percpu *arch_timer_evt;
@@ -417,6 +418,7 @@ static void erratum_workaround_set_sne(struct clock_event_device *clk)
 static void __arch_timer_setup(unsigned type,
 			       struct clock_event_device *clk)
 {
+	u32 freq;
 	clk->features = CLOCK_EVT_FEAT_ONESHOT;
 
 	if (type == ARCH_TIMER_TYPE_CP15) {
@@ -444,6 +446,7 @@ static void __arch_timer_setup(unsigned type,
 		}
 
 		erratum_workaround_set_sne(clk);
+		freq = arch_timer_sysreg_freq;
 	} else {
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
@@ -460,11 +463,12 @@ static void __arch_timer_setup(unsigned type,
 			clk->set_next_event =
 				arch_timer_set_next_event_phys_mem;
 		}
+		freq = arch_timer_mmio_freq;
 	}
 
 	clk->set_state_shutdown(clk);
 
-	clockevents_config_and_register(clk, arch_timer_rate, 0xf, 0x7fffffff);
+	clockevents_config_and_register(clk, freq, 0xf, 0x7fffffff);
 }
 
 static void arch_timer_evtstrm_enable(int divider)
@@ -487,7 +491,7 @@ static void arch_timer_configure_evtstream(void)
 	int evt_stream_div, pos;
 
 	/* Find the closest power of two to the divisor */
-	evt_stream_div = arch_timer_rate / ARCH_TIMER_EVT_STREAM_FREQ;
+	evt_stream_div = arch_timer_sysreg_freq / ARCH_TIMER_EVT_STREAM_FREQ;
 	pos = fls(evt_stream_div);
 	if (pos > 1 && !(evt_stream_div & (1 << (pos - 2))))
 		pos--;
@@ -578,8 +582,8 @@ static void arch_timer_banner(unsigned type)
 		type == (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ?
 			" and " : "",
 		type & ARCH_TIMER_TYPE_MEM ? "mmio" : "",
-		(unsigned long)arch_timer_rate / 1000000,
-		(unsigned long)(arch_timer_rate / 10000) % 100,
+		(unsigned long)arch_timer_sysreg_freq / 1000000,
+		(unsigned long)(arch_timer_sysreg_freq / 10000) % 100,
 		type & ARCH_TIMER_TYPE_CP15 ?
 			(arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) ? "virt" : "phys" :
 			"",
@@ -591,7 +595,7 @@ static void arch_timer_banner(unsigned type)
 
 u32 arch_timer_get_rate(void)
 {
-	return arch_timer_rate;
+	return arch_timer_sysreg_freq;
 }
 
 static u64 arch_counter_get_cntvct_mem(void)
@@ -648,6 +652,7 @@ struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
 static void __init arch_counter_register(unsigned type)
 {
 	u64 start_count;
+	u32 freq;
 
 	/* Register the CP15 based counter if we have one */
 	if (type & ARCH_TIMER_TYPE_CP15) {
@@ -657,6 +662,8 @@ static void __init arch_counter_register(unsigned type)
 		else
 			arch_timer_read_counter = arch_counter_get_cntpct;
 
+		freq = arch_timer_sysreg_freq;
+
 		clocksource_counter.archdata.vdso_direct = true;
 
 #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
@@ -669,19 +676,20 @@ static void __init arch_counter_register(unsigned type)
 #endif
 	} else {
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
+		freq = arch_timer_mmio_freq;
 	}
 
 	if (!arch_counter_suspend_stop)
 		clocksource_counter.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
 	start_count = arch_timer_read_counter();
-	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
+	clocksource_register_hz(&clocksource_counter, freq);
 	cyclecounter.mult = clocksource_counter.mult;
 	cyclecounter.shift = clocksource_counter.shift;
 	timecounter_init(&arch_timer_kvm_info.timecounter,
 			 &cyclecounter, start_count);
 
 	/* 56 bits minimum, so we assume worst case rollover */
-	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+	sched_clock_register(arch_timer_read_counter, 56, freq);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)
@@ -949,10 +957,9 @@ static int __init arch_timer_of_init(struct device_node *np)
 	 * Try to determine the frequency from the device tree,
 	 * if fail, get the frequency from the sysreg CNTFRQ.
 	 */
-	if (!arch_timer_rate &&
-	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
-		arch_timer_rate = arch_timer_get_sysreg_freq();
-	if (!arch_timer_rate) {
+	if (of_property_read_u32(np, "clock-frequency", &arch_timer_sysreg_freq))
+		arch_timer_sysreg_freq = arch_timer_get_sysreg_freq();
+	if (!arch_timer_sysreg_freq) {
 		pr_err(FW_BUG "frequency not available.\n");
 		return -EINVAL;
 	}
@@ -1070,10 +1077,9 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	 * Try to determine the frequency from the device tree,
 	 * if fail, get the frequency from the CNTFRQ reg of MMIO timer.
 	 */
-	if (!arch_timer_rate &&
-	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
-		arch_timer_rate = arch_timer_get_mmio_freq(base);
-	if (!arch_timer_rate) {
+	if (of_property_read_u32(np, "clock-frequency", &arch_timer_mmio_freq))
+		arch_timer_mmio_freq = arch_timer_get_mmio_freq(base);
+	if (!arch_timer_mmio_freq) {
 		pr_err(FW_BUG "frequency not available for MMIO timer.\n");
 		ret = -EINVAL;
 		goto out;
@@ -1140,8 +1146,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		gtdt->non_secure_el2_flags);
 
 	/* Get the frequency from the sysreg CNTFRQ */
-	arch_timer_rate = arch_timer_get_sysreg_freq();
-	if (!arch_timer_rate) {
+	arch_timer_sysreg_freq = arch_timer_get_sysreg_freq();
+	if (!arch_timer_sysreg_freq) {
 		pr_err(FW_BUG "frequency not available.\n");
 		return -EINVAL;
 	}
-- 
2.9.3

