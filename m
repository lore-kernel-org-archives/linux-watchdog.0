Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33252 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757358AbcCCKaB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2016 05:30:01 -0500
From: Romain Izard <romain.izard.pro@gmail.com>
To: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wenyou Yang <wenyou.yang@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v1] watchdog: sama5d4_wdt: Reset delay on start
Date: Thu,  3 Mar 2016 11:29:39 +0100
Message-Id: <1457000979-15717-1-git-send-email-romain.izard.pro@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If the internal counter is not refreshed when the watchdog is started
for the first time, the watchdog will trigger very rapidly. For example,
opening /dev/watchdog without writing in it will immediately trigger a
reboot, instead of waiting for the delay to expire.

To avoid this problem, reload the timer on opening the watchdog device.

Command: "while sleep 5; do echo 1; done > /dev/watchdog"
Before: system reset
After: the watchdog runs correctly

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/watchdog/sama5d4_wdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index a49634cdc1cc..e162fe140ae1 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/watchdog.h>
+#include <linux/delay.h>
 
 #include "at91sam9_wdt.h"
 
@@ -58,6 +59,8 @@ static int sama5d4_wdt_start(struct watchdog_device *wdd)
 	reg = wdt_read(wdt, AT91_WDT_MR);
 	reg &= ~AT91_WDT_WDDIS;
 	wdt_write(wdt, AT91_WDT_MR, reg);
+	udelay(125); /* > 4 cycles at 32,768 Hz */
+	wdt_write(wdt, AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
 
 	return 0;
 }
-- 
2.5.0

