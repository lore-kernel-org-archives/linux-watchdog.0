Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42246 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754496AbaBFRVH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Feb 2014 12:21:07 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v6 08/19] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
Date: Thu,  6 Feb 2014 14:20:15 -0300
Message-Id: <1391707226-18258-9-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

After adding the IRQ request, the BRIDGE_CAUSE bit should be cleared by the
bridge interrupt controller. There's no longer a need to do it in the watchdog
driver, so we can simply remove it.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index ad141d5..d280b17 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -24,7 +24,6 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <mach/bridge-regs.h>
 
 /* RSTOUT mask register physical address for Orion5x, Kirkwood and Dove */
 #define ORION_RSTOUT_MASK_OFFSET	0x20108
@@ -42,7 +41,6 @@
 #define WDT_MAX_CYCLE_COUNT	0xffffffff
 
 #define WDT_RESET_OUT_EN	BIT(1)
-#define WDT_INT_REQ		BIT(3)
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
@@ -64,9 +62,6 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	/* Set watchdog duration */
 	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
 
-	/* Clear watchdog timer interrupt */
-	writel(~WDT_INT_REQ, BRIDGE_CAUSE);
-
 	/* Enable watchdog timer */
 	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, WDT_EN);
 
-- 
1.8.1.5

