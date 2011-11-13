Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 16.mo4.mail-out.ovh.net ([188.165.55.104]:47191 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752453Ab1KMUlc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 13 Nov 2011 15:41:32 -0500
Received: from mail172.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 4B23BFFC411
	for <linux-watchdog@vger.kernel.org>; Sun, 13 Nov 2011 19:20:26 +0100 (CET)
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 10/12] ARM: at91: make watchdog drivers soc independent
Date: Sun, 13 Nov 2011 19:12:30 +0100
Message-Id: <1321207952-13556-10-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <20111113180954.GD15318@game.jcrosoft.org>
References: <20111113180954.GD15318@game.jcrosoft.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

switch the watchdog drivers to resource and pass it via platform_device

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-watchdog@vger.kernel.org
---
HI Wim,

	this is part of a at91 cleanup
	if you don't mind I'll apply via at91 tree

Best Regards,
J.
 arch/arm/mach-at91/at91_devices.c             |  122 +++++++++++++++++++++++++
 arch/arm/mach-at91/at91cap9_devices.c         |   11 ++-
 arch/arm/mach-at91/at91sam9260_devices.c      |   11 ++-
 arch/arm/mach-at91/at91sam9261_devices.c      |   11 ++-
 arch/arm/mach-at91/at91sam9263_devices.c      |   11 ++-
 arch/arm/mach-at91/at91sam9g45_devices.c      |   11 ++-
 arch/arm/mach-at91/at91sam9rl_devices.c       |   11 ++-
 arch/arm/mach-at91/include/mach/at91cap9.h    |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9260.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9261.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9263.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 +-
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    2 +-
 drivers/watchdog/at91sam9_wdt.c               |   22 ++++-
 drivers/watchdog/at91sam9_wdt.h               |    6 +-
 15 files changed, 210 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/mach-at91/at91_devices.c

diff --git a/arch/arm/mach-at91/at91_devices.c b/arch/arm/mach-at91/at91_devices.c
new file mode 100644
index 0000000..d0d55b4
--- /dev/null
+++ b/arch/arm/mach-at91/at91_devices.c
@@ -0,0 +1,122 @@
+/*
+ * arch/arm/mach-at91/at91cap9_devices.c
+ *
+ *  Copyright (C) 2007 Stelian Pop <stelian.pop@leadtechdesign.com>
+ *  Copyright (C) 2007 Lead Tech Design <www.leadtechdesign.com>
+ *  Copyright (C) 2007 Atmel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <mach/gpio.h>
+
+#include "generic.h"
+
+void at91cap9_configure_dbgu_pins(void)
+{
+	at91_set_A_periph(AT91_PIN_PC30, 0);		/* DRXD */
+	at91_set_A_periph(AT91_PIN_PC31, 1);		/* DTXD */
+}
+
+void at91cap9_configure_usart0_pins(unsigned pins)
+{
+	at91_set_A_periph(AT91_PIN_PA22, 1);		/* TXD0 */
+	at91_set_A_periph(AT91_PIN_PA23, 0);		/* RXD0 */
+
+	if (pins & ATMEL_UART_RTS)
+		at91_set_A_periph(AT91_PIN_PA24, 0);	/* RTS0 */
+	if (pins & ATMEL_UART_CTS)
+		at91_set_A_periph(AT91_PIN_PA25, 0);	/* CTS0 */
+}
+
+void at91cap9_configure_usart1_pins(unsigned pins)
+{
+	at91_set_A_periph(AT91_PIN_PD0, 1);		/* TXD1 */
+	at91_set_A_periph(AT91_PIN_PD1, 0);		/* RXD1 */
+
+	if (pins & ATMEL_UART_RTS)
+		at91_set_B_periph(AT91_PIN_PD7, 0);	/* RTS1 */
+	if (pins & ATMEL_UART_CTS)
+		at91_set_B_periph(AT91_PIN_PD8, 0);	/* CTS1 */
+}
+
+void at91cap9_configure_usart2_pins(unsigned pins)
+{
+	at91_set_A_periph(AT91_PIN_PD2, 1);		/* TXD2 */
+	at91_set_A_periph(AT91_PIN_PD3, 0);		/* RXD2 */
+
+	if (pins & ATMEL_UART_RTS)
+		at91_set_B_periph(AT91_PIN_PD5, 0);	/* RTS2 */
+	if (pins & ATMEL_UART_CTS)
+		at91_set_B_periph(AT91_PIN_PD6, 0);	/* CTS2 */
+}
+
+void at91rm9200_configure_dbgu_pins(void)
+{
+	at91_set_A_periph(AT91_PIN_PA30, 0);		/* DRXD */
+	at91_set_A_periph(AT91_PIN_PA31, 1);		/* DTXD */
+}
+
+void at91rm9200_configure_usart0_pins(unsigned pins)
+{
+	at91_set_A_periph(AT91_PIN_PA17, 1);		/* TXD0 */
+	at91_set_A_periph(AT91_PIN_PA18, 0);		/* RXD0 */
+
+	if (pins & ATMEL_UART_CTS)
+		at91_set_A_periph(AT91_PIN_PA20, 0);	/* CTS0 */
+
+	if (pins & ATMEL_UART_RTS) {
+		/*
+		 * AT91RM9200 Errata #39 - RTS0 is not internally connected to PA21.
+		 *  We need to drive the pin manually.  Default is off (RTS is active low).
+		 */
+		at91_set_gpio_output(AT91_PIN_PA21, 1);
+	}
+}
+
+void at91rm9200_configure_usart1_pins(unsigned pins)
+{
+	at91_set_A_periph(AT91_PIN_PB20, 1);		/* TXD1 */
+	at91_set_A_periph(AT91_PIN_PB21, 0);		/* RXD1 */
+
+	if (pins & ATMEL_UART_RI)
+		at91_set_A_periph(AT91_PIN_PB18, 0);	/* RI1 */
+	if (pins & ATMEL_UART_DTR)
+		at91_set_A_periph(AT91_PIN_PB19, 0);	/* DTR1 */
+	if (pins & ATMEL_UART_DCD)
+		at91_set_A_periph(AT91_PIN_PB23, 0);	/* DCD1 */
+	if (pins & ATMEL_UART_CTS)
+		at91_set_A_periph(AT91_PIN_PB24, 0);	/* CTS1 */
+	if (pins & ATMEL_UART_DSR)
+		at91_set_A_periph(AT91_PIN_PB25, 0);	/* DSR1 */
+	if (pins & ATMEL_UART_RTS)
+		at91_set_A_periph(AT91_PIN_PB26, 0);	/* RTS1 */
+}
+
+void at91rm9200_configure_usart2_pins(unsigned pins)
+{
+	at91_set_A_periph(AT91_PIN_PA22, 0);		/* RXD2 */
+	at91_set_A_periph(AT91_PIN_PA23, 1);		/* TXD2 */
+
+	if (pins & ATMEL_UART_CTS)
+		at91_set_B_periph(AT91_PIN_PA30, 0);	/* CTS2 */
+	if (pins & ATMEL_UART_RTS)
+		at91_set_B_periph(AT91_PIN_PA31, 0);	/* RTS2 */
+}
+
+void at91rm9200_configure_usart3_pins(unsigned pins)
+{
+	at91_set_B_periph(AT91_PIN_PA5, 1);		/* TXD3 */
+	at91_set_B_periph(AT91_PIN_PA6, 0);		/* RXD3 */
+
+	if (pins & ATMEL_UART_CTS)
+		at91_set_B_periph(AT91_PIN_PB1, 0);	/* CTS3 */
+	if (pins & ATMEL_UART_RTS)
+		at91_set_B_periph(AT91_PIN_PB0, 0);	/* RTS3 */
+}
+
+
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 3262a7e..019dac0 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -694,10 +694,19 @@ static void __init at91_add_device_rtt(void)
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
+static struct resource wdt_resources[] = {
+	{
+		.start	= AT91CAP9_BASE_WDT,
+		.end	= AT91CAP9_BASE_WDT + SZ_16 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91cap9_wdt_device = {
 	.name		= "at91_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= wdt_resources,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
 };
 
 static void __init at91_add_device_watchdog(void)
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 63cbfb8..9cdaffa 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -738,10 +738,19 @@ static void __init at91_add_device_rtt(void)
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
+static struct resource wdt_resources[] = {
+	{
+		.start	= AT91SAM9260_BASE_WDT,
+		.end	= AT91SAM9260_BASE_WDT + SZ_16 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91sam9260_wdt_device = {
 	.name		= "at91_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= wdt_resources,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
 };
 
 static void __init at91_add_device_watchdog(void)
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index d5bd1e7..c59e1e9 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -624,10 +624,19 @@ static void __init at91_add_device_rtt(void)
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
+static struct resource wdt_resources[] = {
+	{
+		.start	= AT91SAM9261_BASE_WDT,
+		.end	= AT91SAM9261_BASE_WDT + SZ_16 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91sam9261_wdt_device = {
 	.name		= "at91_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= wdt_resources,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
 };
 
 static void __init at91_add_device_watchdog(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 5d2b061..b5f4e25 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -996,10 +996,19 @@ static void __init at91_add_device_rtt(void)
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
+static struct resource wdt_resources[] = {
+	{
+		.start	= AT91SAM9263_BASE_WDT,
+		.end	= AT91SAM9263_BASE_WDT + SZ_16 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91sam9263_wdt_device = {
 	.name		= "at91_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= wdt_resources,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
 };
 
 static void __init at91_add_device_watchdog(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index bb2ba0c..3b91706 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1133,10 +1133,19 @@ static void __init at91_add_device_trng(void) {}
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
+static struct resource wdt_resources[] = {
+	{
+		.start	= AT91SAM9G45_BASE_WDT,
+		.end	= AT91SAM9G45_BASE_WDT + SZ_16 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91sam9g45_wdt_device = {
 	.name		= "at91_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= wdt_resources,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
 };
 
 static void __init at91_add_device_watchdog(void)
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index f9b423b..c7961b4 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -709,10 +709,19 @@ static void __init at91_add_device_rtt(void)
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
+static struct resource wdt_resources[] = {
+	{
+		.start	= AT91SAM9RL_BASE_WDT,
+		.end	= AT91SAM9RL_BASE_WDT + SZ_16 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
 static struct platform_device at91sam9rl_wdt_device = {
 	.name		= "at91_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= wdt_resources,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
 };
 
 static void __init at91_add_device_watchdog(void)
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index f2e7c34..844cba1 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -86,7 +86,6 @@
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
-#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(cpu_is_at91cap9_revB() ?	\
 			(0xfffffd50 - AT91_BASE_SYS) :	\
 			(0xfffffd60 - AT91_BASE_SYS))
@@ -102,6 +101,7 @@
 #define AT91CAP9_BASE_SHDWC	0xfffffd10
 #define AT91CAP9_BASE_RTT	0xfffffd20
 #define AT91CAP9_BASE_PIT	0xfffffd30
+#define AT91CAP9_BASE_WDT	0xfffffd40
 
 #define AT91_USART0	AT91CAP9_BASE_US0
 #define AT91_USART1	AT91CAP9_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 6a13e9d..8a26045 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -86,7 +86,6 @@
 #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
-#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
 #define AT91SAM9260_BASE_ECC	0xffffe800
@@ -98,6 +97,7 @@
 #define AT91SAM9260_BASE_SHDWC	0xfffffd10
 #define AT91SAM9260_BASE_RTT	0xfffffd20
 #define AT91SAM9260_BASE_PIT	0xfffffd30
+#define AT91SAM9260_BASE_WDT	0xfffffd40
 
 #define AT91_USART0	AT91SAM9260_BASE_US0
 #define AT91_USART1	AT91SAM9260_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
index f9b5163..df2ddfd 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9261.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
@@ -71,7 +71,6 @@
 #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
-#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
 
 #define AT91SAM9261_BASE_SMC	0xffffec00
@@ -81,6 +80,7 @@
 #define AT91SAM9261_BASE_SHDWC	0xfffffd10
 #define AT91SAM9261_BASE_RTT	0xfffffd20
 #define AT91SAM9261_BASE_PIT	0xfffffd30
+#define AT91SAM9261_BASE_WDT	0xfffffd40
 
 #define AT91_USART0	AT91SAM9261_BASE_US0
 #define AT91_USART1	AT91SAM9261_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index e8fb5bd..f958ac9 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -81,7 +81,6 @@
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
-#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 
 #define AT91SAM9263_BASE_ECC0	0xffffe000
@@ -97,6 +96,7 @@
 #define AT91SAM9263_BASE_SHDWC	0xfffffd10
 #define AT91SAM9263_BASE_RTT0	0xfffffd20
 #define AT91SAM9263_BASE_PIT	0xfffffd30
+#define AT91SAM9263_BASE_WDT	0xfffffd40
 #define AT91SAM9263_BASE_RTT1	0xfffffd50
 
 #define AT91_USART0	AT91SAM9263_BASE_US0
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index 5f3453e..65098c3 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -93,7 +93,6 @@
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
-#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 #define AT91_RTC	(0xfffffdb0 - AT91_BASE_SYS)
 
@@ -108,6 +107,7 @@
 #define AT91SAM9G45_BASE_SHDWC	0xfffffd10
 #define AT91SAM9G45_BASE_RTT	0xfffffd20
 #define AT91SAM9G45_BASE_PIT	0xfffffd30
+#define AT91SAM9G45_BASE_WDT	0xfffffd40
 
 #define AT91_USART0	AT91SAM9G45_BASE_US0
 #define AT91_USART1	AT91SAM9G45_BASE_US1
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index e012e69..6aee975 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -75,7 +75,6 @@
 #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
 #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
-#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
 #define AT91_SCKCR	(0xfffffd50 - AT91_BASE_SYS)
 #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
 #define AT91_RTC	(0xfffffe00 - AT91_BASE_SYS)
@@ -91,6 +90,7 @@
 #define AT91SAM9RL_BASE_SHDWC	0xfffffd10
 #define AT91SAM9RL_BASE_RTT	0xfffffd20
 #define AT91SAM9RL_BASE_PIT	0xfffffd30
+#define AT91SAM9RL_BASE_WDT	0xfffffd40
 
 #define AT91_USART0	AT91SAM9RL_BASE_US0
 #define AT91_USART1	AT91SAM9RL_BASE_US1
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 87445b2..0056256 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -35,6 +35,11 @@
 
 #define DRV_NAME "AT91SAM9 Watchdog"
 
+#define wdt_read(field) \
+	__raw_readl(at91wdt_private.base + field)
+#define wdt_write(field, val) \
+	__raw_writel((val), at91wdt_private.base + field)
+
 /* AT91SAM9 watchdog runs a 12bit counter @ 256Hz,
  * use this to convert a watchdog
  * value from/to milliseconds.
@@ -63,6 +68,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 static void at91_ping(unsigned long data);
 
 static struct {
+	void __iomem *base;
 	unsigned long next_heartbeat;	/* the next_heartbeat for the timer */
 	unsigned long open;
 	char expect_close;
@@ -77,7 +83,7 @@ static struct {
  */
 static inline void at91_wdt_reset(void)
 {
-	at91_sys_write(AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
+	wdt_write(AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
 }
 
 /*
@@ -132,7 +138,7 @@ static int at91_wdt_settimeout(unsigned int timeout)
 	unsigned int mr;
 
 	/* Check if disabled */
-	mr = at91_sys_read(AT91_WDT_MR);
+	mr = wdt_read(AT91_WDT_MR);
 	if (mr & AT91_WDT_WDDIS) {
 		printk(KERN_ERR DRV_NAME": sorry, watchdog is disabled\n");
 		return -EIO;
@@ -149,7 +155,7 @@ static int at91_wdt_settimeout(unsigned int timeout)
 		| AT91_WDT_WDDBGHLT	/* disabled in debug mode */
 		| AT91_WDT_WDD		/* restart at any time */
 		| (timeout & AT91_WDT_WDV);  /* timer value */
-	at91_sys_write(AT91_WDT_MR, reg);
+	wdt_write(AT91_WDT_MR, reg);
 
 	return 0;
 }
@@ -248,12 +254,22 @@ static struct miscdevice at91wdt_miscdev = {
 
 static int __init at91wdt_probe(struct platform_device *pdev)
 {
+	struct resource	*r;
 	int res;
 
 	if (at91wdt_miscdev.parent)
 		return -EBUSY;
 	at91wdt_miscdev.parent = &pdev->dev;
 
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+	at91wdt_private.base = ioremap(r->start, resource_size(r));
+	if (!at91wdt_private.base) {
+		dev_err(&pdev->dev, "failed to map registers, aborting.\n");
+		return -ENOMEM;
+	}
+
 	/* Set watchdog */
 	res = at91_wdt_settimeout(ms_to_ticks(WDT_HW_TIMEOUT * 1000));
 	if (res)
diff --git a/drivers/watchdog/at91sam9_wdt.h b/drivers/watchdog/at91sam9_wdt.h
index 757f9ca..c6fbb2e6 100644
--- a/drivers/watchdog/at91sam9_wdt.h
+++ b/drivers/watchdog/at91sam9_wdt.h
@@ -16,11 +16,11 @@
 #ifndef AT91_WDT_H
 #define AT91_WDT_H
 
-#define AT91_WDT_CR		(AT91_WDT + 0x00)	/* Watchdog Control Register */
+#define AT91_WDT_CR		0x00			/* Watchdog Control Register */
 #define		AT91_WDT_WDRSTT		(1    << 0)		/* Restart */
 #define		AT91_WDT_KEY		(0xa5 << 24)		/* KEY Password */
 
-#define AT91_WDT_MR		(AT91_WDT + 0x04)	/* Watchdog Mode Register */
+#define AT91_WDT_MR		0x04			/* Watchdog Mode Register */
 #define		AT91_WDT_WDV		(0xfff << 0)		/* Counter Value */
 #define		AT91_WDT_WDFIEN		(1     << 12)		/* Fault Interrupt Enable */
 #define		AT91_WDT_WDRSTEN	(1     << 13)		/* Reset Processor */
@@ -30,7 +30,7 @@
 #define		AT91_WDT_WDDBGHLT	(1     << 28)		/* Debug Halt */
 #define		AT91_WDT_WDIDLEHLT	(1     << 29)		/* Idle Halt */
 
-#define AT91_WDT_SR		(AT91_WDT + 0x08)	/* Watchdog Status Register */
+#define AT91_WDT_SR		0x08			/* Watchdog Status Register */
 #define		AT91_WDT_WDUNF		(1 << 0)		/* Watchdog Underflow */
 #define		AT91_WDT_WDERR		(1 << 1)		/* Watchdog Error */
 
-- 
1.7.7

