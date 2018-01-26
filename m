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
Subject: [RFC v2 23/37] ARM: shmobile: rcar-gen2: Export shmobile_set_wdt_clock_status function
Date: Fri, 26 Jan 2018 16:08:57 +0000
Message-Id: <1516982937-29245-2-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1516982937-29245-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <TY1PR06MB08950BD28BEC28D55C6D80EDC0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <1516982937-29245-1-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>

This patch exposes a function to set the value of variable
"shmobile_wdt_clock_status" so that the watchdog driver may communicate
critical information to the SMP bring up assembly routine.
Also, the new code provided by this commit decides which version of the
boot vector to install to ICRAM1, and that depends on the size of the
memory region available for this purpose.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 arch/arm/mach-shmobile/common.h       |  6 ++++++
 arch/arm/mach-shmobile/platsmp-apmu.c |  1 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 25 +++++++++++++++++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index a8fa4f7..88d3c1b 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -7,6 +7,12 @@ extern void shmobile_init_delay(void);
 extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_size;
+#ifdef CONFIG_ARCH_RCAR_GEN2
+extern void shmobile_boot_vector_gen2(void);
+extern unsigned long shmobile_boot_fn_gen2;
+extern unsigned long shmobile_boot_size_gen2;
+extern unsigned long shmobile_wdt_clock_status;
+#endif /* CONFIG_ARCH_RCAR_GEN2 */
 extern void shmobile_smp_boot(void);
 extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 4422b61..ba732ef 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -191,6 +191,7 @@ static void __init shmobile_smp_apmu_setup_boot(void)
 {
 	/* install boot code shared by all CPUs */
 	shmobile_boot_fn = __pa_symbol(shmobile_smp_boot);
+	shmobile_boot_fn_gen2 = shmobile_boot_fn;
 }
 
 void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index e5f215c..7158d05 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -50,6 +50,18 @@ static inline u32 phys_to_sbar(phys_addr_t addr)
 #define SYSCIER 0x0c
 #define SYSCIMR 0x10
 
+static void __iomem *shmobile_boot_vector_gen2_start = NULL;
+static unsigned long clock_status;
+
+void shmobile_set_wdt_clock_status(unsigned long value)
+{
+	if (!shmobile_boot_vector_gen2_start)
+		return;
+	memcpy_toio(shmobile_boot_vector_gen2_start + clock_status,
+		    &value, sizeof(value));
+}
+EXPORT_SYMBOL(shmobile_set_wdt_clock_status);
+
 #if defined(CONFIG_SMP)
 
 static void __init rcar_gen2_sysc_init(u32 syscier)
@@ -120,8 +132,17 @@ void __init rcar_gen2_pm_init(void)
 	if (!p)
 		return;
 
-	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
-	iounmap(p);
+	if (resource_size(&res) >= shmobile_boot_size_gen2) {
+		memcpy_toio(p, shmobile_boot_vector_gen2,
+			    shmobile_boot_size_gen2);
+		shmobile_boot_vector_gen2_start = p;
+		clock_status = (&shmobile_wdt_clock_status -
+				(unsigned long *)shmobile_boot_vector_gen2) *
+				sizeof(shmobile_wdt_clock_status);
+	} else {
+		memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
+	}
+
 
 	/* setup reset vectors */
 	p = ioremap_nocache(RST, 0x63);
-- 
2.7.4
