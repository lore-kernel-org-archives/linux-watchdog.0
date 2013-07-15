Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60496 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758366Ab3GOXdZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jul 2013 19:33:25 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree-discuss@lists.ozlabs.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	wim@iguana.be, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 02/10] watchdog: orion: Use thread-safe clocksource API
Date: Mon, 15 Jul 2013 20:32:35 -0300
Message-Id: <1373931163-12670-3-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The TIMER_CTRL register allows to control timer and watchdog counters,
so it's a register shared between the clocksource and the watchdog
drivers. In order to prevent race-conditions the clocksource driver
exposed a thread-safe API. Use the API.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index da57798..c0597f4 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -25,12 +25,12 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/time-orion.h>
 #include <mach/bridge-regs.h>
 
 /*
  * Watchdog timer block registers.
  */
-#define TIMER_CTRL		0x0000
 #define WDT_EN			0x0010
 #define WDT_VAL			0x0024
 
@@ -72,9 +72,7 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	writel(reg, BRIDGE_CAUSE);
 
 	/* Enable watchdog timer */
-	reg = readl(wdt_reg + TIMER_CTRL);
-	reg |= WDT_EN;
-	writel(reg, wdt_reg + TIMER_CTRL);
+	orion_timer_ctrl_clrset(0, WDT_EN);
 
 	/* Enable reset on watchdog */
 	reg = readl(RSTOUTn_MASK);
@@ -97,9 +95,7 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 	writel(reg, RSTOUTn_MASK);
 
 	/* Disable watchdog timer */
-	reg = readl(wdt_reg + TIMER_CTRL);
-	reg &= ~WDT_EN;
-	writel(reg, wdt_reg + TIMER_CTRL);
+	orion_timer_ctrl_clrset(WDT_EN, 0);
 
 	spin_unlock(&wdt_lock);
 	return 0;
-- 
1.8.1.5

