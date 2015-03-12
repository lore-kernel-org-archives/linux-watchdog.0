Return-path: <alexandre.belloni@free-electrons.com>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v5 09/10] clocksource: atmel-st: remove mach/hardware dependency
Date: Thu, 12 Mar 2015 13:07:33 +0100
Message-Id: <1426162054-9987-10-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Remove the mach/hardware dependency to prepare the driver for multiplatform
support.
Also switch from setup_irq() to request_irq()

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-st.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index 674ef2519d6b..91d6cbb7a56b 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -31,13 +31,12 @@
 
 #include <asm/mach/time.h>
 
-#include <mach/hardware.h>
-
 static unsigned long last_crtr;
 static u32 irqmask;
 static struct clock_event_device clkevt;
 static struct regmap *regmap_st;
 
+#define AT91_SLOW_CLOCK		32768
 #define RM9200_TIMER_LATCH	((AT91_SLOW_CLOCK + HZ/2) / HZ)
 
 /*
@@ -96,13 +95,6 @@ static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static struct irqaction at91rm9200_timer_irq = {
-	.name		= "at91_tick",
-	.flags		= IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= at91rm9200_timer_interrupt,
-	.irq		= NR_IRQS_LEGACY + AT91_ID_SYS,
-};
-
 static cycle_t read_clk32k(struct clocksource *cs)
 {
 	return read_CRTR();
@@ -193,6 +185,7 @@ static struct clock_event_device clkevt = {
 static void __init atmel_st_timer_init(struct device_node *node)
 {
 	unsigned int val;
+	int irq, ret;
 
 	regmap_st = syscon_node_to_regmap(node);
 	if (IS_ERR(regmap_st))
@@ -204,12 +197,16 @@ static void __init atmel_st_timer_init(struct device_node *node)
 	regmap_read(regmap_st, AT91_ST_SR, &val);
 
 	/* Get the interrupts property */
-	at91rm9200_timer_irq.irq  = irq_of_parse_and_map(node, 0);
-	if (!at91rm9200_timer_irq.irq)
+	irq  = irq_of_parse_and_map(node, 0);
+	if (!irq)
 		panic(pr_fmt("Unable to get IRQ from DT\n"));
 
 	/* Make IRQs happen for the system timer */
-	setup_irq(at91rm9200_timer_irq.irq, &at91rm9200_timer_irq);
+	ret = request_irq(irq, at91rm9200_timer_interrupt,
+			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
+			  "at91_tick", regmap_st);
+	if (ret)
+		panic(pr_fmt("Unable to setup IRQ\n"));
 
 	/* The 32KiHz "Slow Clock" (tick every 30517.58 nanoseconds) is used
 	 * directly for the clocksource and all clockevents, after adjusting
-- 
2.1.0
