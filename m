Return-path: <alexandre.belloni@free-electrons.com>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 2/3] watchdog: sama5d4: Fix setting timeout when watchdog is disabled
Date: Thu, 16 Feb 2017 20:30:52 +0100
Message-Id: <20170216193053.5546-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170216193053.5546-1-alexandre.belloni@free-electrons.com>
References: <20170216193053.5546-1-alexandre.belloni@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

The datasheet states: "When setting the WDDIS bit, and while it is set, the
fields WDV and WDD must not be modified."

Ensure WDDIS is not set when changing the timeout and set it afterwards if
the watchdog was disabled.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Changes in v2:
 - new patch
 drivers/watchdog/sama5d4_wdt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 2c6f5a70ae67..2a60251806d2 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -90,11 +90,18 @@ static int sama5d4_wdt_set_timeout(struct watchdog_device *wdd,
 	u32 reg;
 
 	reg = wdt_read(wdt, AT91_WDT_MR);
+
+	if (reg & AT91_WDT_WDDIS)
+		wdt_write(wdt, AT91_WDT_MR, reg & ~AT91_WDT_WDDIS);
+
 	reg &= ~AT91_WDT_WDV;
 	reg &= ~AT91_WDT_WDD;
 	reg |= AT91_WDT_SET_WDV(value);
 	reg |= AT91_WDT_SET_WDD(value);
-	wdt_write(wdt, AT91_WDT_MR, reg);
+	wdt_write(wdt, AT91_WDT_MR, reg & ~AT91_WDT_WDDIS);
+
+	if (reg & AT91_WDT_WDDIS)
+		wdt_write(wdt, AT91_WDT_MR, reg);
 
 	wdd->timeout = timeout;
 
-- 
2.11.0
