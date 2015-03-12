Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40623 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753787AbbCLMIP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 12 Mar 2015 08:08:15 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v5 05/10] ARM: at91: at91rm9200: remove deprecated arm_pm_restart
Date: Thu, 12 Mar 2015 13:07:29 +0100
Message-Id: <1426162054-9987-6-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Now that a proper driver is available, remove at91rm9200_restart.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91rm9200.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 8fcfb70f7124..2386d08d65e8 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -24,19 +24,8 @@
 #include <asm/mach/irq.h>
 #include <asm/system_misc.h>
 
-#include <mach/at91_st.h>
-
 #include "generic.h"
 
-static void at91rm9200_restart(enum reboot_mode reboot_mode, const char *cmd)
-{
-	/*
-	 * Perform a hardware reset with the use of the Watchdog timer.
-	 */
-	at91_st_write(AT91_ST_WDMR, AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
-	at91_st_write(AT91_ST_CR, AT91_ST_WDRST);
-}
-
 static void __init at91rm9200_dt_timer_init(void)
 {
 	of_clk_init(NULL);
@@ -48,7 +37,6 @@ static void __init at91rm9200_dt_device_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	arm_pm_idle = at91rm9200_idle;
-	arm_pm_restart = at91rm9200_restart;
 	at91rm9200_pm_init();
 }
 
-- 
2.1.0

