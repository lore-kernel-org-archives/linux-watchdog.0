Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:55109 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751315AbeBLRpn (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Feb 2018 12:45:43 -0500
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [PATCH v5 10/26] ARM: shmobile: rcar-gen2: Add watchdog support
Date: Mon, 12 Feb 2018 17:44:19 +0000
Message-Id: <1518457475-4480-11-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds watchdog support by installing shmobile_boot_vector_gen2
to ICRAM1 when enough memory is available, in which case we also keep a
copy of MPIDR to complete the reset vector logic.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
v4->v5:
* reworked comment style

 arch/arm/mach-shmobile/platsmp-apmu.c |  1 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

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
index e5f215c..5a798b4 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -17,6 +17,7 @@
 #include <linux/smp.h>
 #include <linux/soc/renesas/rcar-sysc.h>
 #include <asm/io.h>
+#include <asm/cputype.h>
 #include "common.h"
 #include "rcar-gen2.h"
 
@@ -37,7 +38,6 @@
 #define CA7RESCNT_CODE	0x5a5a0000
 #define CA7RESCNT_CPUS	0xf		/* CPU0-3 */
 
-
 /* On-chip RAM */
 #define ICRAM1		0xe63c0000	/* Inter Connect RAM1 (4 KiB) */
 
@@ -119,8 +119,17 @@ void __init rcar_gen2_pm_init(void)
 	p = ioremap(res.start, resource_size(&res));
 	if (!p)
 		return;
-
-	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
+	/*
+	 * install the reset vector, use the largest version if we have enough
+	 * memory available
+	 */
+	if (resource_size(&res) >= shmobile_boot_size_gen2) {
+		shmobile_boot_cpu_gen2 = read_cpuid_mpidr();
+		memcpy_toio(p, shmobile_boot_vector_gen2,
+			    shmobile_boot_size_gen2);
+	} else {
+		memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
+	}
 	iounmap(p);
 
 	/* setup reset vectors */
-- 
2.7.4

