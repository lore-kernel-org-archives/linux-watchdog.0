Return-Path: <david@lechnology.com>
Return-path: <david@lechnology.com>
From: David Lechner <david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: davinci: remove watchdog reset
Date: Sat,  6 Jan 2018 21:10:15 -0600
Message-Id: <1515294615-5473-3-git-send-email-david@lechnology.com>
In-Reply-To: <1515294615-5473-1-git-send-email-david@lechnology.com>
References: <1515294615-5473-1-git-send-email-david@lechnology.com>
List-ID: <linux-watchdog@vger.kernel.org>

This removes the watchdog reset code. The reset has been moved to
drivers/watchdog/davinci_wdt.c. The watchdog driver registers the reset
with the kernel so defining a reset for each machine is no longer needed.

Signed-off-by: David Lechner <david@lechnology.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  1 -
 arch/arm/mach-davinci/board-da850-evm.c     |  1 -
 arch/arm/mach-davinci/board-dm355-evm.c     |  1 -
 arch/arm/mach-davinci/board-dm355-leopard.c |  1 -
 arch/arm/mach-davinci/board-dm365-evm.c     |  1 -
 arch/arm/mach-davinci/board-dm644x-evm.c    |  1 -
 arch/arm/mach-davinci/board-dm646x-evm.c    |  2 -
 arch/arm/mach-davinci/board-mityomapl138.c  |  1 -
 arch/arm/mach-davinci/board-neuros-osd2.c   |  1 -
 arch/arm/mach-davinci/board-omapl138-hawk.c |  1 -
 arch/arm/mach-davinci/board-sffsdr.c        |  1 -
 arch/arm/mach-davinci/clock.h               |  3 --
 arch/arm/mach-davinci/da8xx-dt.c            |  1 -
 arch/arm/mach-davinci/devices-da8xx.c       | 13 -------
 arch/arm/mach-davinci/devices.c             |  7 +---
 arch/arm/mach-davinci/include/mach/common.h |  1 -
 arch/arm/mach-davinci/include/mach/da8xx.h  |  1 -
 arch/arm/mach-davinci/time.c                | 57 -----------------------------
 18 files changed, 1 insertion(+), 94 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index f673cd7..a58bfca 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -642,5 +642,4 @@ MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
 	.init_machine	= da830_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
-	.restart	= da8xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index cbde003..6039ec1 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1485,6 +1485,5 @@ MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
 	.init_machine	= da850_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
-	.restart	= da8xx_restart,
 	.reserve	= da8xx_rproc_reserve_cma,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 62e7bc3..d60d998 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -420,5 +420,4 @@ MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
 	.init_machine = dm355_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
-	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index be99724..1e7e9b8 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -275,5 +275,4 @@ MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
 	.init_machine = dm355_leopard_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
-	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index e75741f..17b2c29 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -778,6 +778,5 @@ MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
 	.init_machine	= dm365_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
-	.restart	= davinci_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index b07c9b1..5e1afc2 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -821,5 +821,4 @@ MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
 	.init_machine = davinci_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
-	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index cb0a41e..003bbe5 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -801,7 +801,6 @@ MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.init_machine = evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
-	.restart	= davinci_restart,
 MACHINE_END
 
 MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
@@ -812,6 +811,5 @@ MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
 	.init_machine = evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
-	.restart	= davinci_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index b73ce7b..0b23cf3 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -574,5 +574,4 @@ MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
 	.init_machine	= mityomapl138_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
-	.restart	= da8xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 0c02aaa..1e27baa 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -231,5 +231,4 @@ MACHINE_START(NEUROS_OSD2, "Neuros OSD2")
 	.init_machine = davinci_ntosd2_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
-	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index a3e7807..88ab45c 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -338,6 +338,5 @@ MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
 	.init_machine	= omapl138_hawk_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
-	.restart	= da8xx_restart,
 	.reserve	= da8xx_rproc_reserve_cma,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index d85accf..1f02d4e 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -154,5 +154,4 @@ MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
 	.init_machine = davinci_sffsdr_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
-	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index fa2b837..d7894d5 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -135,9 +135,6 @@ int davinci_clk_reset(struct clk *clk, bool reset);
 void davinci_clk_enable(struct clk *clk);
 void davinci_clk_disable(struct clk *clk);
 
-extern struct platform_device davinci_wdt_device;
-extern void davinci_watchdog_reset(struct platform_device *);
-
 #endif
 
 #endif
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index f06db67..779e8ce 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -100,7 +100,6 @@ DT_MACHINE_START(DA850_DT, "Generic DA850/OMAP-L138/AM18x")
 	.init_machine	= da850_init_machine,
 	.dt_compat	= da850_boards_compat,
 	.init_late	= davinci_init_late,
-	.restart	= da8xx_restart,
 MACHINE_END
 
 #endif
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index e1c40e7..fe5e15a 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -371,19 +371,6 @@ static struct platform_device da8xx_wdt_device = {
 	.resource	= da8xx_watchdog_resources,
 };
 
-void da8xx_restart(enum reboot_mode mode, const char *cmd)
-{
-	struct device *dev;
-
-	dev = bus_find_device_by_name(&platform_bus_type, NULL, "davinci-wdt");
-	if (!dev) {
-		pr_err("%s: failed to find watchdog device\n", __func__);
-		return;
-	}
-
-	davinci_watchdog_reset(to_platform_device(dev));
-}
-
 int __init da8xx_register_watchdog(void)
 {
 	return platform_device_register(&da8xx_wdt_device);
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 3ae70f2..0edda40 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -282,18 +282,13 @@ static struct resource wdt_resources[] = {
 	},
 };
 
-struct platform_device davinci_wdt_device = {
+static struct platform_device davinci_wdt_device = {
 	.name		= "davinci-wdt",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(wdt_resources),
 	.resource	= wdt_resources,
 };
 
-void davinci_restart(enum reboot_mode mode, const char *cmd)
-{
-	davinci_watchdog_reset(&davinci_wdt_device);
-}
-
 int davinci_init_wdt(void)
 {
 	return platform_device_register(&davinci_wdt_device);
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 433a008..19b9346 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -81,7 +81,6 @@ extern struct davinci_soc_info davinci_soc_info;
 
 extern void davinci_common_init(const struct davinci_soc_info *soc_info);
 extern void davinci_init_ide(void);
-void davinci_restart(enum reboot_mode mode, const char *cmd);
 void davinci_init_late(void);
 
 #ifdef CONFIG_DAVINCI_RESET_CLOCKS
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 93ff156..751d2ac 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -118,7 +118,6 @@ int da850_register_vpif_display
 			(struct vpif_display_config *display_config);
 int da850_register_vpif_capture
 			(struct vpif_capture_config *capture_config);
-void da8xx_restart(enum reboot_mode mode, const char *cmd);
 void da8xx_rproc_reserve_cma(void);
 int da8xx_register_rproc(void);
 int da850_register_gpio(void);
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 034f865..1bb991a 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -80,13 +80,6 @@ enum {
 #define TGCR_UNRESET                 0x1
 #define TGCR_RESET_MASK              0x3
 
-#define WDTCR_WDEN_SHIFT             14
-#define WDTCR_WDEN_DISABLE           0x0
-#define WDTCR_WDEN_ENABLE            0x1
-#define WDTCR_WDKEY_SHIFT            16
-#define WDTCR_WDKEY_SEQ0             0xa5c6
-#define WDTCR_WDKEY_SEQ1             0xda7e
-
 struct timer_s {
 	char *name;
 	unsigned int id;
@@ -409,53 +402,3 @@ void __init davinci_timer_init(void)
 	for (i=0; i< ARRAY_SIZE(timers); i++)
 		timer32_config(&timers[i]);
 }
-
-/* reset board using watchdog timer */
-void davinci_watchdog_reset(struct platform_device *pdev)
-{
-	u32 tgcr, wdtcr;
-	void __iomem *base;
-	struct clk *wd_clk;
-
-	base = ioremap(pdev->resource[0].start, SZ_4K);
-	if (WARN_ON(!base))
-		return;
-
-	wd_clk = clk_get(&pdev->dev, NULL);
-	if (WARN_ON(IS_ERR(wd_clk)))
-		return;
-	clk_prepare_enable(wd_clk);
-
-	/* disable, internal clock source */
-	__raw_writel(0, base + TCR);
-
-	/* reset timer, set mode to 64-bit watchdog, and unreset */
-	tgcr = 0;
-	__raw_writel(tgcr, base + TGCR);
-	tgcr = TGCR_TIMMODE_64BIT_WDOG << TGCR_TIMMODE_SHIFT;
-	tgcr |= (TGCR_UNRESET << TGCR_TIM12RS_SHIFT) |
-		(TGCR_UNRESET << TGCR_TIM34RS_SHIFT);
-	__raw_writel(tgcr, base + TGCR);
-
-	/* clear counter and period regs */
-	__raw_writel(0, base + TIM12);
-	__raw_writel(0, base + TIM34);
-	__raw_writel(0, base + PRD12);
-	__raw_writel(0, base + PRD34);
-
-	/* put watchdog in pre-active state */
-	wdtcr = __raw_readl(base + WDTCR);
-	wdtcr = (WDTCR_WDKEY_SEQ0 << WDTCR_WDKEY_SHIFT) |
-		(WDTCR_WDEN_ENABLE << WDTCR_WDEN_SHIFT);
-	__raw_writel(wdtcr, base + WDTCR);
-
-	/* put watchdog in active state */
-	wdtcr = (WDTCR_WDKEY_SEQ1 << WDTCR_WDKEY_SHIFT) |
-		(WDTCR_WDEN_ENABLE << WDTCR_WDEN_SHIFT);
-	__raw_writel(wdtcr, base + WDTCR);
-
-	/* write an invalid value to the WDKEY field to trigger
-	 * a watchdog reset */
-	wdtcr = 0x00004000;
-	__raw_writel(wdtcr, base + WDTCR);
-}
-- 
2.7.4
