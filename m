Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-cys01nam02on0044.outbound.protection.outlook.com ([104.47.37.44]:19314
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752992AbdH2PnB (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Aug 2017 11:43:01 -0400
From: "Steven J. Hill" <steven.hill@cavium.com>
To: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 2/8] watchdog: octeon-wdt: Remove old boot vector code.
Date: Tue, 29 Aug 2017 10:40:32 -0500
Message-Id: <1504021238-3184-3-git-send-email-steven.hill@cavium.com>
In-Reply-To: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 drivers/watchdog/octeon-wdt-main.c | 134 +++----------------------------------
 drivers/watchdog/octeon-wdt-nmi.S  |  42 +++++++++---
 2 files changed, 44 insertions(+), 132 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index b5cdceb..fbdd484 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -73,6 +73,7 @@
 #include <asm/uasm.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-boot-vector.h>
 
 /* The count needed to achieve timeout_sec. */
 static unsigned int timeout_cnt;
@@ -104,122 +105,10 @@ MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static u32 nmi_stage1_insns[64] __initdata;
-/* We need one branch and therefore one relocation per target label. */
-static struct uasm_label labels[5] __initdata;
-static struct uasm_reloc relocs[5] __initdata;
-
-enum lable_id {
-	label_enter_bootloader = 1
-};
-
-/* Some CP0 registers */
-#define K0		26
-#define C0_CVMMEMCTL 11, 7
-#define C0_STATUS 12, 0
-#define C0_EBASE 15, 1
-#define C0_DESAVE 31, 0
+static struct cvmx_boot_vector_element *octeon_wdt_bootvector;
 
 void octeon_wdt_nmi_stage2(void);
 
-static void __init octeon_wdt_build_stage1(void)
-{
-	int i;
-	int len;
-	u32 *p = nmi_stage1_insns;
-#ifdef CONFIG_HOTPLUG_CPU
-	struct uasm_label *l = labels;
-	struct uasm_reloc *r = relocs;
-#endif
-
-	/*
-	 * For the next few instructions running the debugger may
-	 * cause corruption of k0 in the saved registers. Since we're
-	 * about to crash, nobody probably cares.
-	 *
-	 * Save K0 into the debug scratch register
-	 */
-	uasm_i_dmtc0(&p, K0, C0_DESAVE);
-
-	uasm_i_mfc0(&p, K0, C0_STATUS);
-#ifdef CONFIG_HOTPLUG_CPU
-	if (octeon_bootloader_entry_addr)
-		uasm_il_bbit0(&p, &r, K0, ilog2(ST0_NMI),
-			      label_enter_bootloader);
-#endif
-	/* Force 64-bit addressing enabled */
-	uasm_i_ori(&p, K0, K0, ST0_UX | ST0_SX | ST0_KX);
-	uasm_i_mtc0(&p, K0, C0_STATUS);
-
-#ifdef CONFIG_HOTPLUG_CPU
-	if (octeon_bootloader_entry_addr) {
-		uasm_i_mfc0(&p, K0, C0_EBASE);
-		/* Coreid number in K0 */
-		uasm_i_andi(&p, K0, K0, 0xf);
-		/* 8 * coreid in bits 16-31 */
-		uasm_i_dsll_safe(&p, K0, K0, 3 + 16);
-		uasm_i_ori(&p, K0, K0, 0x8001);
-		uasm_i_dsll_safe(&p, K0, K0, 16);
-		uasm_i_ori(&p, K0, K0, 0x0700);
-		uasm_i_drotr_safe(&p, K0, K0, 32);
-		/*
-		 * Should result in: 0x8001,0700,0000,8*coreid which is
-		 * CVMX_CIU_WDOGX(coreid) - 0x0500
-		 *
-		 * Now ld K0, CVMX_CIU_WDOGX(coreid)
-		 */
-		uasm_i_ld(&p, K0, 0x500, K0);
-		/*
-		 * If bit one set handle the NMI as a watchdog event.
-		 * otherwise transfer control to bootloader.
-		 */
-		uasm_il_bbit0(&p, &r, K0, 1, label_enter_bootloader);
-		uasm_i_nop(&p);
-	}
-#endif
-
-	/* Clear Dcache so cvmseg works right. */
-	uasm_i_cache(&p, 1, 0, 0);
-
-	/* Use K0 to do a read/modify/write of CVMMEMCTL */
-	uasm_i_dmfc0(&p, K0, C0_CVMMEMCTL);
-	/* Clear out the size of CVMSEG	*/
-	uasm_i_dins(&p, K0, 0, 0, 6);
-	/* Set CVMSEG to its largest value */
-	uasm_i_ori(&p, K0, K0, 0x1c0 | 54);
-	/* Store the CVMMEMCTL value */
-	uasm_i_dmtc0(&p, K0, C0_CVMMEMCTL);
-
-	/* Load the address of the second stage handler */
-	UASM_i_LA(&p, K0, (long)octeon_wdt_nmi_stage2);
-	uasm_i_jr(&p, K0);
-	uasm_i_dmfc0(&p, K0, C0_DESAVE);
-
-#ifdef CONFIG_HOTPLUG_CPU
-	if (octeon_bootloader_entry_addr) {
-		uasm_build_label(&l, p, label_enter_bootloader);
-		/* Jump to the bootloader and restore K0 */
-		UASM_i_LA(&p, K0, (long)octeon_bootloader_entry_addr);
-		uasm_i_jr(&p, K0);
-		uasm_i_dmfc0(&p, K0, C0_DESAVE);
-	}
-#endif
-	uasm_resolve_relocs(relocs, labels);
-
-	len = (int)(p - nmi_stage1_insns);
-	pr_debug("Synthesized NMI stage 1 handler (%d instructions)\n", len);
-
-	pr_debug("\t.set push\n");
-	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < len; i++)
-		pr_debug("\t.word 0x%08x\n", nmi_stage1_insns[i]);
-	pr_debug("\t.set pop\n");
-
-	if (len > 32)
-		panic("NMI stage 1 handler exceeds 32 instructions, was %d\n",
-		      len);
-}
-
 static int cpu2core(int cpu)
 {
 #ifdef CONFIG_SMP
@@ -402,6 +291,8 @@ static int octeon_wdt_cpu_online(unsigned int cpu)
 
 	core = cpu2core(cpu);
 
+	octeon_wdt_bootvector[core].target_ptr = (u64)octeon_wdt_nmi_stage2;
+
 	/* Disable it before doing anything with the interrupts. */
 	ciu_wdog.u64 = 0;
 	cvmx_write_csr(CVMX_CIU_WDOGX(core), ciu_wdog.u64);
@@ -544,6 +435,12 @@ static int __init octeon_wdt_init(void)
 	int ret;
 	u64 *ptr;
 
+	octeon_wdt_bootvector = cvmx_boot_vector_get();
+	if (!octeon_wdt_bootvector) {
+		pr_err("Error: Cannot allocate boot vector.\n");
+		return -ENOMEM;
+	}
+
 	/*
 	 * Watchdog time expiration length = The 16 bits of LEN
 	 * represent the most significant bits of a 24 bit decrementer
@@ -576,17 +473,6 @@ static int __init octeon_wdt_init(void)
 		return ret;
 	}
 
-	/* Build the NMI handler ... */
-	octeon_wdt_build_stage1();
-
-	/* ... and install it. */
-	ptr = (u64 *) nmi_stage1_insns;
-	for (i = 0; i < 16; i++) {
-		cvmx_write_csr(CVMX_MIO_BOOT_LOC_ADR, i * 8);
-		cvmx_write_csr(CVMX_MIO_BOOT_LOC_DAT, ptr[i]);
-	}
-	cvmx_write_csr(CVMX_MIO_BOOT_LOC_CFGX(0), 0x81fc0000);
-
 	cpumask_clear(&irq_enabled_cpus);
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "watchdog/octeon:online",
diff --git a/drivers/watchdog/octeon-wdt-nmi.S b/drivers/watchdog/octeon-wdt-nmi.S
index 8a900a5..97f6eb7 100644
--- a/drivers/watchdog/octeon-wdt-nmi.S
+++ b/drivers/watchdog/octeon-wdt-nmi.S
@@ -3,20 +3,40 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2007 Cavium Networks
+ * Copyright (C) 2007-2017 Cavium, Inc.
  */
 #include <asm/asm.h>
 #include <asm/regdef.h>
 
-#define SAVE_REG(r)	sd $r, -32768+6912-(32-r)*8($0)
+#define CVMSEG_BASE	-32768
+#define CVMSEG_SIZE	6912
+#define SAVE_REG(r)	sd $r, CVMSEG_BASE + CVMSEG_SIZE - ((32 - r) * 8)($0)
 
         NESTED(octeon_wdt_nmi_stage2, 0, sp)
 	.set 	push
 	.set 	noreorder
 	.set 	noat
-	/* Save all registers to the top CVMSEG. This shouldn't
+	/* Clear Dcache so cvmseg works right. */
+	cache	1,0($0)
+	/* Use K0 to do a read/modify/write of CVMMEMCTL */
+	dmfc0	k0, $11, 7
+	/* Clear out the size of CVMSEG	*/
+	dins	k0, $0, 0, 6
+	/* Set CVMSEG to its largest value */
+	ori	k0, k0, 0x1c0 | 54
+	/* Store the CVMMEMCTL value */
+	dmtc0	k0, $11, 7
+	/*
+	 * Restore K0 from the debug scratch register, it was saved in
+	 * the boot-vector code.
+	 */
+	dmfc0	k0, $31
+
+	/*
+	 * Save all registers to the top CVMSEG. This shouldn't
 	 * corrupt any state used by the kernel. Also all registers
-	 * should have the value right before the NMI. */
+	 * should have the value right before the NMI.
+	 */
 	SAVE_REG(0)
 	SAVE_REG(1)
 	SAVE_REG(2)
@@ -49,16 +69,22 @@
 	SAVE_REG(29)
 	SAVE_REG(30)
 	SAVE_REG(31)
+	/* Write zero to all CVMSEG locations per Core-15169 */
+	dli	a0, CVMSEG_SIZE - (33 * 8)
+1:	sd	zero, CVMSEG_BASE(a0)
+	daddiu	a0, a0, -8
+	bgez	a0, 1b
+	nop
 	/* Set the stack to begin right below the registers */
-	li	sp, -32768+6912-32*8
+	dli	sp, CVMSEG_BASE + CVMSEG_SIZE - (32 * 8)
 	/* Load the address of the third stage handler */
-	dla	a0, octeon_wdt_nmi_stage3
+	dla	$25, octeon_wdt_nmi_stage3
 	/* Call the third stage handler */
-	jal	a0
+	jal	$25
 	/* a0 is the address of the saved registers */
 	 move	a0, sp
 	/* Loop forvever if we get here. */
-1:	b	1b
+2:	b	2b
 	nop
 	.set pop
 	END(octeon_wdt_nmi_stage2)
-- 
2.1.4

