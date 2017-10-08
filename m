Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:50197 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbdJHXax (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 8 Oct 2017 19:30:53 -0400
Received: by mail-lf0-f54.google.com with SMTP id a132so17407287lfa.7
        for <linux-watchdog@vger.kernel.org>; Sun, 08 Oct 2017 16:30:52 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2 v2] watchdog: gpio: Add some local helper variables
Date: Mon,  9 Oct 2017 01:28:46 +0200
Message-Id: <20171008232847.7358-1-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This add "dev" and "np" variables to make the probe() function
a bit easier to read.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Collected Guenther's review tag.
---
 drivers/watchdog/gpio_wdt.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index cb66c2f99ff1..448e6c3ba73c 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -101,6 +101,8 @@ static const struct watchdog_ops gpio_wdt_ops = {
 
 static int gpio_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct gpio_wdt_priv *priv;
 	enum of_gpio_flags flags;
 	unsigned int hw_margin;
@@ -108,19 +110,19 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	const char *algo;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, priv);
 
-	priv->gpio = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
+	priv->gpio = of_get_gpio_flags(np, 0, &flags);
 	if (!gpio_is_valid(priv->gpio))
 		return priv->gpio;
 
 	priv->active_low = flags & OF_GPIO_ACTIVE_LOW;
 
-	ret = of_property_read_string(pdev->dev.of_node, "hw_algo", &algo);
+	ret = of_property_read_string(np, "hw_algo", &algo);
 	if (ret)
 		return ret;
 	if (!strcmp(algo, "toggle")) {
@@ -133,12 +135,12 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = devm_gpio_request_one(&pdev->dev, priv->gpio, f,
-				    dev_name(&pdev->dev));
+	ret = devm_gpio_request_one(dev, priv->gpio, f,
+				    dev_name(dev));
 	if (ret)
 		return ret;
 
-	ret = of_property_read_u32(pdev->dev.of_node,
+	ret = of_property_read_u32(np,
 				   "hw_margin_ms", &hw_margin);
 	if (ret)
 		return ret;
@@ -146,7 +148,7 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	if (hw_margin < 2 || hw_margin > 65535)
 		return -EINVAL;
 
-	priv->always_running = of_property_read_bool(pdev->dev.of_node,
+	priv->always_running = of_property_read_bool(np,
 						     "always-running");
 
 	watchdog_set_drvdata(&priv->wdd, priv);
@@ -155,9 +157,9 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	priv->wdd.ops		= &gpio_wdt_ops;
 	priv->wdd.min_timeout	= SOFT_TIMEOUT_MIN;
 	priv->wdd.max_hw_heartbeat_ms = hw_margin;
-	priv->wdd.parent	= &pdev->dev;
+	priv->wdd.parent	= dev;
 
-	if (watchdog_init_timeout(&priv->wdd, 0, &pdev->dev) < 0)
+	if (watchdog_init_timeout(&priv->wdd, 0, dev) < 0)
 		priv->wdd.timeout = SOFT_TIMEOUT_DEF;
 
 	watchdog_stop_on_reboot(&priv->wdd);
-- 
2.13.5

