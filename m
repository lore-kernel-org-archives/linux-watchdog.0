Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:59063 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964824AbbCEPum (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Mar 2015 10:50:42 -0500
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v4 7/9] clocksource: atmel-st: properly initialize driver
Date: Thu,  5 Mar 2015 16:49:52 +0100
Message-Id: <1425570594-13124-8-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use clocksource_of_init to initialize the system timer instead of relying on a
custom function.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/mach-at91/at91rm9200.c      | 7 -------
 arch/arm/mach-at91/generic.h         | 3 ---
 drivers/clocksource/timer-atmel-st.c | 4 +++-
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 2386d08d65e8..5efb075294e5 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -26,12 +26,6 @@
 
 #include "generic.h"
 
-static void __init at91rm9200_dt_timer_init(void)
-{
-	of_clk_init(NULL);
-	at91rm9200_timer_init();
-}
-
 static void __init at91rm9200_dt_device_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
@@ -48,7 +42,6 @@ static const char *at91rm9200_dt_board_compat[] __initconst = {
 };
 
 DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200")
-	.init_time      = at91rm9200_dt_timer_init,
 	.map_io		= at91_map_io,
 	.init_machine	= at91rm9200_dt_device_init,
 	.dt_compat	= at91rm9200_dt_board_compat,
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 583369ffc284..6c953bff13d6 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -18,9 +18,6 @@
 extern void __init at91_map_io(void);
 extern void __init at91_alt_map_io(void);
 
- /* Timer */
-extern void at91rm9200_timer_init(void);
-
 /* idle */
 extern void at91rm9200_idle(void);
 extern void at91sam9_idle(void);
diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index b00d09555f2b..7d062ab32674 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -222,7 +222,7 @@ err:
 /*
  * ST (system timer) module supports both clockevents and clocksource.
  */
-void __init at91rm9200_timer_init(void)
+static void __init atmel_st_timer_init(struct device_node *node)
 {
 	/* For device tree enabled device: initialize here */
 	of_at91rm9200_st_init();
@@ -249,3 +249,5 @@ void __init at91rm9200_timer_init(void)
 	/* register clocksource */
 	clocksource_register_hz(&clk32k, AT91_SLOW_CLOCK);
 }
+CLOCKSOURCE_OF_DECLARE(atmel_st_timer, "atmel,at91rm9200-st",
+		       atmel_st_timer_init);
-- 
2.1.0

