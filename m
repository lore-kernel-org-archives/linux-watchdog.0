Return-Path: <ezequiel.garcia@free-electrons.com>
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
Subject: [PATCH v7 04/18] watchdog: orion: Make sure the watchdog is initially stopped
Date: Mon, 10 Feb 2014 20:00:23 -0300
Message-Id: <1392073237-2554-5-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Having the watchdog initially fully stopped is important to avoid
any spurious watchdog triggers, in case the registers are not in
its reset state.

If the watchdog rstout is enabled and the watchdog counter running,
this initial stop is not performed, to comply with the 'nowayout'
parameter.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 6746033..e10b0b1 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -77,6 +77,16 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int orion_wdt_enabled(void)
+{
+	bool enabled, running;
+
+	enabled = readl(RSTOUTn_MASK) & WDT_RESET_OUT_EN;
+	running = readl(wdt_reg + TIMER_CTRL) & WDT_EN;
+
+	return enabled && running;
+}
+
 static unsigned int orion_wdt_get_timeleft(struct watchdog_device *wdt_dev)
 {
 	return readl(wdt_reg + WDT_VAL) / wdt_tclk;
@@ -142,6 +152,15 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	orion_wdt.max_timeout = wdt_max_duration;
 	watchdog_init_timeout(&orion_wdt, heartbeat, &pdev->dev);
 
+	/*
+	 * Let's make sure the watchdog is fully stopped, unless it's
+	 * explicitly enabled. This may be the case if the module was
+	 * removed and re-insterted, or if the bootloader explicitly
+	 * set a running watchdog before booting the kernel.
+	 */
+	if (!orion_wdt_enabled())
+		orion_wdt_stop(&orion_wdt);
+
 	watchdog_set_nowayout(&orion_wdt, nowayout);
 	ret = watchdog_register_device(&orion_wdt);
 	if (ret)
-- 
1.8.1.5
