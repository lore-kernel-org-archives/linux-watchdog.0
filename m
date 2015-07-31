Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40225 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbbGaHVp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 31 Jul 2015 03:21:45 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: kernel@pengutronix.de, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: gpio-wdt: ping already at startup for always running devices
Date: Fri, 31 Jul 2015 09:21:36 +0200
Message-Id: <1438327296-17904-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

During probe for an always-running watchdog a timer is setup to
constantly ping the watchdog while the device is not open. The gpio to
ping the watchdog is setup to inactive.

For a watchdog with hw_algo = "toggle" this results in a ping depending
on the initial state of the gpio, for hw_algo = "level" no ping is
generated.

Make sure that the first automatic ping is sent immediately and not only
when the timer expires the first time. This makes the machine survive in
case more than half of the watchdog timeout is already elapsed. (Which
is very probable for the chip I'm faced with that has a timeout of one
second.)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/gpio_wdt.c | 60 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index c2dff7d1b790..5d083528e6b9 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -50,12 +50,41 @@ static void gpio_wdt_disable(struct gpio_wdt_priv *priv)
 		gpio_direction_input(priv->gpio);
 }
 
+static void gpio_wdt_hwping(unsigned long data)
+{
+	struct watchdog_device *wdd = (struct watchdog_device *)data;
+	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	if (priv->armed && time_after(jiffies, priv->last_jiffies +
+				      msecs_to_jiffies(wdd->timeout * 1000))) {
+		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
+		return;
+	}
+
+	/* Restart timer */
+	mod_timer(&priv->timer, jiffies + priv->hw_margin);
+
+	switch (priv->hw_algo) {
+	case HW_ALGO_TOGGLE:
+		/* Toggle output pin */
+		priv->state = !priv->state;
+		gpio_set_value_cansleep(priv->gpio, priv->state);
+		break;
+	case HW_ALGO_LEVEL:
+		/* Pulse */
+		gpio_set_value_cansleep(priv->gpio, !priv->active_low);
+		udelay(1);
+		gpio_set_value_cansleep(priv->gpio, priv->active_low);
+		break;
+	}
+}
+
 static void gpio_wdt_start_impl(struct gpio_wdt_priv *priv)
 {
 	priv->state = priv->active_low;
 	gpio_direction_output(priv->gpio, priv->state);
 	priv->last_jiffies = jiffies;
-	mod_timer(&priv->timer, priv->last_jiffies + priv->hw_margin);
+	gpio_wdt_hwping((unsigned long)&priv->wdd);
 }
 
 static int gpio_wdt_start(struct watchdog_device *wdd)
@@ -97,35 +126,6 @@ static int gpio_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
 	return gpio_wdt_ping(wdd);
 }
 
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
-	switch (priv->hw_algo) {
-	case HW_ALGO_TOGGLE:
-		/* Toggle output pin */
-		priv->state = !priv->state;
-		gpio_set_value_cansleep(priv->gpio, priv->state);
-		break;
-	case HW_ALGO_LEVEL:
-		/* Pulse */
-		gpio_set_value_cansleep(priv->gpio, !priv->active_low);
-		udelay(1);
-		gpio_set_value_cansleep(priv->gpio, priv->active_low);
-		break;
-	}
-}
-
 static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
 			       void *unused)
 {
-- 
2.1.4

