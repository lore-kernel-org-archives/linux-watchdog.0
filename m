Return-Path: <ezequiel.garcia@free-electrons.com>
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v5 02/20] clocksource: orion: Use atomic access for shared registers
Date: Mon, 27 Jan 2014 12:27:02 -0300
Message-Id: <1390836440-12744-3-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Replace the driver-specific thread-safe shared register API
by the recently introduced atomic_io_clear_set().

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clocksource/time-orion.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
index 9c7f018..3f14e56 100644
--- a/drivers/clocksource/time-orion.c
+++ b/drivers/clocksource/time-orion.c
@@ -35,20 +35,6 @@
 #define ORION_ONESHOT_MAX	0xfffffffe
 
 static void __iomem *timer_base;
-static DEFINE_SPINLOCK(timer_ctrl_lock);
-
-/*
- * Thread-safe access to TIMER_CTRL register
- * (shared with watchdog timer)
- */
-void orion_timer_ctrl_clrset(u32 clr, u32 set)
-{
-	spin_lock(&timer_ctrl_lock);
-	writel((readl(timer_base + TIMER_CTRL) & ~clr) | set,
-		timer_base + TIMER_CTRL);
-	spin_unlock(&timer_ctrl_lock);
-}
-EXPORT_SYMBOL(orion_timer_ctrl_clrset);
 
 /*
  * Free-running clocksource handling.
@@ -68,7 +54,8 @@ static int orion_clkevt_next_event(unsigned long delta,
 {
 	/* setup and enable one-shot timer */
 	writel(delta, timer_base + TIMER1_VAL);
-	orion_timer_ctrl_clrset(TIMER1_RELOAD_EN, TIMER1_EN);
+	atomic_io_modify(timer_base + TIMER_CTRL,
+		TIMER1_RELOAD_EN | TIMER1_EN, TIMER1_EN);
 
 	return 0;
 }
@@ -80,10 +67,13 @@ static void orion_clkevt_mode(enum clock_event_mode mode,
 		/* setup and enable periodic timer at 1/HZ intervals */
 		writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD);
 		writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL);
-		orion_timer_ctrl_clrset(0, TIMER1_RELOAD_EN | TIMER1_EN);
+		atomic_io_modify(timer_base + TIMER_CTRL,
+			TIMER1_RELOAD_EN | TIMER1_EN,
+			TIMER1_RELOAD_EN | TIMER1_EN);
 	} else {
 		/* disable timer */
-		orion_timer_ctrl_clrset(TIMER1_RELOAD_EN | TIMER1_EN, 0);
+		atomic_io_modify(timer_base + TIMER_CTRL,
+			TIMER1_RELOAD_EN | TIMER1_EN, 0);
 	}
 }
 
@@ -131,7 +121,9 @@ static void __init orion_timer_init(struct device_node *np)
 	/* setup timer0 as free-running clocksource */
 	writel(~0, timer_base + TIMER0_VAL);
 	writel(~0, timer_base + TIMER0_RELOAD);
-	orion_timer_ctrl_clrset(0, TIMER0_RELOAD_EN | TIMER0_EN);
+	atomic_io_modify(timer_base + TIMER_CTRL,
+		TIMER0_RELOAD_EN | TIMER0_EN,
+		TIMER0_RELOAD_EN | TIMER0_EN);
 	clocksource_mmio_init(timer_base + TIMER0_VAL, "orion_clocksource",
 			      clk_get_rate(clk), 300, 32,
 			      clocksource_mmio_readl_down);
-- 
1.8.1.5
