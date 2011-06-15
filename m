Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59459 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab1FORL0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 15 Jun 2011 13:11:26 -0400
Received: by wya21 with SMTP id 21so460822wya.19
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jun 2011 10:11:25 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 3/5 v3] WATCHDOG: mtx1-wdt: fix GPIO toggling
Date: Wed, 15 Jun 2011 19:15:41 +0200
Cc: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Jamie Iles <jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106151915.42044.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit e391be76 (MIPS: Alchemy: Clean up GPIO registers and accessors)
changed the way the GPIO was toggled. Prior to this patch, we would
always actively drive the GPIO output to either 0 or 1, this patch
drove the GPIO active to 0, and put the GPIO in tristate to drive it
to 1, unfortunately this does not work, revert back to active driving.

Using a signed variable (gstate) to hold the gpio state and using a bit-
wise operation on it also resulted in toggling value from 1 to -2 since
the variable is signed. This value was then passed on to gpio_direction_
output, which always perform a if (value) ... to set the value to the
gpio, so we were always writing a 1 to this GPIO instead of 1 -> 0 -> 1 ...

CC: stable@kernel.org
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- use gpio_set_value() instead of gpio_direction_output(.., value)

Changes since v2:
- fixed stable@kernel.org address

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index b93926e..4b0134e 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -66,7 +66,7 @@ static struct {
 	int default_ticks;
 	unsigned long inuse;
 	unsigned gpio;
-	int gstate;
+	unsigned int gstate;
 } mtx1_wdt_device;
 
 static void mtx1_wdt_trigger(unsigned long unused)
@@ -78,11 +78,8 @@ static void mtx1_wdt_trigger(unsigned long unused)
 		ticks--;
 
 	/* toggle wdt gpio */
-	mtx1_wdt_device.gstate = ~mtx1_wdt_device.gstate;
-	if (mtx1_wdt_device.gstate)
-		gpio_direction_output(mtx1_wdt_device.gpio, 1);
-	else
-		gpio_direction_input(mtx1_wdt_device.gpio);
+	mtx1_wdt_device.gstate = !mtx1_wdt_device.gstate;
+	gpio_set_value(mtx1_wdt_device.gpio, mtx1_wdt_device.gstate);
 
 	if (mtx1_wdt_device.queue && ticks)
 		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
@@ -105,7 +102,7 @@ static void mtx1_wdt_start(void)
 	if (!mtx1_wdt_device.queue) {
 		mtx1_wdt_device.queue = 1;
 		mtx1_wdt_device.gstate = 1;
-		gpio_direction_output(mtx1_wdt_device.gpio, 1);
+		gpio_set_value(mtx1_wdt_device.gpio, 1);
 		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
 	}
 	mtx1_wdt_device.running++;
@@ -120,7 +117,7 @@ static int mtx1_wdt_stop(void)
 	if (mtx1_wdt_device.queue) {
 		mtx1_wdt_device.queue = 0;
 		mtx1_wdt_device.gstate = 0;
-		gpio_direction_output(mtx1_wdt_device.gpio, 0);
+		gpio_set_value(mtx1_wdt_device.gpio, 0);
 	}
 	ticks = mtx1_wdt_device.default_ticks;
 	spin_unlock_irqrestore(&mtx1_wdt_device.lock, flags);
-- 
1.7.4.1

