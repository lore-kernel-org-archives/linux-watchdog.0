Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 40/62] watchdog: omap_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 16:44:49 -0800
Message-Id: <1484095516-12720-10-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484095516-12720-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/omap_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 1b02bfa81b29..b735d0b04af1 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -274,7 +274,7 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	if (!early_enable)
 		omap_wdt_disable(wdev);
 
-	ret = watchdog_register_device(&wdev->wdog);
+	ret = devm_watchdog_register_device(&pdev->dev, &wdev->wdog);
 	if (ret) {
 		pm_runtime_disable(wdev->dev);
 		return ret;
@@ -309,7 +309,6 @@ static int omap_wdt_remove(struct platform_device *pdev)
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(wdev->dev);
-	watchdog_unregister_device(&wdev->wdog);
 
 	return 0;
 }
-- 
2.7.4
