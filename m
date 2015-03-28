Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:46982 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbbC1SGE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 28 Mar 2015 14:06:04 -0400
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Wim Van Sebroeck <wim@iguana.be>,
	David Daney <david.daney@cavium.com>,
	linux-watchdog@vger.kernel.org
Cc: linux-mips@linux-mips.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/3] watchdog: octeon: fix some trivial coding style issues
Date: Sat, 28 Mar 2015 20:05:39 +0200
Message-Id: <1427565940-22951-2-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
References: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix some trivial coding style issues to reduce noise from static analyzers.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/watchdog/octeon-wdt-main.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 9aa5121..728840c 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -105,10 +105,10 @@ MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static u32 __initdata nmi_stage1_insns[64];
+static u32 nmi_stage1_insns[64] __initdata;
 /* We need one branch and therefore one relocation per target label. */
-static struct uasm_label __initdata labels[5];
-static struct uasm_reloc __initdata relocs[5];
+static struct uasm_label labels[5] __initdata;
+static struct uasm_reloc relocs[5] __initdata;
 
 enum lable_id {
 	label_enter_bootloader = 1
@@ -217,7 +217,8 @@ static void __init octeon_wdt_build_stage1(void)
 	pr_debug("\t.set pop\n");
 
 	if (len > 32)
-		panic("NMI stage 1 handler exceeds 32 instructions, was %d\n", len);
+		panic("NMI stage 1 handler exceeds 32 instructions, was %d\n",
+		      len);
 }
 
 static int cpu2core(int cpu)
@@ -293,6 +294,7 @@ static void octeon_wdt_write_hex(u64 value, int digits)
 {
 	int d;
 	int v;
+
 	for (d = 0; d < digits; d++) {
 		v = (value >> ((digits - d - 1) * 4)) & 0xf;
 		if (v >= 10)
@@ -302,7 +304,7 @@ static void octeon_wdt_write_hex(u64 value, int digits)
 	}
 }
 
-const char *reg_name[] = {
+static const char *reg_name[] = {
 	"$0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
 	"a4", "a5", "a6", "a7", "t0", "t1", "t2", "t3",
 	"s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7",
@@ -456,6 +458,7 @@ static int octeon_wdt_ping(struct watchdog_device __always_unused *wdog)
 		    !cpumask_test_cpu(cpu, &irq_enabled_cpus)) {
 			/* We have to enable the irq */
 			int irq = OCTEON_IRQ_WDOG0 + coreid;
+
 			enable_irq(irq);
 			cpumask_set_cpu(cpu, &irq_enabled_cpus);
 		}
@@ -573,7 +576,8 @@ static int __init octeon_wdt_init(void)
 	max_timeout_sec = 6;
 	do {
 		max_timeout_sec--;
-		timeout_cnt = ((octeon_get_io_clock_rate() >> 8) * max_timeout_sec) >> 8;
+		timeout_cnt = ((octeon_get_io_clock_rate() >> 8) *
+			      max_timeout_sec) >> 8;
 	} while (timeout_cnt > 65535);
 
 	BUG_ON(timeout_cnt == 0);
-- 
2.2.0

