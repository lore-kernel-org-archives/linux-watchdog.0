Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 15/62] watchdog: davinci_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 15:34:32 -0800
Message-Id: <1484091325-9199-16-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Check return value from clk_prepare_enable()
- Drop assignments to otherwise unused variables
- Drop remove function
- Drop platform_set_drvdata()
- Replace &pdev->dev with dev if 'struct device *dev' is a declared
  variable
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/davinci_wdt.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 0e731d797a2a..98427a30fb17 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -169,13 +169,18 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 
 	if (IS_ERR(davinci_wdt->clk)) {
 		if (PTR_ERR(davinci_wdt->clk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get clock node\n");
+			dev_err(dev, "failed to get clock node\n");
 		return PTR_ERR(davinci_wdt->clk);
 	}
 
-	clk_prepare_enable(davinci_wdt->clk);
-
-	platform_set_drvdata(pdev, davinci_wdt);
+	ret = clk_prepare_enable(davinci_wdt->clk);
+	if (ret)
+		return ret;
+	ret = devm_add_action_or_reset(dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       davinci_wdt->clk);
+	if (ret)
+		return ret;
 
 	wdd			= &davinci_wdt->wdd;
 	wdd->info		= &davinci_wdt_info;
@@ -183,7 +188,7 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 	wdd->min_timeout	= 1;
 	wdd->max_timeout	= MAX_HEARTBEAT;
 	wdd->timeout		= DEFAULT_HEARTBEAT;
-	wdd->parent		= &pdev->dev;
+	wdd->parent		= dev;
 
 	watchdog_init_timeout(wdd, heartbeat, dev);
 
@@ -197,23 +202,13 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(davinci_wdt->base))
 		return PTR_ERR(davinci_wdt->base);
 
-	ret = watchdog_register_device(wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret < 0)
 		dev_err(dev, "cannot register watchdog device\n");
 
 	return ret;
 }
 
-static int davinci_wdt_remove(struct platform_device *pdev)
-{
-	struct davinci_wdt_device *davinci_wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&davinci_wdt->wdd);
-	clk_disable_unprepare(davinci_wdt->clk);
-
-	return 0;
-}
-
 static const struct of_device_id davinci_wdt_of_match[] = {
 	{ .compatible = "ti,davinci-wdt", },
 	{},
@@ -226,7 +221,6 @@ static struct platform_driver platform_wdt_driver = {
 		.of_match_table = davinci_wdt_of_match,
 	},
 	.probe = davinci_wdt_probe,
-	.remove = davinci_wdt_remove,
 };
 
 module_platform_driver(platform_wdt_driver);
-- 
2.7.4
