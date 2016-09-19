Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:47675 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbcISTme (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 15:42:34 -0400
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 2/4] ARM: sa11x0/pxa: acquire timer rate from the clock rate
Date: Mon, 19 Sep 2016 21:12:13 +0200
Message-Id: <1474312335-20997-3-git-send-email-robert.jarzmik@free.fr>
In-Reply-To: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

As both pxa and sa1100 provide a clock to the timer, the rate can be
inferred from the clock rather than hard encoded in a functional call.

This patch changes the pxa timer to have a mandatory clock which is used
as the timer rate.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/generic.c     |  3 +--
 arch/arm/mach-sa1100/generic.c  |  2 +-
 drivers/clocksource/pxa_timer.c | 11 +++++------
 include/clocksource/pxa.h       |  3 +--
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index ec510ecf8370..2a9297991d74 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -69,8 +69,7 @@ void __init pxa_timer_init(void)
 		pxa27x_clocks_init();
 	if (cpu_is_pxa3xx())
 		pxa3xx_clocks_init();
-	pxa_timer_nodt_init(IRQ_OST0, io_p2v(0x40a00000),
-			    get_clock_tick_rate());
+	pxa_timer_nodt_init(IRQ_OST0, io_p2v(0x40a00000));
 }
 
 /*
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 3e09beddb6e8..2eb00691b07d 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -378,7 +378,7 @@ void __init sa1100_map_io(void)
 
 void __init sa1100_timer_init(void)
 {
-	pxa_timer_nodt_init(IRQ_OST0, io_p2v(0x90000000), 3686400);
+	pxa_timer_nodt_init(IRQ_OST0, io_p2v(0x90000000));
 }
 
 static struct resource irq_resource =
diff --git a/drivers/clocksource/pxa_timer.c b/drivers/clocksource/pxa_timer.c
index 3e1cb512f3ce..9cae38eebec2 100644
--- a/drivers/clocksource/pxa_timer.c
+++ b/drivers/clocksource/pxa_timer.c
@@ -220,17 +220,16 @@ CLOCKSOURCE_OF_DECLARE(pxa_timer, "marvell,pxa-timer", pxa_timer_dt_init);
 /*
  * Legacy timer init for non device-tree boards.
  */
-void __init pxa_timer_nodt_init(int irq, void __iomem *base,
-	unsigned long clock_tick_rate)
+void __init pxa_timer_nodt_init(int irq, void __iomem *base)
 {
 	struct clk *clk;
 
 	timer_base = base;
 	clk = clk_get(NULL, "OSTIMER0");
-	if (clk && !IS_ERR(clk))
+	if (clk && !IS_ERR(clk)) {
 		clk_prepare_enable(clk);
-	else
+		pxa_timer_common_init(irq, clk_get_rate(clk));
+	} else {
 		pr_crit("%s: unable to get clk\n", __func__);
-
-	pxa_timer_common_init(irq, clock_tick_rate);
+	}
 }
diff --git a/include/clocksource/pxa.h b/include/clocksource/pxa.h
index 1efbe5a66958..a9a0f03024a4 100644
--- a/include/clocksource/pxa.h
+++ b/include/clocksource/pxa.h
@@ -12,7 +12,6 @@
 #ifndef _CLOCKSOURCE_PXA_H
 #define _CLOCKSOURCE_PXA_H
 
-extern void pxa_timer_nodt_init(int irq, void __iomem *base,
-			   unsigned long clock_tick_rate);
+extern void pxa_timer_nodt_init(int irq, void __iomem *base);
 
 #endif
-- 
2.1.4

