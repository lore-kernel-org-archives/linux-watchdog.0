Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43525 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758369AbdACOjg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Jan 2017 09:39:36 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Fleming <matt.fleming@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/4] watchdog: iTCO_wdt: Simplify module init function
Date: Tue,  3 Jan 2017 06:39:24 -0800
Message-Id: <1483454364-28650-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1483454364-28650-1-git-send-email-linux@roeck-us.net>
References: <1483454364-28650-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The 'ret' variable in iTCO_wdt_init_module() does not add any value;
drop it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/iTCO_wdt.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index ad29ae03a30b..fc7712112412 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -612,15 +612,9 @@ static struct platform_driver iTCO_wdt_driver = {
 
 static int __init iTCO_wdt_init_module(void)
 {
-	int err;
-
 	pr_info("Intel TCO WatchDog Timer Driver v%s\n", DRV_VERSION);
 
-	err = platform_driver_register(&iTCO_wdt_driver);
-	if (err)
-		return err;
-
-	return 0;
+	return platform_driver_register(&iTCO_wdt_driver);
 }
 
 static void __exit iTCO_wdt_cleanup_module(void)
-- 
2.7.4

