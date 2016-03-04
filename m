Return-path: <slemieux.tyco@gmail.com>
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	linux@roeck-us.net,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org,
	wim@iguana.be,
	stigge@antcom.de,
	vz@mleia.com
Subject: [PATCH v7 6/6] arm: lpc32xx: remove restart handler
Date: Fri,  4 Mar 2016 13:44:10 -0500
Message-Id: <1457117050-13543-7-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1457117050-13543-1-git-send-email-slemieux.tyco@gmail.com>
References: <1457117050-13543-1-git-send-email-slemieux.tyco@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Sylvain Lemieux <slemieux@tycoint.com>

Remove the restart handler from "mach-lpc32xx";
this functionality is now available in the
pnx4008 watchdog driver.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v6 to v7:
- none.

Changes from v5 to v6:
- none.

Changes from v4 to v5:
- none.

Changes from v3 to v4:
- Switch patch #5 and #6 order.

Changes from v2 to v3:
- move the change to "phy3250.c" into a separate patch.

Changes from v1 to v2:
- new patch in v2.

 arch/arm/mach-lpc32xx/common.c | 15 ---------------
 arch/arm/mach-lpc32xx/common.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 716e83e..5b7a1e7 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -194,21 +194,6 @@ void __init lpc32xx_map_io(void)
 	iotable_init(lpc32xx_io_desc, ARRAY_SIZE(lpc32xx_io_desc));
 }
 
-void lpc23xx_restart(enum reboot_mode mode, const char *cmd)
-{
-	/* Make sure WDT clocks are enabled */
-	__raw_writel(LPC32XX_CLKPWR_PWMCLK_WDOG_EN,
-		LPC32XX_CLKPWR_TIMER_CLK_CTRL);
-
-	/* Instant assert of RESETOUT_N with pulse length 1mS */
-	__raw_writel(13000, io_p2v(LPC32XX_WDTIM_BASE + 0x18));
-	__raw_writel(0x70, io_p2v(LPC32XX_WDTIM_BASE + 0xC));
-
-	/* Wait for watchdog to reset system */
-	while (1)
-		;
-}
-
 static int __init lpc32xx_check_uid(void)
 {
 	u32 uid[4];
diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
index 1cd8853..2d90801 100644
--- a/arch/arm/mach-lpc32xx/common.h
+++ b/arch/arm/mach-lpc32xx/common.h
@@ -30,7 +30,6 @@ extern void lpc32xx_timer_init(void);
 extern void __init lpc32xx_init_irq(void);
 extern void __init lpc32xx_map_io(void);
 extern void __init lpc32xx_serial_init(void);
-extern void lpc23xx_restart(enum reboot_mode, const char *);
 
 
 /*
-- 
1.8.3.1
