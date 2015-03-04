Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:47205 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758638AbbCDOVt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Mar 2015 09:21:49 -0500
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
Subject: [PATCH v3 8/9] clocksource: atmel-st: use syscon/regmap
Date: Wed,  4 Mar 2015 15:21:36 +0100
Message-Id: <1425478897-27322-9-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The register range from the system timer is also used by the watchdog driver.
Use a regmap to handle concurrent accesses.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/clocksource/timer-atmel-st.c | 99 ++++++++++++++----------------------
 1 file changed, 37 insertions(+), 62 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index 7d062ab32674..c4a52e32675e 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -24,19 +24,19 @@
 #include <linux/irq.h>
 #include <linux/clockchips.h>
 #include <linux/export.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/atmel-st.h>
 #include <linux/of_irq.h>
+#include <linux/regmap.h>
 
 #include <asm/mach/time.h>
 
-#include <mach/at91_st.h>
-#include <mach/hardware.h>
-
 static unsigned long last_crtr;
 static u32 irqmask;
 static struct clock_event_device clkevt;
+static struct regmap *regmap_st;
 
+#define AT91_SLOW_CLOCK		32768
 #define RM9200_TIMER_LATCH	((AT91_SLOW_CLOCK + HZ/2) / HZ)
 
 /*
@@ -46,11 +46,11 @@ static struct clock_event_device clkevt;
  */
 static inline unsigned long read_CRTR(void)
 {
-	unsigned long x1, x2;
+	unsigned int x1, x2;
 
-	x1 = at91_st_read(AT91_ST_CRTR);
+	regmap_read(regmap_st, AT91_ST_CRTR, &x1);
 	do {
-		x2 = at91_st_read(AT91_ST_CRTR);
+		regmap_read(regmap_st, AT91_ST_CRTR, &x2);
 		if (x1 == x2)
 			break;
 		x1 = x2;
@@ -63,7 +63,10 @@ static inline unsigned long read_CRTR(void)
  */
 static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
 {
-	u32	sr = at91_st_read(AT91_ST_SR) & irqmask;
+	u32 sr;
+
+	regmap_read(regmap_st, AT91_ST_SR, &sr);
+	sr &= irqmask;
 
 	/*
 	 * irqs should be disabled here, but as the irq is shared they are only
@@ -96,7 +99,7 @@ static struct irqaction at91rm9200_timer_irq = {
 	.name		= "at91_tick",
 	.flags		= IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= at91rm9200_timer_interrupt,
-	.irq		= NR_IRQS_LEGACY + AT91_ID_SYS,
+	.irq		= 0,
 };
 
 static cycle_t read_clk32k(struct clocksource *cs)
@@ -115,23 +118,25 @@ static struct clocksource clk32k = {
 static void
 clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 {
+	unsigned int val;
+
 	/* Disable and flush pending timer interrupts */
-	at91_st_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
-	at91_st_read(AT91_ST_SR);
+	regmap_write(regmap_st, AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
+	regmap_read(regmap_st, AT91_ST_SR, &val);
 
 	last_crtr = read_CRTR();
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* PIT for periodic irqs; fixed rate of 1/HZ */
 		irqmask = AT91_ST_PITS;
-		at91_st_write(AT91_ST_PIMR, RM9200_TIMER_LATCH);
+		regmap_write(regmap_st, AT91_ST_PIMR, RM9200_TIMER_LATCH);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* ALM for oneshot irqs, set by next_event()
 		 * before 32 seconds have passed
 		 */
 		irqmask = AT91_ST_ALMS;
-		at91_st_write(AT91_ST_RTAR, last_crtr);
+		regmap_write(regmap_st, AT91_ST_RTAR, last_crtr);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_UNUSED:
@@ -139,7 +144,7 @@ clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 		irqmask = 0;
 		break;
 	}
-	at91_st_write(AT91_ST_IER, irqmask);
+	regmap_write(regmap_st, AT91_ST_IER, irqmask);
 }
 
 static int
@@ -147,6 +152,7 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
 {
 	u32		alm;
 	int		status = 0;
+	unsigned int	val;
 
 	BUG_ON(delta < 2);
 
@@ -162,12 +168,12 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
 	alm = read_CRTR();
 
 	/* Cancel any pending alarm; flush any pending IRQ */
-	at91_st_write(AT91_ST_RTAR, alm);
-	at91_st_read(AT91_ST_SR);
+	regmap_write(regmap_st, AT91_ST_RTAR, alm);
+	regmap_read(regmap_st, AT91_ST_SR, &val);
 
 	/* Schedule alarm by writing RTAR. */
 	alm += delta;
-	at91_st_write(AT91_ST_RTAR, alm);
+	regmap_write(regmap_st, AT91_ST_RTAR, alm);
 
 	return status;
 }
@@ -180,57 +186,26 @@ static struct clock_event_device clkevt = {
 	.set_mode	= clkevt32k_mode,
 };
 
-void __iomem *at91_st_base;
-EXPORT_SYMBOL_GPL(at91_st_base);
-
-static const struct of_device_id at91rm9200_st_timer_ids[] = {
-	{ .compatible = "atmel,at91rm9200-st" },
-	{ /* sentinel */ }
-};
-
-static int __init of_at91rm9200_st_init(void)
-{
-	struct device_node *np;
-	int ret;
-
-	np = of_find_matching_node(NULL, at91rm9200_st_timer_ids);
-	if (!np)
-		goto err;
-
-	at91_st_base = of_iomap(np, 0);
-	if (!at91_st_base)
-		goto node_err;
-
-	/* Get the interrupts property */
-	ret = irq_of_parse_and_map(np, 0);
-	if (!ret)
-		goto ioremap_err;
-	at91rm9200_timer_irq.irq = ret;
-
-	of_node_put(np);
-
-	return 0;
-
-ioremap_err:
-	iounmap(at91_st_base);
-node_err:
-	of_node_put(np);
-err:
-	return -EINVAL;
-}
-
 /*
  * ST (system timer) module supports both clockevents and clocksource.
  */
 static void __init atmel_st_timer_init(struct device_node *node)
 {
-	/* For device tree enabled device: initialize here */
-	of_at91rm9200_st_init();
+	unsigned int val;
+
+	regmap_st = syscon_node_to_regmap(node);
+	if (IS_ERR(regmap_st))
+		panic(pr_fmt("Unable to get regmap\n"));
 
 	/* Disable all timer interrupts, and clear any pending ones */
-	at91_st_write(AT91_ST_IDR,
+	regmap_write(regmap_st, AT91_ST_IDR,
 		AT91_ST_PITS | AT91_ST_WDOVF | AT91_ST_RTTINC | AT91_ST_ALMS);
-	at91_st_read(AT91_ST_SR);
+	regmap_read(regmap_st, AT91_ST_SR, &val);
+
+	/* Get the interrupts property */
+	at91rm9200_timer_irq.irq  = irq_of_parse_and_map(node, 0);
+	if (!at91rm9200_timer_irq.irq)
+		panic(pr_fmt("Unable to get IRQ from DT\n"));
 
 	/* Make IRQs happen for the system timer */
 	setup_irq(at91rm9200_timer_irq.irq, &at91rm9200_timer_irq);
@@ -239,7 +214,7 @@ static void __init atmel_st_timer_init(struct device_node *node)
 	 * directly for the clocksource and all clockevents, after adjusting
 	 * its prescaler from the 1 Hz default.
 	 */
-	at91_st_write(AT91_ST_RTMR, 1);
+	regmap_write(regmap_st, AT91_ST_RTMR, 1);
 
 	/* Setup timer clockevent, with minimum of two ticks (important!!) */
 	clkevt.cpumask = cpumask_of(0);
-- 
2.1.0

