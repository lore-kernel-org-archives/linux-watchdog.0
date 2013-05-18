Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:41736 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab3ERWhi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 May 2013 18:37:38 -0400
From: Tomasz Figa <tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, jhbird.choi@samsung.com,
	Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 6/6] ARM: SAMSUNG: Remove unused plat/regs-watchdog.h header
Date: Sun, 19 May 2013 00:37:07 +0200
Message-Id: <1368916627-23139-7-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
References: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Since there are no remaining users of this header, it can be safely
dropped.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/plat-samsung/include/plat/regs-watchdog.h | 41 ----------------------
 1 file changed, 41 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-watchdog.h

diff --git a/arch/arm/plat-samsung/include/plat/regs-watchdog.h b/arch/arm/plat-samsung/include/plat/regs-watchdog.h
deleted file mode 100644
index 4938492..0000000
--- a/arch/arm/plat-samsung/include/plat/regs-watchdog.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-watchdog.h
- *
- * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
- *		      http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2410 Watchdog timer control
-*/
-
-
-#ifndef __ASM_ARCH_REGS_WATCHDOG_H
-#define __ASM_ARCH_REGS_WATCHDOG_H
-
-#define S3C_WDOGREG(x) ((x) + S3C_VA_WATCHDOG)
-
-#define S3C2410_WTCON	   S3C_WDOGREG(0x00)
-#define S3C2410_WTDAT	   S3C_WDOGREG(0x04)
-#define S3C2410_WTCNT	   S3C_WDOGREG(0x08)
-
-/* the watchdog can either generate a reset pulse, or an
- * interrupt.
- */
-
-#define S3C2410_WTCON_RSTEN   (0x01)
-#define S3C2410_WTCON_INTEN   (1<<2)
-#define S3C2410_WTCON_ENABLE  (1<<5)
-
-#define S3C2410_WTCON_DIV16   (0<<3)
-#define S3C2410_WTCON_DIV32   (1<<3)
-#define S3C2410_WTCON_DIV64   (2<<3)
-#define S3C2410_WTCON_DIV128  (3<<3)
-
-#define S3C2410_WTCON_PRESCALE(x) ((x) << 8)
-#define S3C2410_WTCON_PRESCALE_MASK (0xff00)
-
-#endif /* __ASM_ARCH_REGS_WATCHDOG_H */
-
-
-- 
1.8.2.1

