Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44469 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab1EITS5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 May 2011 15:18:57 -0400
Received: by wya21 with SMTP id 21so4139491wya.19
        for <linux-watchdog@vger.kernel.org>; Mon, 09 May 2011 12:18:56 -0700 (PDT)
From: Manuel Lauss <manuel.lauss@googlemail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: Florian Fainelli <florian@openwrt.org>,
	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] Watchdog: mtx-1: fix abuse of gpio registers
Date: Mon,  9 May 2011 21:18:34 +0200
Message-Id: <1304968714-3362-1-git-send-email-manuel.lauss@googlemail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch replaces the drivers racy abuse of the gpio2 direction
register with calls to the gpio library.

Cc: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/watchdog/mtx-1_wdt.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 5ec5ac1..011fee4 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -66,6 +66,7 @@ static struct {
 	int default_ticks;
 	unsigned long inuse;
 	unsigned gpio;
+	int gstate;
 } mtx1_wdt_device;
 
 static void mtx1_wdt_trigger(unsigned long unused)
@@ -75,13 +76,13 @@ static void mtx1_wdt_trigger(unsigned long unused)
 	spin_lock(&mtx1_wdt_device.lock);
 	if (mtx1_wdt_device.running)
 		ticks--;
-	/*
-	 * toggle GPIO2_15
-	 */
-	tmp = au_readl(GPIO2_DIR);
-	tmp = (tmp & ~(1 << mtx1_wdt_device.gpio)) |
-	      ((~tmp) & (1 << mtx1_wdt_device.gpio));
-	au_writel(tmp, GPIO2_DIR);
+
+	/* toggle wdt gpio */
+	mtx1_wdt_device.gstate = ~mtx1_wdt_device.gstate;
+	if (mtx1_wdt_device.gstate)
+		gpio_direction_output(mtx1_wdt_device.gpio, 1);
+	else
+		gpio_direction_input(mtx1_wdt_device.gpio);
 
 	if (mtx1_wdt_device.queue && ticks)
 		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
@@ -103,6 +104,7 @@ static void mtx1_wdt_start(void)
 	spin_lock_irqsave(&mtx1_wdt_device.lock, flags);
 	if (!mtx1_wdt_device.queue) {
 		mtx1_wdt_device.queue = 1;
+		mtx1_wdt_device.gstate = 1;
 		gpio_set_value(mtx1_wdt_device.gpio, 1);
 		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
 	}
@@ -117,6 +119,7 @@ static int mtx1_wdt_stop(void)
 	spin_lock_irqsave(&mtx1_wdt_device.lock, flags);
 	if (mtx1_wdt_device.queue) {
 		mtx1_wdt_device.queue = 0;
+		mtx1_wdt_device.gstate = 0;
 		gpio_set_value(mtx1_wdt_device.gpio, 0);
 	}
 	ticks = mtx1_wdt_device.default_ticks;
-- 
1.7.5.rc3

