Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Baruch Siach <baruch@tkos.co.il>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 16/62] watchdog: digicolor_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 15:34:33 -0800
Message-Id: <1484091325-9199-17-git-send-email-linux@roeck-us.net>
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

- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'val = e; return val;' with 'return e;'
- Drop assignments to otherwise unused variables
- Replace 'if (e) { return expr; }' with 'if (e) return expr;'
- Drop remove function
- Replace of_iomap() with platform_get_resource() followed by
  devm_ioremap_resource()
- Drop platform_set_drvdata()
- Replace &pdev->dev with dev if 'struct device *dev' is a declared
  variable
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Cc: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/digicolor_wdt.c | 48 ++++++++++------------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
index dfe72944822d..870694d9ebc7 100644
--- a/drivers/watchdog/digicolor_wdt.c
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -119,62 +119,40 @@ static struct watchdog_device dc_wdt_wdd = {
 
 static int dc_wdt_probe(struct platform_device *pdev)
 {
+	struct resource *res;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct dc_wdt *wdt;
 	int ret;
 
 	wdt = devm_kzalloc(dev, sizeof(struct dc_wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
-	platform_set_drvdata(pdev, wdt);
 
-	wdt->base = of_iomap(np, 0);
-	if (!wdt->base) {
-		dev_err(dev, "Failed to remap watchdog regs");
-		return -ENODEV;
-	}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdt->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
 
-	wdt->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(wdt->clk)) {
-		ret = PTR_ERR(wdt->clk);
-		goto err_iounmap;
-	}
+	wdt->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(wdt->clk))
+		return PTR_ERR(wdt->clk);
 	dc_wdt_wdd.max_timeout = U32_MAX / clk_get_rate(wdt->clk);
 	dc_wdt_wdd.timeout = dc_wdt_wdd.max_timeout;
-	dc_wdt_wdd.parent = &pdev->dev;
+	dc_wdt_wdd.parent = dev;
 
 	spin_lock_init(&wdt->lock);
 
 	watchdog_set_drvdata(&dc_wdt_wdd, wdt);
 	watchdog_set_restart_priority(&dc_wdt_wdd, 128);
 	watchdog_init_timeout(&dc_wdt_wdd, timeout, dev);
-	ret = watchdog_register_device(&dc_wdt_wdd);
+	watchdog_stop_on_reboot(&dc_wdt_wdd);
+	ret = devm_watchdog_register_device(dev, &dc_wdt_wdd);
 	if (ret) {
 		dev_err(dev, "Failed to register watchdog device");
-		goto err_iounmap;
+		return ret;
 	}
 
 	return 0;
-
-err_iounmap:
-	iounmap(wdt->base);
-	return ret;
-}
-
-static int dc_wdt_remove(struct platform_device *pdev)
-{
-	struct dc_wdt *wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&dc_wdt_wdd);
-	iounmap(wdt->base);
-
-	return 0;
-}
-
-static void dc_wdt_shutdown(struct platform_device *pdev)
-{
-	dc_wdt_stop(&dc_wdt_wdd);
 }
 
 static const struct of_device_id dc_wdt_of_match[] = {
@@ -185,8 +163,6 @@ MODULE_DEVICE_TABLE(of, dc_wdt_of_match);
 
 static struct platform_driver dc_wdt_driver = {
 	.probe		= dc_wdt_probe,
-	.remove		= dc_wdt_remove,
-	.shutdown	= dc_wdt_shutdown,
 	.driver = {
 		.name =		"digicolor-wdt",
 		.of_match_table = dc_wdt_of_match,
-- 
2.7.4
