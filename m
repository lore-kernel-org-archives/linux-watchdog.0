Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:36850 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdL3Nvj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 30 Dec 2017 08:51:39 -0500
From: Paul Cercueil <paul@crapouillou.net>
To: Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 8/8] MIPS: jz4740: Drop old platform reset code
Date: Sat, 30 Dec 2017 14:51:08 +0100
Message-Id: <20171230135108.6834-8-paul@crapouillou.net>
In-Reply-To: <20171230135108.6834-1-paul@crapouillou.net>
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This work is now performed by the watchdog driver directly.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/jz4740/reset.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

 v2: No change

diff --git a/arch/mips/jz4740/reset.c b/arch/mips/jz4740/reset.c
index 67780c4b6573..5bf0cf44b55f 100644
--- a/arch/mips/jz4740/reset.c
+++ b/arch/mips/jz4740/reset.c
@@ -12,18 +12,9 @@
  *
  */
 
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/pm.h>
-
 #include <asm/reboot.h>
 
-#include <asm/mach-jz4740/base.h>
-#include <asm/mach-jz4740/timer.h>
-
 #include "reset.h"
-#include "clock.h"
 
 static void jz4740_halt(void)
 {
@@ -36,29 +27,7 @@ static void jz4740_halt(void)
 	}
 }
 
-#define JZ_REG_WDT_DATA 0x00
-#define JZ_REG_WDT_COUNTER_ENABLE 0x04
-#define JZ_REG_WDT_COUNTER 0x08
-#define JZ_REG_WDT_CTRL 0x0c
-
-static void jz4740_restart(char *command)
-{
-	void __iomem *wdt_base = ioremap(JZ4740_WDT_BASE_ADDR, 0x0f);
-
-	jz4740_timer_enable_watchdog();
-
-	writeb(0, wdt_base + JZ_REG_WDT_COUNTER_ENABLE);
-
-	writew(0, wdt_base + JZ_REG_WDT_COUNTER);
-	writew(0, wdt_base + JZ_REG_WDT_DATA);
-	writew(BIT(2), wdt_base + JZ_REG_WDT_CTRL);
-
-	writeb(1, wdt_base + JZ_REG_WDT_COUNTER_ENABLE);
-	jz4740_halt();
-}
-
 void jz4740_reset_init(void)
 {
-	_machine_restart = jz4740_restart;
 	_machine_halt = jz4740_halt;
 }
-- 
2.11.0

