Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 19/62] watchdog: gpio_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:36 -0800
Message-Id: <1484091325-9199-20-git-send-email-linux@roeck-us.net>
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
- Call del_timer_sync() using devm_add_action()
  Introduce helper function since we can not call del_timer_sync() directly
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/gpio_wdt.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 93457cabc178..2c09e4d8e6e2 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -138,6 +138,11 @@ static const struct watchdog_ops gpio_wdt_ops = {
 	.set_timeout	= gpio_wdt_set_timeout,
 };
 
+static void __del_timer_sync_cb(void *t)
+{
+	del_timer_sync(t);
+}
+
 static int gpio_wdt_probe(struct platform_device *pdev)
 {
 	struct gpio_wdt_priv *priv;
@@ -151,8 +156,6 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, priv);
-
 	priv->gpio = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
 	if (!gpio_is_valid(priv->gpio))
 		return priv->gpio;
@@ -203,10 +206,13 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 		priv->wdd.timeout = SOFT_TIMEOUT_DEF;
 
 	setup_timer(&priv->timer, gpio_wdt_hwping, (unsigned long)&priv->wdd);
+	ret = devm_add_action(&pdev->dev, __del_timer_sync_cb, &priv->timer);
+	if (ret)
+		return ret;
 
 	watchdog_stop_on_reboot(&priv->wdd);
 
-	ret = watchdog_register_device(&priv->wdd);
+	ret = devm_watchdog_register_device(&pdev->dev, &priv->wdd);
 	if (ret)
 		return ret;
 
@@ -216,16 +222,6 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int gpio_wdt_remove(struct platform_device *pdev)
-{
-	struct gpio_wdt_priv *priv = platform_get_drvdata(pdev);
-
-	del_timer_sync(&priv->timer);
-	watchdog_unregister_device(&priv->wdd);
-
-	return 0;
-}
-
 static const struct of_device_id gpio_wdt_dt_ids[] = {
 	{ .compatible = "linux,wdt-gpio", },
 	{ }
@@ -238,7 +234,6 @@ static struct platform_driver gpio_wdt_driver = {
 		.of_match_table	= gpio_wdt_dt_ids,
 	},
 	.probe	= gpio_wdt_probe,
-	.remove	= gpio_wdt_remove,
 };
 
 #ifdef CONFIG_GPIO_WATCHDOG_ARCH_INITCALL
-- 
2.7.4
