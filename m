Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36306 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933245AbcBYScB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 25 Feb 2016 13:32:01 -0500
Received: by mail-io0-f194.google.com with SMTP id b188so6393821iof.3
        for <linux-watchdog@vger.kernel.org>; Thu, 25 Feb 2016 10:32:01 -0800 (PST)
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org, arnd@arndb.de, wim@iguana.be,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	stigge@antcom.de, vz@mleia.com
Subject: [PATCH v4 5/6] arm: lpc32xx: phy3250 remove restart hook
Date: Thu, 25 Feb 2016 13:31:39 -0500
Message-Id: <1456425100-28136-6-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1456425100-28136-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456425100-28136-1-git-send-email-slemieux.tyco@gmail.com>
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

