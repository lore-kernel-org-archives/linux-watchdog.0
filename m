Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:37178 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323AbaF0WAE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Jun 2014 18:00:04 -0400
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	David Daney <ddaney.cavm@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2 2/4] MIPS: OCTEON: watchdog: don't jump to bootloader without entry address
Date: Sat, 28 Jun 2014 00:59:50 +0300
Message-Id: <1403906392-10650-3-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1403906392-10650-1-git-send-email-aaro.koskinen@iki.fi>
References: <1403906392-10650-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If CONFIG_HOTPLUG_CPU is set, the driver thinks bootloader entry
address is configured and we should jump there. However, this is
not necessarily true if the kernel is booted on a system
with older/incompatible bootloader.

Add dynamic checks for the bootloader entry address.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/octeon-wdt-main.c | 62 +++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 4baf2d7..8453531 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -145,35 +145,39 @@ static void __init octeon_wdt_build_stage1(void)
 
 	uasm_i_mfc0(&p, K0, C0_STATUS);
 #ifdef CONFIG_HOTPLUG_CPU
-	uasm_il_bbit0(&p, &r, K0, ilog2(ST0_NMI), label_enter_bootloader);
+	if (octeon_bootloader_entry_addr)
+		uasm_il_bbit0(&p, &r, K0, ilog2(ST0_NMI),
+			      label_enter_bootloader);
 #endif
 	/* Force 64-bit addressing enabled */
 	uasm_i_ori(&p, K0, K0, ST0_UX | ST0_SX | ST0_KX);
 	uasm_i_mtc0(&p, K0, C0_STATUS);
 
 #ifdef CONFIG_HOTPLUG_CPU
-	uasm_i_mfc0(&p, K0, C0_EBASE);
-	/* Coreid number in K0 */
-	uasm_i_andi(&p, K0, K0, 0xf);
-	/* 8 * coreid in bits 16-31 */
-	uasm_i_dsll_safe(&p, K0, K0, 3 + 16);
-	uasm_i_ori(&p, K0, K0, 0x8001);
-	uasm_i_dsll_safe(&p, K0, K0, 16);
-	uasm_i_ori(&p, K0, K0, 0x0700);
-	uasm_i_drotr_safe(&p, K0, K0, 32);
-	/*
-	 * Should result in: 0x8001,0700,0000,8*coreid which is
-	 * CVMX_CIU_WDOGX(coreid) - 0x0500
-	 *
-	 * Now ld K0, CVMX_CIU_WDOGX(coreid)
-	 */
-	uasm_i_ld(&p, K0, 0x500, K0);
-	/*
-	 * If bit one set handle the NMI as a watchdog event.
-	 * otherwise transfer control to bootloader.
-	 */
-	uasm_il_bbit0(&p, &r, K0, 1, label_enter_bootloader);
-	uasm_i_nop(&p);
+	if (octeon_bootloader_entry_addr) {
+		uasm_i_mfc0(&p, K0, C0_EBASE);
+		/* Coreid number in K0 */
+		uasm_i_andi(&p, K0, K0, 0xf);
+		/* 8 * coreid in bits 16-31 */
+		uasm_i_dsll_safe(&p, K0, K0, 3 + 16);
+		uasm_i_ori(&p, K0, K0, 0x8001);
+		uasm_i_dsll_safe(&p, K0, K0, 16);
+		uasm_i_ori(&p, K0, K0, 0x0700);
+		uasm_i_drotr_safe(&p, K0, K0, 32);
+		/*
+		 * Should result in: 0x8001,0700,0000,8*coreid which is
+		 * CVMX_CIU_WDOGX(coreid) - 0x0500
+		 *
+		 * Now ld K0, CVMX_CIU_WDOGX(coreid)
+		 */
+		uasm_i_ld(&p, K0, 0x500, K0);
+		/*
+		 * If bit one set handle the NMI as a watchdog event.
+		 * otherwise transfer control to bootloader.
+		 */
+		uasm_il_bbit0(&p, &r, K0, 1, label_enter_bootloader);
+		uasm_i_nop(&p);
+	}
 #endif
 
 	/* Clear Dcache so cvmseg works right. */
@@ -194,11 +198,13 @@ static void __init octeon_wdt_build_stage1(void)
 	uasm_i_dmfc0(&p, K0, C0_DESAVE);
 
 #ifdef CONFIG_HOTPLUG_CPU
-	uasm_build_label(&l, p, label_enter_bootloader);
-	/* Jump to the bootloader and restore K0 */
-	UASM_i_LA(&p, K0, (long)octeon_bootloader_entry_addr);
-	uasm_i_jr(&p, K0);
-	uasm_i_dmfc0(&p, K0, C0_DESAVE);
+	if (octeon_bootloader_entry_addr) {
+		uasm_build_label(&l, p, label_enter_bootloader);
+		/* Jump to the bootloader and restore K0 */
+		UASM_i_LA(&p, K0, (long)octeon_bootloader_entry_addr);
+		uasm_i_jr(&p, K0);
+		uasm_i_dmfc0(&p, K0, C0_DESAVE);
+	}
 #endif
 	uasm_resolve_relocs(relocs, labels);
 
-- 
2.0.0

