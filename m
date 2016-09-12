Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44846 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932172AbcILNQ4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Sep 2016 09:16:56 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: mt7621_wdt: Remove assignment of dev pointer
Date: Mon, 12 Sep 2016 06:16:51 -0700
Message-Id: <1473686211-5794-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit 0254e953537c ("watchdog: Drop pointer to watchdog device from
struct watchdog_device") removed the dev pointer from struct
watchdog_device, but this driver was still assigning it, leading to
a compilation error:

drivers/watchdog/mt7621_wdt.c: In function 'mt7621_wdt_probe':
drivers/watchdog/mt7621_wdt.c:142:16: error:
	'struct watchdog_device' has no member named 'dev'

Fix this by removing the assignment.

Fixes: 0254e953537c ("watchdog: Drop pointer to watchdog device ...")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/mt7621_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index 4a2290f900a8..d5735c12067d 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -139,7 +139,6 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
 	if (!IS_ERR(mt7621_wdt_reset))
 		reset_control_deassert(mt7621_wdt_reset);
 
-	mt7621_wdt_dev.dev = &pdev->dev;
 	mt7621_wdt_dev.bootstatus = mt7621_wdt_bootcause();
 
 	watchdog_init_timeout(&mt7621_wdt_dev, mt7621_wdt_dev.max_timeout,
-- 
2.5.0

