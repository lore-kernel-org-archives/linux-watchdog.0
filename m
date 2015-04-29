Return-path: <ukl@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Felipe Balbi <balbi@ti.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Lokesh Vutla <lokeshvutla@ti.com>,
	kernel@pengutronix.de
Subject: [PATCH v2 5/4] watchdog: omap: assert the counter being stopped before reprogramming
Date: Wed, 29 Apr 2015 20:38:46 +0200
Message-Id: <1430332727-27491-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

The omap watchdog has the annoying behaviour that writes to most
registers don't have any effect when the watchdog is already running.
Quoting the AM335x reference manual:

	To modify the timer counter value (the WDT_WCRR register),
	prescaler ratio (the WDT_WCLR[4:2] PTV bit field), delay
	configuration value (the WDT_WDLY[31:0] DLY_VALUE bit field), or
	the load value (the WDT_WLDR[31:0] TIMER_LOAD bit field), the
	watchdog timer must be disabled by using the start/stop sequence
	(the WDT_WSPR register).

Currently the timer is stopped in the .probe callback but still there
are possibilities that yield to a situation where omap_wdt_start is
entered with the timer running (e.g. when /dev/watchdog is closed
without stopping and then reopened). In such a case programming the
timeout silently fails!

To circumvent this stop the timer before reprogramming.

Assuming one of the first things the watchdog user does is setting the
timeout explicitly nothing too bad should happen because this explicit
setting works fine.

Fixes: 7768a13c252a ("[PATCH] OMAP: Add Watchdog driver support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/omap_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 0421c06a6cf0..d7619dd7c1ca 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -135,6 +135,13 @@ static int omap_wdt_start(struct watchdog_device *wdog)
 
 	pm_runtime_get_sync(wdev->dev);
 
+	/*
+	 * Make sure the watchdog is disabled. This is unfortunately required
+	 * because writing to various registers with the watchdog running has no
+	 * effect.
+	 */
+	omap_wdt_disable(wdev);
+
 	/* initialize prescaler */
 	while (readl_relaxed(base + OMAP_WATCHDOG_WPS) & 0x01)
 		cpu_relax();
-- 
2.1.4
