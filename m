Return-Path: <marek.behun@nic.cz>
Return-path: <marek.behun@nic.cz>
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To: linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH watchdog-next] watchdog: armada_37xx_wdt: use do_div for u64 division
Date: Wed, 10 Oct 2018 17:17:27 +0200
Message-Id: <20181010151727.21644-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

When the driver is built on 32 bit architectures during compile test,
the linker complains about "__udivdi3" being undefined. We have to use
do_div macro instead of the division operator when dividing u64 value.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
---
 drivers/watchdog/armada_37xx_wdt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
index c43c313ba63d..4b4054f54df9 100644
--- a/drivers/watchdog/armada_37xx_wdt.c
+++ b/drivers/watchdog/armada_37xx_wdt.c
@@ -156,10 +156,10 @@ static int armada_37xx_wdt_ping(struct watchdog_device *wdt)
 static unsigned int armada_37xx_wdt_get_timeleft(struct watchdog_device *wdt)
 {
 	struct armada_37xx_watchdog *dev = watchdog_get_drvdata(wdt);
-	unsigned int res;
+	u64 res;
 
-	res = get_counter_value(dev, CNTR_ID_WDOG) *
-	      CNTR_CTRL_PRESCALE_MIN / dev->clk_rate;
+	res = get_counter_value(dev, CNTR_ID_WDOG) * CNTR_CTRL_PRESCALE_MIN;
+	do_div(res, dev->clk_rate);
 
 	return res;
 }
@@ -176,7 +176,8 @@ static int armada_37xx_wdt_set_timeout(struct watchdog_device *wdt,
 	 * prescaler, which divides the clock rate by 2
 	 * (CNTR_CTRL_PRESCALE_MIN).
 	 */
-	dev->timeout = (u64)dev->clk_rate * timeout / CNTR_CTRL_PRESCALE_MIN;
+	dev->timeout = (u64)dev->clk_rate * timeout;
+	do_div(dev->timeout, CNTR_CTRL_PRESCALE_MIN);
 
 	return 0;
 }
-- 
2.16.4
