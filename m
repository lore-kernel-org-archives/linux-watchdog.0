Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 60/62] watchdog: txx9wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 18:09:14 -0800
Message-Id: <1484100561-17638-9-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484100561-17638-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Use devm_clk_get() if the device parameter is not NULL
- Use devm_add_action_or_reset() for calls to clk_put() after clk_get()
  with NULL device parameter
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'val = e; return val;' with 'return e;'
- Replace 'if (e) { return expr; }' with 'if (e) return expr;'
- Drop remove function
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/txx9wdt.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
index 6f7a9deb27d0..28e192367bd9 100644
--- a/drivers/watchdog/txx9wdt.c
+++ b/drivers/watchdog/txx9wdt.c
@@ -110,21 +110,27 @@ static int __init txx9wdt_probe(struct platform_device *dev)
 	if (IS_ERR(txx9_imclk)) {
 		ret = PTR_ERR(txx9_imclk);
 		txx9_imclk = NULL;
-		goto exit;
+		return ret;
 	}
+	ret = devm_add_action_or_reset(&dev->dev, (void(*)(void *))clk_put,
+				       "imbus_clk");
+	if (ret)
+		return ret;
 	ret = clk_prepare_enable(txx9_imclk);
 	if (ret) {
-		clk_put(txx9_imclk);
 		txx9_imclk = NULL;
-		goto exit;
+		return ret;
 	}
+	ret = devm_add_action_or_reset(&dev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       txx9_imclk);
+	if (ret)
+		return ret;
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	txx9wdt_reg = devm_ioremap_resource(&dev->dev, res);
-	if (IS_ERR(txx9wdt_reg)) {
-		ret = PTR_ERR(txx9wdt_reg);
-		goto exit;
-	}
+	if (IS_ERR(txx9wdt_reg))
+		return PTR_ERR(txx9wdt_reg);
 
 	if (timeout < 1 || timeout > WD_MAX_TIMEOUT)
 		timeout = TIMER_MARGIN;
@@ -134,38 +140,18 @@ static int __init txx9wdt_probe(struct platform_device *dev)
 	txx9wdt.parent = &dev->dev;
 	watchdog_set_nowayout(&txx9wdt, nowayout);
 
-	ret = watchdog_register_device(&txx9wdt);
+	watchdog_stop_on_reboot(&txx9wdt);
+	ret = devm_watchdog_register_device(&dev->dev, &txx9wdt);
 	if (ret)
-		goto exit;
+		return ret;
 
 	pr_info("Hardware Watchdog Timer: timeout=%d sec (max %ld) (nowayout= %d)\n",
 		timeout, WD_MAX_TIMEOUT, nowayout);
 
 	return 0;
-exit:
-	if (txx9_imclk) {
-		clk_disable_unprepare(txx9_imclk);
-		clk_put(txx9_imclk);
-	}
-	return ret;
-}
-
-static int __exit txx9wdt_remove(struct platform_device *dev)
-{
-	watchdog_unregister_device(&txx9wdt);
-	clk_disable_unprepare(txx9_imclk);
-	clk_put(txx9_imclk);
-	return 0;
-}
-
-static void txx9wdt_shutdown(struct platform_device *dev)
-{
-	txx9wdt_stop(&txx9wdt);
 }
 
 static struct platform_driver txx9wdt_driver = {
-	.remove = __exit_p(txx9wdt_remove),
-	.shutdown = txx9wdt_shutdown,
 	.driver = {
 		.name = "txx9wdt",
 	},
-- 
2.7.4
