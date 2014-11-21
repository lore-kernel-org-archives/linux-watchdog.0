Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from atl4mhob05.myregisteredsite.com ([209.17.115.43]:47749 "EHLO
	atl4mhob05.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752639AbaKUJkf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 21 Nov 2014 04:40:35 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.211])
	by atl4mhob05.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id sAL9eWdV028567
	for <linux-watchdog@vger.kernel.org>; Fri, 21 Nov 2014 04:40:32 -0500
From: Mike Looijmans <mike.looijmans@topic.nl>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v3] gpio_wdt: Add "always_running" feature to GPIO watchdog
Date: Fri, 21 Nov 2014 10:40:28 +0100
Message-Id: <1416562828-3978-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <546EE991.1080704@roeck-us.net>
References: <546EE991.1080704@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On some chips, like the TPS386000, the trigger cannot be disabled
and the CPU must keep toggling the line at all times. Add a switch
"always_running" to keep toggling the GPIO line regardless of the
state of the soft part of the watchdog. The "armed" member keeps
track of whether a timeout must also cause a reset.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v3: Indentation adjusted to match
Fix error path in probe when notification registration fails
Prevent double assignment of "armed" variable

 .../devicetree/bindings/watchdog/gpio-wdt.txt      |    5 +++
 drivers/watchdog/gpio_wdt.c                        |   39 ++++++++++++++++----
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
index 37afec1..1987949 100644
--- a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
@@ -13,6 +13,11 @@ Required Properties:
     by the GPIO flags.
 - hw_margin_ms: Maximum time to reset watchdog circuit (milliseconds).
 
+Optional Properties:
+- always-running: If the watchdog timer cannot be disabled, add this flag to
+  have the driver keep toggling the signal without a client. It will only cease
+  to toggle the signal when the device is open and the timeout elapsed.
+
 Example:
 	watchdog: watchdog {
 		/* ADM706 */
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 220a9e0..9bfbd73 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -31,6 +31,8 @@ struct gpio_wdt_priv {
 	int			gpio;
 	bool			active_low;
 	bool			state;
+	bool			always_running;
+	bool			armed;
 	unsigned int		hw_algo;
 	unsigned int		hw_margin;
 	unsigned long		last_jiffies;
@@ -48,10 +50,8 @@ static void gpio_wdt_disable(struct gpio_wdt_priv *priv)
 		gpio_direction_input(priv->gpio);
 }
 
-static int gpio_wdt_start(struct watchdog_device *wdd)
+static void gpio_wdt_start_impl(struct gpio_wdt_priv *priv)
 {
-	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
-
 	priv->state = priv->active_low;
 	gpio_direction_output(priv->gpio, priv->state);
 	priv->last_jiffies = jiffies;
@@ -60,12 +60,25 @@ static int gpio_wdt_start(struct watchdog_device *wdd)
 	return 0;
 }
 
+static int gpio_wdt_start(struct watchdog_device *wdd)
+{
+	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	gpio_wdt_start_impl(priv);
+	priv->armed = true;
+
+	return 0;
+}
+
 static int gpio_wdt_stop(struct watchdog_device *wdd)
 {
 	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
-	mod_timer(&priv->timer, 0);
-	gpio_wdt_disable(priv);
+	priv->armed = false;
+	if (!priv->always_running) {
+		mod_timer(&priv->timer, 0);
+		gpio_wdt_disable(priv);
+	}
 
 	return 0;
 }
@@ -91,8 +104,8 @@ static void gpio_wdt_hwping(unsigned long data)
 	struct watchdog_device *wdd = (struct watchdog_device *)data;
 	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
-	if (time_after(jiffies, priv->last_jiffies +
-		       msecs_to_jiffies(wdd->timeout * 1000))) {
+	if (priv->armed && time_after(jiffies, priv->last_jiffies +
+				      msecs_to_jiffies(wdd->timeout * 1000))) {
 		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
 		return;
 	}
@@ -197,6 +210,9 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	/* Use safe value (1/2 of real timeout) */
 	priv->hw_margin = msecs_to_jiffies(hw_margin / 2);
 
+	priv->always_running = of_property_read_bool(pdev->dev.of_node,
+						     "always-running");
+
 	watchdog_set_drvdata(&priv->wdd, priv);
 
 	priv->wdd.info		= &gpio_wdt_ident;
@@ -216,8 +232,15 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	priv->notifier.notifier_call = gpio_wdt_notify_sys;
 	ret = register_reboot_notifier(&priv->notifier);
 	if (ret)
-		watchdog_unregister_device(&priv->wdd);
+		goto error_unregister;
 
+	if (priv->always_running)
+		gpio_wdt_start_impl(priv);
+
+	return 0;
+
+error_unregister:
+	watchdog_unregister_device(&priv->wdd);
 	return ret;
 }
 
-- 
1.7.9.5

