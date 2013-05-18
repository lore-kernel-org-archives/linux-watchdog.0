Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:48284 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab3ERWhb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 May 2013 18:37:31 -0400
From: Tomasz Figa <tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, jhbird.choi@samsung.com,
	Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 2/6] ARM: SAMSUNG: uncompress: Use local definitions of watchdog registers
Date: Sun, 19 May 2013 00:37:03 +0200
Message-Id: <1368916627-23139-3-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
References: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/plat-samsung/include/plat/uncompress.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index 438b248..e8954b8 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -28,11 +28,20 @@ static void arch_detect_cpu(void);
 /* defines for UART registers */
 
 #include <plat/regs-serial.h>
-#include <plat/regs-watchdog.h>
 
 /* working in physical space... */
-#undef S3C2410_WDOGREG
-#define S3C2410_WDOGREG(x) ((S3C24XX_PA_WATCHDOG + (x)))
+#define S3C_WDOGREG(x)	((S3C_PA_WDT + (x)))
+
+#define S3C2410_WTCON	S3C_WDOGREG(0x00)
+#define S3C2410_WTDAT	S3C_WDOGREG(0x04)
+#define S3C2410_WTCNT	S3C_WDOGREG(0x08)
+
+#define S3C2410_WTCON_RSTEN	(1 << 0)
+#define S3C2410_WTCON_ENABLE	(1 << 5)
+
+#define S3C2410_WTCON_DIV128	(3 << 3)
+
+#define S3C2410_WTCON_PRESCALE(x)	((x) << 8)
 
 /* how many bytes we allow into the FIFO at a time in FIFO mode */
 #define FIFO_MAX	 (14)
-- 
1.8.2.1

