Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33563 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752686AbaBJXAv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Feb 2014 18:00:51 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v7 02/18] watchdog: orion: Use atomic access for shared registers
Date: Mon, 10 Feb 2014 20:00:21 -0300
Message-Id: <1392073237-2554-3-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Since the timer control register is shared with the clocksource driver,
use the recently introduced atomic_io_clear_set() to access such register.
Given the watchdog core already provides serialization for all the
watchdog ops, this commit allows to remove the spinlock entirely.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 42 +++++-------------------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 7f19fa3..b92a991 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -20,7 +20,6 @@
 #include <linux/watchdog.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/spinlock.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/of.h>
@@ -46,25 +45,16 @@ static unsigned int wdt_max_duration;	/* (seconds) */
 static struct clk *clk;
 static unsigned int wdt_tclk;
 static void __iomem *wdt_reg;
-static DEFINE_SPINLOCK(wdt_lock);
 
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 {
-	spin_lock(&wdt_lock);
-
 	/* Reload watchdog duration */
 	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
-
-	spin_unlock(&wdt_lock);
 	return 0;
 }
 
 static int orion_wdt_start(struct watchdog_device *wdt_dev)
 {
-	u32 reg;
-
-	spin_lock(&wdt_lock);
-
 	/* Set watchdog duration */
 	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
 
@@ -72,48 +62,26 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	writel(~WDT_INT_REQ, BRIDGE_CAUSE);
 
 	/* Enable watchdog timer */
-	reg = readl(wdt_reg + TIMER_CTRL);
-	reg |= WDT_EN;
-	writel(reg, wdt_reg + TIMER_CTRL);
+	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, WDT_EN);
 
 	/* Enable reset on watchdog */
-	reg = readl(RSTOUTn_MASK);
-	reg |= WDT_RESET_OUT_EN;
-	writel(reg, RSTOUTn_MASK);
-
-	spin_unlock(&wdt_lock);
+	atomic_io_modify(RSTOUTn_MASK, WDT_RESET_OUT_EN, WDT_RESET_OUT_EN);
 	return 0;
 }
 
 static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 {
-	u32 reg;
-
-	spin_lock(&wdt_lock);
-
 	/* Disable reset on watchdog */
-	reg = readl(RSTOUTn_MASK);
-	reg &= ~WDT_RESET_OUT_EN;
-	writel(reg, RSTOUTn_MASK);
+	atomic_io_modify(RSTOUTn_MASK, WDT_RESET_OUT_EN, 0);
 
 	/* Disable watchdog timer */
-	reg = readl(wdt_reg + TIMER_CTRL);
-	reg &= ~WDT_EN;
-	writel(reg, wdt_reg + TIMER_CTRL);
-
-	spin_unlock(&wdt_lock);
+	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, 0);
 	return 0;
 }
 
 static unsigned int orion_wdt_get_timeleft(struct watchdog_device *wdt_dev)
 {
-	unsigned int time_left;
-
-	spin_lock(&wdt_lock);
-	time_left = readl(wdt_reg + WDT_VAL) / wdt_tclk;
-	spin_unlock(&wdt_lock);
-
-	return time_left;
+	return readl(wdt_reg + WDT_VAL) / wdt_tclk;
 }
 
 static int orion_wdt_set_timeout(struct watchdog_device *wdt_dev,
-- 
1.8.1.5

