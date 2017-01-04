Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 4/4] watchdog: iTCO_wdt: Simplify module init function
Date: Tue,  3 Jan 2017 19:14:15 -0800
Message-Id: <1483499655-24562-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1483499655-24562-1-git-send-email-linux@roeck-us.net>
References: <1483499655-24562-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The 'ret' variable in iTCO_wdt_init_module() does not add any value;
drop it.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Reviewed-by:

 drivers/watchdog/iTCO_wdt.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 9b60f4201c26..d8bb7bf5e669 100644
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
