Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH 02/62] watchdog: aspeed_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:19 -0800
Message-Id: <1484091325-9199-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop assignments to otherwise unused variables
- Drop remove function
- Drop platform_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/aspeed_wdt.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index f5ad8023c2e6..1c652582de40 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -136,15 +136,6 @@ static const struct watchdog_info aspeed_wdt_info = {
 	.identity	= KBUILD_MODNAME,
 };
 
-static int aspeed_wdt_remove(struct platform_device *pdev)
-{
-	struct aspeed_wdt *wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&wdt->wdd);
-
-	return 0;
-}
-
 static int aspeed_wdt_probe(struct platform_device *pdev)
 {
 	struct aspeed_wdt *wdt;
@@ -187,20 +178,17 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
 	}
 
-	ret = watchdog_register_device(&wdt->wdd);
+	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register\n");
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, wdt);
-
 	return 0;
 }
 
 static struct platform_driver aspeed_watchdog_driver = {
 	.probe = aspeed_wdt_probe,
-	.remove = aspeed_wdt_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = of_match_ptr(aspeed_wdt_of_table),
-- 
2.7.4
