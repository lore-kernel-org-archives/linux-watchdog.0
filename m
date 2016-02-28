Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:32896 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758916AbcB1VMg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 28 Feb 2016 16:12:36 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH v8 10/10] watchdog: gpio: Convert to use infrastructure triggered keepalives
Date: Sun, 28 Feb 2016 13:12:23 -0800
Message-Id: <1456693943-6876-11-git-send-email-linux@roeck-us.net>
In-Reply-To: <1456693943-6876-1-git-send-email-linux@roeck-us.net>
References: <1456693943-6876-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog infrastructure now supports handling watchdog keepalive
if the watchdog is running while the watchdog device is closed.
The infrastructure now also supports generating additional heartbeats
if the maximum hardware timeout is smaller than or close to the
configured timeout. Convert the driver to use this infrastructure.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>

---
v8: Added patch to series
---
 drivers/watchdog/gpio_wdt.c | 73 ++++++++-------------------------------------
 1 file changed, 13 insertions(+), 60 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index ba066e4a707b..f36184635403 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -18,7 +18,6 @@
 
 #define SOFT_TIMEOUT_MIN	1
 #define SOFT_TIMEOUT_DEF	60
-#define SOFT_TIMEOUT_MAX	0xffff
 
 enum {
 	HW_ALGO_TOGGLE,
@@ -30,11 +29,7 @@ struct gpio_wdt_priv {
 	bool			active_low;
 	bool			state;
 	bool			always_running;
-	bool			armed;
 	unsigned int		hw_algo;
-	unsigned int		hw_margin;
-	unsigned long		last_jiffies;
-	struct timer_list	timer;
 	struct watchdog_device	wdd;
 };
 
@@ -47,21 +42,10 @@ static void gpio_wdt_disable(struct gpio_wdt_priv *priv)
 		gpio_direction_input(priv->gpio);
 }
 
-static void gpio_wdt_hwping(unsigned long data)
+static int gpio_wdt_ping(struct watchdog_device *wdd)
 {
-	struct watchdog_device *wdd = (struct watchdog_device *)data;
 	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
-	if (priv->armed && time_after(jiffies, priv->last_jiffies +
-				      msecs_to_jiffies(wdd->timeout * 1000))) {
-		dev_crit(wdd->parent,
-			 "Timer expired. System will reboot soon!\n");
-		return;
-	}
-
-	/* Restart timer */
-	mod_timer(&priv->timer, jiffies + priv->hw_margin);
-
 	switch (priv->hw_algo) {
 	case HW_ALGO_TOGGLE:
 		/* Toggle output pin */
@@ -75,55 +59,33 @@ static void gpio_wdt_hwping(unsigned long data)
 		gpio_set_value_cansleep(priv->gpio, priv->active_low);
 		break;
 	}
-}
-
-static void gpio_wdt_start_impl(struct gpio_wdt_priv *priv)
-{
-	priv->state = priv->active_low;
-	gpio_direction_output(priv->gpio, priv->state);
-	priv->last_jiffies = jiffies;
-	gpio_wdt_hwping((unsigned long)&priv->wdd);
+	return 0;
 }
 
 static int gpio_wdt_start(struct watchdog_device *wdd)
 {
 	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
-	gpio_wdt_start_impl(priv);
-	priv->armed = true;
+	priv->state = priv->active_low;
+	gpio_direction_output(priv->gpio, priv->state);
 
-	return 0;
+	set_bit(WDOG_HW_RUNNING, &wdd->status);
+
+	return gpio_wdt_ping(wdd);
 }
 
 static int gpio_wdt_stop(struct watchdog_device *wdd)
 {
 	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
-	priv->armed = false;
 	if (!priv->always_running) {
-		mod_timer(&priv->timer, 0);
 		gpio_wdt_disable(priv);
+		clear_bit(WDOG_HW_RUNNING, &wdd->status);
 	}
 
 	return 0;
 }
 
-static int gpio_wdt_ping(struct watchdog_device *wdd)
-{
-	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
-
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
 static const struct watchdog_info gpio_wdt_ident = {
 	.options	= WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING |
 			  WDIOF_SETTIMEOUT,
@@ -135,7 +97,6 @@ static const struct watchdog_ops gpio_wdt_ops = {
 	.start		= gpio_wdt_start,
 	.stop		= gpio_wdt_stop,
 	.ping		= gpio_wdt_ping,
-	.set_timeout	= gpio_wdt_set_timeout,
 };
 
 static int gpio_wdt_probe(struct platform_device *pdev)
@@ -183,9 +144,6 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	if (hw_margin < 2 || hw_margin > 65535)
 		return -EINVAL;
 
-	/* Use safe value (1/2 of real timeout) */
-	priv->hw_margin = msecs_to_jiffies(hw_margin / 2);
-
 	priv->always_running = of_property_read_bool(pdev->dev.of_node,
 						     "always-running");
 
@@ -194,31 +152,26 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	priv->wdd.info		= &gpio_wdt_ident;
 	priv->wdd.ops		= &gpio_wdt_ops;
 	priv->wdd.min_timeout	= SOFT_TIMEOUT_MIN;
-	priv->wdd.max_timeout	= SOFT_TIMEOUT_MAX;
+	priv->wdd.max_hw_heartbeat_ms = hw_margin;
 	priv->wdd.parent	= &pdev->dev;
 
 	if (watchdog_init_timeout(&priv->wdd, 0, &pdev->dev) < 0)
 		priv->wdd.timeout = SOFT_TIMEOUT_DEF;
 
-	setup_timer(&priv->timer, gpio_wdt_hwping, (unsigned long)&priv->wdd);
-
 	watchdog_stop_on_reboot(&priv->wdd);
 
-	ret = watchdog_register_device(&priv->wdd);
-	if (ret)
-		return ret;
-
 	if (priv->always_running)
-		gpio_wdt_start_impl(priv);
+		gpio_wdt_start(&priv->wdd);
 
-	return 0;
+	ret = watchdog_register_device(&priv->wdd);
+
+	return ret;
 }
 
 static int gpio_wdt_remove(struct platform_device *pdev)
 {
 	struct gpio_wdt_priv *priv = platform_get_drvdata(pdev);
 
-	del_timer_sync(&priv->timer);
 	watchdog_unregister_device(&priv->wdd);
 
 	return 0;
-- 
2.5.0

