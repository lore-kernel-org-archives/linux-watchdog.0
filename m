Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:58670 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbdHHWxy (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 8 Aug 2017 18:53:54 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v9 15/16] MIPS: lantiq: remove old USB PHY initialisation
Date: Wed,  9 Aug 2017 00:52:46 +0200
Message-Id: <20170808225247.32266-16-hauke@hauke-m.de>
In-Reply-To: <20170808225247.32266-1-hauke@hauke-m.de>
References: <20170808225247.32266-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is now done in a PHY driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/xway/reset.c | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index be5fd29de523..04cd9a7c04a3 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -114,45 +114,6 @@ static void ltq_machine_power_off(void)
 	unreachable();
 }
 
-static void ltq_usb_init(void)
-{
-	/* Power for USB cores 1 & 2 */
-	ltq_pmu_enable(PMU_AHBM);
-	ltq_pmu_enable(PMU_USB0);
-	ltq_pmu_enable(PMU_USB1);
-
-	ltq_rcu_w32(ltq_rcu_r32(RCU_CFG1A) | BIT(0), RCU_CFG1A);
-	ltq_rcu_w32(ltq_rcu_r32(RCU_CFG1B) | BIT(0), RCU_CFG1B);
-
-	/* Enable USB PHY power for cores 1 & 2 */
-	ltq_pmu_enable(PMU_USB0_P);
-	ltq_pmu_enable(PMU_USB1_P);
-
-	/* Configure cores to host mode */
-	ltq_rcu_w32(ltq_rcu_r32(RCU_USB1CFG) & ~RCU_USBCFG_HDSEL_BIT,
-		RCU_USB1CFG);
-	ltq_rcu_w32(ltq_rcu_r32(RCU_USB2CFG) & ~RCU_USBCFG_HDSEL_BIT,
-		RCU_USB2CFG);
-
-	/* Select DMA endianness (Host-endian: big-endian) */
-	ltq_rcu_w32((ltq_rcu_r32(RCU_USB1CFG) & ~RCU_USBCFG_SLV_END_BIT)
-		| RCU_USBCFG_HOST_END_BIT, RCU_USB1CFG);
-	ltq_rcu_w32(ltq_rcu_r32((RCU_USB2CFG) & ~RCU_USBCFG_SLV_END_BIT)
-		| RCU_USBCFG_HOST_END_BIT, RCU_USB2CFG);
-
-	/* Hard reset USB state machines */
-	ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET) | USBRESET_BIT, RCU_USBRESET);
-	udelay(50 * 1000);
-	ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET) & ~USBRESET_BIT, RCU_USBRESET);
-
-	/* Soft reset USB state machines */
-	ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET2)
-		| USB1RESET_BIT | USB2RESET_BIT, RCU_USBRESET2);
-	udelay(50 * 1000);
-	ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET2)
-		& ~(USB1RESET_BIT | USB2RESET_BIT), RCU_USBRESET2);
-}
-
 static int __init mips_reboot_setup(void)
 {
 	struct resource res;
@@ -176,10 +137,6 @@ static int __init mips_reboot_setup(void)
 	if (!ltq_rcu_membase)
 		panic("Failed to remap core memory");
 
-	if (of_machine_is_compatible("lantiq,ar9") ||
-	    of_machine_is_compatible("lantiq,vr9"))
-		ltq_usb_init();
-
 	_machine_restart = ltq_machine_restart;
 	_machine_halt = ltq_machine_halt;
 	pm_power_off = ltq_machine_power_off;
-- 
2.11.0

