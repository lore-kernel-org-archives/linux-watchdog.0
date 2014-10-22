Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52501 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751004AbaJVNgr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 09:36:47 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 3/4] clocksource: armada-370-xp: Use the reference clock on A375 SoC
Date: Wed, 22 Oct 2014 10:34:43 -0300
Message-Id: <1413984884-20273-4-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The 25 MHz reference clock has better stability so its use is preferred over the
core clock.

This commit takes advantage of the already introduced Armada 375 devicetree
compatible string and adds a new timer initialization. If available, the timer
will use the reference clock (named as 'fixed'). Otherwise, it falls back to the
previous behavior.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../bindings/timer/marvell,armada-370-xp-timer.txt |  9 +++++--
 drivers/clocksource/time-armada-370-xp.c           | 28 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
index f455182..5ef42bf 100644
--- a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
+++ b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
@@ -2,8 +2,10 @@ Marvell Armada 370 and Armada XP Timers
 ---------------------------------------
 
 Required properties:
-- compatible: Should be either "marvell,armada-370-timer" or
-  "marvell,armada-xp-timer" as appropriate.
+- compatible: Should be one of the following
+              "marvell,armada-370-timer",
+	      "marvell,armada-375-timer",
+	      "marvell,armada-xp-timer".
 - interrupts: Should contain the list of Global Timer interrupts and
   then local timer interrupts
 - reg: Should contain location and length for timers register. First
@@ -13,6 +15,9 @@ Required properties:
 Clocks required for compatible = "marvell,armada-370-timer":
 - clocks : Must contain a single entry describing the clock input
 
+Clocks required for compatible = "marvell,armada-375-timer":
+- clocks : Must contain a "fixed" name clock entry
+
 Clocks required for compatible = "marvell,armada-xp-timer":
 - clocks : Must contain an entry for each entry in clock-names.
 - clock-names : Must include the following entries:
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index d8555f9..3a0704b 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -301,6 +301,34 @@ static void __init armada_xp_timer_init(struct device_node *np)
 CLOCKSOURCE_OF_DECLARE(armada_xp, "marvell,armada-xp-timer",
 		       armada_xp_timer_init);
 
+static void __init armada_375_timer_init(struct device_node *np)
+{
+	struct clk *clk;
+
+	clk = of_clk_get_by_name(np, "fixed");
+	if (!IS_ERR(clk)) {
+		clk_prepare_enable(clk);
+		timer_clk = clk_get_rate(clk);
+	} else {
+
+		/*
+		 * This fallback is required in order to retain proper
+		 * devicetree backwards compatibility.
+		 */
+		clk = of_clk_get(np, 0);
+
+		/* Must have at least a clock */
+		BUG_ON(IS_ERR(clk));
+		clk_prepare_enable(clk);
+		timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
+		timer25Mhz = false;
+	}
+
+	armada_370_xp_timer_common_init(np);
+}
+CLOCKSOURCE_OF_DECLARE(armada_375, "marvell,armada-375-timer",
+		       armada_375_timer_init);
+
 static void __init armada_370_timer_init(struct device_node *np)
 {
 	struct clk *clk = of_clk_get(np, 0);
-- 
2.1.0

