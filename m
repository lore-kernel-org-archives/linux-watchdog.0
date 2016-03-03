Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34839 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758233AbcCCVUx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2016 16:20:53 -0500
Received: by mail-io0-f194.google.com with SMTP id n190so3363541iof.2
        for <linux-watchdog@vger.kernel.org>; Thu, 03 Mar 2016 13:20:47 -0800 (PST)
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	linux@roeck-us.net, manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be, stigge@antcom.de,
	vz@mleia.com
Subject: [PATCH v6 5/6] arm: lpc32xx: phy3250 remove restart hook
Date: Thu,  3 Mar 2016 16:20:24 -0500
Message-Id: <1457040025-1108-6-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1457040025-1108-1-git-send-email-slemieux.tyco@gmail.com>
References: <1457040025-1108-1-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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

