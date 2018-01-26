Return-Path: <fabrizio.castro@bp.renesas.com>
Return-path: <fabrizio.castro@bp.renesas.com>
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [RFC v2 01/37] ARM: shmobile: Add watchdog support
Date: Fri, 26 Jan 2018 16:08:56 +0000
Message-Id: <1516982937-29245-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <TY1PR06MB08950BD28BEC28D55C6D80EDC0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <TY1PR06MB08950BD28BEC28D55C6D80EDC0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
List-ID: <linux-watchdog@vger.kernel.org>

On R-Car Gen2 and RZ/G1 platforms, we use the SBAR registers to make non
boot CPUs run a routine designed to bring up SMP and deal with hot plug.
The value contained in the SBAR registers is not initialized by a WDT
triggered reset, which means that after a WDT triggered reset we jump
to the SMP bring up routine, preventing the system from executing the
bootrom code.

The purpose of this patch is to jump to the bootrom code in case of a
WDT triggered reset, and keep the SMP functionality untouched.
In order to tell if the code had been called due to the WDT overflowing
we need to inspect flag WOVF from register RWTCSRA, however for this
to work smoothly we need to make sure that RWDT clock is ON.
Since it's not wise to interfere with the clock configuration from
within this routine, a flag has been put in place
(shmobile_wdt_clock_status) so that the watchdog driver can tell
shmobile_boot_vector_gen2 when the clock is ON, and therefore there is
no need for shmobile_boot_vector to mess up with the clock registers.

Bit WOVF survives a watchdog triggered reset, and it is usually cleared
by the bootloader. Checking the MMU enable bit from register SCTLR
allows us to make the code a little bit more robust (just in case the
bit wasn't cleared up), as right after a reset the MMU is disabled,
and when Linux is running the MMU is enabled. Also, accessing RWTCSRA
physical address is safe when the MMU is down.

New function shmobile_boot_vector_gen2 isn't replacing
shmobile_boot_vector for backward compatibility reasons. The kernel
will install the best option (either shmobile_boot_vector or
shmobile_boot_vector_gen2) to ICRAM1 after parsing the device tree.

SMP bringup, CPU hot plug, and suspend to RAM work as normal.

Since shmobile_boot_vector has become bigger, "reg" property of nodes
compatible with "renesas,smp-sram" now need to be set to "<0 0x64>".

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 arch/arm/mach-shmobile/headsmp.S | 74 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 32e0bf6..4b14d4c 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -16,6 +16,13 @@
 #include <asm/assembler.h>
 #include <asm/memory.h>
 
+#define RWDT_CLOCK_ON	0xdeadbeef
+#define RWDT_CLOCK_OFF	0x00000000
+#define SCTLR_MMU	0x01
+#define BOOTROM_ADDRESS	0xE6340000
+#define RWTCSRA_ADDRESS 0xE6020004
+#define RWTCSRA_WOVF	0x10
+
 /*
  * Reset vector for secondary CPUs.
  * This will be mapped at address 0 by SBAR register.
@@ -37,6 +44,73 @@ shmobile_boot_fn:
 shmobile_boot_size:
 	.long	. - shmobile_boot_vector
 
+#ifdef CONFIG_ARCH_RCAR_GEN2
+/*
+ * Reset vector for R-Car Gen2 and RZ/G1 secondary CPUs.
+ * This will be mapped at address 0 by SBAR register.
+ */
+ENTRY(shmobile_boot_vector_gen2)
+/*
+	if (SCTLR_MMU == 1)
+		goto shmobile_smp_continue_gen2;
+*/
+	mrc	p15, 0, r1, c1, c0, 0		@ r1 = SCTLR
+	and	r0, r1, #SCTLR_MMU
+	cmp	r0, #SCTLR_MMU
+	beq	shmobile_smp_continue_gen2
+
+/*
+	if (shmobile_wdt_clock_status != RWDT_CLOCK_ON)
+		goto shmobile_smp_continue_gen2;
+*/
+	ldr	r0, #shmobile_wdt_clock_status
+	ldr	r1, #clock_on
+	cmp	r0, r1
+	bne	shmobile_smp_continue_gen2
+
+/*
+	if (RWTCSRA_WOVF == 0)
+		goto shmobile_smp_continue_gen2;
+*/
+	ldr	r0, rwtcsra
+	mov	r1, #0
+	ldrb	r1, [r0]
+	and	r0, r1, #RWTCSRA_WOVF
+	cmp	r0, #RWTCSRA_WOVF
+	bne	shmobile_smp_continue_gen2
+
+/*
+	goto bootrom;
+*/
+	ldr	r0, bootrom
+	bx	r0
+
+shmobile_smp_continue_gen2:
+	ldr     r1, shmobile_boot_fn_gen2
+	bx	r1
+
+ENDPROC(shmobile_boot_vector_gen2)
+
+	.align	4
+rwtcsra:
+	.word	RWTCSRA_ADDRESS
+bootrom:
+	.word	BOOTROM_ADDRESS
+clock_on:
+	.word	RWDT_CLOCK_ON
+	.globl	shmobile_wdt_clock_status
+shmobile_wdt_clock_status:
+	.word	RWDT_CLOCK_OFF
+
+	.align	2
+	.globl	shmobile_boot_fn_gen2
+shmobile_boot_fn_gen2:
+	.space	4
+	.globl	shmobile_boot_size_gen2
+shmobile_boot_size_gen2:
+	.long	. - shmobile_boot_vector_gen2
+#endif /* CONFIG_ARCH_RCAR_GEN2 */
+
 /*
  * Per-CPU SMP boot function/argument selection code based on MPIDR
  */
-- 
2.7.4
