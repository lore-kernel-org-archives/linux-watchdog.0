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
Subject: [PATCH v7 5/6] arm: lpc32xx: phy3250 remove restart hook
Date: Fri,  4 Mar 2016 13:44:09 -0500
Message-Id: <1457117050-13543-6-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1457117050-13543-1-git-send-email-slemieux.tyco@gmail.com>
References: <1457117050-13543-1-git-send-email-slemieux.tyco@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Sylvain Lemieux <slemieux@tycoint.com>

Remove the restart hook assignment from phy3250;
this functionality is now managed by
the pnx4008 watchdog driver.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Note:
This patch was generated with the option "--unified=2" to ensure
it can be apply before or after the changes for the new 
LPC32xx irqchip driver:
- http://permalink.gmane.org/gmane.linux.drivers.devicetree/144683

Changes from v6 to v7:
- none.

Changes from v5 to v6:
- none.

Changes from v4 to v5:
- none.

Changes from v3 to v4:
- Switch patch #5 and #6 order.

Changes from v2 to v3:
- new patch in v3.

 arch/arm/mach-lpc32xx/phy3250.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index a19071a..9e5c3db 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -211,4 +211,3 @@ DT_MACHINE_START(LPC32XX_DT, "LPC32XX SoC (Flattened Device Tree)")
 	.init_machine	= lpc3250_machine_init,
 	.dt_compat	= lpc32xx_dt_compat,
-	.restart	= lpc23xx_restart,
 MACHINE_END
-- 
1.8.3.1
