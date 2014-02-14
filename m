Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59278 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753103AbaBNWYo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Feb 2014 17:24:44 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RESEND/PATCH v7 04/18] watchdog: orion: Make sure the watchdog is initially stopped
Date: Fri, 14 Feb 2014 19:24:04 -0300
Message-Id: <1392416658-2780-5-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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

