Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 7/9] watchdog: gpio_wdt: Convert to use infrastructure triggered keepalives
Date: Sat, 29 Aug 2015 12:32:36 -0700
Message-Id: <1440876758-28047-8-git-send-email-linux@roeck-us.net>
In-Reply-To: <1440876758-28047-1-git-send-email-linux@roeck-us.net>
References: <1440876758-28047-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The watchdog infrastructure now supports handling watchdog keepalive
if the watchdog is running while the watchdog device is closed.
The infrastructure now also supports generating additional heartbeats
if the maximum hardware timeout is smaller than or close to the
configured timeout. Convert the driver to use this infrastructure.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: No changes
v2: No changes
---
 drivers/watchdog/gpio_wdt.c | 65 ++++++++-------------------------------------
 1 file changed, 11 insertions(+), 54 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 1687cc2d7122..cbbdae440bfa 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -32,12 +32,8 @@ struct gpio_wdt_priv {
 	bool			active_low;
 	bool			state;
 	bool			always_running;
-	bool			armed;
 	unsigned int		hw_algo;
-	unsigned int		hw_margin;
-	unsigned long		last_jiffies;
 	struct notifier_block	notifier;
-	struct timer_list	timer;
 	struct watchdog_device	wdd;
 };
 
@@ -50,20 +46,12 @@ static void gpio_wdt_disable(struct gpio_wdt_priv *priv)
 		gpio_direction_input(priv->gpio);
 }
 
-static void gpio_wdt_start_impl(struct gpio_wdt_priv *priv)
-{
-	priv->state = priv->active_low;
-	gpio_direction_output(priv->gpio, priv->state);
-	priv->last_jiffies = jiffies;
-	mod_timer(&priv->timer, priv->last_jiffies + priv->hw_margin);
-}
-
 static int gpio_wdt_start(struct watchdog_device *wdd)
 {
 	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
-	gpio_wdt_start_impl(priv);
-	priv->armed = true;
+	priv->state = priv->active_low;
+	gpio_direction_output(priv->gpio, priv->state);
 
 	return 0;
 }
@@ -72,10 +60,9 @@ static int gpio_wdt_stop(struct watchdog_device *wdd)
 {
 	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
-	priv->armed = false;
 	if (!priv->always_running) {
-		mod_timer(&priv->timer, 0);
 		gpio_wdt_disable(priv);
+		clear_bit(WDOG_RUNNING, &priv->wdd.status);
 	}
 
 	return 0;
@@ -85,32 +72,6 @@ static int gpio_wdt_ping(struct watchdog_device *wdd)
 {
 	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
-	priv->last_jiffies = jiffies;
-
-	return 0;
-}
-
-static int gpio_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
-{
-	wdd->timeout = t;
-
-	return gpio_wdt_ping(wdd);
-}
-
-static void gpio_wdt_hwping(unsigned long data)
-{
-	struct watchdog_device *wdd = (struct watchdog_device *)data;
-	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
-
-	if (priv->armed && time_after(jiffies, priv->last_jiffies +
-				      msecs_to_jiffies(wdd->timeout * 1000))) {
-		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
-		return;
-	}
-
-	/* Restart timer */
-	mod_timer(&priv->timer, jiffies + priv->hw_margin);
-
 	switch (priv->hw_algo) {
 	case HW_ALGO_TOGGLE:
 		/* Toggle output pin */
@@ -124,6 +85,8 @@ static void gpio_wdt_hwping(unsigned long data)
 		gpio_set_value_cansleep(priv->gpio, priv->active_low);
 		break;
 	}
+
+	return 0;
 }
 
 static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
@@ -132,12 +95,10 @@ static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
 	struct gpio_wdt_priv *priv = container_of(nb, struct gpio_wdt_priv,
 						  notifier);
 
-	mod_timer(&priv->timer, 0);
-
 	switch (code) {
 	case SYS_HALT:
 	case SYS_POWER_OFF:
-		gpio_wdt_disable(priv);
+		gpio_wdt_stop(&priv->wdd);
 		break;
 	default:
 		break;
@@ -157,7 +118,6 @@ static const struct watchdog_ops gpio_wdt_ops = {
 	.start		= gpio_wdt_start,
 	.stop		= gpio_wdt_stop,
 	.ping		= gpio_wdt_ping,
-	.set_timeout	= gpio_wdt_set_timeout,
 };
 
 static int gpio_wdt_probe(struct platform_device *pdev)
@@ -205,9 +165,6 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	if (hw_margin < 2 || hw_margin > 65535)
 		return -EINVAL;
 
-	/* Use safe value (1/2 of real timeout) */
-	priv->hw_margin = msecs_to_jiffies(hw_margin / 2);
-
 	priv->always_running = of_property_read_bool(pdev->dev.of_node,
 						     "always-running");
 
@@ -217,11 +174,15 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	priv->wdd.ops		= &gpio_wdt_ops;
 	priv->wdd.min_timeout	= SOFT_TIMEOUT_MIN;
 	priv->wdd.max_timeout	= SOFT_TIMEOUT_MAX;
+	priv->wdd.max_hw_timeout_ms = hw_margin;
 
 	if (watchdog_init_timeout(&priv->wdd, 0, &pdev->dev) < 0)
 		priv->wdd.timeout = SOFT_TIMEOUT_DEF;
 
-	setup_timer(&priv->timer, gpio_wdt_hwping, (unsigned long)&priv->wdd);
+	if (priv->always_running) {
+		set_bit(WDOG_RUNNING, &priv->wdd.status);
+		gpio_wdt_start(&priv->wdd);
+	}
 
 	ret = watchdog_register_device(&priv->wdd);
 	if (ret)
@@ -232,9 +193,6 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_unregister;
 
-	if (priv->always_running)
-		gpio_wdt_start_impl(priv);
-
 	return 0;
 
 error_unregister:
@@ -246,7 +204,6 @@ static int gpio_wdt_remove(struct platform_device *pdev)
 {
 	struct gpio_wdt_priv *priv = platform_get_drvdata(pdev);
 
-	del_timer_sync(&priv->timer);
 	unregister_reboot_notifier(&priv->notifier);
 	watchdog_unregister_device(&priv->wdd);
 
-- 
2.1.4
