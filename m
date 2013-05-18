Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:53338 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab3ERWhg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 May 2013 18:37:36 -0400
From: Tomasz Figa <tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, jhbird.choi@samsung.com,
	Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 5/6] ARM: SAMSUNG: Remove legacy watchdog reset code
Date: Sun, 19 May 2013 00:37:06 +0200
Message-Id: <1368916627-23139-6-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
References: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Since all platforms have been moved to the new watchdog reset driver,
the legacy code can be removed safely.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 .../arm/plat-samsung/include/plat/watchdog-reset.h | 35 ----------------------
 1 file changed, 35 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/watchdog-reset.h b/arch/arm/plat-samsung/include/plat/watchdog-reset.h
index 4def1b2..f2dc304 100644
--- a/arch/arm/plat-samsung/include/plat/watchdog-reset.h
+++ b/arch/arm/plat-samsung/include/plat/watchdog-reset.h
@@ -13,41 +13,6 @@
 #ifndef __PLAT_WATCHDOG_RESET_H
 #define __PLAT_WATCHDOG_RESET_H
 
-#include <plat/clock.h>
-#include <plat/regs-watchdog.h>
-#include <mach/map.h>
-
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/delay.h>
-
-static inline void arch_wdt_reset(void)
-{
-	printk("arch_reset: attempting watchdog reset\n");
-
-	__raw_writel(0, S3C2410_WTCON);	  /* disable watchdog, to be safe  */
-
-	if (!IS_ERR(s3c2410_wdtclk))
-		clk_enable(s3c2410_wdtclk);
-
-	/* put initial values into count and data */
-	__raw_writel(0x80, S3C2410_WTCNT);
-	__raw_writel(0x80, S3C2410_WTDAT);
-
-	/* set the watchdog to go and reset... */
-	__raw_writel(S3C2410_WTCON_ENABLE|S3C2410_WTCON_DIV16|S3C2410_WTCON_RSTEN |
-		     S3C2410_WTCON_PRESCALE(0x20), S3C2410_WTCON);
-
-	/* wait for reset to assert... */
-	mdelay(500);
-
-	printk(KERN_ERR "Watchdog reset failed to assert reset\n");
-
-	/* delay to allow the serial port to show the message */
-	mdelay(50);
-}
-
 extern void samsung_wdt_reset(void);
 extern void samsung_wdt_reset_of_init(void);
 extern void samsung_wdt_reset_init(void __iomem *base);
-- 
1.8.2.1

