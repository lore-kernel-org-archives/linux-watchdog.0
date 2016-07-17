Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55776 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcGQUrv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:47:51 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: tangox: Set max_hw_heartbeat_ms instead of max_timeout
Date: Sun, 17 Jul 2016 13:47:47 -0700
Message-Id: <1468788467-18895-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Setting max_hw_heartbeat_ms lets the watchdog core provide a virtual
timeout if the timeout requested by user space is larger than the maximum
hardware timeout. Also, it helps the watchdog core to provide heartbeats
if the hardware watchdog is running while closed.

Fixes: a3e376d26ace ("watchdog: tangox: Mark running watchdog correctly")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/tangox_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
index e7a5d0fc81d4..202c4b9cc921 100644
--- a/drivers/watchdog/tangox_wdt.c
+++ b/drivers/watchdog/tangox_wdt.c
@@ -149,7 +149,7 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 	dev->wdt.ops = &tangox_wdt_ops;
 	dev->wdt.timeout = DEFAULT_TIMEOUT;
 	dev->wdt.min_timeout = 1;
-	dev->wdt.max_timeout = (U32_MAX - 1) / dev->clk_rate;
+	dev->wdt.max_hw_heartbeat_ms = (U32_MAX - 1) / dev->clk_rate;
 
 	watchdog_init_timeout(&dev->wdt, timeout, &pdev->dev);
 	watchdog_set_nowayout(&dev->wdt, nowayout);
-- 
2.5.0

