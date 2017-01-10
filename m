Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 07/62] watchdog: bcm7038_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 15:34:24 -0800
Message-Id: <1484091325-9199-8-git-send-email-linux@roeck-us.net>
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
- Replace &pdev->dev with dev if 'struct device *dev' is a declared
  variable
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/bcm7038_wdt.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
index c1b8e534fb55..a17942e5e0a6 100644
--- a/drivers/watchdog/bcm7038_wdt.c
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -136,7 +136,14 @@ static int bcm7038_wdt_probe(struct platform_device *pdev)
 	wdt->clk = devm_clk_get(dev, NULL);
 	/* If unable to get clock, use default frequency */
 	if (!IS_ERR(wdt->clk)) {
-		clk_prepare_enable(wdt->clk);
+		err = clk_prepare_enable(wdt->clk);
+		if (err)
+			return err;
+		err = devm_add_action_or_reset(dev,
+					(void(*)(void *))clk_disable_unprepare,
+					wdt->clk);
+		if (err)
+			return err;
 		wdt->rate = clk_get_rate(wdt->clk);
 		/* Prevent divide-by-zero exception */
 		if (!wdt->rate)
@@ -154,10 +161,10 @@ static int bcm7038_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.parent		= dev;
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 
-	err = watchdog_register_device(&wdt->wdd);
+	watchdog_stop_on_reboot(&wdt->wdd);
+	err = devm_watchdog_register_device(dev, &wdt->wdd);
 	if (err) {
 		dev_err(dev, "Failed to register watchdog device\n");
-		clk_disable_unprepare(wdt->clk);
 		return err;
 	}
 
@@ -173,9 +180,6 @@ static int bcm7038_wdt_remove(struct platform_device *pdev)
 	if (!nowayout)
 		bcm7038_wdt_stop(&wdt->wdd);
 
-	watchdog_unregister_device(&wdt->wdd);
-	clk_disable_unprepare(wdt->clk);
-
 	return 0;
 }
 
@@ -204,14 +208,6 @@ static int bcm7038_wdt_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(bcm7038_wdt_pm_ops, bcm7038_wdt_suspend,
 			 bcm7038_wdt_resume);
 
-static void bcm7038_wdt_shutdown(struct platform_device *pdev)
-{
-	struct bcm7038_watchdog *wdt = platform_get_drvdata(pdev);
-
-	if (watchdog_active(&wdt->wdd))
-		bcm7038_wdt_stop(&wdt->wdd);
-}
-
 static const struct of_device_id bcm7038_wdt_match[] = {
 	{ .compatible = "brcm,bcm7038-wdt" },
 	{},
@@ -221,7 +217,6 @@ MODULE_DEVICE_TABLE(of, bcm7038_wdt_match);
 static struct platform_driver bcm7038_wdt_driver = {
 	.probe		= bcm7038_wdt_probe,
 	.remove		= bcm7038_wdt_remove,
-	.shutdown	= bcm7038_wdt_shutdown,
 	.driver		= {
 		.name		= "bcm7038-wdt",
 		.of_match_table	= bcm7038_wdt_match,
-- 
2.7.4
