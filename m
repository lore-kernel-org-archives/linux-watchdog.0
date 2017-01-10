Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/62] watchdog: coh901327_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:27 -0800
Message-Id: <1484091325-9199-11-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Use devm_clk_get() if the device parameter is not NULL
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'val = e; return val;' with 'return e;'
- Replace 'if (e) { return expr; }' with 'if (e) return expr;'
- Replace request_irq, request_threaded_irq, and request_any_context_irq
  with their device managed equivalent
- Replace &pdev->dev with dev if 'struct device *dev' is a declared
  variable
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/coh901327_wdt.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index 38dd60f0cfcc..8b6f7f35c479 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -241,11 +241,7 @@ static struct watchdog_device coh901327_wdt = {
 
 static int __exit coh901327_remove(struct platform_device *pdev)
 {
-	watchdog_unregister_device(&coh901327_wdt);
 	coh901327_disable();
-	free_irq(irq, pdev);
-	clk_disable_unprepare(clk);
-	clk_put(clk);
 	return 0;
 }
 
@@ -263,7 +259,7 @@ static int __init coh901327_probe(struct platform_device *pdev)
 	if (IS_ERR(virtbase))
 		return PTR_ERR(virtbase);
 
-	clk = clk_get(dev, NULL);
+	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
 		dev_err(dev, "could not get clock\n");
@@ -272,8 +268,13 @@ static int __init coh901327_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(clk);
 	if (ret) {
 		dev_err(dev, "could not prepare and enable clock\n");
-		goto out_no_clk_enable;
+		return ret;
 	}
+	ret = devm_add_action_or_reset(dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       clk);
+	if (ret)
+		return ret;
 
 	val = readw(virtbase + U300_WDOG_SR);
 	switch (val) {
@@ -309,31 +310,21 @@ static int __init coh901327_probe(struct platform_device *pdev)
 	writew(U300_WDOG_SR_RESET_STATUS_RESET, virtbase + U300_WDOG_SR);
 
 	irq = platform_get_irq(pdev, 0);
-	if (request_irq(irq, coh901327_interrupt, 0,
-			DRV_NAME " Bark", pdev)) {
-		ret = -EIO;
-		goto out_no_irq;
-	}
+	if (devm_request_irq(dev, irq, coh901327_interrupt, 0,
+			     DRV_NAME " Bark", pdev))
+		return -EIO;
 
 	ret = watchdog_init_timeout(&coh901327_wdt, margin, dev);
 	if (ret < 0)
 		coh901327_wdt.timeout = 60;
 
 	coh901327_wdt.parent = dev;
-	ret = watchdog_register_device(&coh901327_wdt);
+	ret = devm_watchdog_register_device(dev, &coh901327_wdt);
 	if (ret)
-		goto out_no_wdog;
+		return ret;
 
 	dev_info(dev, "initialized. timer margin=%d sec\n", margin);
 	return 0;
-
-out_no_wdog:
-	free_irq(irq, pdev);
-out_no_irq:
-	clk_disable_unprepare(clk);
-out_no_clk_enable:
-	clk_put(clk);
-	return ret;
 }
 
 #ifdef CONFIG_PM
-- 
2.7.4
