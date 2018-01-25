Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:33572 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751213AbeAYSFa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 25 Jan 2018 13:05:30 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
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
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [RFC 23/37] ARM: shmobile: rcar-gen2: Export shmobile_set_wdt_clock_status function
Date: Thu, 25 Jan 2018 18:02:57 +0000
Message-Id: <1516903391-30467-24-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch exposes a function to set the value of variable
"shmobile_wdt_clock_status" so that the watchdog driver may communicate
critical information to the SMP bring up assembly routine.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 arch/arm/mach-shmobile/common.h       |  1 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index a8fa4f7..e4ffca8 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -5,6 +5,7 @@
 extern void shmobile_init_cntvoff(void);
 extern void shmobile_init_delay(void);
 extern void shmobile_boot_vector(void);
+extern unsigned long shmobile_wdt_clock_status;
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_size;
 extern void shmobile_smp_boot(void);
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index e5f215c..cfdc3cd 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -50,6 +50,16 @@ static inline u32 phys_to_sbar(phys_addr_t addr)
 #define SYSCIER 0x0c
 #define SYSCIMR 0x10
 
+static void __iomem *shmobile_boot_vector_start;
+static unsigned long clock_status;
+
+void shmobile_set_wdt_clock_status(unsigned long value)
+{
+	memcpy_toio(shmobile_boot_vector_start + clock_status,
+		    &value, sizeof(value));
+}
+EXPORT_SYMBOL(shmobile_set_wdt_clock_status);
+
 #if defined(CONFIG_SMP)
 
 static void __init rcar_gen2_sysc_init(u32 syscier)
@@ -120,8 +130,12 @@ void __init rcar_gen2_pm_init(void)
 	if (!p)
 		return;
 
+	shmobile_boot_vector_start = p;
+	clock_status = (&shmobile_wdt_clock_status -
+				(unsigned long *)shmobile_boot_vector) *
+				sizeof(shmobile_wdt_clock_status);
+
 	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
-	iounmap(p);
 
 	/* setup reset vectors */
 	p = ioremap_nocache(RST, 0x63);
-- 
2.7.4

