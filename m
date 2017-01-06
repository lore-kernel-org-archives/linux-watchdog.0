Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44581 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757675AbdAFOis (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 6 Jan 2017 09:38:48 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: bcm47xx_wdt: Don't validate platform data on remove
Date: Fri,  6 Jan 2017 06:38:42 -0800
Message-Id: <1483713522-2986-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Platform data was already validated in the probe function. If it was NULL,
the remove function will never be called. Remove the unnecessary check.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/bcm47xx_wdt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index a1900b9ab6c4..35725e21b18a 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -226,9 +226,6 @@ static int bcm47xx_wdt_remove(struct platform_device *pdev)
 {
 	struct bcm47xx_wdt *wdt = dev_get_platdata(&pdev->dev);
 
-	if (!wdt)
-		return -ENXIO;
-
 	watchdog_unregister_device(&wdt->wdd);
 
 	return 0;
-- 
2.7.4

