Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36667 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeINP1t (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Sep 2018 11:27:49 -0400
From: Romain Izard <romain.izard.pro@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 2/2] watchdog: sama5d4: write the mode register in two steps
Date: Fri, 14 Sep 2018 12:13:39 +0200
Message-Id: <20180914101339.7382-3-romain.izard.pro@gmail.com>
In-Reply-To: <20180914101339.7382-1-romain.izard.pro@gmail.com>
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The specification for SAMA5D2 and SAMA5D4 chips, that use this IP for
their watchdog timer, has the following advice regarding the Mode Register:

"When setting the WDDIS bit, and while it is set, the fields WDV and WDD
must not be modified."

I have observed on a board based on a SAMA5D2 chip that using any other
timeout duration than the default 16s in the device tree will reset the
board when the watchdog device is opened; this is probably due to ignoring
the aforementioned constraint.

To fix this, read the content of the Mode Register before writing it,
and split the access into two parts if WDV or WDD need to be changed.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/watchdog/sama5d4_wdt.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 1e93c1b0e3cf..1e05268ad94b 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -46,7 +46,10 @@ MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
 	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-#define wdt_enabled (!(wdt->mr & AT91_WDT_WDDIS))
+#define wdt_enabled(reg) (!((reg) & AT91_WDT_WDDIS))
+
+#define wdt_different_counters(reg_a, reg_b) \
+	(((reg_a) ^ (reg_b)) & (AT91_WDT_WDV | AT91_WDT_WDD))
 
 #define wdt_read(wdt, field) \
 	readl_relaxed((wdt)->reg_base + (field))
@@ -78,8 +81,11 @@ static void wdt_write_nosleep(struct sama5d4_wdt *wdt, u32 field, u32 val)
 static int sama5d4_wdt_start(struct watchdog_device *wdd)
 {
 	struct sama5d4_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 reg = wdt_read(wdt, AT91_WDT_MR);
 
 	wdt->mr &= ~AT91_WDT_WDDIS;
+	if (!wdt_enabled(reg) && wdt_different_counters(reg, wdt->mr))
+		wdt_write(wdt, AT91_WDT_MR, reg & ~AT91_WDT_WDDIS);
 	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
 
 	return 0;
@@ -88,8 +94,11 @@ static int sama5d4_wdt_start(struct watchdog_device *wdd)
 static int sama5d4_wdt_stop(struct watchdog_device *wdd)
 {
 	struct sama5d4_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 reg = wdt_read(wdt, AT91_WDT_MR);
 
 	wdt->mr |= AT91_WDT_WDDIS;
+	if (wdt_enabled(reg) && wdt_different_counters(reg, wdt->mr))
+		wdt_write(wdt, AT91_WDT_MR, wdt->mr & ~AT91_WDT_WDDIS);
 	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
 
 	return 0;
@@ -122,7 +131,7 @@ static int sama5d4_wdt_set_timeout(struct watchdog_device *wdd,
 	 * If the watchdog is enabled, then the timeout can be updated. Else,
 	 * wait that the user enables it.
 	 */
-	if (wdt_enabled)
+	if (wdt_enabled(wdt->mr))
 		wdt_write(wdt, AT91_WDT_MR, wdt->mr & ~AT91_WDT_WDDIS);
 
 	wdd->timeout = timeout;
@@ -186,13 +195,17 @@ static int sama5d4_wdt_init(struct sama5d4_wdt *wdt)
 	 * If the watchdog is already running, we can safely update it.
 	 * Else, we have to disable it properly.
 	 */
-	if (wdt_enabled) {
+	reg = wdt_read(wdt, AT91_WDT_MR);
+	if (wdt_enabled(reg)) {
+		if (!wdt_enabled(wdt->mr))
+			wdt_write_nosleep(wdt, AT91_WDT_MR,
+					  wdt->mr & ~AT91_WDT_WDDIS);
 		wdt_write_nosleep(wdt, AT91_WDT_MR, wdt->mr);
-	} else {
-		reg = wdt_read(wdt, AT91_WDT_MR);
-		if (!(reg & AT91_WDT_WDDIS))
+	} else if (wdt_enabled(wdt->mr)) {
+		if (wdt_different_counters(reg, wdt->mr))
 			wdt_write_nosleep(wdt, AT91_WDT_MR,
-					  reg | AT91_WDT_WDDIS);
+					  reg & ~AT91_WDT_WDDIS);
+		wdt_write_nosleep(wdt, AT91_WDT_MR, wdt->mr);
 	}
 	return 0;
 }
-- 
2.17.1
