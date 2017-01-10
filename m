Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 29/62] watchdog: max77620_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:46 -0800
Message-Id: <1484091325-9199-30-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
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
 drivers/watchdog/max77620_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
index 68c41fa2be27..fad139a2ebe6 100644
--- a/drivers/watchdog/max77620_wdt.c
+++ b/drivers/watchdog/max77620_wdt.c
@@ -182,7 +182,7 @@ static int max77620_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(wdt_dev, nowayout);
 	watchdog_set_drvdata(wdt_dev, wdt);
 
-	ret = watchdog_register_device(wdt_dev);
+	ret = devm_watchdog_register_device(&pdev->dev, wdt_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "watchdog registration failed: %d\n", ret);
 		return ret;
@@ -196,7 +196,6 @@ static int max77620_wdt_remove(struct platform_device *pdev)
 	struct max77620_wdt *wdt = platform_get_drvdata(pdev);
 
 	max77620_wdt_stop(&wdt->wdt_dev);
-	watchdog_unregister_device(&wdt->wdt_dev);
 
 	return 0;
 }
-- 
2.7.4
